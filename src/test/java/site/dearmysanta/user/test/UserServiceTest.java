package site.dearmysanta.user.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import site.dearmysanta.SantaApplication;
import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.service.domain.user.User;
import site.dearmysanta.service.user.UserDao;
import site.dearmysanta.service.user.UserService;
import site.dearmysanta.service.user.impl.UserServiceImpl;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SantaApplication.class)
//@SpringBootTest(classes = UserServiceTest.class)

public class UserServiceTest {
	
	//UserService userService = new UserServiceImpl();
	
	@Autowired
	@Qualifier("userService")
	private UserService userService;
	
	@Test
	public void testAddUser() throws Exception {
		
		User user = User.builder()
				.userNo(4)
				.userId("user04")
				.userName("UserFour")
				.userPassword("password4")
				.address("Address4")
				.birthDate("1990/04/04")
				.build();
		
		userService.addUser(user);
		
		//user = userService.getUser(4);
		
		SantaLogger.makeLog("info", user.toString() +"\n");
	}
	
	//@Test
	public void testGetUser() throws Exception {
		
		User user = userService.getUser(4);
		
		SantaLogger.makeLog("info", user.toString() + "\n");
		
	}
	
	//@Test
	public void testUpdateUser() throws Exception {
		
		User user = userService.findUserId("user04");
		
		user.setAddress("Address4 º¯°æ");
		
		SantaLogger.makeLog("info", user.toString() + "\n");
	}

}
