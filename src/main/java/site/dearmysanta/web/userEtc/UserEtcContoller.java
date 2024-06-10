package site.dearmysanta.web.userEtc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import site.dearmysanta.service.user.etc.UserEtcService;

@Controller
@RequestMapping("/userEtc/*")
public class UserEtcContoller {
	
	@Autowired
	UserEtcService userEtcService;
	
	@GetMapping(value="getAlarmMessageList")
	public String getAlarmMessageList(@RequestParam int userNo, Model model) throws Exception {
		
		model.addAttribute("alarmMessageList", userEtcService.getAlarmMessageList(userNo));
		
		return "forward:/user/getAlarmMessageList.jsp";
	}
}
