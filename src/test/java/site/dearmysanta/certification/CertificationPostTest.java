package site.dearmysanta.certification;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.service.certification.CertificationPostDao;
import site.dearmysanta.service.certification.CertificationPostService;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SantaApplication.class)
public class CertificationPostTest {

	@Autowired
	CertificationPostService certificationPostService;
	
//	@Autowired
//	CertificationPostDao certificationPostDao;

	//@Test
    public void testgetMountainTotalCount() throws Exception {
       
       int count = certificationPostService.getTotalMountainCount("Mountain");
       
       //int count = scheduleMapper.getMountainTotalCount("���ǻ�");
       
       SantaLogger.makeLog("info", count + "\n");
       
    }
	
	
	
	
	@Test
    public void testGetCertificationPostList() throws Exception {
        Search search = new Search();
         search.setSearchCondition(4);
     //  search.setSearchKeyword("F");

        Map<String, Object> result = certificationPostService.getCertificationPostList(search);
        List<CertificationPost> certificationPosts = (List<CertificationPost>) result.get("list");

        for (CertificationPost post : certificationPosts) {
            SantaLogger.makeLog("info", post.getTitle() + " " + post.getCertificationPostLikeCount());

        }
    }
	//@Test
	public void testgetCertification() throws Exception {
		
		Map<String, Object> certificationPost = certificationPostService.getCertificationPost(1);
		
		SantaLogger.makeLog("info", certificationPost.toString());
		
	}
	
	 //@Test
	    public void testMyCertificationPostList() throws Exception {
	
	        int userNo = 3; // �׽�Ʈ�� ����� ��ȣ
	      
        List<CertificationPost> results = certificationPostService.getMyCertificationPostList(userNo);
	 
	        for (CertificationPost result : results) {
	            SantaLogger.makeLog("info", result.toString());
	        }
	    }
	
////	@Test
//    public void testAddCertificationPostComment1() throws Exception {
//        // CertificationPostComment ��ü�� �����մϴ�.
//        CertificationPostComment certificationPostComment = CertificationPostComment.builder()
//            .userNo(2)
//            .certificationPostNo(1)
//            .certificationPostCommentContents("����ۼ��ϱ�!!.")
//            .build();
//
//        // addCertificationPostComment �޼��� ȣ��
//        certificationPostService.addCertificationPostComment(certificationPostComment);
//        
//        List<CertificationPost> list = certificationPostService.getCertificationPostList();
//        list = certificationPostService.getCertificationPostList();
//    	System.out.println("==================");
//    	for(CertificationPost post : list) {
//    		System.out.println(post);
//        // �α� ���
//        SantaLogger.makeLog("info", certificationPostComment.toString());
//    }
//    }
//	
	//@Test
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
	         .certificationPostHashtagContents("1111")
	         .build();

	     certificationPostService.addCertificationPost(certificationPost);
	     SantaLogger.makeLog("info", certificationPost.toString());


	 }

	 

	// @Test
//	    public void testGetCertificationPostCommentList() throws Exception {
//	        int postNo = 1;
//	        
//	        List<CertificationPostComment> commentList = certificationPostService.getCertificationPostCommentList(postNo);
//	        
//	            for (CertificationPostComment comment : commentList) {
//	            SantaLogger.makeLog("info", comment.toString());
//	        }
//	        
//	    }
	 	//@Test
//	 public void TestgetCertificationPost() throws Exception {
//
//		   CertificationPost certificationPost = new CertificationPost();
//		   
//		   certificationPost = certificationPostService.getCertificationPost(2);
//				  
//	        SantaLogger.makeLog("info", certificationPost.toString());
//	 }
//	
//	//@Test
//	 public void Testhashtag() throws Exception {
//
//		   CertificationPost certificationPost = new CertificationPost();
//		   
//		   certificationPost = certificationPostService.getHashtag(2);
//				  
//	        SantaLogger.makeLog("info", certificationPost.toString());
//	 
//	}
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
//    public void testAddCertificationPostComment() throws Exception {
//        // CertificationPostComment ��ü�� �����մϴ�.
//        CertificationPostComment certificationPostComment = CertificationPostComment.builder()
//            .userNo(2)
//            .certificationPostNo(1)
//            .certificationPostCommentContents("����ۼ��ϱ���.")
//            .build();
//
//        // addCertificationPostComment �޼��� ȣ��
//        certificationPostService.addCertificationPostComment(certificationPostComment);
//
//        // �α� ���
//        SantaLogger.makeLog("info", certificationPostComment.toString());
//    }

	
	
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
public void testAddCertificationPostLike() {
 
    int userNo = 2;
    int postNo = 2;
    

    Like like = new Like();
    like.setUserNo(userNo);
    like.setPostNo(postNo);
    
  
    certificationPostService.addCertificationPostLike(like);
    
}

//@Test
public void testDeleteCertificationPostLike() {
   
    int userNo = 2;
    int postNo = 3; 
    

    Like like = new Like();
    like.setUserNo(userNo);
    like.setPostNo(postNo);
    
    
    certificationPostService.deleteCertificationPostLike(like);
}

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
	 
	









