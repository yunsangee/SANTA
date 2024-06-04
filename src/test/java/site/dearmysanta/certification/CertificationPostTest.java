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
	        // CertificationPost 객체를 생성합니다.
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

	        // CertificationPostService를 사용하여 게시글을 데이터베이스에 추가합니다.
	        certificationPostService.addCertificationPost(certificationPost);

	        // SantaLogger를 사용하여 로그를 출력합니다.
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
	     // 좋아요를 추가할 사용자 번호와 게시물 번호를 설정합니다.
	     int userNo = 1; // 사용자 번호
	     int postNo = 1; // 게시물 번호
	     
	     // Like 객체를 생성하여 사용자 번호와 게시물 번호를 설정합니다.
	     Like like = new Like();
	     like.setUserNo(userNo);
	     like.setPostNo(postNo);
	     
	     // 좋아요를 추가하는 쿼리를 실행합니다.
	     certificationPostService.addCertificationPostLike(like);
	     
	
	     
	 }

	 
	}












