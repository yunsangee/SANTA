package site.dearmysanta.web.certification;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.certificationPost.CertificationPostComment;
import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.certification.CertificationPostService;
import site.dearmysanta.service.common.ObjectStorageService;
import site.dearmysanta.service.user.UserService;
import site.dearmysanta.service.user.etc.UserEtcService;

@RestController
@RequestMapping("/certificationPost/*")

public class CertificationPostRestController {

    @Autowired
    @Qualifier("CertificationPostServiceImpl")
    private CertificationPostService certificationPostService;
    
    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;
    
    @Autowired
    @Qualifier("userEtcServiceImpl")
    private UserEtcService userEtcService;
    
	@Value("${pageSize}")
	private int pageSize;
	
	@Value("${pageUnit}")
	private int pageUnit;
    
    
	@Autowired
	private ObjectStorageService objectStorageService;
    
    public CertificationPostRestController() {
        System.out.println(this.getClass());
    }
    

        @PostMapping(value = "rest/listCertificationPost")
        public Map<String, Object> listCertificationPost(
            @RequestBody Search search, 
            @RequestParam(defaultValue = "0") int currentPage,
            @RequestParam(defaultValue = "10") int pageSize) throws Exception {
            
            if (search == null) {
                search = new Search(); // 기본 검색 조건 설정 또는 처리
            }
            
            if (search.getSearchKeyword() == null) {
                search.setSearchKeyword(""); // 검색어가 null인 경우 빈 문자열로 설정
            }
            
            // 페이지네이션 파라미터 설정
            search.setCurrentPage(currentPage);
            search.setPageSize(pageSize);
            
            Map<String, Object> result = certificationPostService.getCertificationPostList(search);
            List<CertificationPost> certificationPostList = (List<CertificationPost>) result.get("list");
            List<String> certificationPostImages = new ArrayList<>();
            for (CertificationPost certificationPost : certificationPostList) {
                String fileName = certificationPost.getPostNo() + "_0_1"; // 첫 번째 사진 파일명
                String imageURL = objectStorageService.getImageURL(fileName);
                certificationPostImages.add(imageURL);
            }

            // 클라이언트로 전송할 결과에 이미지 URL 추가
            result.put("certificationPostImages", certificationPostImages);

            return result;
        }



    @GetMapping(value="rest/updateCertificationPostDeleteFlag")
    public void updateCertificationPostDeleteFlag(@RequestParam int postNo, @RequestParam int userNo) throws Exception {
    	certificationPostService.updateCertificationPostDeleteFlag(postNo);
       userEtcService.updateCertificationCount(userNo, 1);
	}
    
    @GetMapping(value = "rest/listMyCertificationPost")
    public Map<String, Object> listMyCertificationPost(@RequestParam int userNo) throws Exception {
        List<CertificationPost> myCertificationPost = certificationPostService.getMyCertificationPostList(userNo);
        
        System.out.println("내 인증 게시물: " + myCertificationPost);
        
        int postType = 0;
        List<String> certificationPostImages = new ArrayList<>();
        for (CertificationPost certificationPost : myCertificationPost) {
            String fileName = certificationPost.getPostNo() + "_" + postType + "_1"; // 첫 번째 사진 파일명
            String imageURL = objectStorageService.getImageURL(fileName);
            certificationPostImages.add(imageURL);
        }

        Map<String, Object> response = new HashMap<>();
        response.put("certificationPostList", myCertificationPost);
        response.put("certificationPostImages", certificationPostImages);
        
        System.out.println("이미지: " + certificationPostImages);
        
        return response;
    }

    @GetMapping(value="rest/getProfile")
    public Map<String, Object> getProfile(@RequestParam int userNo) throws Exception {
        Map<String, Object> result = new HashMap<>();

        User user = userService.getUser(userNo);
        System.out.println("User Info: " + user);
        result.put("infouser", user);

        int followerCount = userEtcService.getFollowerCount(userNo);
        System.out.println("Follower Count: " + followerCount);
        result.put("followerCount", followerCount);

        List<CertificationPost> myCertificationPost = certificationPostService.getMyCertificationPostList(userNo);
        result.put("myCertificationPost", myCertificationPost);

        List<CertificationPost> getCertificationPostLikeList = certificationPostService.getCertificationPostLikeList(userNo);
        System.out.println("getCertificationPostLikeList: " + getCertificationPostLikeList);
        result.put("getCertificationPostLikeList", getCertificationPostLikeList);

        return result;
    }
    
    @PostMapping(value = "rest/getCertificationPostLikeList")
    public Map<String, Object> getCertificationPostLikeList(@RequestParam int userNo) throws Exception {
        List<CertificationPost> getCertificationPostLikeList = certificationPostService.getCertificationPostLikeList(userNo);
        System.out.println("좋아요한 게시물: " + getCertificationPostLikeList);

        int postType = 0;
        List<String> certificationPostImages = new ArrayList<>();
        for (CertificationPost certificationPost : getCertificationPostLikeList) {
            String fileName = certificationPost.getPostNo() + "_" + postType + "_1"; // 첫 번째 사진 파일명
            String imageURL = objectStorageService.getImageURL(fileName);
            certificationPostImages.add(imageURL);
        }

        Map<String, Object> response = new HashMap<>();
        response.put("certificationPostList", getCertificationPostLikeList);
        response.put("certificationPostImages", certificationPostImages);

        System.out.println("이미지" + certificationPostImages);

        return response;
    }


    @GetMapping(value="rest/getCertificationPostComment")
    public List<CertificationPostComment> getCertificationPostComment(@RequestParam int postNo) throws Exception {
        List<CertificationPostComment> certificationPostComment = certificationPostService.getCertificationPostCommentList(postNo);
        return certificationPostComment;
    }
    
    
    @PostMapping(value="rest/addCertificationPostComment")
    public void addCertificationPostComment(@RequestBody CertificationPostComment certificationPostComment)throws Exception {
    
    	certificationPostService.addCertificationPostComment(certificationPostComment);
    
}

    
    @DeleteMapping(value="rest/deleteCertificationPostComment")
    public void deleteCertificationPostComment(@RequestParam int certificationPostCommentNo , @RequestParam int userNo) throws Exception {
    
    	certificationPostService.deleteCertificationPostComment(certificationPostCommentNo, userNo);
    	
}

    @GetMapping(value="rest/getCertificationPost")
    public String getCertificationPost(@RequestParam int postNo,  Model model) throws Exception {
    	int userNo = 1;
    	int postType = 0;
    	 Map<String, Object> map = certificationPostService.getCertificationPost(postNo, userNo);
    	 List<CertificationPostComment> certificationPostComment = certificationPostService.getCertificationPostCommentList(postNo);
    	// List<MeetingPost> unCertifiedMeetingPosts = meetingService.getUnCertifiedMeetingPost(userNo);
    	 //meetingService.updateMeetingPostCertifiedStatus(postNo);
    	 CertificationPost certificationPost = (CertificationPost)map.get("certificationPost");
 		
    	 List<String> certificationPostImages = new ArrayList<>();
         int imageCount = certificationPost.getCertificationPostImageCount();
          System.out.println("imageCount==="+imageCount);
         for (int i = 0; i < imageCount; i++) {
        	 String fileName = postNo+ "_" +postType+ "_" +(i+1);
             String imageURL = objectStorageService.getImageURL(fileName);
             certificationPostImages.add(imageURL);
         }
       
 		// model.addAttribute("unCertifiedMeetingPosts", map.get("unCertifiedMeetingPosts"));
    	 model.addAttribute("certificationPost", map.get("certificationPost"));
    	 model.addAttribute("certificationPostComments", certificationPostComment);
       model.addAttribute("hashtagList", map.get("hashtagList"));
      model.addAttribute("certificationPostImages", certificationPostImages);
      // model.addAttribute("certificationPostType", certificationPostType);

    	
         System.out.println("이거맞지"+certificationPostComment);
         
         return "forward:/certificationPost/getCertificationPost.jsp";
 					  
    	 
    }
    
    
    
    
    
    
    
    
    
    
    
    
	//like
    @PostMapping(value="rest/addCertificationPostLike")
    public void addCertificationPostLike(@RequestBody Like like) throws Exception {
    	certificationPostService.addCertificationPostLike(like);
    	
    
}
    
    @PostMapping(value="rest/deleteCertificationPostLike")
    public void deleteCertificationPostLike(@RequestBody Like like) throws Exception {
    	certificationPostService.deleteCertificationPostLike(like);
    	
    
}
    //hashtag
    
//    @PostMapping(value="rest/addHashtag")
//    public void addHashtag(@RequestBody CertificationPost certificationPost )throws Exception {
//    	certificationPostService.addHashtag(certificationPost);
//}
//    
    @PostMapping(value="rest/deleteHashtag")
    public void deleteHashtag(@RequestParam int hashtagNo) throws Exception {
        certificationPostService.deleteHashtag(hashtagNo);
    }
    
    
    
}
    
    
