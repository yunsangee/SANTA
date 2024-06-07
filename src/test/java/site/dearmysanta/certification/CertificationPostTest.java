package site.dearmysanta.certification;

import java.util.Arrays;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import site.dearmysanta.SantaApplication;
import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.certificationPost.CertificationPostComment;
import site.dearmysanta.domain.common.Like;
import site.dearmysanta.service.certification.CertificationPostService;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SantaApplication.class)
public class CertificationPostTest {

	@Autowired
	CertificationPostService certificationPostService;
	
	//@Test
	public void testGetCertificationPostList() throws Exception {
        List<CertificationPost> certificationPostList = certificationPostService.getCertificationPostList();
        
        
        for (CertificationPost certificationPost : certificationPostList) {
            SantaLogger.makeLog("info", certificationPost.toString());
        }
    }

	
	 @Test
	 public void testAddCertificationPostWithTags() throws Exception {
	     CertificationPost certificationPost = CertificationPost.builder()
	         .userNo(1)
	         .title("Test Title@@")
	         .contents("Test Contents")
	         .certificationPostMountainName("Mountain")
	         .certificationPostHikingTrail("Trail")
	         .certificationPostTotalTime("4:30")
	         .certificationPostAscentTime("2:00")
	         .certificationPostDescentTime("2:30")
	         .certificationPostHikingDate("2024-06-01")
	         .certificationPostTransportation(1)
	         .certificationPostHikingDifficulty(1)
	         .certificationPostHashtagContents("tag1, tag2")
	         .build();

	     certificationPostService.addCertificationPost(certificationPost);
	     SantaLogger.makeLog("info", certificationPost.toString());


	 }

	 

	// @Test
	    public void testGetCertificationPostCommentList() throws Exception {
	        int postNo = 1;
	        
	        List<CertificationPostComment> commentList = certificationPostService.getCertificationPostCommentList(postNo);
	        
	            for (CertificationPostComment comment : commentList) {
	            SantaLogger.makeLog("info", comment.toString());
	        }
	        
	    }
	 
	//@Test
	 public void TestgetCertificationPost() throws Exception {

		   CertificationPost certificationPost = new CertificationPost();
		   
		   certificationPost = certificationPostService.getCertificationPost(2);
				  
	        SantaLogger.makeLog("info", certificationPost.toString());
	 }
	
	
	
//	@Test
//	public void testDeleteCertificationPostComment() throws Exception {
//	    // ����� ������ ����� ��ȣ, ��� ��ȣ, �Խù� ��ȣ�� �����մϴ�.
//	    int userNo = 3; // ����� ��ȣ
//	    int certificationPostCommentNo = 3; // ��� ��ȣ
//	
//	    // CertificationPostComment ��ü�� �����Ͽ� ����� ��ȣ, ��� ��ȣ, �Խù� ��ȣ�� �����մϴ�.
//	    CertificationPostComment certificationPostComment = new CertificationPostComment();
//	    certificationPostComment.setUserNo(userNo);
//	    certificationPostComment.setCertificationPostCommentNo(certificationPostCommentNo);
//
//	    // ����� �����ϴ� ������ �����մϴ�.
//	    certificationPostService.deleteCertificationPostComment(certificationPostComment);
//	}

	
	
	
	//@Test
    public void testAddCertificationPostComment() throws Exception {
        // CertificationPostComment ��ü�� �����մϴ�.
        CertificationPostComment certificationPostComment = CertificationPostComment.builder()
            .userNo(2)
            .certificationPostNo(1)
            .certificationPostCommentContents("����ۼ��ϱ���.")
            .build();

        // addCertificationPostComment �޼��� ȣ��
        certificationPostService.addCertificationPostComment(certificationPostComment);

        // �α� ���
        SantaLogger.makeLog("info", certificationPostComment.toString());
    }

	
	
	//@Test
//	public void testAddCertificationPost() throws Exception {
//	    // CertificationPost ��ü�� �����մϴ�.
//	    CertificationPost certificationPost = CertificationPost.builder()
//	        .userNo(2)
//	        .title("Certification Post")
//	        .contents("This is a certification post.")
//	        .certificationPostMountainName("1111")
//	        .certificationPostHikingTrail("Base Camp")
//	        .certificationPostTotalTime("4:30")
//	        .certificationPostAscentTime("2:00")
//	        .certificationPostDescentTime("2:30")
//	        .certificationPostHikingDate("2024-06-01")
//	        .certificationPostTransportation(1)
//	        .certificationPostHikingDifficulty(1)
//	        .certificationPostHashtagContents( "222")
//	        .build();
//
//	    // addCertificationPost �޼��� ȣ��
//	    certificationPostService.addCertificationPost(certificationPost);
//
//	    // �α� ���
//	    System.out.println(certificationPost.toString());
//	}

	
	
	
	
	
	
	
 //@Test
//	    public void TestaddCertificationPost() throws Exception {
//	        // CertificationPost ��ü�� �����մϴ�.
//	        CertificationPost certificationPost = CertificationPost.builder()
//	            .userNo(2)
//	            .title("Certification Post")
//	            .contents("This is a certification post.")
//	            .certificationPostMountainName("1111")
//	            .certificationPostHikingTrail("Base Camp")
//	            .certificationPostTotalTime("4:30")
//	            .certificationPostAscentTime("2:00")
//	            .certificationPostDescentTime("2:30")
//	            .certificationPostHikingDate("2024-06-01")
//	            .certificationPostTransportation(1)
//	            .certificationPostHikingDifficulty(1)
//	            .certificationPostHashtag(Arrays.asList("333", "222"))
//	    
//	            .build();
//
//	        
//	        
//	        // CertificationPostService�� ����Ͽ� �Խñ��� �����ͺ��̽��� �߰��մϴ�.
//	        certificationPostService.addCertificationPost(certificationPost);
//	        certificationPostService.addCertificationPostHashtags(certificationPost);
//
//	        // SantaLogger�� ����Ͽ� �α׸� ����մϴ�.
//	        SantaLogger.makeLog("info", certificationPost.toString());
//	    }

// @Test
// public void TestaddCertificationPostHashtags() throws Exception {
//	    
//	 
//	   CertificationPost certificationPost = CertificationPost.builder()
//			   
//			
//			   .certificationPostNo(1)
//			   .certificationPostHashtag("11sfsf")
//			   	   
//			   .build();
//	   certificationPostService.addCertificationPostHashtags(certificationPost);
//
//       // SantaLogger�� ����Ͽ� �α׸� ����մϴ�.
//       SantaLogger.makeLog("info", certificationPost.toString());
// }
	    
	    
//	
//	// @Test
//	 public void TestupdateCertificationPost() throws Exception {
//	 
//	     CertificationPost certificationPost = certificationPostService.getCertificationPost(1);
//	     
//	     certificationPost.setCertificationPostMountainName("ppp");
//
//	     certificationPostService.updateCertificationPost(certificationPost);
//
//	     SantaLogger.makeLog("info", certificationPost.toString());
//	 }

	 
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
	 
	 
//@Test
//public void testAddCertificationPostLike() {
//    // ���ƿ並 �߰��� ����� ��ȣ�� �Խù� ��ȣ�� �����մϴ�.
//    int userNo = 2; // ����� ��ȣ
//    int postNo = 3; // �Խù� ��ȣ
//    
//    // Like ��ü�� �����Ͽ� ����� ��ȣ�� �Խù� ��ȣ�� �����մϴ�.
//    Like like = new Like();
//    like.setUserNo(userNo);
//    like.setPostNo(postNo);
//    
//    // ���ƿ並 �߰��ϴ� ������ �����մϴ�.
//    certificationPostService.addCertificationPostLike(like);
//    
//    // ���ƿ䰡 �� �߰��Ǿ����� Ȯ���ϴ� �ڵ带 �߰��մϴ�.
//    // ���� ���, ���ƿ䰡 �߰��Ǿ��ٴ� ���� Ȯ���� �� �ִ� �پ��� ����� ����� �� �ֽ��ϴ�.
//    // �߰��� ���ƿ並 �����ͺ��̽����� ��ȸ�ϰų�, �ش� �Խù��� ���� ���ƿ� ������ Ȯ���ϴ� ���� ����� �ֽ��ϴ�.
//    // ���� ���, assertEquals(expectedCount, actualCount) �޼ҵ带 ����Ͽ� ����Ǵ� ���ƿ� ������ ���� �߰��� ���ƿ� ������ ���� �� �ֽ��ϴ�.
//}

//@Test
//public void testDeleteCertificationPostLike() {
//    // ���ƿ並 ������ ����� ��ȣ�� �Խù� ��ȣ�� �����մϴ�.
//    int userNo = 2; // ����� ��ȣ
//    int postNo = 18; // �Խù� ��ȣ
//    
//    // Like ��ü�� �����Ͽ� ����� ��ȣ�� �Խù� ��ȣ�� �����մϴ�.
//    Like like = new Like();
//    like.setUserNo(userNo);
//    like.setPostNo(postNo);
//    
//    // ���ƿ並 �����ϴ� ������ �����մϴ�.
//    certificationPostService.deleteCertificationPostLike(like);
//}

//	@Test
//	public void testGetCertificationPostLikeList() {
//	    int userNo = 2; // ����� ��ȣ
//	    
//	    // Like ��ü ���� �� ����� ��ȣ ����
//	    Like like = new Like();
//	    like.setUserNo(userNo);
//	    
//	    List<CertificationPost> postList = certificationPostService.getCertificationPostLikeList(like);
//	 
//	    for (CertificationPost post : postList) {
//	        System.out.println("�Խñ� ��ȣ: " + post.getPostNo());
//	        System.out.println("�Խñ� ����: " + post.getTitle());
//	        // �ʿ��� ���� ���
//	    }}

	}
	 
	









