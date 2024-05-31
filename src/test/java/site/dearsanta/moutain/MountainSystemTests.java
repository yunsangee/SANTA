package site.dearsanta.moutain;

import java.sql.Date;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import site.dearmysanta.domain.correctionPost.CorrectionPost;

@SpringBootTest
public class MountainSystemTests {
	private static final Logger logger = LogManager.getLogger(MountainSystemTests.class);


	
	@Test
	public void extendsTest() {
		
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
		
		logger.info("=============================================\n");
		logger.info("correctionPost:" + correctionPost.toString() + "\n");
		logger.info("=============================================\n");
		
		
		
	}

}
