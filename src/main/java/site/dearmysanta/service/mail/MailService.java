package site.dearmysanta.service.mail;

import java.util.Map;

public interface MailService {

	public void makeRandomNumber(String receiverEmail);
	
	public void mailSend(String receiverEmail);
	
	public boolean checkAuth(String receiverEmail, int authCode);
	
	public Map<String, Integer> getMap();

}