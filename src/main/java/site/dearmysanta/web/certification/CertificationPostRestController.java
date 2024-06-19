package site.dearmysanta.web.certification;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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
    
	@Autowired
	private ObjectStorageService objectStorageService;
    
    public CertificationPostRestController() {
        System.out.println(this.getClass());
    }
    
    @PostMapping(value = "rest/listCertificationPost")
    public Map<String, Object> listCertificationPost(@RequestBody Search search, Model model) throws Exception {
    	if (search == null) {
            search = new Search(); // 기본 검색 조건 설정 또는 처리
        }
        
        if (search.getSearchKeyword() == null) {
            search.setSearchKeyword(""); // 검색어가 null인 경우 빈 문자열로 설정
        }
        
        Map<String, Object> result = certificationPostService.getCertificationPostList(search);
        System.out.println(result);
        List<CertificationPost> certificationPost = (List<CertificationPost>) result.get("list");
        model.addAttribute("certificationPost", certificationPost);

        System.out.println("Certification Post: " + certificationPost);

        return result;
    }
    
    @GetMapping(value="rest/updateCertificationPostDeleteFlag")
    public void updateCertificationPostDeleteFlag(@RequestParam int postNo, @RequestParam int userNo) throws Exception {
    	certificationPostService.updateCertificationPostDeleteFlag(postNo);
       userEtcService.updateCertificationCount(userNo, 1);
	}
    
    @GetMapping(value="rest/listMyCertificationPost")
    public List<CertificationPost> listMyCertificationPost(@RequestParam int userNo) throws Exception {
    	List<CertificationPost> myCertificationPost = certificationPostService.getMyCertificationPostList(userNo);
        System.out.println("오잉:" + myCertificationPost);
        return myCertificationPost;
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

        List<CertificationPost> myLikeCertificationPost = certificationPostService.getCertificationPostLikeList(userNo);
        System.out.println("myLikeCertificationPost: " + myLikeCertificationPost);
        result.put("myLikeCertificationPost", myLikeCertificationPost);

        return result;
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
    
    @PostMapping(value="rest/addHashtag")
    public void addHashtag(@RequestBody CertificationPost certificationPost )throws Exception {
    	certificationPostService.addHashtag(certificationPost);
}
    
    @DeleteMapping(value="rest/deleteHashtag/{hashtagNo}")
    public void deleteHashtag(@PathVariable int hashtagNo) throws Exception {
        certificationPostService.deleteHashtag(hashtagNo);
    }
    
    
    
}
    
    
