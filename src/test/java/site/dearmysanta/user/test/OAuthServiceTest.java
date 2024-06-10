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
	        // ���� �׽�Ʈ�� ���ؼ��� ��ȿ�� īī�� �ΰ� �ڵ带 ����ؾ� �մϴ�.
	        String testCode = "mXppNm3WRFIDlpsVs5t8dfZeo9A7vq4xl4glX6rCyj24R4c6IpCDyAAAAAQKKcleAAABj__qiSRtZc76WqiBKA";
	        
	        // access token�� �������� �޼��带 ȣ���մϴ�.
	        String accessToken = oAuthService.getKakaoAccessToken(testCode);
	        
	        // access token�� null�� �ƴ��� Ȯ���մϴ�.
	        assertNotNull(accessToken, "Access token should not be null");

	        System.out.println("Access Token: " + accessToken);
	    }
	}
		
