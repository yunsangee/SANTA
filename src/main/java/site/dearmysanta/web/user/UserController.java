package site.dearmysanta.web.user;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.alarmMessage.AlarmMessage;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.user.QNA;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.user.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Autowired
	UserService userService;
		
		@PostMapping(value="addUser" )
		public String addUser(@ModelAttribute User user, Model model ) throws Exception {

			System.out.println("addUser : POST");
			//Business Logic
			userService.addUser(user);
			
			return "redirect:/user/login.jsp";
		}	
		
		//
		// login(Get, Post)
		//
		
		@GetMapping( value="login")
		public String login(@ModelAttribute String userId, String password ,Model model) throws Exception {
			
			System.out.println("login : GET");
			
			userService.login(userId, password);
			
			System.out.println("login : " +userService.login(userId, password));

			return "redirect:/user/main.jsp";
		}
		
		//
		// logout(Get)
		//
		
		@GetMapping( value="logout")
		public String logout(HttpSession session) throws Exception{
			
			System.out.println("logout : GET");
			
			session.invalidate();
			
			return "redirect:/main.jsp";
		}
		
		//
		// findUserId
		//
		
		@GetMapping( value="findUserId")
		public String findUserId(@RequestParam String userName, String phoneNumber ,Model model, String userId) throws Exception {
			
			System.out.println("findUserId : GET");
			
			userService.findUserId(userName, phoneNumber);
			model.addAttribute("userId : " + userId);
			
			return "redirect:/user/findUserIdresult.jsp";
		}
		
		//
		// findUserId
		//
		
		@GetMapping( value="findUserPassword")
		public String findUserPassword(@RequestParam String userId, String phoneNumber ,Model model) throws Exception {
			
			System.out.println("findUserPassword : GET");
			
			userService.login(userId, phoneNumber);

			return "redirect:/user/setUserPassword.jsp";
		}
		
		//
		// setUserPassword //////////////////////////////////////////
		//
		
		@GetMapping( value="setUserPassword")
		public String setUserPassword(@RequestParam String userId, String userPassword ,Model model) throws Exception {
			
			System.out.println("setUserPassword : GET");
			
			userService.login(userId, userPassword);

			return "redirect:/user/login.jsp";
		}
		
		//
		// getUser
		//
		
		@GetMapping( value="getUser")
		public String getUser( @RequestParam int userNo , Model model ) throws Exception {
			
			System.out.println("getUser : GET");
			//Business Logic
			User user = userService.getUser(userNo);
			// Model °ú View ¿¬°á
			model.addAttribute("user", user);
			
			return "forward:/user/getUser.jsp";
		}
		
		//
		// updateUser
		//
		
		@PostMapping( value="updateUser")
		public String updateUser(@ModelAttribute User user , Model model , HttpSession session) throws Exception {

			System.out.println("updateUser : POST");
			//Business Logic
			userService.updateUser(user);
			
			String sessionId=((User)session.getAttribute("user")).getUserId();
			if(sessionId.equals(user.getUserId())){
				session.setAttribute("user", user);
			}
			
			return "redirect:/user/getUser?userNo="+user.getUserNo();
		}
		
		//
		// deleteUser
		//
		
		@GetMapping( value="deleteUser")
		public String deleteUser(@RequestParam int userNo ,Model model) throws Exception {
			
			System.out.println("deleteUser : GET");
			
			userService.deleteUser(userNo);

			return "redirect:/user/main.jsp";
		}
		
		//
		// ---------------> QNA
		//
		
		//
		// addQnA
		//
		
		@PostMapping(value="addQnA" )
		public String addQnA(@ModelAttribute QNA qna, Model model ) throws Exception {

			System.out.println("addQnA : POST");
			
			userService.addQnA(qna);
			
			return "redirect:/user/getQnA.jsp";
		}	
		
		//
		// getQnA
		//
		
		@GetMapping( value="getQnA")
		public String getQnA(@RequestParam int postNo ,Model model) throws Exception {
			
			System.out.println("getQnA : GET");
			
			userService.getQnA(postNo);

			return "redirect:/user/getQnAList.jsp";
		}
		
		//
		// addAdminAnswer
		//
		
		@PostMapping(value="addAdminAnswer" )
		public String addAdiminAnswer(@ModelAttribute QNA qna, Model model ) throws Exception {

			System.out.println("addAdminAnswer : POST");
			
			userService.addAdminAnswer(qna);
			
			return "redirect:/user/getQnA.jsp";
		}	
}
