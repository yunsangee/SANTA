package site.dearmysanta.web.user;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.alarmMessage.AlarmMessage;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.correctionPost.CorrectionPost;
import site.dearmysanta.domain.user.QNA;
import site.dearmysanta.domain.user.Schedule;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.common.ObjectStorageService;
import site.dearmysanta.service.correctionpost.CorrectionPostService;
import site.dearmysanta.service.mountain.MountainService;
import site.dearmysanta.service.user.UserService;
import site.dearmysanta.service.user.etc.UserEtcService;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	MountainService mountainService;
	
	@Autowired
	UserEtcService userEtcService; 
	
	@Value("${pageSize}")
	private int pageSize;
	
	@Value("${pageUnit}")
	private int pageUnit;
	
	@Autowired
	private ObjectStorageService objectStorageService;
	
	ObjectMapper objectMapper = new ObjectMapper();
	
	public UserController() {
		SantaLogger.makeLog("info", this.getClass().toString());
	}
		
		//
		// addUser(Post)
		//
	
		@PostMapping(value="addUser" )
		public String addUser(@ModelAttribute User user, Model model ) throws Exception {

			System.out.println("addUser : POST");
			
			String addPassword = user.getUserPassword();
		    
		    System.out.println("addPassword : " +addPassword);
		    
		    // ���ο� ��й�ȣ Ȯ�ο� ��й�ȣ
		    String checkPassword = user.getCheckPassword(); // ����ڰ� �Է��� ���ο� ��й�ȣ Ȯ�ο�
		    
		    System.out.println("checkPassword : " +checkPassword);
		    
		    if (!addPassword.equals(checkPassword)) {
		        // ���ο� ��й�ȣ�� ��й�ȣ Ȯ���� ��ġ���� �ʴ� ���
		        model.addAttribute("error", "��й�ȣ�� ��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
		        return "redirect:/user/addUser.jsp";
		    }
			
			userService.addUser(user);
			
			return "redirect:/user/login.jsp";
		}	
		
		//
		// login(Get, Post)
		//
		
		@GetMapping(value = "login")
		public String login(@ModelAttribute String userId, String password, Model model, HttpSession session) throws Exception {
		    System.out.println("login : GET");
		    
		    // login
//		    User user = userService.login(userId, password);
//		    System.out.println("login : " + user);
//		    
//		    // success login -> session : userNo
//		    if (user != null) {
//		        session.setAttribute("userNo", user.getUserNo());
//		    }
		    
		    return "forward:/user/login.jsp";
		}	

		@PostMapping(value = "login")
		public String login(@ModelAttribute User user, String userId, String userPassword, HttpSession session, Model model, Search search, HttpServletResponse response) throws Exception {
		    System.out.println("/user/login : POST");
		    
		    // DB���� ����� ���� ��ȸ
		    User dbUser = userService.getUserByUserId(user.getUserId());
		    
		    System.out.println("Ȯ�� : " + dbUser);
		    
		    // ����ڰ� �����ϴ��� Ȯ��
		    if (dbUser == null || !dbUser.getUserPassword().equals(userPassword)) {
		        model.addAttribute("loginError", "���̵� Ȥ�� ��й�ȣ�� �߸��Ǿ����ϴ�. �ٽ� �Է����ּ���.");
		        return "forward:/user/login.jsp";
		    }
		    
		    System.out.println("dbUser : " + dbUser);
		    
		    // Ż���Ͻð� null���� Ȯ��
		    if (dbUser.getWithdrawDate() != null) {
		        model.addAttribute("withdrawError", "Ż���� ��Ÿ���Դϴ�.");
		        return "forward:/user/login.jsp";
		    }	
		    
		    if(dbUser.getProfileImage() != null && !dbUser.getProfileImage().contains("ncloudstorage")) {
		        dbUser.setProfileImage(objectStorageService.getImageURL(dbUser.getProfileImage()));
		    }
		    
		    session.setAttribute("user", dbUser);	
		    
		    // ��Ű ����
		    Cookie cookie = new Cookie("userNo", ""+dbUser.getUserNo());
		    cookie.setMaxAge(60 * 60 * 24 * 7); // ��Ű ��ȿ�Ⱓ 7�Ϸ� ����
		    cookie.setPath("/"); // ���ø����̼��� ��� ��ο� ���� ��ȿ
		    cookie.setHttpOnly(false); // Ŭ���̾�Ʈ �������� ���� �����ϵ��� ���� (���� �ʿ� �� true)
		    cookie.setSecure(false); // 
		    response.addCookie(cookie);
		    
		    // ��Ű ����
		    Cookie nickNameCookie = new Cookie("nickName", dbUser.getNickName());
		    nickNameCookie.setMaxAge(60 * 60 * 24 * 7); // ��Ű ��ȿ�Ⱓ 7�Ϸ� ����
		    nickNameCookie.setPath("/"); // ���ø����̼��� ��� ��ο� ���� ��ȿ
		    nickNameCookie.setHttpOnly(false); // Ŭ���̾�Ʈ �������� ���� �����ϵ��� ���� (���� �ʿ� �� true)
		    nickNameCookie.setSecure(false); // 
		    response.addCookie(nickNameCookie);
		    
		 // ��Ű ����
		    Cookie profileCookie = new Cookie("profile", dbUser.getProfileImage());
		    profileCookie.setMaxAge(60 * 60 * 24 * 7); // ��Ű ��ȿ�Ⱓ 7�Ϸ� ����
		    profileCookie.setPath("/"); // ���ø����̼��� ��� ��ο� ���� ��ȿ
		    profileCookie.setHttpOnly(false); // Ŭ���̾�Ʈ �������� ���� �����ϵ��� ���� (���� �ʿ� �� true)
		    profileCookie.setSecure(false); // 
		    response.addCookie(profileCookie);
		    
		    System.out.println("��ŰȮ�� �г��� : " + nickNameCookie);
		    
		    System.out.println("��ŰȮ�� userNo : " + cookie);
		    
		    System.out.println("��Ű ������ ���� : " + profileCookie);
		    
		    return "redirect:/common/main.jsp";
		}

		
		//
		// logout(Get)
		//
		
		@GetMapping( value="logout")
		public String logout(HttpSession session) throws Exception{
			
			System.out.println("logout : GET");
			
			session.invalidate();
			
			return "redirect:/common/main.jsp";
		}
		
		//
		// findUserId
		//
		
		@PostMapping( value="findUserId")
		public String findUserId(@ModelAttribute User user , HttpServletRequest request, Model model) throws Exception {
			
			System.out.println("findUserId : Post");
			
			System.out.println("name" +user.getUserName());
			System.out.println("phoneNumber" +user.getPhoneNumber());
			
			
			String userId = userService.findUserId(user.getUserName(), user.getPhoneNumber());
			
			if (userId != null) {
	            request.getSession().setAttribute("userId", userId);
	            return "redirect:/user/findUserIdresult.jsp";
	        } else {
	            model.addAttribute("errorMessage", "�̸��� ��ȭ��ȣ�� ��ġ���� �ʽ��ϴ�.");
	            return "redirect:/user/findUserIdresult.jsp";
	        }
	    }

		
		//
		// findUserPassword
		//
		
		@PostMapping(value="findUserPassword")
		public String findUserPassword(@ModelAttribute User user, HttpServletRequest request, Model model) throws Exception {
		    System.out.println("findUserPassword : POST");
		    System.out.println("id :" + user.getUserId());
		    System.out.println("phoneNumber : " + user.getPhoneNumber());

		    String userPassword = userService.findUserPassword(user.getUserId(), user.getPhoneNumber());

		    if (userPassword != null) {
		        request.getSession().setAttribute("userPassword", userPassword);
		        request.getSession().setAttribute("userId", user.getUserId());
		        return "forward:/user/setUserPassword.jsp";
		    } else {
		        model.addAttribute("errorMessage", "���̵�� ��ȭ��ȣ�� ��ġ���� �ʽ��ϴ�.");
		        return "redirect:/user/findUserPassword.jsp";
		    }
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
		    
		    System.out.println("user : " +sessionUser);    
		    
		    User user = null;

		    if (userNo!=null) {
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
		    
		    if (sessionUser.getRole()==1) {
		    	
		    	model.addAttribute("admin", 1);
		    	
		    }
		    
		    String profileImage = objectStorageService.getImageURL(user.getUserId());
			
			user.setProfileImage(profileImage);

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
		public String updateUser(@RequestParam int userNo , Model model ) throws Exception {

			System.out.println("updateUser : GET");
			//Business Logic
			User user = userService.getUser(userNo);
			// Model �� View ����
			
			String profileImage = objectStorageService.getImageURL(user.getUserId());
			
			user.setProfileImage(profileImage);
			
			System.out.println("user :" +user);
			
			model.addAttribute("user", user);	
			
			return "forward:/user/updateUser.jsp";
		}
		
		
		@PostMapping(value = "updateUser")
		public String updateUser(@ModelAttribute User user, @RequestParam(required = false) Integer userNo, Model model, HttpSession session, HttpServletResponse response) throws Exception {
		    System.out.println("updateUser : POST");

		    if (user.getImage() != null) {
		        objectStorageService.uploadFile(user.getImage(), user.getUserId());
		    }

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
		    dbUser.setDetailAddress(user.getDetailAddress());
		    dbUser.setPhoneNumber(user.getPhoneNumber());
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
		    
		    // ��Ű ����
		    Cookie cookie = new Cookie("userNo", ""+dbUser.getUserNo());
		    cookie.setMaxAge(60 * 60 * 24 * 7); // ��Ű ��ȿ�Ⱓ 7�Ϸ� ����
		    cookie.setPath("/"); // ���ø����̼��� ��� ��ο� ���� ��ȿ
		    cookie.setHttpOnly(false); // Ŭ���̾�Ʈ �������� ���� �����ϵ��� ���� (���� �ʿ� �� true)
		    cookie.setSecure(false); // 
		    response.addCookie(cookie);

		    // ��Ű ����
		    Cookie nickNameCookie = new Cookie("nickName", dbUser.getNickName());
		    nickNameCookie.setMaxAge(60 * 60 * 24 * 7); // ��Ű ��ȿ�Ⱓ 7�Ϸ� ����
		    nickNameCookie.setPath("/"); // ���ø����̼��� ��� ��ο� ���� ��ȿ
		    nickNameCookie.setHttpOnly(false); // Ŭ���̾�Ʈ �������� ���� �����ϵ��� ���� (���� �ʿ� �� true)
		    nickNameCookie.setSecure(false); // 
		    response.addCookie(nickNameCookie);
		    
			 // ��Ű ����
		    Cookie profileCookie = new Cookie("profile", dbUser.getProfileImage());
		    profileCookie.setMaxAge(60 * 60 * 24 * 7); // ��Ű ��ȿ�Ⱓ 7�Ϸ� ����
		    profileCookie.setPath("/"); // ���ø����̼��� ��� ��ο� ���� ��ȿ
		    profileCookie.setHttpOnly(false); // Ŭ���̾�Ʈ �������� ���� �����ϵ��� ���� (���� �ʿ� �� true)
		    profileCookie.setSecure(false); // 
		    response.addCookie(profileCookie);
		  
		    System.out.println("��ŰȮ�� �г��� : " + nickNameCookie);
		    
		    System.out.println("��ŰȮ�� ���̵� : " + cookie);
		    
		    System.out.println("��ŰȮ�� ������ : " +profileCookie);
		    
		    System.out.println("updateUser : " + dbUser);

		    // ������Ʈ ���� �������� �����̷�Ʈ
		    return "redirect:/user/getUser?userNo=" + dbUser.getUserNo();
		}
		
		//
		// deleteUser
		//
			
		@GetMapping( value="deleteUser")
		public String deleteUser(@RequestParam int userNo , Model model ) throws Exception {

			System.out.println("deleteUser : GET");
			//Business Logic
			User user = userService.getUser(userNo);
			// Model �� View ����
			model.addAttribute("user", user);
			
			return "forward:/user/deleteUser.jsp";
		}
		
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
		    dbUser.setWithdrawContent(user.getWithdrawContent());    
		    //userService.updateUser(dbUser);
		    
		    userService.deleteUser(dbUser);
		    
		    User dbUser2 = userService.getUser(targetUserNo);

		    // ���ǿ� �α����� ����ڿ� ������Ʈ�� ����ڰ� ������ ���, ���� ������ ��ȿȭ
		    if (sessionUser.getUserNo() == dbUser2.getUserNo()) {
		        session.invalidate(); // ���� ��ȿȭ
		    }

		    System.out.println("deleteUser : " + dbUser2);

		    // Ż�� ���� �� ���� �������� �����̷�Ʈ
		    return "redirect:/common/main.jsp";
		    
		   // return "redirect:/user/getUser?userNo=" + dbUser.getUserNo();
		}
		
		//
		// getUserList(GET)
		//
		
		@GetMapping(value = "getUserList")
		public String getUserList(@ModelAttribute Search search, Model model, HttpSession session) throws Exception {
		    System.out.println("getUserList : GET");

		    if (search != null && search.getCurrentPage() == 0) {
		        search.setCurrentPage(1);
		    }

		    int pageSize = this.pageSize; // �������� �׸� ��
		    int pageUnit = this.pageUnit; // ������ �׺���̼ǿ� ǥ���� ������ ��
		    int currentPage = search.getCurrentPage();

		    // ���ǿ��� �α����� ������ ���� ��������
		    User admin = (User) session.getAttribute("user");

		    System.out.println("admin login : " + admin);

		    // ���ǿ� �α����� ������ ������ �ִ��� Ȯ��
		    if (admin.getRole() == 0) {
		        // �����ڰ� �ƴ� ��� ���� ó��
		        model.addAttribute("error", "�����ڸ� ������ �� �ֽ��ϴ�.");
		        return "redirect:/user/login.jsp";
		    }

		    List<User> userList = userService.getUserList(search);

		    System.out.println("userList : " + userList);

		    int totalCount = userList.size(); // �� ����� ��
		    int totalPages = (int) Math.ceil((double) totalCount / pageSize); // �� ������ �� ���

		    // ����¡ ó���� ���� startRow�� endRow ���
		    int startRow = (currentPage - 1) * pageSize;
		    int endRow = Math.min(startRow + pageSize, totalCount);
		    List<User> paginatedUserList = userList.subList(startRow, endRow);

		    int currentPageCount = paginatedUserList.size(); // ���� �������� ǥ�õǴ� ȸ�� ��

		    model.addAttribute("userList", paginatedUserList);
		    model.addAttribute("search", search);
		    model.addAttribute("currentPage", currentPage);
		    model.addAttribute("totalPages", totalPages);
		    model.addAttribute("totalCount", totalCount);
		    model.addAttribute("currentPageCount", currentPageCount);

		    return "forward:/user/getUserList.jsp";
		}

		
		//
		// withdrawUserList
		//
		
		@GetMapping(value="withdrawUserList")
		public String withUserList(@ModelAttribute Search search, Model model, HttpSession session) throws Exception {
		    System.out.println("withUserList : GET");

		    if (search != null && search.getCurrentPage() == 0) {
		        search.setCurrentPage(1);
		    }

		    int pageSize = this.pageSize; // �������� �׸� ��
		    int pageUnit = this.pageUnit; // ������ �׺���̼ǿ� ǥ���� ������ ��
		    int currentPage = search.getCurrentPage();

		    // ���ǿ��� �α����� ������ ���� ��������
		    User admin = (User) session.getAttribute("user");

		    System.out.println("admin login : " + admin);

		    // ���ǿ� �α����� ������ ������ �ִ��� Ȯ��
		    if (admin.getRole() == 0) {
		        // �����ڰ� �ƴ� ��� ���� ó��
		        model.addAttribute("error", "�����ڸ� ������ �� �ֽ��ϴ�.");
		        return "redirect:/user/login.jsp";
		    }

		    List<User> userList = userService.withdrawUserList(search);

		    System.out.println("userList : " + userList);

		    int totalCount = userList.size(); // �� ����� ��
		    int totalPages = (int) Math.ceil((double) totalCount / pageSize); // �� ������ �� ���

		    // ����¡ ó���� ���� startRow�� endRow ���
		    int startRow = (currentPage - 1) * pageSize;
		    int endRow = Math.min(startRow + pageSize, totalCount);
		    List<User> paginatedUserList = userList.subList(startRow, endRow);

		    int currentPageCount = paginatedUserList.size(); // ���� �������� ǥ�õǴ� ȸ�� ��

		    model.addAttribute("userList", paginatedUserList);
		    model.addAttribute("search", search);
		    model.addAttribute("currentPage", currentPage);
		    model.addAttribute("totalPages", totalPages);
		    model.addAttribute("totalCount", totalCount);
		    model.addAttribute("currentPageCount", currentPageCount);

		    return "forward:/user/getUserList.jsp";
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
		
		@GetMapping(value = "addQnA")
		public String addQnA(@RequestParam(required = false) Integer postNo, @RequestParam(required = false) Integer userNo, HttpSession session, Model model) throws Exception {
		    System.out.println("addQnA : GET");
		    
		    // ���ǿ��� �α����� ����� ���� ��������
		    User sessionUser = (User) session.getAttribute("user");
		    
		    System.out.println("user : " +sessionUser);
		    
		    User user = null;
		    
		    QNA qna = userService.getQnA(postNo, userNo);

//		    if (user == null) {
//		        // �α����� ����� ������ ���� ��� ���� ó��
//		        model.addAttribute("error", "�α��� ������ ã�� �� �����ϴ�.");
//		        return "redirect:/login"; // �α��� �������� �����̷�Ʈ �Ǵ� �ٸ� ó��
//		    }

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
		    }
		    
		    if (sessionUser.getRole()==1) {
		    	
		    	model.addAttribute("admin", 1);
		    	
		    }
		    
		    String profileImage = objectStorageService.getImageURL(user.getUserId());
			
			user.setProfileImage(profileImage);

		    
		    System.out.println("sessionUser : " +sessionUser);
		    
		    model.addAttribute("user", user);

		    return "forward:/user/getUser.jsp";
		}
		
		
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

		    return "forward:/user/getQnA.jsp";
		}

		
		//
		// getQnA
		//
		
		@GetMapping(value = "getQnA")
		public String getQnA(@RequestParam(required = false) Integer postNo, 
		                     @RequestParam(required = false) Integer userNo, 
		                     HttpSession session, 
		                     Model model) throws Exception {
		    
		    System.out.println("getQnA : GET");

		    // ���ǿ��� �α����� ����� ���� ��������
		    User sessionUser = (User) session.getAttribute("user");
		    
		    System.out.println("user : " + sessionUser);
		    
		    if (sessionUser == null) {
		        // �α����� ����� ������ ���� ��� ���� ó��
		        model.addAttribute("error", "�α��� ������ ã�� �� �����ϴ�.");
		        return "redirect:/login"; // �α��� �������� �����̷�Ʈ �Ǵ� �ٸ� ó��
		    }

		    QNA qna = userService.getQnA(postNo, userNo);

		    if (qna == null) {
		        // QNA ������ ���� ��� ���� ó��
		        model.addAttribute("error", "QNA ������ ã�� �� �����ϴ�.");
		        return "redirect:/user/addQnA.jsp";
		    }

		    model.addAttribute("qna", qna);
		    
		    if (sessionUser.getRole() == 1) {
		        model.addAttribute("admin", 1);
		    }
		    
		    model.addAttribute("user", sessionUser);

		    System.out.println("sessionUser : " + sessionUser);
		    
		    return "forward:/user/getQnA.jsp";
		
		}
			
		//
		// addAdminAnswer
		//
		
		@GetMapping(value="addAdminAnswer")
		public String addAdminAnswer(@RequestParam int postNo, @RequestParam int userNo, Model model) throws Exception {
		   
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
		// getQnAList
		//
		
		@GetMapping(value="getQnAList")
		 public String getQnAList(@ModelAttribute Search search, Model model, HttpSession session) throws Exception {
	        System.out.println("getQnAList : GET");

	        // ���ǿ��� ����� ���� ��������
	        User user = (User) session.getAttribute("user");
	        
	        if (user.getRole()==1) {
		    	
		    	model.addAttribute("admin", 1);
		    	
		    }

	        // ���� �������� ���� �ε��� ���
	        int currentPage = (search.getCurrentPage() == 0) ? 1 : search.getCurrentPage();
	        int startIndex = (currentPage - 1) * pageSize;
	        int endIndex = currentPage * pageSize;

	        List<QNA> allQnaList = userService.getQnAList(search);
	        int totalCount = allQnaList.size();

	        // �ʿ��� �������� �����͸� ����
	        List<QNA> qnaList = allQnaList.subList(
	            Math.min(startIndex, totalCount), 
	            Math.min(endIndex, totalCount)
	        );
	     
	        // ��ü �׸� �� �� ������ �� ���
	        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
	        
	        System.out.println("QNAList_controller : "+qnaList);

	        // �𵨿� ������ �߰�
	        model.addAttribute("qnaList", qnaList);
	        model.addAttribute("totalCount", totalCount);
	        model.addAttribute("totalPages", totalPages);
	        model.addAttribute("currentPage", currentPage);
	        model.addAttribute("currentPageCount", qnaList.size());

	        return "forward:/user/getQnAList.jsp";
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
			schedule.setScheduleDate(schedule.getStringDate());
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
		    Search search = new Search();
		    List<Schedule> scheduleList = userService.getScheduleList(sessionUser.getUserNo(), search);
		    ObjectMapper objectMapper = new ObjectMapper();
		    List<String> scheduleJson = new ArrayList<>();
		    for(Schedule sd : scheduleList) {
		    	  scheduleJson.add(objectMapper.writeValueAsString(sd));
		    }
		    
		    // �𵨿� ������ ��� �߰�
		    model.addAttribute("scheduleList", scheduleJson);

		    return "forward:/user/month-view.jsp";
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
		
		@GetMapping(value="updateSchedule")
		public String updateSchedule(@RequestParam int postNo, @RequestParam int userNo, Model model) throws Exception {
		   
			System.out.println("updateSchedule : GET");
		    
			// Business Logic
		    Schedule schedule = userService.getSchedule(postNo, userNo);
		    
		    // Model �� View ����
		   model.addAttribute("schedule", schedule);
		    
		   return "forward:/user/updateSchedule.jsp";
		}
		
		@PostMapping(value = "updateSchedule")
		public String updateSchedule(@ModelAttribute Schedule schedule, Model model, HttpSession session) throws Exception {
		   
			System.out.println("updateSchedule : POST");
		  
		    System.out.println("postNo : " +schedule.getPostNo());
		    System.out.println("userNo : " +schedule.getUserNo());	    
		    
		    // ���ǿ��� �α����� ������ ���� ��������
		    User sessionUser = (User) session.getAttribute("user");
		    
		    System.out.println("sessionUser : " +sessionUser);
		    
		    if (sessionUser == null) {
		        // �α������� ���� ��� �α��� �������� �����̷�Ʈ
		        model.addAttribute("error", "�α����� �ʿ��մϴ�.");
		        return "redirect:/user/login.jsp";
		    }
		    
		    // Schedule ���� ��ȸ
		    Schedule dbschedule = userService.getSchedule(schedule.getPostNo(), schedule.getUserNo());
		    
		 // SCHEDULE ��ü�� ����� ���� ����
		    schedule.setUserNo(sessionUser.getUserNo());
		    
		    // ������Ʈ
		    dbschedule.setTitle(schedule.getTitle());
		    dbschedule.setMountainName(schedule.getMountainName());
		    dbschedule.setHikingTotalTime(schedule.getHikingTotalTime());
		    dbschedule.setHikingAscentTime(schedule.getHikingAscentTime());
		    dbschedule.setHikingDescentTime(schedule.getHikingDescentTime());
		    dbschedule.setHikingDifficulty(schedule.getHikingDifficulty());
		    dbschedule.setTransportation(schedule.getTransportation());
		    dbschedule.setContents(schedule.getContents());
		    
		    // Schedule ������Ʈ
		    userService.updateSchedule(dbschedule);
		    
		    model.addAttribute("schedule", dbschedule);

		    System.out.println("updateSchedule : " + dbschedule);

		    //return "forward:/user/getSchedule.jsp";
		    
		    //"redirect:/user/getSchedule?userNo=" + dbUser.getUserNo();
		    return "redirect:/user/getSchedule?postNo=" + dbschedule.getPostNo() + "&userNo=" + dbschedule.getUserNo();

		}
		
		//
		//
		//
		
//		@GetMapping(value="getScheduleList")
//		public String getSchedulList(@ModelAttribute Search search, Model model, HttpSession session) throws Exception {
//			
//			System.out.println("getScheduleList : GET");
//			
//			if(search != null & search.getCurrentPage() == 0) {
//				search.setCurrentPage(1);
//			}
//
////			search.setPageSize(pageSize);
////			search.setPageUnit(pageUnit);
//		    
//		    // ���ǿ��� �α����� ����� ���� ��������
//		    User user = (User) session.getAttribute("user");
//			
//			List<Schedule> scheduleList = userService.getScheduleList(search);
//			
//			System.out.println("scheduleList : " + scheduleList);		
//			
//			model.addAttribute("schedule", scheduleList);
//			
//			return "forward:/user/month-view.jsp";
//		}
		
		@GetMapping(value="getScheduleList")
		public String getScheduleList(@ModelAttribute Search search, Model model, HttpSession session) throws Exception {
		    System.out.println("getScheduleList : GET");

		    // search �ʱ�ȭ
		    if (search != null && search.getCurrentPage() == 0) {
		        search.setCurrentPage(1);
		    }

		    // ���ǿ��� �α����� ����� ���� ��������
		    User user = (User) session.getAttribute("user");
		    
		    if (user == null) {
		        model.addAttribute("error", "�α����� �ʿ��մϴ�.");
		        return "redirect:/user/login.jsp";
		    }

		    // �α����� ������� ID�� ������� ������ ��� ��������
		    List<Schedule> scheduleList = userService.getScheduleList(user.getUserNo(), search);
		    
		    System.out.println("scheduleList : " + scheduleList);
		    
		    // Schedule ��ü�� JSON �������� ��ȯ�Ͽ� �𵨿� �߰�
		    ObjectMapper objectMapper = new ObjectMapper();
		    List<String> scheduleJson = new ArrayList<>();
		    for(Schedule schedule : scheduleList) {
		        scheduleJson.add(objectMapper.writeValueAsString(schedule));
		    }
		    
		    // �𵨿� ������ ��� �߰�
		    model.addAttribute("scheduleList", scheduleJson);
		    
		    return "forward:/user/month-view.jsp";
		}

		
		//
		//	updateAnswerQnA /////////////////////////////////////////////
		//
		
		@GetMapping(value="updateAnswerQnA")
		public String updateAnswerQnA(@RequestParam int postNo, @RequestParam int userNo, Model model) throws Exception {
		   
			System.out.println("updateAnswerQnA : GET");
		    
			// Business Logic
		    QNA qna = userService.getQnA(postNo, userNo);
		    
		    // Model �� View ����
		   model.addAttribute("qna", qna);
		    
		   return "forward:/user/updateAnswerQnA.jsp";
		}
		
		@PostMapping(value = "updateAnswer")
		public String updateAnswer(@ModelAttribute QNA qna, Model model, HttpSession session) throws Exception {
		    System.out.println("updateAnswer : POST");
		  
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

		    System.out.println("updateAnswer : " + dbqna);

		    return "forward:/user/getQnA.jsp";
		}
		
		//
		//
		//
		
		@PostMapping(value = "changePassword")
	    public String changePassword(@RequestParam String currentPassword,
	                                 @RequestParam String userPassword,
	                                 @RequestParam String checkPassword,
	                                 HttpSession session, Model model) throws Exception {
	        User sessionUser = (User) session.getAttribute("user");

	        if (sessionUser == null) {
	            model.addAttribute("error", "������ ����Ǿ����ϴ�. �ٽ� �α��� ���ּ���.");
	            return "redirect:/user/login.jsp";
	        }

	        if (!sessionUser.getUserPassword().equals(currentPassword)) {
	            model.addAttribute("error", "���� ��й�ȣ�� ��ġ���� �ʽ��ϴ�. �ٽ� �Է����ּ���.");
	            return "redirect:/user/changePassword.jsp";
	        }

	        if (userPassword.length() < 10) {
	            model.addAttribute("error", "��й�ȣ�� 10�� �̻� �Է����ּ���.");
	            return "redirect:/user/changePassword.jsp";
	        }

	        if (!userPassword.equals(checkPassword)) {
	            model.addAttribute("error", "��й�ȣ�� ��ġ���� �ʽ��ϴ�. �ٽ� �Է����ּ���.");
	            return "redirect:/user/changePassword.jsp";
	        }

	        sessionUser.setUserPassword(userPassword);
	        userService.updateUser(sessionUser);
	        session.setAttribute("user", sessionUser);
	        model.addAttribute("message", "��й�ȣ�� ���������� ����Ǿ����ϴ�.");
	        return "forward:/user/updateUser?userNo=" + sessionUser.getUserNo();
	    }
		
		//
		//
		//
		
		@PostMapping(value="changePhoneNumber")
		public String changePhoneNumber(@RequestParam("phoneNumber") String phoneNumber,
                														HttpSession session, Model model) throws Exception {
		
			User sessionUser = (User) session.getAttribute("user");
		
			if (sessionUser == null) {
			model.addAttribute("error", "������ ����Ǿ����ϴ�. �ٽ� �α��� ���ּ���.");
			return "redirect:/user/login.jsp";
			}
			
			// ��ȭ��ȣ ����
			sessionUser.setPhoneNumber(phoneNumber);
			userService.updateUser(sessionUser);
			session.setAttribute("user", sessionUser);
			
			model.addAttribute("message", "�޴��� ��ȣ�� ���������� ����Ǿ����ϴ�.");
			
			return "redirect:/user/updateUser?userNo=" + sessionUser.getUserNo();
		}
		
}
