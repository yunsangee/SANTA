//package site.dearmysanta.user.test;
//
//import static org.junit.Assert.assertEquals;
//import static org.junit.Assert.assertFalse;
//import static org.junit.Assert.assertNotEquals;
//import static org.junit.Assert.assertNotNull;
//import static org.junit.Assert.assertNull;
//import static org.junit.Assert.assertTrue;
//
//import java.time.LocalDate;
//import java.util.List;
//import java.util.Map;
//
//import org.junit.Assert;
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Qualifier;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.test.context.junit4.SpringRunner;
//import org.springframework.transaction.annotation.Transactional;
//
//import site.dearmysanta.SantaApplication;
//import site.dearmysanta.common.SantaLogger;
//import site.dearmysanta.domain.common.Search;
//import site.dearmysanta.domain.user.QNA;
//import site.dearmysanta.domain.user.Schedule;
//import site.dearmysanta.domain.user.User;
//import site.dearmysanta.service.user.UserDao;
//import site.dearmysanta.service.user.UserService;
//import site.dearmysanta.service.user.impl.UserServiceImpl;
//
//@RunWith(SpringRunner.class)
//@SpringBootTest(classes = SantaApplication.class)
////@SpringBootTest(classes = UserServiceTest.class)
////@Transactional
//
//public class UserServiceTest {
//	
//	//UserService userService = new UserServiceImpl();
//	
//	@Autowired
//	//@Qualifier("userService")
//	//private UserService userService;
//	UserService userService;
//	
//	//
//	// test addUser
//	//
//	
//	//@Test
//	public void testAddUser() throws Exception {
//		
//		User user = User.builder()
//				//.userNo(13)
//				.userId("user2")
//				.userName("User2")
//				.userPassword("password2")
//				.nickName("Nick2")
//				.address("Address2")
//				.birthDate("1990/2/2")
//				.phoneNumber("000-222-2222")
//				.gender(0)
//				.hikingPurpose(0)
//				.hikingDifficulty(1)
//				.hikingLevel(3)
//				.role(0)
////				.certificationCount(0)
////				.meetingCount(0)
//				.profileImage("profileImage2")
//				.build();
//		
//		userService.addUser(user);
//		
//		user = userService.getUser(2);
//		
//		SantaLogger.makeLog("info", userService.getUser(2).toString() +"\n");
//	}
//	
//	//
//	// test GetUser
//	//
//	
//	//@Test
//	public void testGetUser() throws Exception {
//		
//		User user = userService.getUser(1);
//		
//		SantaLogger.makeLog("info", user.toString() + "\n");
//		
//	}
//	
//	//
//	// test UpdateUser
//	//
//	
//	//@Test
//	public void testUpdateUser() throws Exception {
//		
//		User user = userService.getUser(5);
//		
//		user.setAddress("Address5 변경5");
//		user.setBadgeImage("BadgeImage5 변경5");
//		
//		 userService.updateUser(user);
//						
//		SantaLogger.makeLog("info", userService.getUser(5).toString() + "\n");
//	}
//	
//	//
//	// test getUserList
//	//
//	
//	//@Test
////			public void testgetUserList(Search search) throws Exception {
////				Map<String, Object> list = userService.getUserList(search);
////				
////				
////				for(User u : list) {
////					System.out.println(u);
////				}
////				
////				System.out.println("==========");
////				///////////////////////////////////////////////////////////////
////			}
//			
//	//
//	// test Search getUserList 
//	//
//			
//			  //@Test
//			    public void testGetUserList() throws Exception {
//			        
////			        Search search = Search.builder()
////			                .searchCondition(0)
////			                .searchKeyword("user")
////			                .build();
//			        
////			        Search search = Search.builder()
////			                .searchCondition(1)
////			                .searchKeyword("Nick1")
////			                .build();
//				  
//				  Search search = Search.builder()
//			                .searchCondition(2)
//			                .searchKeyword("User")
//			                .build();
//
//			        Map<String, Object> results = userService.getUserList(search);
//			        assertNotNull(results);
//			        
////			        System.out.println("search : " + search);
////			        for (User u : results) {
////			            System.out.println(u);
////			        }
//			        
//			        System.out.println("==========");
//
//			        assertFalse(results.isEmpty());
//			        System.out.println("result : " + results);
//			        
//			    }
//    //
//    // test Search withdrawUserList
//    //
//			    
//	@Test
//			public void testwithdrawUserList() throws Exception {
//			        
////			        Search search = Search.builder()
////			                .searchCondition(0)
////			                .searchKeyword("user")
////			                .build();
//			        
//			        Search search = Search.builder()
//			                .searchCondition(1)
//			                .searchKeyword("Nick")
//			                .build();
//				  
////				  Search search = Search.builder()
////			                .searchCondition(2)
////			                .searchKeyword("User")
////			                .build();
//
//			        List<User> results = userService.withdrawUserList(search);
//			        assertNotNull(results);
//			        
//			        System.out.println("search : " + search);
//			        for (User u : results) {
//			            System.out.println(u);
//			        }
//			        
//			        System.out.println("==========");
//
//			        assertFalse(results.isEmpty());
//			        System.out.println("result : " + results);
//			        
//			    }
//			  
//	//
//	// test withdrawUserList
//	//
//			
//	//@Test
//	public void testwithdrawUserList(Search search) throws Exception {
//		List<User> list = userService.withdrawUserList(search);
//		
//		
//		for(User u : list) {
//			System.out.println(u);
//		}
//		
//		System.out.println("==========");
//		///////////////////////////////////////////////////////////////
//	}
//			
//	//
//	// test DuplicaionId
//	//
//	
//	//@Test
//	public void testDuplicationId() throws Exception {
//		
//		// NonDuplicate UserId
//		String nonDuplicationId = "newUser";
//		assertNull(userService.getDuplicationId(nonDuplicationId));
//		SantaLogger.makeLog("info", "Non-duplicate user: " + nonDuplicationId);
//		
//		// Duplicate UserId ( exist in DB )
//		String DuplicationId = "user04";
//		assertEquals(DuplicationId, userService.getDuplicationId(DuplicationId));
//		SantaLogger.makeLog("info", "Duplicate userId: " + DuplicationId);
//		
////		Assert.assertFalse( userService.getDuplicationId("testUserId") );
////	 	Assert.assertTrue( userService.getDuplicationId("testUserId"+System.currentTimeMillis()) );
//	}
//	
//	//
//	// test DuplicationNickName
//	//
//	
//	//@Test
//		public void testDuplicationNickname() throws Exception {
//			
//			// NonDuplicate NickName
//			String nonDuplicationNickName = "newNickName";
//			assertNull(userService.getDuplicationId(nonDuplicationNickName));
//			SantaLogger.makeLog("info", "Non-duplicate user: " + nonDuplicationNickName);
//			
//			// Duplicate NickName ( exist in DB )
//			String DuplicationNickName = "Nick4";
//			assertEquals(DuplicationNickName, userService.getDuplicationNickName(DuplicationNickName));
//			SantaLogger.makeLog("info", "duplicate user: " + DuplicationNickName);
//		}
//		
//		//
//		// test check password
//		//
//		
//		//@Test
//	    public void testCheckPassword() throws Exception {
//			
//	        String userId = "user04"; // test UserId
//	        String correctPassword = "password4"; // correct Password
//	        String incorrectPassword = "wrong_password"; // wrong Password
//
//	        // check correct Password
//	        assertEquals( 1, userService.getPassword(userId, correctPassword));
//	        SantaLogger.makeLog("info", "correctPassword: " + correctPassword);
//
//	        // check wrong Password
//	        assertEquals( 0, userService.getPassword(userId, incorrectPassword));
//	        SantaLogger.makeLog("info", "incorrectPassword: " + incorrectPassword);
//	    }
//	    
//	    //
//	    // test find UserId
//	    //
//	    
//	    //@Test
//	    public void testFindUserId() throws Exception {
//	       
//	        String userName = "UserFive"; // test UserName
//	        String phoneNumber = "555-5555-5555"; // test User PhoneNumber
//	        
//	        String expectedUserId = "user05"; // test input userId
//	        
//	        String existUserId = userService.findUserId(userName, phoneNumber); // search UserId
//	        
//	        assertNotNull(existUserId); // existUserId NULL test
//	        
//	        assertEquals(expectedUserId, existUserId); // compare expectedUserid, existUserId
//	        
//	        SantaLogger.makeLog("info", "expectedUserId: " + expectedUserId);
//	        SantaLogger.makeLog("info", "existUserId: " + existUserId);
//	    
//	    }
//	    
//	    //
//	    // test FindUserPassword
//	    //
//	    
//	    //@Test
//	    public void testFindUserPassword() throws Exception {
//	       
//	        String userId = "user05"; // test UserId
//	        String phoneNumber = "555-5555-5555"; // test User PhoneNumber
//	        
//	        String expectedUserPassword = "password5"; // test input userPassword
//	        
//	        String existUserPassword = userService.findUserPassword(userId, phoneNumber); // search UserPassword
//	        
//	        assertNotNull(existUserPassword); // existUserPassword NULL test
//	        
//	        assertEquals(expectedUserPassword, existUserPassword); // compare expectedUserPassword, existUserPassword
//	        
//	        SantaLogger.makeLog("info", "expectedUserPassword: " + expectedUserPassword);
//	        SantaLogger.makeLog("info", "existUserPassword: " + existUserPassword);
//	    
//	    }
//
//	    //
//	    // test delete User
//	    //
//	    
//	    //@Test
//	    public void testdeleteUser() throws Exception {
//	    	
//	            int userNo = 43;
//
//	            // delete User
//	            userService.deleteUser(userNo);
//	            
//	            User user = userService.getUser(43);
//	            
//	            //user.setWithdrawDate(withdrawDate);
//	            
//	            SantaLogger.makeLog("info", "deleteUser : " + userService.getUser(43).toString() + "\n");
//	           
//	        }
//	    
//	    //
//	    // test addQNA
//	    //
//	    
//		//@Test
//		public void testAddQnA() throws Exception {
//			
////			QNA qna = QNA.builder()
////					//.userNo(13)
////					.contents("qna add2 content")
////					.title("qna add2 title")
////					.qnaPostCategory(1)
////					.userNo(1)
////					.adminAnswer("관리자답변2")
////					.build();
//			
//			//userService.addQnA(qna);
//			
//			QNA qna = userService.getQnA(42); 
//			
//			SantaLogger.makeLog("info", userService.getQnA(42).toString() +"\n");
//		}
//		
//		//
//		// test add, get, List, update, delete QNA
//		//
//		
//		//@Test
//		public void testQnA(Search search) throws Exception {
//			List<QNA> list = userService.getQnAList(search);
//			
//			
//			for(QNA q : list) {
//				System.out.println(q);
//			}
//			
//			System.out.println("==========");
//			///////////////////////////////////////////////////////////////
//			
//			QNA qna = QNA.builder()
//			//.userNo(13)
//			.contents("qna add22 content")
//			.title("qna add22 title")
//			.qnaPostCategory(1)
//			.userNo(1)
//			.adminAnswer("관리자답변22")
//			.build();
//			
//			userService.addQnA(qna);
//			
//			//userService.addAdminAnswer(45, "관리자답변test");
//			
//			list = userService.getQnAList(search);
//			
//			for(QNA q : list) {
//				System.out.println(q);
//			}
//			System.out.println("==========");
//			
//			////////////////////////////////////////////////////////////////
//			
//			userService.deleteQnA(45, 1);
//			
//			list = userService.getQnAList(search);
//			
//			
//			for(QNA q : list) {
//				System.out.println(q);
//			}
//			
//		}
//		
//		//
//		// test adminAnswer
//		//
//		
//		//@Test
//		public void testaddAdminAnswer() throws Exception {
//			
//			QNA qna = userService.getQnA(46);
//			
//			qna.setAdminAnswer("관리자답변변경test");
//			
//			 userService.addAdminAnswer(qna);
//							
//			SantaLogger.makeLog("info", userService.getQnA(46).toString() + "\n");
//		}
//		
//		//
//		// test add, get, List, update, delete SCHEDULE
//		//
//		
//		//@Test
//		public void testSchedule() throws Exception {
//			List<Schedule> list = userService.getScheduleList();
//			
//			
//			for(Schedule s : list) {
//				System.out.println(s);
//			}
//			
//			System.out.println("==========");
//			///////////////////////////////////////////////////////////////
//			
//			Schedule schedule = Schedule.builder()
//			.contents("schedule add5 content")
//			.title("schedule add5 title")
//			.mountainName("치악산")
//			.userNo(42)
//			.hikingTotalTime("3:30")
//			.hikingDifficulty(1)
//			.hikingDescentTime("01:45")
//			.hikingAscentTime("01:45")
//			.Transportaion(0)
//			.build();
//			
//			userService.addSchedule(schedule);
//			
//			list = userService.getScheduleList();
//			
//			for(Schedule s : list) {
//				System.out.println(s);
//			}
//			System.out.println("==========");
//			
//			////////////////////////////////////////////////////////////////
//			
//			userService.deleteSchedule(71, 42);
//			
//			list = userService.getScheduleList();
//			
//			
//			for(Schedule s : list) {
//				System.out.println(s);
//			}
//			
//		}
//		
//		//
//		// test updateSchedule
//		//
//		
//		//@Test
//		public void testUpdateSchedule() throws Exception {
//			
//			Schedule schedule = userService.getSchedule(72);
//			
//			schedule.setMountainName("비트산1");
//			schedule.setContents("content 변경 test");
//			
//			 userService.updateSchedule(schedule);
//							
//			SantaLogger.makeLog("info", userService.getSchedule(72).toString() + "\n");
//		}
//		
//		//
//		// test login
//		//
//		
//		 //@Test
//		    public void testLogin() throws Exception {
//		        
//			 	String userId = "user02";
//		        String password = "password2";
//		        
//		        User result = userService.login(userId, password);
//		        
//		        assertNotNull(result);
//		        assertEquals(userId, result);
//		        
//		        SantaLogger.makeLog("info", "result: " + result);
//		        
//		    }
//		    
//		    //
//		    // test Search QNAList TITLE and Nickname
//		    //
//		    
//		    //@Test
//		    public void testGetQnAList() throws Exception {
//		        
////		        Search search = Search.builder()
////		                .searchCondition(0)
////		                .searchKeyword("qna add1 title")
////		                .build();
//		        
//		        Search search = Search.builder()
//		                .searchCondition(1)
//		                .searchKeyword("Nick")
//		                .build();
//
//		        List<QNA> results = userService.getQnAList(search);
//		        assertNotNull(results);
//		        
//		        System.out.println("search : " + search);
//		        for (QNA q : results) {
//		            System.out.println(q);
//		        }
//		        
//		        System.out.println("==========");
//
//		        assertFalse(results.isEmpty());
//		        System.out.println("result : " + results);
//		        
//		    }
//		    
//		    //
//		    // test GetMountain Total count
//		    //
//		  
//		    @Test
//			public void testgetMountainTotalCount() throws Exception {
//				
//				int count = userService.getMountainTotalCount("관악산");
//				
//				//int count = scheduleMapper.getMountainTotalCount("관악산");
//				
//				SantaLogger.makeLog("info", count + "\n");
//				
//			}
//		    
////		    @Test
////		    public void testFindUserPhoneNumber() throws Exception {
////		    	
////			    //String userName = "UserOne";
////		        String phoneNumber = "456-7890-0123";
////
////		        // 데이터베이스에 해당 전화번호를 가진 사용자가 있다고 가정합니다.
////		        //User user = userService.findUserPhoneNumber(userName, phoneNumber);
////		        String user = userService.findUserPhoneNumber(phoneNumber);
////		        
////		        System.out.println(phoneNumber);
////
////		        assertNotNull(user);
////		        //assertEquals(userName, phoneNumber, user.getPhoneNumber());
////		        assertEquals(phoneNumber, userService.findUserPhoneNumber(phoneNumber));
////		        
////		        SantaLogger.makeLog("info", "phoneNumber: " + phoneNumber);
////		        
//////		        System.out.println("User No: " + user.getUserNo());
//////		        System.out.println("User Name: " + user.getUserName());
//////		        System.out.println("User PhoneNumber: " + user.getPhoneNumber());
////		        
////		    }
//}
