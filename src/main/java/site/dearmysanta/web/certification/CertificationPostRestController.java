package site.dearmysanta.web.certification;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.certificationPost.CertificationPostComment;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.certification.CertificationPostService;
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
    
    public CertificationPostRestController() {
        System.out.println(this.getClass());
    }
    
    @PostMapping(value = "rest/listCertificationPost")
    public Map<String, Object> listCertificationPost(@RequestParam(required = false) Search search, Model model) throws Exception {
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
    
    @PostMapping(value="rest/addCertificationPostComment")
    public void addCertificationPostComment(@RequestBody CertificationPostComment certificationPostComment)throws Exception {
    
    	certificationPostService.addCertificationPostComment(certificationPostComment);
    
}

    
    @GetMapping(value="rest/deleteCertificationPostComment")
    public void deleteCertificationPostComment(@RequestParam int certificationPostCommentNo)throws Exception {
    
    	certificationPostService.deleteCertificationPostComment(certificationPostCommentNo);
    	
}

    
}
    
    
 
    
    
    
    
    
    
