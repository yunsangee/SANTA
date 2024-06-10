package site.dearmysanta.web.userEtc;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import site.dearmysanta.domain.alarmMessage.AlarmMessage;
import site.dearmysanta.service.user.etc.UserEtcService;

@Controller
@RequestMapping("/userEtc/*")
public class UserEtcContoller {
	
	@Autowired
	UserEtcService userEtcService;
	
	@GetMapping(value="getAlarmMessageList")
	public String getAlarmMessageList(@RequestParam int userNo, Model model) throws Exception {
		
		
		List<AlarmMessage> list = userEtcService.getAlarmMessageList(userNo);
		List<String> messages = new ArrayList<>();
		
		for(AlarmMessage message : list) {
			String sentence = message.getUserName()+"님! " + message.getTitle();
			
			if(message.getPostTypeNo() == 0) {
				sentence += " 인증 게시글에 ";
			}else {
				sentence += " 모임 게시글에 ";
			}
			
			if(message.getAlarmTypeNo() == 0) {
				sentence += "좋아요가 늘어났어요!";
			}else {
				sentence += "댓글이 달렸어요!";
			}
			
			messages.add(sentence);
		}
		
		
		model.addAttribute("alarmMessageList", messages);
		
		return "forward:/userEtc/getAlarmMessageList.jsp";
	}
}
