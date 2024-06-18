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
//    //access_token�� �̿��Ͽ� ����� ���� ��ȸ
//    try {
//       URL url = new URL(reqURL);
//       HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//
//       conn.setRequestMethod("POST");
//       conn.setDoOutput(true);
//       conn.setRequestProperty("Authorization", "Bearer " + token); //������ header �ۼ�, access_token����
//
//       //��� �ڵ尡 200�̶�� ����
//       int responseCode = conn.getResponseCode();
//       System.out.println("responseCode : " + responseCode);
//
//       //��û�� ���� ���� JSONŸ���� Response �޼��� �о����
//       BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//       String line = "";
//       String result = "";
//
//       while ((line = br.readLine()) != null) {
//           result += line;
//       }
//       System.out.println("response body : " + result);
//
//       //Gson ���̺귯���� JSON�Ľ�
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