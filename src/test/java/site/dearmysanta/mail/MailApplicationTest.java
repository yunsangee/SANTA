package site.dearmysanta.mail;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.junit4.SpringRunner;

import site.dearmysanta.SantaApplication;
import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.mail.MailConfig;
import site.dearmysanta.service.mail.MailService;
import site.dearmysanta.service.mail.impl.MailServiceImpl;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SantaApplication.class)
@Import(MailConfig.class)
public class MailApplicationTest {
	
	@Autowired
	MailService mailService;

	@Before
    public void setUp() {
        mailService = new MailServiceImpl();
    }

    //@Test
    void testMakeRandomNumber() throws Exception {
        String receiverEmail = "ljh71506@gmail.com";
        mailService.makeRandomNumber(receiverEmail);
        
        assertNotNull(mailService.getMap().get(receiverEmail));
        assertTrue(mailService.getMap().get(receiverEmail) >= 111111 && mailService.getMap().get(receiverEmail) <= 999999);
    
        SantaLogger.makeLog("info", "receiverEmail: " + receiverEmail);
    }

    @Test
    public void testMailSend() {
        String receiverEmail = "ljh71506@gmail.com";
        mailService.mailSend(receiverEmail);
        
        assertNotNull(mailService.getMap().get(receiverEmail));
        assertTrue(mailService.getMap().containsKey(receiverEmail));
    }

    //@Test
    void testCheckAuth() {
        String receiverEmail = "ljh71506@gmail.com";
        mailService.makeRandomNumber(receiverEmail);
        int authCode = mailService.getMap().get(receiverEmail);
        
        assertTrue(mailService.checkAuth(receiverEmail, authCode));
    }

}
