package site.dearmysanta.web.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.fasterxml.jackson.databind.ObjectMapper;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.mountain.MountainSearch;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.user.UserService;


@RestController
@RequestMapping("/user/*")
	
public class UserRestController {
	
	@Autowired
	private UserService userService;
	
	@Value("${pageSize}")
	private int pageSize;
	
	@Value("${pageUnit}")
	private int pageUnit;
	
	
	ObjectMapper objectMapper = new ObjectMapper();
	
	public UserRestController() {
		SantaLogger.makeLog("info", this.getClass().toString());
	}
	
	@PostMapping(value="rest/addUser")
	public User addUser(@RequestBody User user) throws Exception {
        
		System.out.println("addUser : POST");
        
		userService.addUser(user);
        
		return user;
    }
	
	//
	// finduserId
	//
	
	@PostMapping("rest/findUserId")
    public Map<String, Object> findUserId(@RequestBody User user) throws Exception {
        Map<String, Object> response = new HashMap<>();
        
        System.out.println("findUserId : POST");
        System.out.println("name: " + user.getUserName());
        System.out.println("phoneNumber: " + user.getPhoneNumber());

        String userId = userService.findUserId(user.getUserName(), user.getPhoneNumber());
        
        if (userId == null) {
            response.put("userExists", false);
        } else {
            response.put("userExists", true);
            response.put("userId", userId);
        }

        return response;
    }
	
	//
	// findUserPassword
	//

	@PostMapping( value="rest/findUserPassword")
	 public ResponseEntity<Object> setUserPassword(@RequestBody User user, HttpSession session) throws Exception {
        System.out.println("setUserPassword : POST");
        System.out.println("userId : " + user.getUserId());

        // 사용자의 아이디로 DB에 저장된 실제 비밀번호 가져오기
        String currentPassword = (String) session.getAttribute("userPassword");
        
        System.out.println("currentPassword : " + currentPassword);

        // 새로운 비밀번호
        String newPassword = user.getPasswordNew();
        System.out.println("newPassword : " + newPassword);

        // 비밀번호 확인용 입력
        String confirmPassword = user.getCheckPassword();
        System.out.println("confirmPassword : " + confirmPassword);

        // 새로운 비밀번호와 비밀번호 확인이 일치하는지 확인
        if (!newPassword.equals(confirmPassword)) {
            return ResponseEntity.badRequest().body("비밀번호가 일치하지 않습니다.");
        }

        // 새로운 비밀번호와 현재 비밀번호가 같은지 확인
        if (newPassword.equals(currentPassword)) {
            return ResponseEntity.badRequest().body("기존 비밀번호와 같은 비밀번호입니다.");
        }

        // 변경된 비밀번호를 DB에 저장
        userService.setUserPassword(user.getUserId(), newPassword);

        // 변경된 비밀번호를 성공적으로 클라이언트에게 알림
        return ResponseEntity.ok("비밀번호가 변경되었습니다.");
    }
	
	//
	// updateUser
	//
	
	@PostMapping("rest/updateUser")
    public User updateUser(@RequestBody User user) throws Exception {
        
		System.out.println("updateUser : POST");

        // 업데이트하려는 사용자 번호 설정
        Integer targetUserNo = user.getUserNo(); // 클라이언트에서 전송한 사용자 번호

//        if (targetUserNo == null) {
//            return ResponseEntity.badRequest().body("{\"error\": \"사용자 번호가 전송되지 않았습니다.\"}");
//        }
        
        // DB에서 해당 사용자 정보 가져오기
        User dbUser = userService.getUser(targetUserNo);

//        if (dbUser == null) {
//            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("{\"error\": \"사용자를 찾을 수 없습니다.\"}");
//        }

        // 사용자 정보 업데이트
        dbUser.setNickName(user.getNickName());
        dbUser.setAddress(user.getAddress());
        dbUser.setPhoneNumber(user.getPhoneNumber());
        dbUser.setProfileImage(user.getProfileImage());
        dbUser.setHikingPurpose(user.getHikingPurpose());
        dbUser.setHikingDifficulty(user.getHikingDifficulty());
        dbUser.setHikingLevel(user.getHikingLevel());
        dbUser.setIntroduceContent(user.getIntroduceContent());
        // 필요한 다른 필드도 업데이트

        // UserService를 사용하여 사용자 정보 업데이트
        userService.updateUser(dbUser);

        System.out.println("updateUser : " + dbUser);
        
        return userService.getUser(user.getUserNo());

    }
	
	//
	// delete QNA
	//
	
	@GetMapping(value="rest/deleteQnA")
	public void deleteQnA(@RequestParam int postNo, int userNo) throws Exception {
		
		userService.deleteQnA(postNo, userNo);
	}
	
	//
	// delete Schedule
	//
	
	@GetMapping(value="rest/deleteSchedule")
	public void deleteSchedule(@RequestParam int postNo, int userNo) throws Exception {
		
		userService.deleteSchedule(postNo, userNo);
	}
	
	//
	// UserList
	//

	    @GetMapping("rest/getUserList")
	    public Map<String, Object> getUserList(@ModelAttribute Search search, HttpSession session) throws Exception {
	        System.out.println("getUserList : GET");

	        if (search != null && search.getCurrentPage() == 0) {
	            search.setCurrentPage(1);
	        }

	        int pageSize = this.pageSize; // 페이지당 항목 수
		    int pageUnit = this.pageUnit; // 페이지 네비게이션에 표시할 페이지 수
		    int currentPage = search.getCurrentPage();

	        // 세션에서 로그인한 관리자 정보 가져오기
	        User admin = (User) session.getAttribute("user");

	        System.out.println("admin login : " + admin);

	        // 세션에 로그인한 관리자 정보가 있는지 확인
	        if (admin == null || admin.getRole() != 1) { // assuming 1 is for admin
	            // 관리자가 아닌 경우 에러 처리
	            Map<String, Object> error = new HashMap<>();
	            error.put("error", "관리자만 접근할 수 있습니다.");
	            return error;
	        }

	        try {
	            List<User> userList = userService.getUserList(search);
	            int totalCount = userList.size(); // 총 사용자 수
	            int totalPages = (int) Math.ceil((double) totalCount / pageSize); // 총 페이지 수 계산

	            // 페이징 처리를 위한 startRow와 endRow 계산
	            int startRow = (currentPage - 1) * pageSize;
	            int endRow = Math.min(startRow + pageSize, totalCount);
	            List<User> paginatedUserList = userList.subList(startRow, endRow);

	            int currentPageCount = paginatedUserList.size(); // 현재 페이지에 표시되는 회원 수

	            Map<String, Object> result = new HashMap<>();
	            result.put("userList", paginatedUserList);
	            result.put("currentPage", currentPage);
	            result.put("totalPages", totalPages);
	            result.put("totalCount", totalCount);
	            result.put("currentPageCount", currentPageCount);

	            return result;
	        } catch (Exception e) {
	            // 예외 처리
	            Map<String, Object> error = new HashMap<>();
	            error.put("error", "사용자 목록을 가져오는 중 오류가 발생했습니다.");
	            return error;
	        }
	    }

	
	    @GetMapping("rest/withdrawUserList")
	    public Map<String, Object> withdrawUserList(@ModelAttribute Search search, HttpSession session) throws Exception {
	        System.out.println("withdrawUserList : GET");

	        if (search != null && search.getCurrentPage() == 0) {
	            search.setCurrentPage(1);
	        }

	        int pageSize = this.pageSize; // 페이지당 항목 수
	        int pageUnit = this.pageUnit; // 페이지 네비게이션에 표시할 페이지 수
	        int currentPage = search.getCurrentPage();

	        // 세션에서 로그인한 관리자 정보 가져오기
	        User admin = (User) session.getAttribute("user");

	        System.out.println("admin login : " + admin);

	        // 세션에 로그인한 관리자 정보가 있는지 확인
	        if (admin == null || admin.getRole() != 1) { // assuming 1 is for admin
	            // 관리자가 아닌 경우 에러 처리
	            Map<String, Object> error = new HashMap<>();
	            error.put("error", "관리자만 접근할 수 있습니다.");
	            return error;
	        }

	        try {
	            List<User> userList = userService.withdrawUserList(search);
	            int totalCount = userList.size(); // 총 사용자 수
	            int totalPages = (int) Math.ceil((double) totalCount / pageSize); // 총 페이지 수 계산

	            // 페이징 처리를 위한 startRow와 endRow 계산
	            int startRow = (currentPage - 1) * pageSize;
	            int endRow = Math.min(startRow + pageSize, totalCount);
	            List<User> paginatedUserList = userList.subList(startRow, endRow);

	            int currentPageCount = paginatedUserList.size(); // 현재 페이지에 표시되는 회원 수

	            Map<String, Object> result = new HashMap<>();
	            result.put("userList", paginatedUserList);
	            result.put("currentPage", currentPage);
	            result.put("totalPages", totalPages);
	            result.put("totalCount", totalCount);
	            result.put("currentPageCount", currentPageCount);

	            return result;
	        } catch (Exception e) {
	            // 예외 처리
	            Map<String, Object> error = new HashMap<>();
	            error.put("error", "사용자 목록을 가져오는 중 오류가 발생했습니다.");
	            return error;
	        }
	    }
}