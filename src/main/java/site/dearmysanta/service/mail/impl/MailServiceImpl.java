package site.dearmysanta.service.mail.impl;

import java.util.Map;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;



import site.dearmysanta.service.mail.MailService;

@Service
public class MailServiceImpl implements MailService{

	@Autowired
	//@Qualifier("mailSender")
	private JavaMailSenderImpl mailSender;
	
//	private static final String senderEmail = "ljh71506@gmail.com";
	private static Map<String,Integer> map;
	
	
	public MailServiceImpl() {
		map = new ConcurrentHashMap<String,Integer>();
		System.out.println(this.getClass());
	}
	
	public void makeRandomNumber(String receiverEmail) {
		System.out.println("Random Number Generate");
		Random random = new Random();
		
		int randomNumber = random.nextInt(888888)+111111;
		System.out.println("randomNumber : " + randomNumber);
		map.put(receiverEmail, randomNumber);
		
	}
	
		public void mailSend(String receiverEmail) {
		    makeRandomNumber(receiverEmail);
		    String setFrom = "ljh71506@gmail.com";
		    String title = "SANTA 회원 가입 인증 이메일입니다.";
		    String content = 
		    		 "<div style='border-top: 2px solid #81C408; padding-top: 20px; font-family: Arial, sans-serif;'>" +
		    			        "<h2 style='color: black; text-align: left; font-weight: normal; font-size:14px; margin-bottom: 20px;'>Bitcamp:SANTA</h2>" +
		    			        "<div style='margin-bottom: -10px;'>" +
		    			        "<span style='color: #81C408; font-size: 40px;'>메일인증</span>" +
		    			        "<span style='color: black; font-size: 40px;'> 안내입니다.</span>" +
		    			        "</div>" +
		    			        "<br>" +
		    			        "<p style='text-align: left; color: black; font-size: 16px; margin-bottom:-5px;'>안녕하세요. SANTA에 오신 것을 환영합니다.</p>" +
		    			        "<p style='text-align: left; color: black; font-size: 16px; margin-bottom:-5px;'>아래 <span style='color: #81C408;'>인증코드</span>를 입력하시고 회원가입을 완료해 주세요.</p>" +
		    			        "<p style='text-align: left; color: black; font-size: 16px;'>감사합니다.</p>" +
		    			        "<h1 style='text-align: left; color: #81C408; font-size: 30px;'>" + map.get(receiverEmail) + "</h1>" +
		    			        "<hr style='border: 0; height: 1px; background: #ccc; margin: 20px 0;'>" +
		    			        "<p style='text-align: left; color: black; font-size: 16px;'>회원가입을 중단하고 SANTA를 구경하고 싶으시다면 아래 버튼을 눌러주세요.</p>" +
		    			        "<div style='text-align: left;'>" +
		    			        "<a href='https://www.dearmysanta.site' style='display: inline-block; padding: 10px 20px; margin: 20px 0; font-size: 16px; color: white; background-color: #81C408; text-decoration: none; border-radius: 5px;'>SANTA 구경하기</a>" +
		    			        "</div>" +
		    			        "<div class='footer' style='text-align: left; margin-top: 20px;'>" +
		    			        "<p>&copy; 2024 SANTA. All rights reserved.</p>" +
		    			        "</div>" +
		    			        "</div>";


		    MimeMessage message = mailSender.createMimeMessage();
		    try {
		        MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
		        helper.setFrom(setFrom);
		        helper.setTo(receiverEmail);
		        helper.setSubject(title);
		        helper.setText(content, true);

		        mailSender.send(message);

		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		}







	public boolean checkAuth(String receiverEmail, int authCode) {
		
		System.out.println("checkAuth:" + map.get(receiverEmail).intValue() + " " + authCode);
		if(map.get(receiverEmail).intValue() == authCode) {
			return true;
		}else {
			return false;
		}
	}
	
    public Map<String, Integer> getMap() {
        return map;
    }

}
