package site.dearmysanta.web.certification;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.certificationPost.CertificationPostComment;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.certification.CertificationPostService;
import site.dearmysanta.service.user.UserService;
import site.dearmysanta.service.user.etc.UserEtcService;

@Controller
@RequestMapping("/certificationPost/*")
public class CertificationPostController {

    @Autowired
    @Qualifier("CertificationPostServiceImpl")
    private CertificationPostService certificationPostService;

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;
    
    @Autowired
    @Qualifier("userEtcServiceImpl")
    private UserEtcService userEtcService;
    
    public CertificationPostController() {
        System.out.println(this.getClass());
    }
    
    
   
//   Submit�ؼ� �����°� ����Ʈ����
//    urlŸ������°� ��
    @GetMapping(value ="addCertificationPost")
    public String addCertificationPost() throws Exception {
    	
    	  return "forward:/certificationPost/addCertificationPost.jsp";
    } //�̹�����Ͼ����� ��
    

    @PostMapping(value = "addCertificationPost")
    public String addCertificationPost(@ModelAttribute CertificationPost certificationPost, Model model) throws Exception {
        certificationPostService.addCertificationPost(certificationPost);
        int userNo = certificationPost.getUserNo();
        userEtcService.updateCertificationCount(userNo, 0); // type 0: �߰�

  
        return "forward:/certificationPost/getCertificationPost.jsp";
    }
   
    @PostMapping(value = "updateCertificationPost")
    public String updateCertificationPost(@ModelAttribute CertificationPost certificationPost ) throws Exception {
    	
    	certificationPostService.updateCertificationPost(certificationPost);
    	return "forward:/certificationPost/updateCertificationPost.jsp";
    	
    }

    
    ///�̰� ����Ʈ��ȸ ���ѽ�ũ���� rest?!
    @GetMapping(value = "listCertificationPost")
  //  public String listCertificationPost(@ModelAttribute Search search, Model model) throws Exception {
    public String listCertificationPost(@RequestParam(required=false) Search search, Model model) throws Exception {
        Map<String, Object> result = certificationPostService.getCertificationPostList(search);
        System.out.println(result);
        List<CertificationPost> certificationPost = (List<CertificationPost>) result.get("list");
        model.addAttribute("certificationPost", certificationPost);

         System.out.println("Certification Post: " + certificationPost);

        return "forward:/certificationPost/listCertificationPost.jsp";
    }
    
    // �Խñ� ����ȸ..
    @GetMapping(value="getCertificationPost")
    public String getCertificationPost(@RequestParam int postNo, Model model,@RequestParam int userNo) throws Exception {
    	
    	 Map<String, Object> certificationPost = certificationPostService.getCertificationPost(postNo, userNo);
    	 List<CertificationPostComment> certificationPostComment = certificationPostService.getCertificationPostCommentList(postNo);
    	 System.out.println("CertificationPost:"+certificationPost);


    	 model.addAttribute("certificationPost", certificationPost.get("certificationPost"));
    	 model.addAttribute("certificationPostComments", certificationPostComment);
       model.addAttribute("hashtagList", certificationPost.get("hashtagList"));
    	
         System.out.println("�̰Ÿ���"+certificationPostComment);
         
         return "forward:/certificationPost/getCertificationPost.jsp";
 					  
    	 
    }

    //���� �ۼ��� �Խñ� �����ȸ 
    @RequestMapping(value="listMyCertificationPost")
    public String listMyCertificationPost(@RequestParam int userNo, Model model) throws Exception {
        List<CertificationPost> myCertificationPost = certificationPostService.getMyCertificationPostList(userNo);
        model.addAttribute("myCertificationPost", myCertificationPost);
        System.out.println("����:" + myCertificationPost);
        return "forward:/certificationPost/listMyCertificationPost.jsp";
    }
    
    //�ȷο�����Ʈ 
    @RequestMapping(value="listFollower")
    public String listFollower(@RequestParam int userNo, Model model) throws Exception {
    	List<User> followerList = userEtcService.getFollowerList(userNo);
        model.addAttribute("followerList", followerList);
        System.out.println("�ȷο�����Ʈ����:" + followerList);
    return "forward:/certificationPost/listFollower.jsp";
}

    //�ȷ��׸���Ʈ
    @RequestMapping(value="listFollowing")
    public String listFollowing(@RequestParam int userNo, Model model) throws Exception {
    	List<User> followingList = userEtcService.getFollowingList(userNo);
        model.addAttribute("followingList", followingList);
        System.out.println("�ȷ��׸���Ʈ����:" + followingList);
    return "forward:/certificationPost/listFollowing.jsp";
}
    
    @RequestMapping(value="getProfile")
    public String getProfile(@RequestParam int userNo, Model model) throws Exception {
    	 User user = userService.getUser(userNo);
         System.out.println("User Info: " + user);
         model.addAttribute("infouser", user);

         int followerCount = userEtcService.getFollowerCount(userNo);
         System.out.println("Follower Count: " + followerCount);
         model.addAttribute("followerCount", followerCount);
  
         
    	 List<CertificationPost> myCertificationPost = certificationPostService.getMyCertificationPostList(userNo);
          model.addAttribute("myCertificationPost", myCertificationPost);
       
          List<CertificationPost> myLikeCertificationPost = certificationPostService.getCertificationPostLikeList(userNo);
          System.out.println("myLikeCertificationPost: " + myLikeCertificationPost);
          model.addAttribute("myLikeCertificationPost", myLikeCertificationPost);
    
 return "forward:/certificationPost/getProfile.jsp";  
}

}