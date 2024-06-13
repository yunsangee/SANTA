package site.dearmysanta.web.user;

import java.util.ArrayList;
import java.util.Date;
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
import site.dearmysanta.domain.user.Schedule;
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
		
		@GetMapping(value = "login")
		public String login(@ModelAttribute String userId, String password, Model model, HttpSession session) throws Exception {
		    System.out.println("login : GET");
		    
		    // �α��� ó��
		    User user = userService.login(userId, password);
		    System.out.println("login : " + user);
		    
		    // �α��ο� �����ϸ� ���ǿ� userNo ����
		    if (user != null) {
		        session.setAttribute("userNo", user.getUserNo());
		    }
		    
		    return "redirect:/user/login.jsp";
		}
		
//		@GetMapping(value = "login")
//		public String login(@RequestParam String userId, String password, Model model, HttpSession session) {
//		    try {
//		        // �α��� �õ� 
//		        User user = userService.login(userId, password);
//		        // �α��� ���� �� 
//		        if (user != null) {
//		            // ���ǿ� ����� ���� ���� 
//		            session.setAttribute("user", user); 
//		            // �α��� ���� �������� �����̷�Ʈ
//		            return "redirect:/user/main.jsp";
//		        } else {
//		            // ����ڰ� �������� �ʴ� ���
//		            model.addAttribute("error", "����ڸ� ã�� �� �����ϴ�.");
//		            // �α��� �������� �̵�
//		            System.out.println("login : " +user); 
//		            return "redirect:/user/login.jsp";
//		        }
//		    } catch (Exception e) {
//		        // ���� ó��
//		        model.addAttribute("error", "�α��ο� �����߽��ϴ�.");
//		        // �α��� �������� �̵�
//		        System.out.println("login error : ");
//		        return "redirect:/user/login.jsp";
//		    }
//		}

//		@PostMapping(value = "login")
//		public String login(@ModelAttribute String userId, String userPassword, HttpSession session, Model model) throws Exception {
//		    System.out.println("login : POST");
//
//		    // DB���� ����� ���� ��ȸ
//		    User dbUser = userService.login(userId, userPassword);
//
//		    System.out.println("Ȯ�� : " +dbUser);
//		    
//		    // ����ڰ� �����ϴ��� Ȯ��
//		    if (dbUser == null) {
//		        model.addAttribute("error", "����ڸ� ã�� �� �����ϴ�.");
//		        return "redirect:/user/login.jsp";
//		    }
//
//		    System.out.println("dbUser : " + dbUser);
//
//		    // ��й�ȣ ��ġ ���� Ȯ��
//		    if (userPassword.equals(dbUser.getUserPassword())) {
//		        session.setAttribute("user", dbUser);
//		        return "forward:/user/main.jsp";
//		    } else {
//		        model.addAttribute("error", "��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
//		        return "redirect:/user/login.jsp";
//		    }
//		}
		
		@PostMapping(value = "login")
		public String login(@ModelAttribute User user, String userId, String userPassword, HttpSession session, Model model) throws Exception {
		    System.out.println("/user/login : POST");
		    
		    // DB���� ����� ���� ��ȸ
		    User dbUser = userService.getUserByUserId(user.getUserId());
		    
		    System.out.println("Ȯ�� : " +dbUser);
		    
		    // ����ڰ� �����ϴ��� Ȯ��
		    if (dbUser == null) {
		        model.addAttribute("error", "����ڸ� ã�� �� �����ϴ�.");
		        return "redirect:/user/login.jsp";
		    }
		    
		    System.out.println("dbUser : " + dbUser);
		    System.out.println("user : " + user);
		    
		    // ��й�ȣ ��ġ ���� Ȯ��
		    if (user.getUserPassword().equals(dbUser.getUserPassword())) {
		        session.setAttribute("user", dbUser);
		        return "forward:/user/main.jsp";
		    } else {
		        model.addAttribute("error", "��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
		        return "redirect:/user/login.jsp";
		    }
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
		
		@PostMapping( value="findUserId")
		public String findUserId(@ModelAttribute User user ,Model model) throws Exception {
			
			System.out.println("findUserId : Post");
			
			System.out.println("name" +user.getUserName());
			System.out.println("phoneNumber" +user.getPhoneNumber());
			
			
			String find = userService.findUserId(user.getUserName(), user.getPhoneNumber());
			
			model.addAttribute("userId" , find);
			
			System.out.println("user : " +find);
			
			return "forward:/user/findUserIdresult.jsp";
		}
		
		//
		// findUserPassword
		//
		
		@PostMapping( value="findUserPassword")
		public String findUserPassword(@ModelAttribute User user ,Model model) throws Exception {
			
			System.out.println("findUserPassword : POST");
			
			System.out.println("id :" +user.getUserId());
			System.out.println("phoneNumber : " +user.getPhoneNumber());
			
			String find = userService.findUserPassword(user.getUserId(), user.getPhoneNumber());
			
			model.addAttribute("userPassword" , find);
			model.addAttribute("userId" , user.getUserId());
			
			System.out.println("userPassword : " +find);

			return "forward:/user/setUserPassword.jsp";
		}
		
		//
		// setUserPassword //////////////////////////////////////////
		//
		
//		@PostMapping( value="setUserPassword")
//		public String setUserPassword(@RequestParam String userPassword, Model model) throws Exception {
//			
//			System.out.println("setUserPassword : GET");
//			
//			userService.setUserPassword(userPassword);
//
//			return "redirect:/user/login.jsp";
//		}
		
		@PostMapping(value = "setUserPassword")
		public String setUserPassword(@ModelAttribute User user, Model model) throws Exception {
		    
			System.out.println("setUserPassword : POST");
			
			System.out.println("userId : " +user.getUserId());

		    // ������� ���̵�� ��ȭ��ȣ�� ���� ��й�ȣ ��������
		    String currentPassword = user.getUserPassword();
		    
		    //System.out.println("find : " +findAttribute);
		    System.out.println("password : " +currentPassword);

		    // ���ο� ��й�ȣ Ȯ��
		    String newPassword = user.getPasswordNew(); // ����ڰ� �Է��� ���ο� ��й�ȣ
		    
		    System.out.println("newPassword : " +newPassword);
		    
		    // ���ο� ��й�ȣ Ȯ�ο� ��й�ȣ
		    String confirmPassword = user.getCheckPassword(); // ����ڰ� �Է��� ���ο� ��й�ȣ Ȯ�ο�
		    
		    System.out.println("confirmPassword : " +confirmPassword);
		    
		    if (!newPassword.equals(confirmPassword)) {
		        // ���ο� ��й�ȣ�� ��й�ȣ Ȯ���� ��ġ���� �ʴ� ���
		        model.addAttribute("error", "��й�ȣ�� ��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
		        return "redirect:/user/setUserPassword.jsp";
		    }

		    if (newPassword.equals(currentPassword)) {
		        // ���ο� ��й�ȣ�� ���� ��й�ȣ�� ���� ���
		        model.addAttribute("error", "���ο� ��й�ȣ�� ���� ��й�ȣ�� �޶�� �մϴ�.");
		        return "redirect:/user/setUserPassword.jsp";
		    }

		    // ����� ��й�ȣ�� �����ϰų� ó���ϴ� ���� �߰�
		    userService.setUserPassword(user.getUserId(), newPassword);
		    
		    // ����� ��й�ȣ�� ��� ����
		    model.addAttribute("userPassword", newPassword);
		    
		    System.out.println("newPassword2 : " +newPassword);

		    return "forward:/user/main.jsp";
		}


		
		//
		// getUser
		//
		
//		@GetMapping( value="getUser")
//		public String getUser( @RequestParam String userId , Model model ) throws Exception {
//			
//			System.out.println("getUser : GET");
//			//Business Logic
//			User user = userService.getUser(userId);
//			// Model �� View ����
//			model.addAttribute("user", user);
//			
//			return "forward:/user/getUser.jsp";
//		}
		
		@GetMapping(value = "getUser")
		public String getUser(@RequestParam(required = false) Integer userNo, HttpSession session, Model model) throws Exception {
		    System.out.println("getUser : GET");

		    User sessionUser = (User) session.getAttribute("user");
		    User user = null;

		    if (userNo != null) {
		        // ��û �Ű������� ���� userNo�� �ִ� ���
		        user = userService.getUser(userNo);
		        System.out.println("getUser: userNo from request parameter = " + userNo);
		    } else if (sessionUser != null) {
		        // ���ǿ��� ���� �α����� ����� ���� ��������
		        user = userService.getUser(sessionUser.getUserNo());
		        System.out.println("getUser: sessionUser = " + sessionUser.getUserNo());
		    } else {
		        System.out.println("getUser: No userNo provided and no sessionUser");
		        model.addAttribute("error", "����ڸ� ã�� �� �����ϴ�.");
		        return "redirect:/user/login.jsp";
		    }

		    // ����� ���� �𵨿� �߰�
		    model.addAttribute("user", user);

		    return "forward:/user/getUser.jsp";
		}

		
		//
		// updateUser
		//
		
//		@PostMapping( value="updateUser")
//		public String updateUser(@ModelAttribute User user , Model model , HttpSession session) throws Exception {
//
//			System.out.println("updateUser : POST");
//			//Business Logic
//			userService.updateUser(user);
//			
//			int sessionNo = ((User) session.getAttribute("user")).getUserNo();
//			if (sessionNo == user.getUserNo()) {
//			    session.setAttribute("user", user);
//			}
//
//			
//			return "forward:/user/getUser?userNo="+user.getUserNo();
//		}
//		
		
		@GetMapping( value="updateUser")
		public String updateUser( @RequestParam int userNo , Model model ) throws Exception {

			System.out.println("updateUser : GET");
			//Business Logic
			User user = userService.getUser(userNo);
			// Model �� View ����
			model.addAttribute("user", user);
			
			return "forward:/user/updateUser.jsp";
		}
		
		
		@PostMapping(value = "updateUser")
		public String updateUser(@ModelAttribute User user, @RequestParam(required = false) Integer userNo, Model model, HttpSession session) throws Exception {
		    System.out.println("updateUser : POST");

		    // ���ǿ��� ���� �α����� ����� ���� ��������
		    User sessionUser = (User) session.getAttribute("user");

		    // ���� ����� ���� �α� ���
		    if (sessionUser != null) {
		        System.out.println("updateUser: sessionUser = " + sessionUser.getUserId());
		    } else {
		        System.out.println("updateUser: sessionUser is null");
		    }

		    // ���ǿ� �α����� ����� ������ �ִ��� Ȯ��
		    if (sessionUser == null) {
		        // �α������� ���� ��� �α��� �������� �����̷�Ʈ
		        model.addAttribute("error", "�α����� �ʿ��մϴ�.");
		        return "redirect:/user/login.jsp";
		    }

		    // ������Ʈ�Ϸ��� ����� ��ȣ ����
		    int targetUserNo = (userNo != null) ? userNo : sessionUser.getUserNo();

		    // DB���� �ֽ� ����� ���� ��������
		    User dbUser = userService.getUser(targetUserNo);

		    if (dbUser == null) {
		        model.addAttribute("error", "����ڸ� ã�� �� �����ϴ�.");
		        return "redirect:/user/updateUser.jsp";
		    }

		    // ����� ���� ������Ʈ
		    dbUser.setNickName(user.getNickName());
		    dbUser.setAddress(user.getAddress());
		    dbUser.setPhoneNumber(user.getPhoneNumber());
		    dbUser.setProfileImage(user.getProfileImage());
		    dbUser.setHikingPurpose(user.getHikingPurpose());
		    dbUser.setHikingDifficulty(user.getHikingDifficulty());
		    dbUser.setHikingLevel(user.getHikingLevel());
		    dbUser.setIntroduceContent(user.getIntroduceContent());
		    // �ʿ��� �ٸ� �ʵ嵵 ������Ʈ

		    userService.updateUser(dbUser);

		    // ���ǿ� �α����� ����ڿ� ������Ʈ�� ����ڰ� ������ ���, ���� ������ ������Ʈ
		    if (sessionUser.getUserNo() == dbUser.getUserNo()) {
		        session.setAttribute("user", dbUser);
		    }

		    System.out.println("updateUser : " + dbUser);

		    // ������Ʈ ���� �������� �����̷�Ʈ
		    return "redirect:/user/getUser?userNo=" + dbUser.getUserNo();
		}


		
		//
		// deleteUser
		//
		
		@PostMapping(value="deleteUser")
		public String deleteUser(@ModelAttribute User user, @RequestParam(required = false) Integer userNo, Model model, HttpSession session) throws Exception {
		    
		    System.out.println("deleteUser : POST");
		    
		    // ���ǿ��� ���� �α����� ����� ���� ��������
		    User sessionUser = (User) session.getAttribute("user");

		    // ���� ����� ���� �α� ���
		    if (sessionUser != null) {
		        System.out.println("deleteUser: sessionUser = " + sessionUser.getUserId());
		    } else {
		        System.out.println("deleteUser: sessionUser is null");
		    }

		    // ���ǿ� �α����� ����� ������ �ִ��� Ȯ��
		    if (sessionUser == null) {
		        // �α������� ���� ��� �α��� �������� �����̷�Ʈ
		        model.addAttribute("error", "�α����� �ʿ��մϴ�.");
		        return "redirect:/user/login.jsp";
		    }

		    // ������Ʈ�Ϸ��� ����� ��ȣ ����
		    int targetUserNo = (userNo != null) ? userNo : sessionUser.getUserNo();

		    // DB���� �ֽ� ����� ���� ��������
		    User dbUser = userService.getUser(targetUserNo);

		    if (dbUser == null) {
		        model.addAttribute("error", "����ڸ� ã�� �� �����ϴ�.");
		        return "redirect:/user/updateUser.jsp";
		    }

		    // ����� ���� ������Ʈ
		    dbUser.setWithdrawReason(user.getWithdrawReason());
		    
		    //userService.updateUser(dbUser);
		    
		    userService.deleteUser(dbUser);
		    
		    User dbUser2 = userService.getUser(targetUserNo);

		    // ���ǿ� �α����� ����ڿ� ������Ʈ�� ����ڰ� ������ ���, ���� ������ ��ȿȭ
		    if (sessionUser.getUserNo() == dbUser2.getUserNo()) {
		        session.invalidate(); // ���� ��ȿȭ
		    }

		    System.out.println("deleteUser : " + dbUser2);

		    // Ż�� ���� �� ���� �������� �����̷�Ʈ
		    return "redirect:/user/main.jsp";
		}
		
		//
		// ---------------> QNA
		//
		
		//
		// addQnA
		//
		
//		@PostMapping(value="addQnA" )
//		public String addQnA(@ModelAttribute QNA qna, Model model ) throws Exception {
//
//			System.out.println("addQnA : POST");
//			
//			userService.addQnA(qna);
//			
//			return "redirect:/user/getQnA.jsp";
//		}
		
		@PostMapping(value = "addQnA")
		public String addQnA(@ModelAttribute QNA qna, Model model, HttpSession session) throws Exception {
		    
			System.out.println("addQnA : POST");

		    // ���ǿ��� ���� �α����� ����� ���� ��������
		    User sessionUser = (User) session.getAttribute("user");

		    if (sessionUser == null) {
		        // �α������� ���� ��� �α��� �������� �����̷�Ʈ
		        model.addAttribute("error", "�α����� �ʿ��մϴ�.");
		        return "redirect:/user/login.jsp";
		    }

		    // QNA ��ü�� ����� ���� ����
		    qna.setUserNo(sessionUser.getUserNo());
		    qna.setNickName(sessionUser.getNickName());
		    qna.setProfileImage(sessionUser.getProfileImage());

		    // QNA �߰�
		    userService.addQnA(qna);
		    
		    session.setAttribute("qna", qna);
		    
		    System.out.println("addQnA : " + qna);

		    return "redirect:/user/getQnA.jsp";
		}

		
		//
		// getQnA
		//
		
//		@GetMapping( value="getQnA")
//		public String getQnA(@RequestParam int postNo ,Model model) throws Exception {
//			
//			System.out.println("getQnA : GET");
//			
//			userService.getQnA(postNo);
//
//			return "redirect:/user/getQnAList.jsp";
//		}
		
		@GetMapping(value = "getQnA")
		public String getQnA(@RequestParam(required = false) Integer postNo, @RequestParam(required = false) Integer userNo, HttpSession session, Model model) throws Exception {
		    
			System.out.println("getQnA : GET");

		    // ���ǿ��� �α����� ����� ���� ��������
		    User user = (User) session.getAttribute("user");

		    QNA qna = userService.getQnA(postNo, userNo);

//		    if (user == null) {
//		        // �α����� ����� ������ ���� ��� ���� ó��
//		        model.addAttribute("error", "�α��� ������ ã�� �� �����ϴ�.");
//		        return "redirect:/login"; // �α��� �������� �����̷�Ʈ �Ǵ� �ٸ� ó��
//		    }

		    if (qna == null) {
		        // QNA ������ ���� ��� ���� ó��
		        model.addAttribute("error", "QNA ������ ã�� �� �����ϴ�.");
		        return "redirect:/user/addQnA.jsp";
		    }

		    if (postNo != null && qna.getPostNo() == postNo) {
		        // �Խù� ��ȣ�� ��ȸ�ϴ� ���
		        model.addAttribute("qna", qna);
		        return "forward:/user/getQnA.jsp";
		    } else if (userNo != null && qna.getUserNo() == userNo) {
		        // ����� ��ȣ�� ��ȸ�ϴ� ���
		        model.addAttribute("qna", qna);
		        return "forward:/user/getQnA.jsp";
		    } else {
		        // �߸��� ��û ó��
		        model.addAttribute("error", "�ùٸ� ��û�� �ƴմϴ�.");
		        return "redirect:/user/addQnA.jsp";
		    }
		}
		
		//
		// addAdminAnswer
		//
		
//		@PostMapping(value="addAdminAnswer" )
//		public String addAdiminAnswer(@ModelAttribute QNA qna, Model model ) throws Exception {
//
//			System.out.println("addAdminAnswer : POST");
//			
//			userService.addAdminAnswer(qna);
//			
//			return "redirect:/user/getQnA.jsp";
//		}
		
		@GetMapping(value="addAdminAnswer")
		public String showAddAdminAnswerForm(@RequestParam int postNo, @RequestParam int userNo, Model model) throws Exception {
		   
			System.out.println("addAdminAnswer : GET");
		    
			// Business Logic
		    QNA qna = userService.getQnA(postNo, userNo);
		    
		    // Model �� View ����
		   model.addAttribute("qna", qna);
		    
		   return "forward:/user/addAdminAnswer.jsp";
		}
		
		@PostMapping(value = "addAdminAnswer")
		public String addAdminAnswer(@ModelAttribute QNA qna, Model model, HttpSession session) throws Exception {
		    System.out.println("addAdminAnswer : POST");
		  
		    System.out.println("postNo : " +qna.getPostNo());
		    System.out.println("userNo : " +qna.getUserNo());	    
		    
		    // ���ǿ��� �α����� ������ ���� ��������
		    User admin = (User) session.getAttribute("user");
		    
		    System.out.println("admin login : " +admin);
		    
		    // ���ǿ� �α����� ������ ������ �ִ��� Ȯ��
		    if (admin.getRole() == 0) {
		        // �����ڰ� �ƴ� ��� ���� ó��
		        model.addAttribute("error", "�����ڸ� ������ �� �ֽ��ϴ�.");
		        return "redirect:/admin/login.jsp";
		    }
		    
		    // QNA ���� ��ȸ
		    QNA dbqna = userService.getQnA(qna.getPostNo(), qna.getUserNo());
		    
		    // ������ �亯 �߰�
		    dbqna.setAdminAnswer(qna.getAdminAnswer());

		    // QNA ������Ʈ
		    userService.addAdminAnswer(dbqna);
		    
		    model.addAttribute("qna", dbqna);

		    System.out.println("addAdminAnswer : " + dbqna);

		    return "forward:/user/getQnA.jsp";
		}

		//
		// ---------------> SCHEDULE
		//
		
		//
		// addSchedule
		//
		
//		@PostMapping(value="addSchedule" )
//		public String addSchedule(@ModelAttribute Schedule schedule, Model model ) throws Exception {
//
//			System.out.println("addQnA : POST");
//			
//			userService.addQnA(qna);
//			
//			return "redirect:/user/getQnA.jsp";
//		}
		
		@PostMapping(value = "addSchedule")
		public String addSchedule(@ModelAttribute Schedule schedule, Model model, HttpSession session) throws Exception {
		    
			System.out.println("addSchedule : POST");

		    // ���ǿ��� ���� �α����� ����� ���� ��������
		    User sessionUser = (User) session.getAttribute("user");

		    if (sessionUser == null) {
		        // �α������� ���� ��� �α��� �������� �����̷�Ʈ
		        model.addAttribute("error", "�α����� �ʿ��մϴ�.");
		        return "redirect:/user/login.jsp";
		    }

		    // SCHEDULE ��ü�� ����� ���� ����
		    schedule.setUserNo(sessionUser.getUserNo());

		    // SCHEDULE �߰�
		    userService.addSchedule(schedule);
		    
		    session.setAttribute("schedule", schedule);
		    
		    System.out.println("addSchedule : " + schedule);

		    return "forward:/user/getSchedule.jsp";
		}
		
		@GetMapping(value = "getSchedule")
		public String getSchedule(@RequestParam(required = false) Integer postNo, @RequestParam(required = false) Integer userNo, HttpSession session, Model model) throws Exception {
		    
			System.out.println("getSchedule : GET");

		    // ���ǿ��� �α����� ����� ���� ��������
		    User user = (User) session.getAttribute("user");

		    Schedule schedule = userService.getSchedule(postNo, userNo);

//		    if (user == null) {
//		        // �α����� ����� ������ ���� ��� ���� ó��
//		        model.addAttribute("error", "�α��� ������ ã�� �� �����ϴ�.");
//		        return "redirect:/login"; // �α��� �������� �����̷�Ʈ �Ǵ� �ٸ� ó��
//		    }

		    if (schedule == null) {
		        // Schedule ������ ���� ��� ���� ó��
		        model.addAttribute("error", "Schedule ������ ã�� �� �����ϴ�.");
		        return "redirect:/user/addSchedule.jsp";
		    }

		    if (userNo != null && schedule.getUserNo() == userNo) {
		        // ����� ��ȣ�� ��ȸ�ϴ� ���
		        model.addAttribute("schedule", schedule);
		        return "forward:/user/getSchedule.jsp";
		    } else {
		        // �߸��� ��û ó��
		        model.addAttribute("error", "�ùٸ� ��û�� �ƴմϴ�.");
		        return "redirect:/user/addSchedule.jsp";
		    }
		}
		
		
}
