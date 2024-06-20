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
    
    
    public CertificationPostController() {
        System.out.println(this.getClass());
    }
    
    
   
//   Submit해서 들어오는건 포스트매핑
//    url타고들어오는건 겟

    
    @GetMapping(value = "addCertificationPost")
    public String addCertificationPost(int userNo, Model model) throws Exception {
        List<MeetingPost> unCertifiedMeetingPosts = meetingService.getUnCertifiedMeetingPost(userNo);

        // 리스트의 크기 출력
        System.out.println("UnCertified Meeting Posts Count: " + unCertifiedMeetingPosts.size());

        // 리스트 내용 개별 필드 출력
        for (MeetingPost post : unCertifiedMeetingPosts) {
            System.out.println("Post meetingName: " + post.getMeetingName());
            System.out.println("Title: " + post.getTitle());
   
        }

        model.addAttribute("unCertifiedMeetingPosts", unCertifiedMeetingPosts);
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
                                       Model model) throws Exception {

        // 시간을 "ㅇㅇ시 ㅇㅇ분" 형식으로 변환하여 설정
        String totalTime = totalTimeHours + "시간 " + totalTimeMinutes + "분";
        String ascentTime = ascentTimeHours + "시간 " + ascentTimeMinutes + "분";
        String descentTime = descentTimeHours + "시간 " + descentTimeMinutes + "분";

        certificationPost.setCertificationPostTotalTime(totalTime);
        certificationPost.setCertificationPostAscentTime(ascentTime);
        certificationPost.setCertificationPostDescentTime(descentTime);

        certificationPostService.addCertificationPost(certificationPost);

        // 디비에 postNo 가져오기
        int postNo = certificationPost.getPostNo();
        int postType = 0;

        if (certificationPost.getCertificationPostImage() != null && !certificationPost.getCertificationPostImage().isEmpty()) {
            List<MultipartFile> images = certificationPost.getCertificationPostImage();
            int imageCount = images.size();

            for (int i = 0; i < imageCount; i++) { // 인덱스는 1부터 시작
                MultipartFile image = images.get(i); // 리스트 인덱스는 0부터 시작하므로 i 사용
                String fileName = postNo + "_" + postType + "_"+(i+1);

                System.out.println(fileName);

                objectStorageService.uploadFile(image, fileName);
                
                int userNo = certificationPost.getUserNo();
                userEtcService.updateCertificationCount(userNo, 0);
            }
        }
        return "redirect:/certificationPost/getCertificationPost?postNo=" + postNo;

    }


    /*
    @PostMapping(value = "addCertificationPost")
    public String addCertificationPost(@RequestParam(required = false) int certificationPostType,
                                       @ModelAttribute CertificationPost certificationPost,
                                       Model model) throws Exception {

        certificationPost.setCertificationPostType(certificationPostType);
        
        System.out.println("add " + certificationPostType);
        certificationPostService.addCertificationPost(certificationPost);

        // 디비에 postNo 가져오기
        int postNo = certificationPost.getPostNo();
        int postType = 0;
        
     

        if (certificationPost.getCertificationPostImage() != null && !certificationPost.getCertificationPostImage().isEmpty()) {
            List<MultipartFile> images = certificationPost.getCertificationPostImage();
            int imageCount = images.size();

            for (int i = 0; i < imageCount; i++) { // 인덱스는 1부터 시작
                MultipartFile image = images.get(i); // 리스트 인덱스는 0부터 시작하므로 i-1 사용
                String fileName = postNo + "_" + postType + "_"+(i+1);

                System.out.println(fileName);

                objectStorageService.uploadFile(image, fileName);
            }
        }

        // 산 통계 
        String certificationPostMountainName = certificationPost.getCertificationPostMountainName();
        mountainService.addMountainStatistics(certificationPostMountainName, 1);

        // 사용자 인증 카운트 
        int userNo = certificationPost.getUserNo();
        userEtcService.updateCertificationCount(userNo, 0); // type 0: 추가

        // forward를 통해 다음 페이지로 이동
        return "redirect:/certificationPost/getCertificationPost?postNo=" + postNo + "&certificationPostType=" + certificationPostType;
    }*/

//    @PostMapping(value = "addCertificationPost")
//    public String addCertificationPost(@ModelAttribute CertificationPost certificationPost, Model model) throws Exception {
//        
//    	
//    	certificationPostService.addCertificationPost(certificationPost);
//        String certificationPostMountainName = certificationPost.getCertificationPostMountainName();
//        mountainService.addMountainStatistics(certificationPostMountainName, 1);
//        int userNo = certificationPost.getUserNo();
//        userEtcService.updateCertificationCount(userNo, 0); // type 0: 추가
//
//  
//        return "forward:/certificationPost/getCertificationPost.jsp";
//    }
    
    /*
    @PostMapping(value = "addCertificationPost")
    public String addCertificationPost(@ModelAttribute CertificationPost certificationPost, Model model) throws Exception {
        try {
            // 사용자 번호 가져오기
            int userNo = certificationPost.getUserNo();
            System.out.println("User No: " + userNo);

            // 인증 포스트 추가
            certificationPostService.addCertificationPost(certificationPost);
            System.out.println("Certification post added");

            // 디비에 postNo 가져오기
            int postNo = certificationPost.getPostNo();
            System.out.println("Post No: " + postNo);

            // 이미지 업로드
            if (certificationPost.getCertificationPostImage() != null && !certificationPost.getCertificationPostImage().isEmpty()) {
                List<MultipartFile> images = certificationPost.getCertificationPostImage();
                int imageCount = images.size();
                System.out.println("Image count: " + imageCount);

                for (int i = 1; i <= imageCount; i++) { // 인덱스는 1부터 시작
                    MultipartFile image = images.get(i - 1); // 리스트 인덱스는 0부터 시작하므로 i-1 사용
                    String fileName = postNo + "_" + i;
                    System.out.println("Uploading image: " + fileName);

                    objectStorageService.uploadFile(image, fileName);
                }
            }

            // 산 통계
            String certificationPostMountainName = certificationPost.getCertificationPostMountainName();
            mountainService.addMountainStatistics(certificationPostMountainName, 1);
            System.out.println("Mountain statistics updated for: " + certificationPostMountainName);

            // 사용자 인증 카운트
            userEtcService.updateCertificationCount(userNo, 0); // type 0: 추가
            System.out.println("User certification count updated for userNo: " + userNo);

            // forward를 통해 다음 페이지로 이동
            System.out.println("Redirecting to getCertificationPost with postNo: " + postNo);
            return "redirect:/certificationPost/getCertificationPost?postNo=" + postNo;
        } catch (Exception e) {
            System.out.println("Error in addCertificationPost: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }

*/

    @GetMapping(value = "updateCertificationPost")
    public String updateCertificationPost(@RequestParam int postNo, Model model) throws Exception {
        CertificationPost certificationPost = certificationPostService.getCertificationPost(postNo);
        model.addAttribute("certificationPost", certificationPost);

        // 시간 데이터를 분리하여 모델에 추가
        String[] totalTimeParts = certificationPost.getCertificationPostTotalTime().split(" ");
        String[] ascentTimeParts = certificationPost.getCertificationPostAscentTime().split(" ");
        String[] descentTimeParts = certificationPost.getCertificationPostDescentTime().split(" ");
        
        model.addAttribute("totalTimeHours", totalTimeParts[0].replace("시간", "").trim());
        model.addAttribute("totalTimeMinutes", totalTimeParts[1].replace("분", "").trim());
        model.addAttribute("ascentTimeHours", ascentTimeParts[0].replace("시간", "").trim());
        model.addAttribute("ascentTimeMinutes", ascentTimeParts[1].replace("분", "").trim());
        model.addAttribute("descentTimeHours", descentTimeParts[0].replace("시간", "").trim());
        model.addAttribute("descentTimeMinutes", descentTimeParts[1].replace("분", "").trim());

        int postType = 0;
        List<String> certificationPostImages = new ArrayList<>();
        int imageCount = certificationPost.getCertificationPostImageCount();
        System.out.println("imageCount===" + imageCount);
        for (int i = 0; i < imageCount; i++) {
            String fileName = postNo + "_" + postType + "_" + (i + 1);
            String imageURL = objectStorageService.getImageURL(fileName);
            certificationPostImages.add(imageURL);
        }
        model.addAttribute("certificationPostImages", certificationPostImages);

        return "forward:/certificationPost/updateCertificationPost.jsp";
    }

    @PostMapping(value = "updateCertificationPost")
    public String updateCertificationPost(@ModelAttribute CertificationPost certificationPost,
                                          @RequestParam int totalTimeHours,
                                          @RequestParam int totalTimeMinutes,
                                          @RequestParam int ascentTimeHours,
                                          @RequestParam int ascentTimeMinutes,
                                          @RequestParam int descentTimeHours,
                                          @RequestParam int descentTimeMinutes) throws Exception {

        // 시간을 "ㅇㅇ시 ㅇㅇ분" 형식으로 변환하여 설정
        String totalTime = totalTimeHours + "시간 " + totalTimeMinutes + "분";
        String ascentTime = ascentTimeHours + "시간 " + ascentTimeMinutes + "분";
        String descentTime = descentTimeHours + "시간 " + descentTimeMinutes + "분";

        certificationPost.setCertificationPostTotalTime(totalTime);
        certificationPost.setCertificationPostAscentTime(ascentTime);
        certificationPost.setCertificationPostDescentTime(descentTime);

        certificationPostService.updateCertificationPost(certificationPost);

        return "redirect:/certificationPost/getCertificationPost?postNo=" + certificationPost.getPostNo();
    }

    
   /* 
    ///이건 리스트조회 무한스크롤은 rest?!
    @GetMapping(value = "listCertificationPost")
  //  public String listCertificationPost(@ModelAttribute Search search, Model model) throws Exception {
    public String listCertificationPost(@RequestParam(required=false) Search search, Model model) throws Exception {
        Map<String, Object> result = certificationPostService.getCertificationPostList(search);
        System.out.println(result);
        List<CertificationPost> certificationPost = (List<CertificationPost>) result.get("list");
        model.addAttribute("certificationPost", certificationPost);
        model.addAttribute("hashtagList", result.get("hashtagList"));
         System.out.println("Certification Post: " + certificationPost);

        return "forward:/certificationPost/listCertificationPost.jsp";
    }
    */
	
	@GetMapping(value = "listCertificationPost")
	public String listCertificationPost(@RequestParam(required = false)  Search search, Model model) throws Exception {
	    Map<String, Object> result = certificationPostService.getCertificationPostList(search);
	    List<CertificationPost> certificationPostList = (List<CertificationPost>) result.get("list");

	    int postType = 0;
	    List<String> certificationPostImages = new ArrayList<>();
	    for (CertificationPost certificationPost : certificationPostList) {
	        String fileName = certificationPost.getPostNo() + "_" +postType + "_1"; // 첫 번째 사진 파일명
	        String imageURL = objectStorageService.getImageURL(fileName);
	        certificationPostImages.add(imageURL);
	    }
       
	    model.addAttribute("certificationPost", certificationPostList);
	    model.addAttribute("hashtagList", result.get("hashtagList"));
	    model.addAttribute("certificationPostImages", certificationPostImages);
	    return "forward:/certificationPost/listCertificationPost.jsp";
	}

	
    // 게시글 상세조회..@RequestParam int certificationPostType, 
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
       

     	System.out.println("댓글"+postNo+userNo+certificationPostCommentList);
 		// model.addAttribute("unCertifiedMeetingPosts", map.get("unCertifiedMeetingPosts"));
    	 model.addAttribute("certificationPost", map.get("certificationPost"));
    	 model.addAttribute("certificationPostCommentList", certificationPostCommentList);
       model.addAttribute("hashtagList", map.get("hashtagList"));
      model.addAttribute("certificationPostImages", certificationPostImages);
      // model.addAttribute("certificationPostType", certificationPostType);

    	
         System.out.println("이거맞지"+certificationPostCommentList);
         
         return "forward:/certificationPost/getCertificationPost.jsp";
 					  
    	 
    }

    //내가 작성한 게시글 목록조회 
    @RequestMapping(value="listMyCertificationPost")
    public String listMyCertificationPost(@RequestParam int userNo, Model model) throws Exception {
        List<CertificationPost> myCertificationPost = certificationPostService.getMyCertificationPostList(userNo);
        model.addAttribute("myCertificationPost", myCertificationPost);
        System.out.println("오잉:" + myCertificationPost);
        return "forward:/certificationPost/listMyCertificationPost.jsp";
    }
    
    //팔로워리스트 
    @RequestMapping(value="listFollower")
    public String listFollower(@RequestParam int userNo, Model model) throws Exception {
    	List<User> followerList = userEtcService.getFollowerList(userNo);
        model.addAttribute("followerList", followerList);
        System.out.println("팔로워리스트보기:" + followerList);
    return "forward:/certificationPost/listFollower.jsp";
}

    //팔로잉리스트
    @RequestMapping(value="listFollowing")
    public String listFollowing(@RequestParam int userNo, Model model) throws Exception {
    	List<User> followingList = userEtcService.getFollowingList(userNo);
        model.addAttribute("followingList", followingList);
        System.out.println("팔로잉리스트보기:" + followingList);
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
    
    