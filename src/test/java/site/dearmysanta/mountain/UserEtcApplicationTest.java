package site.dearmysanta.mountain;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import site.dearmysanta.SantaApplication;
import site.dearmysanta.service.user.etc.UserEtcService;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SantaApplication.class)
public class UserEtcApplicationTest {

	@Autowired
	UserEtcService userEtcService;
	
	//@Test
	public void userEtcTest() throws Exception {
		
		System.out.println(userEtcService.getCertificationCount(1));
		System.out.println(userEtcService.getCertificationCount(1));
		
		userEtcService.updateCertificationCount(1);
		userEtcService.updateMeetingCount(1);
		
		System.out.println(userEtcService.getCertificationCount(1));
		System.out.println(userEtcService.getCertificationCount(1));
		
		
		
	}
	
	
	
}
