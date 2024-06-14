package site.dearmysanta.web.user;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.mountain.MountainSearch;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.user.UserService;


@RestController
@RequestMapping("/user/*")
	
public class UserRestController {
	
	@Autowired
	private UserService userService;
	
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
	public String findUserId(@RequestBody User user) throws Exception {
	    
		System.out.println("findUserId : POST");
	    
		System.out.println("name: " + user.getUserName());
	    
		System.out.println("phoneNumber: " + user.getPhoneNumber());
		
		userService.findUserId(user.getUserName(), user.getPhoneNumber());

	    return userService.findUserId(user.getUserName(), user.getPhoneNumber());
	}
	
	//
	// findUserPassword
	//

	@PostMapping( value="rest/findUserPassword")
	public String findUserPassword(@RequestBody User user) throws Exception {
		
		System.out.println("findUserPassword : POST");
		
		System.out.println("id :" +user.getUserId());
		
		System.out.println("phoneNumber : " +user.getPhoneNumber());
		
		userService.findUserPassword(user.getUserId(), user.getPhoneNumber());

		return userService.findUserPassword(user.getUserId(), user.getPhoneNumber());
	}
	
	//
	// setUserPassword
	//
	
	@PostMapping("/rest/setUserPassword")
	public ResponseEntity<Object> setUserPassword(@RequestBody User user) throws Exception {
	    System.out.println("setUserPassword : POST");
	    System.out.println("userId : " + user.getUserId());

	    // ������� ���̵�� DB�� ����� ���� ��й�ȣ ��������
	    String currentPassword = userService.getUserPassword(user.getUserId());
	    
	    System.out.println("currentPassword : " + currentPassword);

	    // ����ڰ� �Է��� ���� ��й�ȣ
	    String inputPassword = user.getUserPassword();
	    System.out.println("inputPassword : " + inputPassword);

	    // ���ο� ��й�ȣ
	    String newPassword = user.getPasswordNew();
	    System.out.println("newPassword : " + newPassword);

	    // ��й�ȣ Ȯ�ο� �Է�
	    String confirmPassword = user.getCheckPassword();
	    System.out.println("confirmPassword : " + confirmPassword);

	    // ���� ��й�ȣ�� DB�� ����� ��й�ȣ�� ��ġ�ϴ��� Ȯ��
	    if (!inputPassword.equals(currentPassword)) {
	        return ResponseEntity.badRequest().body("Current password is incorrect");
	    }

	    // ���ο� ��й�ȣ�� ��й�ȣ Ȯ���� ��ġ�ϴ��� Ȯ��
	    if (!newPassword.equals(confirmPassword)) {
	        return ResponseEntity.badRequest().body("Passwords do not match");
	    }

	    // ���ο� ��й�ȣ�� ���� ��й�ȣ�� ������ Ȯ��
	    if (newPassword.equals(inputPassword)) {
	        return ResponseEntity.badRequest().body("New password must be different from current password");
	    }

	    // ����� ��й�ȣ�� DB�� ����
	    userService.setUserPassword(user.getUserId(), newPassword);

	    // ����� ��й�ȣ�� ���������� Ŭ���̾�Ʈ���� �˸�
	    return ResponseEntity.ok("Password updated successfully");
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
	
}
