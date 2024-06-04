package site.dearmysanta;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Test;

import site.dearmysanta.domain.correctionPost.CorrectionPost;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest(classes = SantaApplicationTests.class)
public class SantaApplicationTests {

	private static final Logger logger = LogManager.getLogger(SantaApplicationTests.class);

	@Test
	public void contextLoads() {
		
		System.out.println("==========================\n");
		
		CorrectionPost correctionPost = CorrectionPost.builder()
	            .userNo(1)
	            .nickName("JohnDoe")
	            .profileImage("https://example.com/johndoe.jpg")
	            .postNo(102)
	            .title("Correction Post")
	            .contents("This is a correction post.")
	            .mountainNo(1001)
	            .mountainName("Everest")
	            .status(1)
	            .build();
		
		System.out.println(correctionPost.toString());		
		System.out.println("==========================\n");
		
		logger.info("=============================================\n");
		logger.info("correctionPost:" + correctionPost.toString() + "\n"); // realization test
		logger.info("=============================================\n"); //log4j2 test
//		logger.debug("debug");
		logger.error("error");
		

	}

}
