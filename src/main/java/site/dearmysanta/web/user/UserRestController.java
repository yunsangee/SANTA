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
import site.dearmysanta.domain.user.QNA;
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
	
	@PostMapping("rest/findUserPassword")
    public Map<String, Object> findUserPassword(@RequestBody User user) throws Exception {
        Map<String, Object> response = new HashMap<>();
        
        System.out.println("findUserPassword : POST");
        System.out.println("id: " + user.getUserId());
        System.out.println("phoneNumber: " + user.getPhoneNumber());

        String userPassword = userService.findUserPassword(user.getUserId(), user.getPhoneNumber());
        
        if (userPassword == null) {
            response.put("userExists", false);
        } else {
            response.put("userExists", true);
            response.put("userId", userPassword);
        }

        return response;
    }
	
	//
	// setUserPassword
	//

	@PostMapping( value="rest/setUserPassword")
	 public ResponseEntity<Object> setUserPassword(@RequestBody User user, HttpSession session) throws Exception {
        System.out.println("setUserPassword : POST");
        System.out.println("userId : " + user.getUserId());

        // ������� ���̵�� DB�� ����� ���� ��й�ȣ ��������
        String currentPassword = (String) session.getAttribute("userPassword");
        
        System.out.println("currentPassword : " + currentPassword);

        // ���ο� ��й�ȣ
        String newPassword = user.getPasswordNew();
        System.out.println("newPassword : " + newPassword);

        // ��й�ȣ Ȯ�ο� �Է�
        String confirmPassword = user.getCheckPassword();
        System.out.println("confirmPassword : " + confirmPassword);

        // ���ο� ��й�ȣ�� ��й�ȣ Ȯ���� ��ġ�ϴ��� Ȯ��
        if (!newPassword.equals(confirmPassword)) {
            return ResponseEntity.badRequest().body("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
        }

        // ���ο� ��й�ȣ�� ���� ��й�ȣ�� ������ Ȯ��
        if (newPassword.equals(currentPassword)) {
            return ResponseEntity.badRequest().body("���� ��й�ȣ�� ���� ��й�ȣ�Դϴ�.");
        }

        // ����� ��й�ȣ�� DB�� ����
        userService.setUserPassword(user.getUserId(), newPassword);

        // ����� ��й�ȣ�� ���������� Ŭ���̾�Ʈ���� �˸�
        return ResponseEntity.ok("��й�ȣ�� ����Ǿ����ϴ�.");
    }
	
	//
	// updateUser
	//
	
	@PostMapping("rest/updateUser")
    public User updateUser(@RequestBody User user) throws Exception {
        
		System.out.println("updateUser : POST");

        // ������Ʈ�Ϸ��� ����� ��ȣ ����
        Integer targetUserNo = user.getUserNo(); // Ŭ���̾�Ʈ���� ������ ����� ��ȣ

//        if (targetUserNo == null) {
//            return ResponseEntity.badRequest().body("{\"error\": \"����� ��ȣ�� ���۵��� �ʾҽ��ϴ�.\"}");
//        }
        
        // DB���� �ش� ����� ���� ��������
        User dbUser = userService.getUser(targetUserNo);

//        if (dbUser == null) {
//            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("{\"error\": \"����ڸ� ã�� �� �����ϴ�.\"}");
//        }

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

        // UserService�� ����Ͽ� ����� ���� ������Ʈ
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

	        int pageSize = this.pageSize; // �������� �׸� ��
		    int pageUnit = this.pageUnit; // ������ �׺���̼ǿ� ǥ���� ������ ��
		    int currentPage = search.getCurrentPage();

	        // ���ǿ��� �α����� ������ ���� ��������
	        User admin = (User) session.getAttribute("user");

	        System.out.println("admin login : " + admin);

	        // ���ǿ� �α����� ������ ������ �ִ��� Ȯ��
	        if (admin == null || admin.getRole() != 1) { // assuming 1 is for admin
	            // �����ڰ� �ƴ� ��� ���� ó��
	            Map<String, Object> error = new HashMap<>();
	            error.put("error", "�����ڸ� ������ �� �ֽ��ϴ�.");
	            return error;
	        }

	        try {
	            List<User> userList = userService.getUserList(search);
	            int totalCount = userList.size(); // �� ����� ��
	            int totalPages = (int) Math.ceil((double) totalCount / pageSize); // �� ������ �� ���

	            // ����¡ ó���� ���� startRow�� endRow ���
	            int startRow = (currentPage - 1) * pageSize;
	            int endRow = Math.min(startRow + pageSize, totalCount);
	            List<User> paginatedUserList = userList.subList(startRow, endRow);

	            int currentPageCount = paginatedUserList.size(); // ���� �������� ǥ�õǴ� ȸ�� ��

	            Map<String, Object> result = new HashMap<>();
	            result.put("userList", paginatedUserList);
	            result.put("currentPage", currentPage);
	            result.put("totalPages", totalPages);
	            result.put("totalCount", totalCount);
	            result.put("currentPageCount", currentPageCount);

	            return result;
	        } catch (Exception e) {
	            // ���� ó��
	            Map<String, Object> error = new HashMap<>();
	            error.put("error", "����� ����� �������� �� ������ �߻��߽��ϴ�.");
	            return error;
	        }
	    }

	
	    @GetMapping("rest/withdrawUserList")
	    public Map<String, Object> withdrawUserList(@ModelAttribute Search search, HttpSession session) throws Exception {
	        System.out.println("withdrawUserList : GET");

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
	        if (admin == null || admin.getRole() != 1) { // assuming 1 is for admin
	            // �����ڰ� �ƴ� ��� ���� ó��
	            Map<String, Object> error = new HashMap<>();
	            error.put("error", "�����ڸ� ������ �� �ֽ��ϴ�.");
	            return error;
	        }

	        try {
	            List<User> userList = userService.withdrawUserList(search);
	            int totalCount = userList.size(); // �� ����� ��
	            int totalPages = (int) Math.ceil((double) totalCount / pageSize); // �� ������ �� ���

	            // ����¡ ó���� ���� startRow�� endRow ���
	            int startRow = (currentPage - 1) * pageSize;
	            int endRow = Math.min(startRow + pageSize, totalCount);
	            List<User> paginatedUserList = userList.subList(startRow, endRow);

	            int currentPageCount = paginatedUserList.size(); // ���� �������� ǥ�õǴ� ȸ�� ��

	            Map<String, Object> result = new HashMap<>();
	            result.put("userList", paginatedUserList);
	            result.put("currentPage", currentPage);
	            result.put("totalPages", totalPages);
	            result.put("totalCount", totalCount);
	            result.put("currentPageCount", currentPageCount);

	            return result;
	        } catch (Exception e) {
	            // ���� ó��
	            Map<String, Object> error = new HashMap<>();
	            error.put("error", "����� ����� �������� �� ������ �߻��߽��ϴ�.");
	            return error;
	        }
	    }
	    
	   //
	   // QNAList
	   //

	    @GetMapping("rest/getQnAList")
	    public @ResponseBody Map<String, Object> getQnAList(@ModelAttribute Search search, HttpSession session) throws Exception {
	        System.out.println("getQnAList : GET");

	        // ���ǿ��� ����� ���� ��������
	        User user = (User) session.getAttribute("user");

	        // ���� �������� ���� �ε��� ���
	        int currentPage = (search.getCurrentPage() == 0) ? 1 : search.getCurrentPage();
	        int startIndex = (currentPage - 1) * pageSize;
	        int endIndex = currentPage * pageSize;

	        List<QNA> allQnaList = userService.getQnAList(search);
	        int totalCount = allQnaList.size();

	        List<QNA> qnaList = allQnaList.subList(
	            Math.min(startIndex, totalCount), 
	            Math.min(endIndex, totalCount)
	        );
	        
	        // ��ü �׸� �� �� ������ �� ���
	        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
	        
	        System.out.println("Search : "+search);
	        
	        System.out.println("QNAList_restcontroller : "+qnaList);
	        
	        // ���� ������ �غ�
	        Map<String, Object> response = new HashMap<>();
	        response.put("qnaList", qnaList);
	        response.put("totalCount", totalCount);
	        response.put("totalPages", totalPages);
	        response.put("currentPage", currentPage);
	        response.put("currentPageCount", qnaList.size());

	        return response;
	    }
	    
	    ////////////////////////////// ���̵� �ߺ�Ȯ�� //////////////////////////////////
	    
	    @GetMapping("rest/checkDuplicationId")
	    public Map<String, String> checkDuplicationId(@RequestParam String userId) {
	        Map<String, String> response = new HashMap<>();
	        try {
	            String duplicationId = userService.checkDuplicationId(userId);
	            if (duplicationId != null) {
	                response.put("status", "duplicated");
	                response.put("message", "�ߺ��� ���̵��Դϴ�.");
	            } else {
	                response.put("status", "available");
	                response.put("message", "��� ������ ���̵��Դϴ�.");
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.put("status", "error");
	            response.put("message", "������ �߻��߽��ϴ�.");
	        }
	        return response;
	    }

	    /////////////////////////////// �г��� �ߺ�Ȯ�� //////////////////////////////
	    
	    @GetMapping("rest/checkDuplicationNickName")
	    public Map<String, String> checkDuplicationNickName(@RequestParam String nickName) {
	        Map<String, String> response = new HashMap<>();
	        try {
	            String duplicationNickName = userService.checkDuplicationNickName(nickName);
	            if (duplicationNickName != null) {
	                response.put("status", "duplicated");
	                response.put("message", "�ߺ��� �г����Դϴ�.");
	            } else {
	                response.put("status", "available");
	                response.put("message", "��� ������ �г����Դϴ�.");
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.put("status", "error");
	            response.put("message", "������ �߻��߽��ϴ�.");
	        }
	        return response;
	    }
	    
	    ////////////////////////////// ȸ������ ��й�ȣ Ȯ�� //////////////////////////////
	    @PostMapping(value="rest/addUserPassword")
	    public Map<String, String> addUserPassword(@RequestBody Map<String, String> request) throws Exception {
	        
	    	String userPassword = request.get("userPassword");
	        String checkPassword = request.get("checkPassword");

	        System.out.println("addUserPassword : POST");
	        System.out.println("newPassword : " + userPassword);
	        System.out.println("confirmPassword : " + checkPassword);

	        Map<String, String> response = new HashMap<>();
	        try {
	        	if (userPassword.length() < 10) {
	                response.put("status", "shortpassword");
	                response.put("message", "��й�ȣ�� 10�� �̻� �Է����ּ���.");
	            } else if (!userPassword.equals(checkPassword)) {
	                response.put("status", "notequals");
	                response.put("message", "��й�ȣ�� ��ġ���� �ʽ��ϴ�. �ٽ� �Է����ּ���.");
	            } else {
	                response.put("status", "equals");
	                response.put("message", "��й�ȣ�� ��ġ�մϴ�.");
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.put("status", "error");
	            response.put("message", "������ �߻��߽��ϴ�.");
	        }
	        return response;
	            
	    }
}

