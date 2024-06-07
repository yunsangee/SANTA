//package site.dearmysanta.mail;
//
//import static org.junit.Assert.assertNotNull;
//import static org.junit.Assert.assertTrue;
//
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.test.context.junit4.SpringRunner;
//
//import site.dearmysanta.SantaApplication;
//import site.dearmysanta.common.SantaLogger;
//import site.dearmysanta.service.mail.MailService;
//
//@RunWith(SpringRunner.class)
//@SpringBootTest(classes = SantaApplication.class)
//
//public class MailApplicationTest {
//	
//	@Autowired
//	
//	MailService mailService;
//
//	 //@Test
//	    public void testMakeRandomNumberAndCheckAuth() {
//	        // Arrange
//	        String receiverEmail = "test@example.com";
//
//	        // Act
//	        // 메일을 보내고 랜덤 번호를 생성하도록 호출
//	        mailService.mailSend(receiverEmail);
//
//	        // Assert
//	        // 생성된 랜덤 번호를 확인하고 로깅
//	        Integer randomNumber = mailService.getMap().get(receiverEmail);
//	        assertNotNull(randomNumber);
//	        //logger.info("Generated random number for " + receiverEmail + ": " + randomNumber);
//	        SantaLogger.makeLog("info", "Generated random number for " + receiverEmail + ": " + randomNumber);
//
//	        // Act
//	        // 생성된 랜덤 번호로 인증 확인하도록 호출
//	        boolean authResult = mailService.checkAuth(receiverEmail, randomNumber);
//
//	        // Assert
//	        // 인증 확인 결과를 로깅
//	        assertTrue(authResult);
//	        //logger.info("Authentication check for " + receiverEmail + ": Passed");
//	        SantaLogger.makeLog("info", "Authentication check for " + receiverEmail + ": Passed");
//	    }
//}
