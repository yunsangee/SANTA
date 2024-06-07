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
    public void testAddCertificationPostComment() throws Exception {
        // CertificationPostComment 객체를 생성합니다.
        CertificationPostComment certificationPostComment = CertificationPostComment.builder()
            .userNo(2)
            .certificationPostNo(1)
            .certificationPostCommentContents("댓글작성하기이.")
            .build();

        // addCertificationPostComment 메서드 호출
        certificationPostService.addCertificationPostComment(certificationPostComment);

        // 로그 출력
        SantaLogger.makeLog("info", certificationPostComment.toString());
    }

	
	
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
//public void testAddCertificationPostLike() {
//    // 좋아요를 추가할 사용자 번호와 게시물 번호를 설정합니다.
//    int userNo = 2; // 사용자 번호
//    int postNo = 3; // 게시물 번호
//    
//    // Like 객체를 생성하여 사용자 번호와 게시물 번호를 설정합니다.
//    Like like = new Like();
//    like.setUserNo(userNo);
//    like.setPostNo(postNo);
//    
//    // 좋아요를 추가하는 쿼리를 실행합니다.
//    certificationPostService.addCertificationPostLike(like);
//    
//    // 좋아요가 잘 추가되었는지 확인하는 코드를 추가합니다.
//    // 예를 들어, 좋아요가 추가되었다는 것을 확인할 수 있는 다양한 방법을 사용할 수 있습니다.
//    // 추가한 좋아요를 데이터베이스에서 조회하거나, 해당 게시물에 대한 좋아요 개수를 확인하는 등의 방법이 있습니다.
//    // 예를 들어, assertEquals(expectedCount, actualCount) 메소드를 사용하여 예상되는 좋아요 개수와 실제 추가된 좋아요 개수를 비교할 수 있습니다.
//}

//@Test
//public void testDeleteCertificationPostLike() {
//    // 좋아요를 삭제할 사용자 번호와 게시물 번호를 설정합니다.
//    int userNo = 2; // 사용자 번호
//    int postNo = 18; // 게시물 번호
//    
//    // Like 객체를 생성하여 사용자 번호와 게시물 번호를 설정합니다.
//    Like like = new Like();
//    like.setUserNo(userNo);
//    like.setPostNo(postNo);
//    
//    // 좋아요를 삭제하는 쿼리를 실행합니다.
//    certificationPostService.deleteCertificationPostLike(like);
//}

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
	 
	









