package site.dearmysanta.mountain;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import site.dearmysanta.SantaApplication;
import site.dearmysanta.SantaApplicationTests;
import site.dearmysanta.service.mountain.impl.MountainServiceImpl;

//@RunWith(SpringRunner.class)
//@SpringBootTest(classes = SantaApplication.class)
@SpringBootTest(classes = MountainApplicationTest.class)
public class MountainApplicationTest {
	
//	@Autowired
//	MountainService mountainService;
	
	@Test
	public void apiTest() throws Exception {
		
		MountainServiceImpl mountainServiceImpl = new MountainServiceImpl();
		mountainServiceImpl.getMountain();
	}
	

}
