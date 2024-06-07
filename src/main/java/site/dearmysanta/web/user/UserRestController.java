//package site.dearmysanta.web.user;
//
//import java.util.HashMap;
//import java.util.Map;
//
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.RestController;
//
//import net.nurigo.sdk.NurigoApp;
//import net.nurigo.sdk.message.model.Message;
//import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
//import net.nurigo.sdk.message.response.SingleMessageSentResponse;
//import net.nurigo.sdk.message.service.DefaultMessageService;
//import site.dearmysanta.common.MakeRandomNumber;
//import site.dearmysanta.domain.message.MessageInfo;
//
//@RestController
//@RequestMapping("/message/*")
//public class UserRestController {
//	
//	@Value("${coolSmsClientId}")
//	private String clientId;
//	
//	@Value("${coolSmsClientSecret}")
//	private String clientSecret;
//	
//	final DefaultMessageService userService;
//	private static Map<String,Integer> map;
//	
//	public UserRestController() {
//		this.userService = NurigoApp.INSTANCE.initialize(clientSecret, clientSecret, "https://api.coolsms.co.kr");
//		map = new HashMap<String,Integer>();
//	}
//	
//	@PostMapping("/send-one")
//	public boolean sendOne(@RequestBody MessageInfo messageInfo) {
//		
//		int randomNumber = MakeRandomNumber.makeRandomNumber();
//		
//		Message message = new Message();
//		message.setFrom("01095740310");
//		message.setTo(messageInfo.getPhoneNumber());
//		message.setText("안녕하세요\n 인증번호는 다음과 같습니다. \n [" + randomNumber + "] \n 값을 입력해주세요."); 
//		
//		SingleMessageSentResponse response = this.userService.sendOne(new SingleMessageSendingRequest(message));
//		
////		System.out.println("response:" + response);
//		System.out.println(randomNumber);
//		System.out.println("messageInfo:" + messageInfo);
//		
//		
//		map.put(messageInfo.getPhoneNumber(), randomNumber);
//		
//		return true;
//		
//	}
//	
//	@GetMapping("/check-one")
//	public int getValidationNumber(@ModelAttribute MessageInfo messageInfo) {
//		Integer randomNumber = map.get(messageInfo.getPhoneNumber());
//		
//		if(randomNumber != null && randomNumber == messageInfo.getValidationNumber() ) {
//			return randomNumber;
//		}else {
//			return -1;
//		}
//	}
//
//}