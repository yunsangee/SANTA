//package site.dearmysanta.service.user;
//
//import java.io.BufferedReader;
//import java.io.IOException;
//import java.io.InputStreamReader;
//import java.net.HttpURLConnection;
//import java.net.URL;
//
//import org.springframework.stereotype.Service;
//import org.springframework.transaction.annotation.Transactional;
//
//import com.google.gson.JsonElement;
//import com.google.gson.JsonParser;
//
//@Service
//@Transactional
//
//public class OAuthService {
//
//public void CreateKakaoUser(String token) throws BaseException {
//	
//	String reqURL = "https://kapi.kakao.com/v2/user/me";
//
//    //access_token을 이용하여 사용자 정보 조회
//    try {
//       URL url = new URL(reqURL);
//       HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//
//       conn.setRequestMethod("POST");
//       conn.setDoOutput(true);
//       conn.setRequestProperty("Authorization", "Bearer " + token); //전송할 header 작성, access_token전송
//
//       //결과 코드가 200이라면 성공
//       int responseCode = conn.getResponseCode();
//       System.out.println("responseCode : " + responseCode);
//
//       //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
//       BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//       String line = "";
//       String result = "";
//
//       while ((line = br.readLine()) != null) {
//           result += line;
//       }
//       System.out.println("response body : " + result);
//
//       //Gson 라이브러리로 JSON파싱
//       JsonParser parser = new JsonParser();
//       JsonElement element = parser.parse(result);
//
//       int id = element.getAsJsonObject().get("id").getAsInt();
//       boolean hasEmail = element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("has_email").getAsBoolean();
//       String email = "";
//       if(hasEmail){
//           email = element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("email").getAsString();
//       }
//
//       System.out.println("id : " + id);
//       System.out.println("email : " + email);
//
//       br.close();
//
//       } catch (IOException e) {
//            e.printStackTrace();
//       }
// }
//}