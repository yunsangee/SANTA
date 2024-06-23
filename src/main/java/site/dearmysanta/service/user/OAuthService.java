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

            //POST ��û�� ���� �⺻���� false�� setDoOutput�� true��
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //POST ��û�� �ʿ�� �䱸�ϴ� �Ķ���� ��Ʈ���� ���� ����
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
//            sb.append("&client_id=af43c655326aaa2ca97588ce636e1e29"); // TODO REST_API_KEY �Է�
            sb.append("&client_id=53ae98941fff9e24b11901e9a79432d9"); // TODO REST_API_KEY �Է�
            sb.append("&redirect_uri=http://localhost:8001/oauth/kakao"); // TODO �ΰ��ڵ� ���� redirect_uri �Է�
            sb.append("&code=" + code);
            bw.write(sb.toString());
            bw.flush();

            //��� �ڵ尡 200�̶�� ����
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            //��û�� ���� ���� JSONŸ���� Response �޼��� �о����
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            //Gson ���̺귯���� ���Ե� Ŭ������ JSON�Ľ� ��ü ����
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

        //access_token�� �̿��Ͽ� ����� ���� ��ȸ
        try {
           URL url = new URL(reqURL);
           HttpURLConnection conn = (HttpURLConnection) url.openConnection();

           conn.setRequestMethod("POST");
           conn.setDoOutput(true);
           conn.setRequestProperty("Authorization", "Bearer " + token); //������ header �ۼ�, access_token����

           //��� �ڵ尡 200�̶�� ����
           int responseCode = conn.getResponseCode();
           System.out.println("responseCode : " + responseCode);

           //��û�� ���� ���� JSONŸ���� Response �޼��� �о����
           BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
           StringBuilder result = new StringBuilder();
           String line;
           while ((line = br.readLine()) != null) {
               result.append(line);
           }
           System.out.println("response body : " + result);

           //Gson ���̺귯���� JSON�Ľ�
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
           int gender = convertGenderStringToInt(genderStr); // ������ int�� ��ȯ
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
           
           // ����� ���� ����
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
            return 0; // �� �� ���� ��� 0���� ����
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
    
    ///////////////////////////////// �α׾ƿ� /////////////////////////////////////////////////////////////////////////////////
    
    
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