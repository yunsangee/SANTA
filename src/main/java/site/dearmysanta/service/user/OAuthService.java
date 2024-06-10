package site.dearmysanta.service.user;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import org.springframework.stereotype.Service;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

@Service
public class OAuthService {

    public String getKakaoAccessToken(String code) {
        String access_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            // POST 요청을 위해 기본값이 false인 setDoOutput을 true로 설정
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

            // POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=53ae98941fff9e24b11901e9a79432d9"); // TODO REST_API_KEY 입력
            sb.append("&redirect_uri=http://localhost:8001/oauth/kakao"); // TODO 인가코드 받은 redirect_uri 입력
            sb.append("&code=").append(code);
            bw.write(sb.toString());
            bw.flush();

            // 결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            // 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br;
            if (responseCode == 200) {
                br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }
            String line;
            StringBuilder result = new StringBuilder();

            while ((line = br.readLine()) != null) {
                result.append(line);
            }
            System.out.println("response body : " + result);

            if (responseCode == 200) {
                // Gson 라이브러리에 포함된 클래스로 JSON 파싱 객체 생성
                JsonParser parser = new JsonParser();
                JsonElement element = parser.parse(result.toString());

                access_Token = element.getAsJsonObject().get("access_token").getAsString();

                System.out.println("access_token : " + access_Token);
            } else {
                System.err.println("Error response: " + result);
            }

            br.close();
            bw.close();
        } catch (IOException e) {
            throw new RuntimeException("카카오 API 요청 중 오류 발생", e);
        }

        return access_Token;
    }
}
