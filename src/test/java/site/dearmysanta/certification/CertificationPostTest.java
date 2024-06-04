package site.dearmysanta.certification;

import java.util.Arrays;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import site.dearmysanta.SantaApplication;
import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.common.Like;
import site.dearmysanta.service.certification.CertificationPostService;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SantaApplication.class)
public class CertificationPostTest {

	@Autowired
	CertificationPostService certificationPostService;
	
	// @Test
	    public void TestaddCertificationPost() throws Exception {
	        // CertificationPost ��ü�� �����մϴ�.
	        CertificationPost certificationPost = CertificationPost.builder()
	            .userNo(2)
	            .title("Certification Post")
	            .contents("This is a certification post.")
	            .certificationPostMountainName("1111")
	            .certificationPostHikingTrail("Base Camp")
	            .certificationPostTotalTime("4:30")
	            .certificationPostAscentTime("2:00")
	            .certificationPostDescentTime("2:30")
	            .certificationPostHikingDate("2024-06-01")
	            .certificationPostTransportation(1)
	            .certificationPostHikingDifficulty(1)
	            .certificationPostHashtag(Arrays.asList("333", "222"))
	    
	            .build();

	        // CertificationPostService�� ����Ͽ� �Խñ��� �����ͺ��̽��� �߰��մϴ�.
	        certificationPostService.addCertificationPost(certificationPost);

	        // SantaLogger�� ����Ͽ� �α׸� ����մϴ�.
	        SantaLogger.makeLog("info", certificationPost.toString());
	    }
	 
//	@Test
	 public void TestgetCertificationPost() throws Exception {

		   CertificationPost certificationPost = new CertificationPost();
		   
		   certificationPost = certificationPostService.getCertificationPost(1);
				  
	        SantaLogger.makeLog("info", certificationPost.toString());
	 }
	
	// @Test
	 public void TestupdateCertificationPost() throws Exception {
	 
	     CertificationPost certificationPost = certificationPostService.getCertificationPost(1);
	     
	     certificationPost.setCertificationPostMountainName("ppp");

	     certificationPostService.updateCertificationPost(certificationPost);

	     SantaLogger.makeLog("info", certificationPost.toString());
	 }

	 
//	// @Test
//	   public void TestaddCertificationPostHashtags() throws Exception {
//	 
//	 
//		   CertificationPost certificationPost = CertificationPost.builder()
//				   
//				  . hashtag_content
//	 
//				   .build();
//	 
//		 SantaLogger.makeLog("info", certificationPost.toString());
//	 
	 
	 
	 
	 @Test
	 public void testAddCertificationPostLike() {
	     // ���ƿ並 �߰��� ����� ��ȣ�� �Խù� ��ȣ�� �����մϴ�.
	     int userNo = 1; // ����� ��ȣ
	     int postNo = 1; // �Խù� ��ȣ
	     
	     // Like ��ü�� �����Ͽ� ����� ��ȣ�� �Խù� ��ȣ�� �����մϴ�.
	     Like like = new Like();
	     like.setUserNo(userNo);
	     like.setPostNo(postNo);
	     
	     // ���ƿ並 �߰��ϴ� ������ �����մϴ�.
	     certificationPostService.addCertificationPostLike(like);
	     
	
	     
	 }

	 
	}












