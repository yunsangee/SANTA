package site.dearmysanta.service.user;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import site.dearmysanta.domain.user.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

import com.google.gson.JsonParser;
import com.google.gson.JsonElement;
import org.springframework.stereotype.Service;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

@Service
public class OAuthService{
	
	private final UserService userService;
	
	@Autowired
	public OAuthService(UserService userService) {
		this.userService=userService;
	}

    public String getKakaoAccessToken (String code) {
        String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
//            sb.append("&client_id=af43c655326aaa2ca97588ce636e1e29"); // TODO REST_API_KEY 입력
            sb.append("&client_id=53ae98941fff9e24b11901e9a79432d9"); // TODO REST_API_KEY 입력
            sb.append("&redirect_uri=http://localhost:8001/oauth/kakao"); // TODO 인가코드 받은 redirect_uri 입력
            sb.append("&code=" + code);
            bw.write(sb.toString());
            bw.flush();

            //결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            //Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);

            br.close();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return access_Token;
    }

    public User CreateKakaoUser(String token) throws Exception {
    	
    	String reqURL = "https://kapi.kakao.com/v2/user/me";
    	
    	User user = null;

        //access_token을 이용하여 사용자 정보 조회
        try {
           URL url = new URL(reqURL);
           HttpURLConnection conn = (HttpURLConnection) url.openConnection();

           conn.setRequestMethod("POST");
           conn.setDoOutput(true);
           conn.setRequestProperty("Authorization", "Bearer " + token); //전송할 header 작성, access_token전송

           //결과 코드가 200이라면 성공
           int responseCode = conn.getResponseCode();
           System.out.println("responseCode : " + responseCode);

           //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
           BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
           StringBuilder result = new StringBuilder();
           String line;
           while ((line = br.readLine()) != null) {
               result.append(line);
           }
           System.out.println("response body : " + result);

           //Gson 라이브러리로 JSON파싱
           JsonParser parser = new JsonParser();
           JsonElement element = parser.parse(result.toString());

//           int id = element.getAsJsonObject().get("id").getAsInt();
//           String name=element.getAsJsonObject().get("name").getAsString();
//           String password=element.getAsJsonObject().get("password").getAsString();
//           boolean hasEmail = element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("has_email").getAsBoolean();
//           String email = "";
//           if(hasEmail){
//               email = element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("email").getAsString();
//           }
           
           int id = element.getAsJsonObject().get("id").getAsInt();
           JsonElement kakaoAccount = element.getAsJsonObject().get("kakao_account");

           String email = kakaoAccount.getAsJsonObject().get("email").getAsString();
           String name = getStringFromJson(kakaoAccount, "name");
           String profileImage = element.getAsJsonObject().get("properties").getAsJsonObject().get("profile_image").getAsString();
           String genderStr = kakaoAccount.getAsJsonObject().get("gender").getAsString();
           int gender = convertGenderStringToInt(genderStr); // 성별을 int로 변환
           String birthyear = kakaoAccount.getAsJsonObject().get("birthyear").getAsString();
           String birthday = kakaoAccount.getAsJsonObject().get("birthday").getAsString();
           String birthDate = convertBirthDate(birthyear, birthday);
           String phoneNumber = kakaoAccount.getAsJsonObject().get("phone_number").getAsString();

           phoneNumber = convertPhoneNumber(phoneNumber);
           
           System.out.println("id : " + id);
           System.out.println("email : " + email);
           
//           User user = new User();
//           user.setUserId(email);

           user = new User();
           user.setUserId(email);
           user.setUserName(name);
           user.setProfileImage(profileImage);
           user.setGender(gender);
           user.setBirthDate(birthyear + "-" + birthday);
           user.setPhoneNumber(phoneNumber);
           
           // 사용자 정보 저장
           userService.addUser(user);
           
           br.close();

        } catch (IOException e) {
            throw new Exception("Error while creating Kakao user", e);
        }
        
        return user;
     }
    
    private String getStringFromJson(JsonElement jsonElement, String key) {
        return jsonElement != null && jsonElement.getAsJsonObject().has(key) ? jsonElement.getAsJsonObject().get(key).getAsString() : null;
    }
    
    private int convertGenderStringToInt(String genderStr) {
        if (genderStr.equalsIgnoreCase("female")) {
            return 0;
        } else if (genderStr.equalsIgnoreCase("male")) {
            return 1;
        } 
        else {
            return 0; // 알 수 없는 경우 0으로 설정
        }
    }
    
    private String convertPhoneNumber(String phoneNumber) {
        if (phoneNumber.startsWith("+82")) {
            phoneNumber = phoneNumber.replace("+82", "0").replace("-", "").replaceAll("\\s+", "");
        }
        return phoneNumber;
    }
    
    private String convertBirthDate(String birthyear, String birthday) {
        return birthyear + "-" + birthday.substring(0, 2) + "-" + birthday.substring(2);
    }
    
    ///////////////////////////////// 로그아웃 /////////////////////////////////////////////////////////////////////////////////
    
    
    public void kakaoLogout(String accessToken) {
        String reqURL = "https://kapi.kakao.com/v1/user/logout";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            br.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}