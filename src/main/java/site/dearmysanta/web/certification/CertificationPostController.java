package site.dearmysanta.web.certification;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.certificationPost.CertificationPostComment;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.certification.CertificationPostService;
import site.dearmysanta.service.common.ObjectStorageService;
import site.dearmysanta.service.meeting.MeetingDAO;
import site.dearmysanta.service.meeting.MeetingService;
import site.dearmysanta.service.mountain.MountainService;
import site.dearmysanta.service.user.UserService;
import site.dearmysanta.service.user.etc.UserEtcService;

@Controller
@RequestMapping("/certificationPost/*")
public class CertificationPostController {

    @Autowired
    @Qualifier("CertificationPostServiceImpl")
    private CertificationPostService certificationPostService;

    @Autowired
    private UserService userService;
    
    @Autowired
    private UserEtcService userEtcService;
    
    @Autowired
    private MountainService mountainService;
    
    @Autowired
    private MeetingService meetingService;
    
    @Value("${bucketName}")
	private String bucketName;
	
	@Autowired
	private ObjectStorageService objectStorageService;
	
	@Value("${pageSize}")
	private int pageSize;
	
	@Value("${pageUnit}")
	private int pageUnit;
    
    
    public CertificationPostController() {
        System.out.println(this.getClass());
    }

//   Submit�ؼ� �����°� ����Ʈ����
//    urlŸ������°� ��

    
    @GetMapping(value = "addCertificationPost")
    public String addCertificationPost(int userNo, Model model) throws Exception {

        return "forward:/certificationPost/addCertificationPost.jsp";
    }
    
 
    @PostMapping(value = "addCertificationPost")
    public String addCertificationPost(
                                       @ModelAttribute CertificationPost certificationPost,
                                       @RequestParam int totalTimeHours,
                                       @RequestParam int totalTimeMinutes,
                                       @RequestParam int ascentTimeHours,
                                       @RequestParam int ascentTimeMinutes,
                                       @RequestParam int descentTimeHours,
                                       @RequestParam int descentTimeMinutes,
                                       @RequestParam(value = "certificationPostHashtagContents") String[] certificationPostHashtagContents,
                                       Model model) throws Exception {

        // �ð��� "������ ������" �������� ��ȯ�Ͽ� ����
        String totalTime = totalTimeHours + "�ð� " + totalTimeMinutes + "��";
        String ascentTime = ascentTimeHours + "�ð� " + ascentTimeMinutes + "��";
        String descentTime = descentTimeHours + "�ð� " + descentTimeMinutes + "��";

        certificationPost.setCertificationPostTotalTime(totalTime);
        certificationPost.setCertificationPostAscentTime(ascentTime);
        certificationPost.setCertificationPostDescentTime(descentTime);

        certificationPostService.addCertificationPost(certificationPost);

        // ��� postNo ��������
        int postNo = certificationPost.getPostNo();
        int postType = 0;

        if (certificationPost.getCertificationPostImage() != null && !certificationPost.getCertificationPostImage().isEmpty()) {
            List<MultipartFile> images = certificationPost.getCertificationPostImage();
            int imageCount = images.size();

            for (int i = 0; i < imageCount; i++) { // �ε����� 1���� ����
                MultipartFile image = images.get(i); // ����Ʈ �ε����� 0���� �����ϹǷ� i ���
                String fileName = postNo + "_" + postType + "_"+(i+1);

                System.out.println(fileName);

                objectStorageService.uploadFile(image, fileName);

                int userNo = certificationPost.getUserNo();
                userEtcService.updateCertificationCount(userNo, 0);
            }
        }

        // �ؽ��±� ����
        for (String hashtagContent : certificationPostHashtagContents) {
            if (!hashtagContent.isEmpty()) {
                certificationPostService.addHashtag(postNo, hashtagContent);
            }
        }

        return "redirect:/certificationPost/getCertificationPost?postNo=" + postNo;
    }

    @GetMapping(value = "updateCertificationPost")
    public String updateCertificationPost(@RequestParam int postNo, Model model) throws Exception {
        System.out.println("postNo: " + postNo);

        CertificationPost certificationPost = certificationPostService.getCertificationPost(postNo);
        List<String> hashtagList = certificationPostService.getHashtag(postNo);

        System.out.println("hashtagList: " + hashtagList);

        model.addAttribute("certificationPost", certificationPost);
        model.addAttribute("hashtagList", hashtagList);

        String[] totalTimeParts = certificationPost.getCertificationPostTotalTime().split(" ");
        String[] ascentTimeParts = certificationPost.getCertificationPostAscentTime().split(" ");
        String[] descentTimeParts = certificationPost.getCertificationPostDescentTime().split(" ");

        model.addAttribute("totalTimeHours", totalTimeParts[0].replace("�ð�", "").trim());
        model.addAttribute("totalTimeMinutes", totalTimeParts[1].replace("��", "").trim());
        model.addAttribute("ascentTimeHours", ascentTimeParts[0].replace("�ð�", "").trim());
        model.addAttribute("ascentTimeMinutes", ascentTimeParts[1].replace("��", "").trim());
        model.addAttribute("descentTimeHours", descentTimeParts[0].replace("�ð�", "").trim());
        model.addAttribute("descentTimeMinutes", descentTimeParts[1].replace("��", "").trim());

        int postType = 0;
        List<String> certificationPostImages = new ArrayList<>();
        int imageCount = certificationPost.getCertificationPostImageCount();
        for (int i = 0; i < imageCount; i++) {
            String fileName = postNo + "_" + postType + "_" + (i + 1);
            String imageURL = objectStorageService.getImageURL(fileName);
            certificationPostImages.add(imageURL);
        }
        model.addAttribute("certificationPostImages", certificationPostImages);

        return "forward:/certificationPost/updateCertificationPost.jsp";
    }

    @PostMapping(value = "updateCertificationPost")
    public String updateCertificationPost(
                                          @ModelAttribute CertificationPost certificationPost,
                                          @RequestParam int totalTimeHours,
                                          @RequestParam int totalTimeMinutes,
                                          @RequestParam int ascentTimeHours,
                                          @RequestParam int ascentTimeMinutes,
                                          @RequestParam int descentTimeHours,
                                          @RequestParam int descentTimeMinutes,
                                          @RequestParam(value = "existingHashtags", required = false) String[] existingHashtags,
                                          @RequestParam(value = "existingHashtagNos", required = false) int[] existingHashtagNos,
                                          @RequestParam(value = "newHashtags", required = false) String[] newHashtags,
                                          @RequestParam(value = "deleteHashtagNos", required = false) int[] deleteHashtagNos,
                                          Model model) throws Exception {

        String totalTime = totalTimeHours + "�ð� " + totalTimeMinutes + "��";
        String ascentTime = ascentTimeHours + "�ð� " + ascentTimeMinutes + "��";
        String descentTime = descentTimeHours + "�ð� " + descentTimeMinutes + "��";

        certificationPost.setCertificationPostTotalTime(totalTime);
        certificationPost.setCertificationPostAscentTime(ascentTime);
        certificationPost.setCertificationPostDescentTime(descentTime);

        certificationPostService.updateCertificationPost(certificationPost);

        if (deleteHashtagNos != null) {
            for (int hashtagNo : deleteHashtagNos) {
                certificationPostService.deleteHashtag(hashtagNo);
            }
        }

        if (existingHashtags != null && existingHashtagNos != null) {
            for (int i = 0; i < existingHashtags.length; i++) {
                if (!existingHashtags[i].isEmpty()) {
                    certificationPostService.updateHashtag(existingHashtagNos[i], existingHashtags[i]);
                }
            }
        }

        if (newHashtags != null) {
            for (String hashtagContent : newHashtags) {
                if (!hashtagContent.isEmpty()) {
                    certificationPostService.addHashtag(certificationPost.getPostNo(), hashtagContent);
                }
            }
        }

        return "redirect:/certificationPost/getCertificationPost?postNo=" + certificationPost.getPostNo();
    }



    @GetMapping(value = "listCertificationPost")
    public String listCertificationPost(@ModelAttribute Search search, Model model) throws Exception {
	

    	System.out.println("search" +search ) ;
        // CertificationPost ��� �� ���� ������ ��������
        Map<String, Object> result = certificationPostService.getCertificationPostList(search);
        List<CertificationPost> certificationPostList = (List<CertificationPost>) result.get("list");
        System.out.println(" certificationPostList  " + certificationPostList );
        // CertificationPost �̹��� URL ��������
        List<String> certificationPostImages = new ArrayList<>();
        for (CertificationPost certificationPost : certificationPostList) {
            String fileName = certificationPost.getPostNo() + "_0_1"; // ù ��° ���� ���ϸ�
            String imageURL = objectStorageService.getImageURL(fileName);
            certificationPostImages.add(imageURL);
        }

        // �𵨿� ������ �߰�
        model.addAttribute("certificationPost", certificationPostList); // CertificationPost ���
        model.addAttribute("hashtagList", result.get("hashtagList")); // �ؽ��±� ���
        model.addAttribute("certificationPostImages", certificationPostImages); // CertificationPost �̹��� URL ���
        model.addAttribute("search", search); 

        return "forward:/certificationPost/listCertificationPost.jsp"; // JSP �������� ������
    }


	
    // �Խñ� ����ȸ..@RequestParam int certificationPostType, 
    @GetMapping(value="getCertificationPost")
    public String getCertificationPost(@RequestParam int postNo,  Model model) throws Exception {
    	int userNo = 1;
    	int postType = 0;
    	 Map<String, Object> map = certificationPostService.getCertificationPost(postNo, userNo);
    	 List<CertificationPostComment> certificationPostCommentList = certificationPostService.getCertificationPostCommentList(postNo);
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
       

     	System.out.println("���"+postNo+userNo+certificationPostCommentList);
 	 	 model.addAttribute("certificationPost", map.get("certificationPost"));
    	 model.addAttribute("certificationPostCommentList", certificationPostCommentList);
       model.addAttribute("hashtagList", map.get("hashtagList"));
      model.addAttribute("certificationPostImages", certificationPostImages);
     
    	
         System.out.println("�̰Ÿ���"+certificationPostCommentList);
         
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
    

        @RequestMapping(value = "getProfile")
        public String getProfile(@RequestParam int userNo, Model model) throws Exception {
            User user = userService.getUser(userNo);
            System.out.println("User Info: " + user);
            model.addAttribute("infouser", user);

            int followerCount = userEtcService.getFollowerCount(userNo);
            System.out.println("Follower Count: " + followerCount);
            model.addAttribute("followerCount", followerCount);

            int followingCount = userEtcService.getFollowingCount(userNo);
            System.out.println("Following Count: " + followingCount);
            model.addAttribute("followingCount", followingCount);

            // ���Ƿ� ������ followerNo (�α����� ������� ��ȣ��� ����)
            int followerNo = 1; // ���÷� 1�� ������ ����

            int isFollowing = userEtcService.isFollowing(followerNo, userNo);
            model.addAttribute("isFollowing", isFollowing);
            System.out.println("Is Following: " + isFollowing);

            List<CertificationPost> myCertificationPost = certificationPostService.getMyCertificationPostList(userNo);
            model.addAttribute("myCertificationPost", myCertificationPost);
            System.out.println("myCertificationPost: " + myCertificationPost);

            List<CertificationPost> myLikeCertificationPost = certificationPostService.getCertificationPostLikeList(userNo);
            System.out.println("myLikeCertificationPost: " + myLikeCertificationPost);
            model.addAttribute("myLikeCertificationPost", myLikeCertificationPost);

            int postType = 0;
            List<String> certificationPostImages = new ArrayList<>();
            for (CertificationPost certificationPost : myCertificationPost) {
                String fileName = certificationPost.getPostNo() + "_" + postType + "_1"; // ù ��° ���� ���ϸ�
                String imageURL = objectStorageService.getImageURL(fileName);
                certificationPostImages.add(imageURL);
            }

            model.addAttribute("certificationPostImages", certificationPostImages);

            System.out.println("�̹���" + certificationPostImages);

            return "forward:/certificationPost/getProfile.jsp";
        }
        
        

        
    }
    


    
    