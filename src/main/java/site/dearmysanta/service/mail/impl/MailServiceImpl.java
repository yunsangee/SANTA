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
	    System.out.println("confirm : ");
	    String setFrom = "ljh71506@gmail.com";
	    String title = "산타 회원가입 인증번호 입니다.";
	    String content = "<!DOCTYPE html>" +
	            "<html>" +
	            "<head>" +
	            "<meta charset='UTF-8'>" +
	            "<title>이메일 인증번호</title>" +
	            "<style>" +
	            "body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }" +
	            ".container { width: 80%; max-width: 600px; margin: 0 auto; background-color: #ffffff; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }" +
	            ".header { text-align: center; padding-bottom: 20px; }" +
	            ".header img { width: 100%; max-width: 100%; height: auto; border-radius: 10px; }" +
	            ".content { font-size: 16px; line-height: 1.6; color: #333333; }" +
	            ".content p { margin: 0 0 10px; }" +
	            ".footer { text-align: center; font-size: 12px; color: #999999; margin-top: 20px; }" +
	            "</style>" +
	            "</head>" +
	            "<body>" +
	            "<div class='container'>" +
	            "<div class='header'>" +
				/* "<img src='https://source.unsplash.com/featured/?hiking' alt='hiking'>" + */
	            "</div>" +
	            "<div class='content'>" +
	            "<p>안녕하세요 산타님!</p>" +
	            "<p>SANTA에 오신 것을 환영합니다. <strong>SANTA</strong>. 산타에 가입하기 위해 이메일 인증을 진행합니다,  아래에 전송된 인증번호를 회원가입 페이지에 입력해주시기 바랍니다.</p>" +
	            "<p><strong>인증번호: " + map.get(receiverEmail) + "</strong></p>" +
	            "<p>해당 이메일로 회원가입을 희망하지 않는다면, 다른 이메일을 입력하여 주세요.</p>" +
	            "</div>" +
	            "<div class='footer'>" +
	            "<p>&copy; 2024 SANTA. All rights reserved.</p>" +
	            "</div>" +
	            "</div>" +
	            "</body>" +
	            "</html>";

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
