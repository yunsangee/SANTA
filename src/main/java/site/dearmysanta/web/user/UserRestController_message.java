package site.dearmysanta.web.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;
import site.dearmysanta.domain.message.MessageInfo;
import site.dearmysanta.common.MakeRandomNumber;

@RestController
@RequestMapping("/message/*")
public class UserRestController_message {
	
	final DefaultMessageService messageService;
	public static Map<String,Integer> map;
	
	public UserRestController_message() {
	//private UserRestController() {
		this.messageService = NurigoApp.INSTANCE.initialize("NCSMJXRUH06HCAGB", "YZQXS4WPBB5RMIWEAY7MJ6MWJWTLPQEC", "https://api.coolsms.co.kr");
		map = new HashMap<String,Integer>();
	}
	
	@PostMapping("/send-one")
	public boolean sendOne(@RequestBody MessageInfo messageInfo) {
		
		int randomNumber = MakeRandomNumber.makeRandomNumber();
		
		Message message = new Message();
		message.setFrom("01095740310");
		message.setTo(messageInfo.getPhoneNumber());
		message.setText("안녕하세요 " + messageInfo.getUserName() + "님\n [" + randomNumber + "] \n 값을 입력해주세요."); 
		
		SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
		
//		System.out.println("response:" + response);
		System.out.println(randomNumber);
		System.out.println("messageInfo:" + messageInfo);
		
		
		map.put(messageInfo.getPhoneNumber(), randomNumber);
		
		return true;
		
	}
	
	@GetMapping("/check-one")
	public static int getValidationNumber(@ModelAttribute MessageInfo messageInfo) {
	//public int 
		Integer randomNumber = map.get(messageInfo.getPhoneNumber());
		
		if(randomNumber != null && randomNumber == messageInfo.getValidationNumber() ) {
			return randomNumber;
		}else {
			return -1;
		}
	}

}