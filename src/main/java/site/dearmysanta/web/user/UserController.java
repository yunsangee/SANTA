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

import com.fasterxml.jackson.databind.ObjectMapper;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.alarmMessage.AlarmMessage;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.correctionPost.CorrectionPost;
import site.dearmysanta.domain.user.QNA;
import site.dearmysanta.domain.user.Schedule;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.correctionpost.CorrectionPostService;
import site.dearmysanta.service.user.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Autowired
	UserService userService;
		
		//
		// addUser(Post)
		//
	
		@PostMapping(value="addUser" )
		public String addUser(@ModelAttribute User user, Model model ) throws Exception {

			System.out.println("addUser : POST");
			
			String addPassword = user.getUserPassword();
		    
		    System.out.println("addPassword : " +addPassword);
		    
		    // 새로운 비밀번호 확인용 비밀번호
		    String checkPassword = user.getCheckPassword(); // 사용자가 입력한 새로운 비밀번호 확인용
		    
		    System.out.println("checkPassword : " +checkPassword);
		    
		    if (!addPassword.equals(checkPassword)) {
		        // 새로운 비밀번호와 비밀번호 확인이 일치하지 않는 경우
		        model.addAttribute("error", "비밀번호와 비밀번호 확인이 일치하지 않습니다.");
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
		    
//		    // login
//		    User user = userService.login(userId, password);
//		    System.out.println("login : " + user);
//		    
//		    // success login -> session : userNo
//		    if (user != null) {
//		        session.setAttribute("userNo", user.getUserNo());
//		    }
		    
		    return "redirect:/user/login.jsp";
		}	

		@PostMapping(value = "login")
		public String login(@ModelAttribute User user, String userId, String userPassword, HttpSession session, Model model) throws Exception {
		    System.out.println("/user/login : POST");
		    
		    // DB에서 사용자 정보 조회
		    User dbUser = userService.getUserByUserId(user.getUserId());
		    
		    System.out.println("확인 : " + dbUser);
		    
		    // 사용자가 존재하는지 확인
		    if (dbUser == null) {
		        model.addAttribute("error", "사용자를 찾을 수 없습니다.");
		        return "redirect:/user/login.jsp";
		    }
		    
		    System.out.println("dbUser : " + dbUser);
		    
		    // 탈퇴일시가 null인지 확인
		    if (dbUser.getWithdrawDate() != null) {
		        model.addAttribute("error", "탈퇴한 사용자입니다.");
		        return "redirect:/user/login.jsp";
		    }
		    
		    // 비밀번호 일치 여부 확인
		    if (user.getUserPassword().equals(dbUser.getUserPassword())) {
		        session.setAttribute("user", dbUser);
		        return "forward:/common/main.jsp";
		    } else {
		        model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
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

		    // 사용자의 아이디와 전화번호로 현재 비밀번호 가져오기
		    String currentPassword = user.getUserPassword();
		    
		    //System.out.println("find : " +findAttribute);
		    System.out.println("password : " +currentPassword);

		    // 새로운 비밀번호 확인
		    String newPassword = user.getPasswordNew(); // 사용자가 입력한 새로운 비밀번호
		    
		    System.out.println("newPassword : " +newPassword);
		    
		    // 새로운 비밀번호 확인용 비밀번호
		    String confirmPassword = user.getCheckPassword(); // 사용자가 입력한 새로운 비밀번호 확인용
		    
		    System.out.println("confirmPassword : " +confirmPassword);
		    
		    if (!newPassword.equals(confirmPassword)) {
		        // 새로운 비밀번호와 비밀번호 확인이 일치하지 않는 경우
		        model.addAttribute("error", "비밀번호와 비밀번호 확인이 일치하지 않습니다.");
		        return "redirect:/user/setUserPassword.jsp";
		    }

		    if (newPassword.equals(currentPassword)) {
		        // 새로운 비밀번호가 현재 비밀번호와 같은 경우
		        model.addAttribute("error", "새로운 비밀번호는 현재 비밀번호와 달라야 합니다.");
		        return "redirect:/user/setUserPassword.jsp";
		    }

		    // 변경된 비밀번호를 저장하거나 처리하는 로직 추가
		    userService.setUserPassword(user.getUserId(), newPassword);
		    
		    // 변경된 비밀번호를 뷰로 전달
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
//			// Model 과 View 연결
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
		        // 요청 매개변수로 받은 userNo가 있는 경우
		        user = userService.getUser(userNo);
		        System.out.println("getUser: userNo from request parameter = " + userNo);
		    } else if (sessionUser != null) {
		        // 세션에서 현재 로그인한 사용자 정보 가져오기
		        user = userService.getUser(sessionUser.getUserNo());
		        System.out.println("getUser: sessionUser = " + sessionUser.getUserNo());
		    } else {
		        System.out.println("getUser: No userNo provided and no sessionUser");
		        model.addAttribute("error", "사용자를 찾을 수 없습니다.");
		        return "redirect:/user/login.jsp";
		    }
		    
		    if (sessionUser.getRole()==1) {
		    	
		    	model.addAttribute("admin", 1);
		    	
		    }

		    // 사용자 정보 모델에 추가
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
			// Model 과 View 연결
			
			System.out.println("user :" +user);
			
			model.addAttribute("user", user);	
			
			return "forward:/user/updateUser.jsp";
		}
		
		
		@PostMapping(value = "updateUser")
		public String updateUser(@ModelAttribute User user, @RequestParam(required = false) Integer userNo, Model model, HttpSession session) throws Exception {
		    System.out.println("updateUser : POST");

		    // 세션에서 현재 로그인한 사용자 정보 가져오기
		    User sessionUser = (User) session.getAttribute("user");

		    // 세션 사용자 정보 로그 출력
		    if (sessionUser != null) {
		        System.out.println("updateUser: sessionUser = " + sessionUser.getUserId());
		    } else {
		        System.out.println("updateUser: sessionUser is null");
		    }

		    // 세션에 로그인한 사용자 정보가 있는지 확인
		    if (sessionUser == null) {
		        // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
		        model.addAttribute("error", "로그인이 필요합니다.");
		        return "redirect:/user/login.jsp";
		    }

		    // 업데이트하려는 사용자 번호 설정
		    int targetUserNo = (userNo != null) ? userNo : sessionUser.getUserNo();

		    // DB에서 최신 사용자 정보 가져오기
		    User dbUser = userService.getUser(targetUserNo);

		    if (dbUser == null) {
		        model.addAttribute("error", "사용자를 찾을 수 없습니다.");
		        return "redirect:/user/updateUser.jsp";
		    }

		    // 사용자 정보 업데이트;
		    dbUser.setNickName(user.getNickName());
		    dbUser.setAddress(user.getAddress());
		    dbUser.setPhoneNumber(user.getPhoneNumber());
			/* dbUser.setProfileImage(user.getProfileImage()); */
		    dbUser.setHikingPurpose(user.getHikingPurpose());
		    dbUser.setHikingDifficulty(user.getHikingDifficulty());
		    dbUser.setHikingLevel(user.getHikingLevel());
		    dbUser.setIntroduceContent(user.getIntroduceContent());
		    // 필요한 다른 필드도 업데이트

		    userService.updateUser(dbUser);

		    // 세션에 로그인한 사용자와 업데이트한 사용자가 동일한 경우, 세션 정보를 업데이트
		    if (sessionUser.getUserNo() == dbUser.getUserNo()) {
		        session.setAttribute("user", dbUser);
		    }

		    System.out.println("updateUser : " + dbUser);

		    // 업데이트 성공 페이지로 리다이렉트
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
			// Model 과 View 연결
			model.addAttribute("user", user);
			
			return "forward:/user/deleteUser.jsp";
		}
		
		@PostMapping(value="deleteUser")
		public String deleteUser(@ModelAttribute User user, @RequestParam(required = false) Integer userNo, Model model, HttpSession session) throws Exception {
		    
		    System.out.println("deleteUser : POST");
		    
		    // 세션에서 현재 로그인한 사용자 정보 가져오기
		    User sessionUser = (User) session.getAttribute("user");

		    // 세션 사용자 정보 로그 출력
		    if (sessionUser != null) {
		        System.out.println("deleteUser: sessionUser = " + sessionUser.getUserId());
		    } else {
		        System.out.println("deleteUser: sessionUser is null");
		    }

		    // 세션에 로그인한 사용자 정보가 있는지 확인
		    if (sessionUser == null) {
		        // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
		        model.addAttribute("error", "로그인이 필요합니다.");
		        return "redirect:/user/login.jsp";
		    }

		    // 업데이트하려는 사용자 번호 설정
		    int targetUserNo = (userNo != null) ? userNo : sessionUser.getUserNo();

		    // DB에서 최신 사용자 정보 가져오기
		    User dbUser = userService.getUser(targetUserNo);

		    if (dbUser == null) {
		        model.addAttribute("error", "사용자를 찾을 수 없습니다.");
		        return "redirect:/user/updateUser.jsp";
		    }

		    // 사용자 정보 업데이트
		    dbUser.setWithdrawReason(user.getWithdrawReason());
		    dbUser.setWithdrawContent(user.getWithdrawContent());    
		    //userService.updateUser(dbUser);
		    
		    userService.deleteUser(dbUser);
		    
		    User dbUser2 = userService.getUser(targetUserNo);

		    // 세션에 로그인한 사용자와 업데이트한 사용자가 동일한 경우, 세션 정보를 무효화
		    if (sessionUser.getUserNo() == dbUser2.getUserNo()) {
		        session.invalidate(); // 세션 무효화
		    }

		    System.out.println("deleteUser : " + dbUser2);

		    // 탈퇴 성공 후 메인 페이지로 리다이렉트
		    return "redirect:/common/main.jsp";
		    
		   // return "redirect:/user/getUser?userNo=" + dbUser.getUserNo();
		}
		
		//
		// getUserList(GET)
		//
		
		@GetMapping(value="getUserList")
		public String getUserList(@ModelAttribute Search search, Model model, HttpSession session) throws Exception {
			
			System.out.println("getUserList : GET");
			
			if(search != null & search.getCurrentPage() == 0) {
				search.setCurrentPage(1);
			}

//			search.setPageSize(pageSize);
//			search.setPageUnit(pageUnit);
		    
			 // 세션에서 로그인한 관리자 정보 가져오기
		    User admin = (User) session.getAttribute("user");
		    
		    System.out.println("admin login : " +admin);
		    
		    // 세션에 로그인한 관리자 정보가 있는지 확인
		    if (admin.getRole() == 0) {
		        // 관리자가 아닌 경우 에러 처리
		        model.addAttribute("error", "관리자만 접근할 수 있습니다.");
		        return "redirect:/user/login.jsp";
		    }
			
			List<User> userList = userService.getUserList(search);
			
			System.out.println("userList : " + userList);		
			
			model.addAttribute("user", userList);
			
			return "forward:/user/getUserList.jsp";
		}
		
		//
		// withdrawUserList
		//
		
		@GetMapping(value="withdrawUserList")
		public String withdrawUserList(@ModelAttribute Search search, Model model, HttpSession session) throws Exception {
			
			System.out.println("withdrawUserList : GET");
			
			if(search != null & search.getCurrentPage() == 0) {
				search.setCurrentPage(1);
			}

//			search.setPageSize(pageSize);
//			search.setPageUnit(pageUnit);
		    
			 // 세션에서 로그인한 관리자 정보 가져오기
		    User admin = (User) session.getAttribute("user");
		    
		    System.out.println("admin login : " +admin);
		    
		    // 세션에 로그인한 관리자 정보가 있는지 확인
		    if (admin.getRole() == 0) {
		        // 관리자가 아닌 경우 에러 처리
		        model.addAttribute("error", "관리자만 접근할 수 있습니다.");
		        return "redirect:/user/login.jsp";
		    }
			
			List<User> userList = userService.withdrawUserList(search);
			
			System.out.println("userList : " + userList);		
			
			model.addAttribute("user", userList);
			
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
		
		@PostMapping(value = "addQnA")
		public String addQnA(@ModelAttribute QNA qna, Model model, HttpSession session) throws Exception {
		    
			System.out.println("addQnA : POST");

		    // 세션에서 현재 로그인한 사용자 정보 가져오기
		    User sessionUser = (User) session.getAttribute("user");

		    if (sessionUser == null) {
		        // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
		        model.addAttribute("error", "로그인이 필요합니다.");
		        return "redirect:/user/login.jsp";
		    }

		    // QNA 객체에 사용자 정보 설정
		    qna.setUserNo(sessionUser.getUserNo());
		    qna.setNickName(sessionUser.getNickName());
		    qna.setProfileImage(sessionUser.getProfileImage());

		    // QNA 추가
		    userService.addQnA(qna);
		    
		    session.setAttribute("qna", qna);
		    
		    System.out.println("addQnA : " + qna);

		    return "forward:/user/getQnA.jsp";
		}

		
		//
		// getQnA
		//
		
		@GetMapping(value = "getQnA")
		public String getQnA(@RequestParam(required = false) Integer postNo, @RequestParam(required = false) Integer userNo, HttpSession session, Model model) throws Exception {
		    
			System.out.println("getQnA : GET");

		    // 세션에서 로그인한 사용자 정보 가져오기
		    User sessionUser = (User) session.getAttribute("user");
		    
		    System.out.println("user : " +sessionUser);
		    
		    User user = null;

		    QNA qna = userService.getQnA(postNo, userNo);

//		    if (user == null) {
//		        // 로그인한 사용자 정보가 없는 경우 오류 처리
//		        model.addAttribute("error", "로그인 정보를 찾을 수 없습니다.");
//		        return "redirect:/login"; // 로그인 페이지로 리다이렉트 또는 다른 처리
//		    }

		    if (qna == null) {
		        // QNA 정보가 없는 경우 오류 처리
		        model.addAttribute("error", "QNA 정보를 찾을 수 없습니다.");
		        return "redirect:/user/addQnA.jsp";
		    }

		    if (postNo != null && qna.getPostNo() == postNo) {
		        // 게시물 번호로 조회하는 경우
		        model.addAttribute("qna", qna);
		        return "forward:/user/getQnA.jsp";
		    } else if (userNo != null && qna.getUserNo() == userNo) {
		        // 사용자 번호로 조회하는 경우
		        model.addAttribute("qna", qna);
		        return "forward:/user/getQnA.jsp";
		    } else {
		        // 잘못된 요청 처리
		        model.addAttribute("error", "올바른 요청이 아닙니다.");
		    }
		    
		    if (sessionUser.getRole()==1) {
		    	
		    	model.addAttribute("admin", 1);
		    	
		    }
		    
		    System.out.println("sessionUser : " +sessionUser);
		    
		    model.addAttribute("user", user);
		
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
		    
		    // Model 과 View 연결
		   model.addAttribute("qna", qna);
		    
		   return "forward:/user/addAdminAnswer.jsp";
		}
		
		@PostMapping(value = "addAdminAnswer")
		public String addAdminAnswer(@ModelAttribute QNA qna, Model model, HttpSession session) throws Exception {
		    System.out.println("addAdminAnswer : POST");
		  
		    System.out.println("postNo : " +qna.getPostNo());
		    System.out.println("userNo : " +qna.getUserNo());	    
		    
		    // 세션에서 로그인한 관리자 정보 가져오기
		    User admin = (User) session.getAttribute("user");
		    
		    System.out.println("admin login : " +admin);
		    
		    // 세션에 로그인한 관리자 정보가 있는지 확인
		    if (admin.getRole() == 0) {
		        // 관리자가 아닌 경우 에러 처리
		        model.addAttribute("error", "관리자만 접근할 수 있습니다.");
		        return "redirect:/admin/login.jsp";
		    }
		    
		    // QNA 정보 조회
		    QNA dbqna = userService.getQnA(qna.getPostNo(), qna.getUserNo());
		    
		    // 관리자 답변 추가
		    dbqna.setAdminAnswer(qna.getAdminAnswer());

		    // QNA 업데이트
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
			
			if(search != null & search.getCurrentPage() == 0) {
				search.setCurrentPage(1);
			}

//			search.setPageSize(pageSize);
//			search.setPageUnit(pageUnit);
		    
		    // 세션에서 로그인한 사용자 정보 가져오기
		    User user = (User) session.getAttribute("user");
			
			List<QNA> qnaList = userService.getQnAList(search);
			
			System.out.println("qanList : " + qnaList);		
			
			model.addAttribute("qna", qnaList);
			
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
		    // 세션에서 현재 로그인한 사용자 정보 가져오기
		    User sessionUser = (User) session.getAttribute("user");

		    if (sessionUser == null) {
		        // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
		        model.addAttribute("error", "로그인이 필요합니다.");
		        return "redirect:/user/login.jsp";
		    }

		    // SCHEDULE 객체에 사용자 정보 설정
		    schedule.setUserNo(sessionUser.getUserNo());

		    // SCHEDULE 추가
		    userService.addSchedule(schedule);
		    Search search = new Search();
		    List<Schedule> scheduleList = userService.getScheduleList(search);
		    ObjectMapper objectMapper = new ObjectMapper();
		    List<String> scheduleJson = new ArrayList<>();
		    for(Schedule sd : scheduleList) {
		    	  scheduleJson.add(objectMapper.writeValueAsString(sd));
		    }
		    
		    // 모델에 스케줄 목록 추가
		    model.addAttribute("scheduleList", scheduleJson);

		    return "forward:/user/month-view.jsp";
		}
		
		@GetMapping(value = "getSchedule")
		public String getSchedule(@RequestParam(required = false) Integer postNo, @RequestParam(required = false) Integer userNo, HttpSession session, Model model) throws Exception {
		    
			System.out.println("getSchedule : GET");

		    // 세션에서 로그인한 사용자 정보 가져오기
		    User user = (User) session.getAttribute("user");

		    Schedule schedule = userService.getSchedule(postNo, userNo);

//		    if (user == null) {
//		        // 로그인한 사용자 정보가 없는 경우 오류 처리
//		        model.addAttribute("error", "로그인 정보를 찾을 수 없습니다.");
//		        return "redirect:/login"; // 로그인 페이지로 리다이렉트 또는 다른 처리
//		    }

		    if (schedule == null) {
		        // Schedule 정보가 없는 경우 오류 처리
		        model.addAttribute("error", "Schedule 정보를 찾을 수 없습니다.");
		        return "redirect:/user/addSchedule.jsp";
		    }

		    if (userNo != null && schedule.getUserNo() == userNo) {
		        // 사용자 번호로 조회하는 경우
		        model.addAttribute("schedule", schedule);
		        return "forward:/user/getSchedule.jsp";
		    } else {
		        // 잘못된 요청 처리
		        model.addAttribute("error", "올바른 요청이 아닙니다.");
		        return "redirect:/user/addSchedule.jsp";
		    }
		    
		}
		
		@GetMapping(value="updateSchedule")
		public String updateSchedule(@RequestParam int postNo, @RequestParam int userNo, Model model) throws Exception {
		   
			System.out.println("updateSchedule : GET");
		    
			// Business Logic
		    Schedule schedule = userService.getSchedule(postNo, userNo);
		    
		    // Model 과 View 연결
		   model.addAttribute("schedule", schedule);
		    
		   return "forward:/user/updateSchedule.jsp";
		}
		
		@PostMapping(value = "updateSchedule")
		public String updateSchedule(@ModelAttribute Schedule schedule, Model model, HttpSession session) throws Exception {
		   
			System.out.println("updateSchedule : POST");
		  
		    System.out.println("postNo : " +schedule.getPostNo());
		    System.out.println("userNo : " +schedule.getUserNo());	    
		    
		    // 세션에서 로그인한 관리자 정보 가져오기
		    User sessionUser = (User) session.getAttribute("user");
		    
		    System.out.println("sessionUser : " +sessionUser);
		    
		    if (sessionUser == null) {
		        // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
		        model.addAttribute("error", "로그인이 필요합니다.");
		        return "redirect:/user/login.jsp";
		    }
		    
		    // Schedule 정보 조회
		    Schedule dbschedule = userService.getSchedule(schedule.getPostNo(), schedule.getUserNo());
		    
		 // SCHEDULE 객체에 사용자 정보 설정
		    schedule.setUserNo(sessionUser.getUserNo());
		    
		    // 업데이트
		    dbschedule.setTitle(schedule.getTitle());
		    dbschedule.setMountainName(schedule.getMountainName());
		    dbschedule.setHikingTotalTime(schedule.getHikingTotalTime());
		    dbschedule.setHikingAscentTime(schedule.getHikingAscentTime());
		    dbschedule.setHikingDescentTime(schedule.getHikingDescentTime());
		    dbschedule.setHikingDifficulty(schedule.getHikingDifficulty());
		    dbschedule.setTransportation(schedule.getTransportation());

		    // Schedule 업데이트
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
//		    // 세션에서 로그인한 사용자 정보 가져오기
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
		    
		    // search 초기화
		    if (search != null && search.getCurrentPage() == 0) {
		        search.setCurrentPage(1);
		    }

		    // 세션에서 로그인한 사용자 정보 가져오기
		    User user = (User) session.getAttribute("user");
		    
		    if (user == null) {
		        model.addAttribute("error", "로그인이 필요합니다.");
		        return "redirect:/user/login.jsp";
		    }

		    // userService를 통해 스케줄 목록 가져오기
		    List<Schedule> scheduleList = userService.getScheduleList(search);
		    
		    System.out.println("scheduleList : " + scheduleList);
		    
		    // Schedule 객체를 JSON 형식으로 변환하여 모델에 추가
		    ObjectMapper objectMapper = new ObjectMapper();
		    List<String> scheduleJson = new ArrayList<>();
		    for(Schedule schedule : scheduleList) {
		    	  scheduleJson.add(objectMapper.writeValueAsString(schedule));
		    }
		    
		    // 모델에 스케줄 목록 추가
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
		    
		    // Model 과 View 연결
		   model.addAttribute("qna", qna);
		    
		   return "forward:/user/updateAnswerQnA.jsp";
		}
		
		@PostMapping(value = "updateAnswer")
		public String updateAnswer(@ModelAttribute QNA qna, Model model, HttpSession session) throws Exception {
		    System.out.println("updateAnswer : POST");
		  
		    System.out.println("postNo : " +qna.getPostNo());
		    System.out.println("userNo : " +qna.getUserNo());	    
		    
		    // 세션에서 로그인한 관리자 정보 가져오기
		    User admin = (User) session.getAttribute("user");
		    
		    System.out.println("admin login : " +admin);
		    
		    // 세션에 로그인한 관리자 정보가 있는지 확인
		    if (admin.getRole() == 0) {
		        // 관리자가 아닌 경우 에러 처리
		        model.addAttribute("error", "관리자만 접근할 수 있습니다.");
		        return "redirect:/admin/login.jsp";
		    }
		    
		    // QNA 정보 조회
		    QNA dbqna = userService.getQnA(qna.getPostNo(), qna.getUserNo());
		    
		    // 관리자 답변 추가
		    dbqna.setAdminAnswer(qna.getAdminAnswer());

		    // QNA 업데이트
		    userService.addAdminAnswer(dbqna);
		    
		    model.addAttribute("qna", dbqna);

		    System.out.println("updateAnswer : " + dbqna);

		    return "forward:/user/getQnA.jsp";
		}
		
}
