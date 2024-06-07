package site.dearmysanta.user.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

import java.time.LocalDate;
import java.util.List;

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
import site.dearmysanta.domain.user.QNA;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.user.UserDao;
import site.dearmysanta.service.user.UserService;
import site.dearmysanta.service.user.impl.UserServiceImpl;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SantaApplication.class)
//@SpringBootTest(classes = UserServiceTest.class)
//@Transactional

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
				//.userNo(13)
				.userId("user2")
				.userName("User2")
				.userPassword("password2")
				.nickName("Nick2")
				.address("Address2")
				.birthDate("1990/2/2")
				.phoneNumber("000-222-2222")
				.gender(0)
				.hikingPurpose(0)
				.hikingDifficulty(1)
				.hikingLevel(3)
				.role(0)
//				.certificationCount(0)
//				.meetingCount(0)
				.profileImage("profileImage2")
				.build();
		
		userService.addUser(user);
		
		user = userService.getUser(2);
		
		SantaLogger.makeLog("info", userService.getUser(2).toString() +"\n");
	}
	
	//
	// test GetUser
	//
	
	//@Test
	public void testGetUser() throws Exception {
		
		User user = userService.getUser(1);
		
		SantaLogger.makeLog("info", user.toString() + "\n");
		
	}
	
	//
	// test UpdateUser
	//
	
	//@Test
	public void testUpdateUser() throws Exception {
		
		User user = userService.getUser(5);
		
		user.setAddress("Address5 변경5");
		user.setBadgeImage("BadgeImage5 변경5");
		
		 userService.updateUser(user);
						
		SantaLogger.makeLog("info", userService.getUser(5).toString() + "\n");
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
	    
	    //@Test
	    public void testFindUserId() throws Exception {
	       
	        String userName = "UserFive"; // test UserName
	        String phoneNumber = "555-5555-5555"; // test User PhoneNumber
	        
	        String expectedUserId = "user05"; // test input userId
	        
	        String existUserId = userService.findUserId(userName, phoneNumber); // search UserId
	        
	        assertNotNull(existUserId); // existUserId NULL test
	        
	        assertEquals(expectedUserId, existUserId); // compare expectedUserid, existUserId
	        
	        SantaLogger.makeLog("info", "expectedUserId: " + expectedUserId);
	        SantaLogger.makeLog("info", "existUserId: " + existUserId);
	    
	    }
	    
	    //
	    // test FindUserPassword
	    //
	    
	    //@Test
	    public void testFindUserPassword() throws Exception {
	       
	        String userId = "user05"; // test UserId
	        String phoneNumber = "555-5555-5555"; // test User PhoneNumber
	        
	        String expectedUserPassword = "password5"; // test input userPassword
	        
	        String existUserPassword = userService.findUserPassword(userId, phoneNumber); // search UserPassword
	        
	        assertNotNull(existUserPassword); // existUserPassword NULL test
	        
	        assertEquals(expectedUserPassword, existUserPassword); // compare expectedUserPassword, existUserPassword
	        
	        SantaLogger.makeLog("info", "expectedUserPassword: " + expectedUserPassword);
	        SantaLogger.makeLog("info", "existUserPassword: " + existUserPassword);
	    
	    }

	    //
	    // test delete User
	    //
	    
	    //@Test
	    public void testdeleteUser() throws Exception {
	    	
	            int userNo = 5;

	            // delete User
	            userService.deleteUser(userNo);
	            
	            User user = userService.getUser(5);
	            
	            //user.setWithdrawDate(withdrawDate);
	            
	            SantaLogger.makeLog("info", "deleteUser : " + userService.getUser(5).toString() + "\n");
	           
	        }
	    
	    //
	    // test addQNA
	    //
	    
		//@Test
		public void testAddQnA() throws Exception {
			
//			QNA qna = QNA.builder()
//					//.userNo(13)
//					.contents("qna add2 content")
//					.title("qna add2 title")
//					.qnaPostCategory(1)
//					.userNo(1)
//					.adminAnswer("관리자답변2")
//					.build();
			
			//userService.addQnA(qna);
			
			QNA qna = userService.getQnA(42); 
			
			SantaLogger.makeLog("info", userService.getQnA(42).toString() +"\n");
		}
		
		@Test
		public void testQnA() throws Exception {
			List<QNA> list = userService.getQnAList();
			
			
			for(QNA q : list) {
				System.out.println(q);
			}
			
			System.out.println("==========");
			///////////////////////////////////////////////////////////////
			
			QNA qna = QNA.builder()
			//.userNo(13)
			.contents("qna add22 content")
			.title("qna add22 title")
			.qnaPostCategory(1)
			.userNo(1)
			.adminAnswer("관리자답변22")
			.build();
			
			userService.addQnA(qna);
			
			userService.addAdminAnswer(45, "김남주바보");
			
			list = userService.getQnAList();
			
			for(QNA q : list) {
				System.out.println(q);
			}
			System.out.println("==========");
			
			////////////////////////////////////////////////////////////////
			
			userService.deleteQnA(45, 1);
			
			list = userService.getQnAList();
			
			
			for(QNA q : list) {
				System.out.println(q);
			}
			
			
		}
}
