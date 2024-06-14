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

	    // 사용자의 아이디로 DB에 저장된 실제 비밀번호 가져오기
	    String currentPassword = userService.getUserPassword(user.getUserId());
	    
	    System.out.println("currentPassword : " + currentPassword);

	    // 사용자가 입력한 현재 비밀번호
	    String inputPassword = user.getUserPassword();
	    System.out.println("inputPassword : " + inputPassword);

	    // 새로운 비밀번호
	    String newPassword = user.getPasswordNew();
	    System.out.println("newPassword : " + newPassword);

	    // 비밀번호 확인용 입력
	    String confirmPassword = user.getCheckPassword();
	    System.out.println("confirmPassword : " + confirmPassword);

	    // 현재 비밀번호가 DB에 저장된 비밀번호와 일치하는지 확인
	    if (!inputPassword.equals(currentPassword)) {
	        return ResponseEntity.badRequest().body("Current password is incorrect");
	    }

	    // 새로운 비밀번호와 비밀번호 확인이 일치하는지 확인
	    if (!newPassword.equals(confirmPassword)) {
	        return ResponseEntity.badRequest().body("Passwords do not match");
	    }

	    // 새로운 비밀번호와 현재 비밀번호가 같은지 확인
	    if (newPassword.equals(inputPassword)) {
	        return ResponseEntity.badRequest().body("New password must be different from current password");
	    }

	    // 변경된 비밀번호를 DB에 저장
	    userService.setUserPassword(user.getUserId(), newPassword);

	    // 변경된 비밀번호를 성공적으로 클라이언트에게 알림
	    return ResponseEntity.ok("Password updated successfully");
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
	
}
