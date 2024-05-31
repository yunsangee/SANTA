package site.dearsanta.moutain;

import java.sql.Date;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import site.dearmysanta.domain.correctionPost.CorrectionPost;

@SpringBootTest
public class MountainSystemTests {
	
	@Test
	public void extendsTest() {
		
		CorrectionPost correctionPost = CorrectionPost.builder()
	            .userNo(1)
	            .nickName("JohnDoe")
	            .profileImage("https://example.com/johndoe.jpg")
	            .postNo(102)
	            .title("Correction Post")
	            .contents("This is a correction post.")
	            .date(new Date().getDate())
	            .mountainNo(1001)
	            .mountainName("Everest")
	            .status(1)
	            .build();
		
		
		
	}

}
