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
//	        // ������ ������ ���� ��ȣ�� �����ϵ��� ȣ��
//	        mailService.mailSend(receiverEmail);
//
//	        // Assert
//	        // ������ ���� ��ȣ�� Ȯ���ϰ� �α�
//	        Integer randomNumber = mailService.getMap().get(receiverEmail);
//	        assertNotNull(randomNumber);
//	        //logger.info("Generated random number for " + receiverEmail + ": " + randomNumber);
//	        SantaLogger.makeLog("info", "Generated random number for " + receiverEmail + ": " + randomNumber);
//
//	        // Act
//	        // ������ ���� ��ȣ�� ���� Ȯ���ϵ��� ȣ��
//	        boolean authResult = mailService.checkAuth(receiverEmail, randomNumber);
//
//	        // Assert
//	        // ���� Ȯ�� ����� �α�
//	        assertTrue(authResult);
//	        //logger.info("Authentication check for " + receiverEmail + ": Passed");
//	        SantaLogger.makeLog("info", "Authentication check for " + receiverEmail + ": Passed");
//	    }
//}
