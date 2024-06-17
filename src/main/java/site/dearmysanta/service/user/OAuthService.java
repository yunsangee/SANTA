package site.dearmysanta.service.user;

import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
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
            sb.append("&client_id=af43c655326aaa2ca97588ce636e1e29"); // TODO REST_API_KEY �Է�
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

    public void CreateKakaoUser(String token) throws Exception {
    	
    	String reqURL = "https://kapi.kakao.com/v2/user/me";

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
           String line = "";
           String result = "";

           while ((line = br.readLine()) != null) {
               result += line;
           }
           System.out.println("response body : " + result);

           //Gson ���̺귯���� JSON�Ľ�
           JsonParser parser = new JsonParser();
           JsonElement element = parser.parse(result);

           int id = element.getAsJsonObject().get("id").getAsInt();
           boolean hasEmail = element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("has_email").getAsBoolean();
           String email = "";
           if(hasEmail){
               email = element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("email").getAsString();
           }

           System.out.println("id : " + id);
           System.out.println("email : " + email);

           br.close();

        } catch (IOException e) {
            throw new Exception("Error while creating Kakao user", e);
        }
     }
}