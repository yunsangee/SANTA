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
       
       //int count = scheduleMapper.getMountainTotalCount("관악산");
       
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
	
	        int userNo = 3; // 테스트할 사용자 번호
	      
        List<CertificationPost> results = certificationPostService.getMyCertificationPostList(userNo);
	 
	        for (CertificationPost result : results) {
	            SantaLogger.makeLog("info", result.toString());
	        }
	    }
	
////	@Test
//    public void testAddCertificationPostComment1() throws Exception {
//        // CertificationPostComment 객체를 생성합니다.
//        CertificationPostComment certificationPostComment = CertificationPostComment.builder()
//            .userNo(2)
//            .certificationPostNo(1)
//            .certificationPostCommentContents("댓글작성하기!!.")
//            .build();
//
//        // addCertificationPostComment 메서드 호출
//        certificationPostService.addCertificationPostComment(certificationPostComment);
//        
//        List<CertificationPost> list = certificationPostService.getCertificationPostList();
//        list = certificationPostService.getCertificationPostList();
//    	System.out.println("==================");
//    	for(CertificationPost post : list) {
//    		System.out.println(post);
//        // 로그 출력
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
//	    // 댓글을 삭제할 사용자 번호, 댓글 번호, 게시물 번호를 설정합니다.
//	    int userNo = 3; // 사용자 번호
//	    int certificationPostCommentNo = 3; // 댓글 번호
//	
//	    // CertificationPostComment 객체를 생성하여 사용자 번호, 댓글 번호, 게시물 번호를 설정합니다.
//	    CertificationPostComment certificationPostComment = new CertificationPostComment();
//	    certificationPostComment.setUserNo(userNo);
//	    certificationPostComment.setCertificationPostCommentNo(certificationPostCommentNo);
//
//	    // 댓글을 삭제하는 쿼리를 실행합니다.
//	    certificationPostService.deleteCertificationPostComment(certificationPostComment);
//	}

	
	
	
	//@Test
//    public void testAddCertificationPostComment() throws Exception {
//        // CertificationPostComment 객체를 생성합니다.
//        CertificationPostComment certificationPostComment = CertificationPostComment.builder()
//            .userNo(2)
//            .certificationPostNo(1)
//            .certificationPostCommentContents("댓글작성하기이.")
//            .build();
//
//        // addCertificationPostComment 메서드 호출
//        certificationPostService.addCertificationPostComment(certificationPostComment);
//
//        // 로그 출력
//        SantaLogger.makeLog("info", certificationPostComment.toString());
//    }

	
	
	//@Test
//	public void testAddCertificationPost() throws Exception {
//	    // CertificationPost 객체를 생성합니다.
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
//	    // addCertificationPost 메서드 호출
//	    certificationPostService.addCertificationPost(certificationPost);
//
//	    // 로그 출력
//	    System.out.println(certificationPost.toString());
//	}

	
	
	
	
	
	
	
 //@Test
//	    public void TestaddCertificationPost() throws Exception {
//	        // CertificationPost 객체를 생성합니다.
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
//	        // CertificationPostService를 사용하여 게시글을 데이터베이스에 추가합니다.
//	        certificationPostService.addCertificationPost(certificationPost);
//	        certificationPostService.addCertificationPostHashtags(certificationPost);
//
//	        // SantaLogger를 사용하여 로그를 출력합니다.
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
//       // SantaLogger를 사용하여 로그를 출력합니다.
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
//	    int userNo = 2; // 사용자 번호
//	    
//	    // Like 객체 생성 및 사용자 번호 설정
//	    Like like = new Like();
//	    like.setUserNo(userNo);
//	    
//	    List<CertificationPost> postList = certificationPostService.getCertificationPostLikeList(like);
//	 
//	    for (CertificationPost post : postList) {
//	        System.out.println("게시글 번호: " + post.getPostNo());
//	        System.out.println("게시글 제목: " + post.getTitle());
//	        // 필요한 정보 출력
//	    }}

	}
	 
	









