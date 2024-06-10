package site.dearmysanta.web.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import site.dearmysanta.service.user.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@GetMapping(value="getAlarmMessageList")
	public String getAlarmMessageList(@RequestParam int userNo, Model model) throws Exception {
		
		//model.addAttribute("alarmMessageList", userService.getAlarmMessageList(userNo));
		
		return "forward:/user/getAlarmMessageList.jsp";
	}
}
