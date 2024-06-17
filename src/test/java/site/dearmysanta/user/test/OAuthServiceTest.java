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
	        String testCode = "UreCZZOJ_L4loS5E5l10ZU-PZ4fLjiY14xnRiUCDZn-lDGkmuZLrfQAAAAQKPXLqAAABkB-4Dgv7Ewsnpgvovw";
	        
	        // access token�� �������� �޼��带 ȣ���մϴ�.
	        String accessToken = oAuthService.getKakaoAccessToken(testCode);
	        
	        // access token�� null�� �ƴ��� Ȯ���մϴ�.
	        assertNotNull(accessToken, "Access token should not be null");

	        System.out.println("Access Token: " + accessToken);
	    }
	}
		
