package site.dearmysanta.user.test;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import site.dearmysanta.SantaApplication;
import site.dearmysanta.service.user.OAuthService;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SantaApplication.class)

public class OAuthServiceTest {

	@Autowired
    OAuthService oAuthService;
	
	 @Test
	    public void testGetKakaoAccessToken() {
	        // 실제 테스트를 위해서는 유효한 카카오 인가 코드를 사용해야 합니다.
	        String testCode = "mXppNm3WRFIDlpsVs5t8dfZeo9A7vq4xl4glX6rCyj24R4c6IpCDyAAAAAQKKcleAAABj__qiSRtZc76WqiBKA";
	        
	        // access token을 가져오는 메서드를 호출합니다.
	        String accessToken = oAuthService.getKakaoAccessToken(testCode);
	        
	        // access token이 null이 아닌지 확인합니다.
	        assertNotNull(accessToken, "Access token should not be null");

	        System.out.println("Access Token: " + accessToken);
	    }
	}
		
