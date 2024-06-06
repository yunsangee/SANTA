package site.dearmysanta.user.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.time.LocalDate;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import site.dearmysanta.SantaApplication;
import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.user.UserDao;
import site.dearmysanta.service.user.UserService;
import site.dearmysanta.service.user.impl.UserServiceImpl;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SantaApplication.class)
//@SpringBootTest(classes = UserServiceTest.class)

public class UserServiceTest {
	
	//UserService userService = new UserServiceImpl();
	
	@Autowired
	//@Qualifier("userService")
	//private UserService userService;
	UserService userService;
	
	//
	// test addUser
	//
	
	//@Test
	public void testAddUser() throws Exception {
		
		User user = User.builder()
				.userNo(5)
				.userId("user05")
				.userName("UserFive")
				.userPassword("password5")
				.nickName("Nick5")
				.address("Address5")
				.birthDate("1990/05/05")
				.phoneNumber("555-5555-5555")
				.gender(0)
				.hikingPurpose(0)
				.hikingDifficulty(1)
				.hikingLevel(3)
				.role(0)
//				.certificationCount(0)
//				.meetingCount(0)
				.creationDate(java.sql.Date.valueOf(LocalDate.of(2024,06,30)))
				.profileImage("profileImage4")
				.build();
		
		userService.addUser(user);
		
		//user = userService.getUser(4);
		
		SantaLogger.makeLog("info", user.toString() +"\n");
	}
	
	//
	// test GetUser
	//
	
	//@Test
	public void testGetUser() throws Exception {
		
		User user = userService.getUser(5);
		
		SantaLogger.makeLog("info", user.toString() + "\n");
		
	}
	
	//
	// test UpdateUser
	//
	
	//@Test
	public void testUpdateUser() throws Exception {
		
		User user = userService.getUser(5);
		
		user.setAddress("Address5 변경");
		user.setBadgeImage("BadgeImage5 변경");
		
		SantaLogger.makeLog("info", user.toString() + "\n");
	}
	
	//
	// test DuplicaionId
	//
	
	//@Test
	public void testDuplicationId() throws Exception {
		
		// NonDuplicate UserId
		String nonDuplicationId = "newUser";
		assertNull(userService.getDuplicationId(nonDuplicationId));
		SantaLogger.makeLog("info", "Non-duplicate user: " + nonDuplicationId);
		
		// Duplicate UserId ( exist in DB )
		String DuplicationId = "user04";
		assertEquals(DuplicationId, userService.getDuplicationId(DuplicationId));
		SantaLogger.makeLog("info", "Duplicate userId: " + DuplicationId);
		
//		Assert.assertFalse( userService.getDuplicationId("testUserId") );
//	 	Assert.assertTrue( userService.getDuplicationId("testUserId"+System.currentTimeMillis()) );
	}
	
	//
	// test DuplicationNickName
	//
	
	//@Test
		public void testDuplicationNickname() throws Exception {
			
			// NonDuplicate NickName
			String nonDuplicationNickName = "newNickName";
			assertNull(userService.getDuplicationId(nonDuplicationNickName));
			SantaLogger.makeLog("info", "Non-duplicate user: " + nonDuplicationNickName);
			
			// Duplicate NickName ( exist in DB )
			String DuplicationNickName = "Nick4";
			assertEquals(DuplicationNickName, userService.getDuplicationNickName(DuplicationNickName));
			SantaLogger.makeLog("info", "duplicate user: " + DuplicationNickName);
		}
		
		//
		// test check password
		//
		
		//@Test
	    public void testCheckPassword() throws Exception {
			
	        String userId = "user04"; // test UserId
	        String correctPassword = "password4"; // correct Password
	        String incorrectPassword = "wrong_password"; // wrong Password

	        // check correct Password
	        assertEquals( 1, userService.getPassword(userId, correctPassword));
	        SantaLogger.makeLog("info", "correctPassword: " + correctPassword);

	        // check wrong Password
	        assertEquals( 0, userService.getPassword(userId, incorrectPassword));
	        SantaLogger.makeLog("info", "incorrectPassword: " + incorrectPassword);
	    }
	    
	    //
	    // test find UserId
	    //
	    
	    @Test
	    public void testFindUserId() throws Exception {
	       
	        String userName = "UserFive"; // test UserName
	        String phoneNumber = "555-5555-5555"; // test User PhoneNumber
	        
	        String expectedUserId = "user05"; // test input userId
	        
//	        // UserService 객체 생성
	        UserService userService = new UserServiceImpl();
	        
	        String existUserId = userService.findUserId(userName, phoneNumber); // search UserId
	        
	        assertNotNull(existUserId); // 확인된 아이디가 null이 아닌지 검사합니다.
	        
	        // 기대되는 아이디가 데이터베이스에서 가져온 아이디와 일치하는지 검사합니다.
	        assertEquals(userName, userService.getUserName(existUserId));
	        assertEquals(phoneNumber, userService.getPhoneNumber(existUserId));
	        SantaLogger.makeLog("info", "existUserId: " + existUserId);
	    
	    }

}
