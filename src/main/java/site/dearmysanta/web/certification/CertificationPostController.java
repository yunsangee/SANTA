package site.dearmysanta.web.certification;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.certificationPost.CertificationPostComment;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.certification.CertificationPostService;
import site.dearmysanta.service.common.ObjectStorageService;
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

//   Submit해서 들어오는건 포스트매핑
//    url타고들어오는건 겟

    
    @GetMapping(value = "addCertificationPost")
    public String addCertificationPost(HttpSession session, Model model) throws Exception {
        // 세션에서 사용자 정보 가져오기
        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);
        } else {
            // 사용자 정보가 없으면 로그인 페이지로 리디렉션
            return "redirect:/user/login";
        }

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
                                       Model model,
                                       HttpSession session) throws Exception {

        // 세션에서 사용자 정보 가져오기
        User user = (User) session.getAttribute("user");
        if (user != null) {
            certificationPost.setUserNo(user.getUserNo());
        } else {
            // 사용자 정보가 없으면 로그인 페이지로 리디렉션
            return "redirect:/user/login";
        }

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
                String fileName = postNo + "_" + postType + "_" + (i + 1);

                System.out.println(fileName);

                objectStorageService.uploadFile(image, fileName);

                int userNo = certificationPost.getUserNo();
                userEtcService.updateCertificationCount(userNo, 0);
             
                int cnt = userEtcService.getCertificationCount(userNo);
                		User user2 = (User)session.getAttribute("user");
                		user2.setCertificationCount(cnt);
                		session.setAttribute("user", user2);
            }
        }

        // 해시태그 저장
        for (String hashtagContent : certificationPostHashtagContents) {
            if (!hashtagContent.isEmpty()) {
                certificationPostService.addHashtag(postNo, hashtagContent);
            }
        }
        
        mountainService.addMountainStatistics(certificationPost.getCertificationPostMountainName(), 1);
        return "redirect:/certificationPost/getCertificationPost?postNo=" + postNo;
    }


    @GetMapping(value = "updateCertificationPost")
    public String updateCertificationPost(@RequestParam int postNo, Model model, HttpSession session) throws Exception {
       
    	  User user = (User) session.getAttribute("user");
          if (user != null) {
              model.addAttribute("user", user);
          }

    	System.out.println("postNo: " + postNo);

        CertificationPost certificationPost = certificationPostService.getCertificationPost(postNo);
        List<String> hashtagList = certificationPostService.getHashtag(postNo);

        System.out.println("hashtagList: " + hashtagList);


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
        for (int i = 0; i < imageCount; i++) {
            String fileName = postNo + "_" + postType + "_" + (i + 1);
            String imageURL = objectStorageService.getImageURL(fileName);
            certificationPostImages.add(imageURL);
        }
        model.addAttribute("certificationPostImages", certificationPostImages);
        model.addAttribute("certificationPost", certificationPost);
        model.addAttribute("hashtagList", hashtagList); 
        // 사용자 세션에서 user 정보 가져오기
      
        return "forward:/certificationPost/updateCertificationPost.jsp";
    }

    @PostMapping(value = "updateCertificationPost")
    public String updateCertificationPost(
                                          @ModelAttribute("certificationPost") CertificationPost certificationPost,
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
                                          Model model,
                                          HttpSession session,
                                          @RequestParam(value = "updateImageURL", required = false) List<String> updateImageURL) throws Exception {

        if (certificationPost == null) {
            throw new NullPointerException("certificationPost is null");
        }

        if (updateImageURL == null) {
            updateImageURL = new ArrayList<>();
        }

        String totalTime = totalTimeHours + "시간 " + totalTimeMinutes + "분";
        String ascentTime = ascentTimeHours + "시간 " + ascentTimeMinutes + "분";
        String descentTime = descentTimeHours + "시간 " + descentTimeMinutes + "분";

        certificationPost.setCertificationPostTotalTime(totalTime);
        certificationPost.setCertificationPostAscentTime(ascentTime);
        certificationPost.setCertificationPostDescentTime(descentTime);

        System.out.println("여기다" + certificationPost);
        System.out.println("updateImageUrl 확인===" + updateImageURL);

        User user = (User) session.getAttribute("user");
        if (user != null) {
            model.addAttribute("user", user);
        }

        // 삭제할 해시태그를 폼 제출 시 처리
        List<Integer> hashtagsToDelete = new ArrayList<>();
        if (deleteHashtagNos != null) {
            for (int hashtagNo : deleteHashtagNos) {
                hashtagsToDelete.add(hashtagNo);
            }
        }

        // 해시태그 업데이트 로직
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

        int postNo = certificationPost.getPostNo();
        int postType = 0;

        certificationPostService.updateCertificationPost(certificationPost, updateImageURL);

        List<String> fileNames = new ArrayList<>();

        for (String imageURL : updateImageURL) {
            int lastIndex = imageURL.lastIndexOf("/");
            String fileName = imageURL.substring(lastIndex + 1);
            System.out.println("파일이름" + fileName);
            fileNames.add(fileName);
        }

        int appendImageStartIndex = objectStorageService.updateObjectStorageImage(fileNames);

        List<String> list = new ArrayList<String>();
        
        for(int i = 1; i < appendImageStartIndex; i++) {
        	list.add(postNo + "_" + postType + "_" +i);
        }
        
        if (certificationPost.getCertificationPostImage() != null) {
            List<MultipartFile> images = certificationPost.getCertificationPostImage().stream()
                .filter(image -> !image.isEmpty())
                .collect(Collectors.toList());

            int imageCount = images.size();
            System.out.println("imageCount : " + imageCount);

            for (int i = 0; i < imageCount; i++) {
                MultipartFile image = images.get(i);
                String fileName = postNo + "_" + postType + "_" + (appendImageStartIndex);
                list.add(fileName);
                System.out.println("fileName : " + fileName);
                objectStorageService.uploadFile(image, fileName);
                appendImageStartIndex += 1;
            }
        }
        // 폼 제출 시에만 삭제 처리
        for (int hashtagNo : hashtagsToDelete) {
            certificationPostService.deleteHashtag(hashtagNo);
        }
        
        model.addAttribute("certificationPostImages", list);
       

     
        
        return "redirect:/certificationPost/getCertificationPost?postNo=" + certificationPost.getPostNo();
    }


    @GetMapping(value = "listCertificationPost")
    public String listCertificationPost(@ModelAttribute Search search, Model model) throws Exception {
	

    	System.out.println("search" +search ) ;
        // CertificationPost 목록 및 관련 데이터 가져오기
        Map<String, Object> result = certificationPostService.getCertificationPostList(search);
        List<CertificationPost> certificationPostList = (List<CertificationPost>) result.get("list");
        System.out.println(" certificationPostList  " + certificationPostList );
        // CertificationPost 이미지 URL 가져오기
        List<String> certificationPostImages = new ArrayList<>();
        for (CertificationPost certificationPost : certificationPostList) {
            String fileName = certificationPost.getPostNo() + "_0_1"; // 첫 번째 사진 파일명
            String imageURL = objectStorageService.getImageURL(fileName);
            certificationPostImages.add(imageURL);
        }

        // 모델에 데이터 추가
        model.addAttribute("certificationPost", certificationPostList); // CertificationPost 목록
        model.addAttribute("hashtagList", result.get("hashtagList")); // 해시태그 목록
        model.addAttribute("certificationPostImages", certificationPostImages); // CertificationPost 이미지 URL 목록
        model.addAttribute("search", search); 

        return "forward:/certificationPost/listCertificationPost.jsp"; // JSP 페이지로 포워딩
    }


	
    // 게시글 상세조회..@RequestParam int certificationPostType, 
    @GetMapping(value="getCertificationPost")
    public String getCertificationPost(@RequestParam int postNo, Model model, HttpSession session) throws Exception {
        // 세션에서 로그인한 사용자 정보 가져오기
        User user = (User) session.getAttribute("user");
        if (user == null) {
            // 로그인이 되어 있지 않은 경우 처리
            return "redirect:/user/login"; // 로그인 페이지로 리다이렉트
        }

        int userNo = user.getUserNo(); // 로그인한 사용자의 유저번호

        int postType = 0;
        Map<String, Object> map = certificationPostService.getCertificationPost(postNo, userNo);
        List<CertificationPostComment> certificationPostCommentList = certificationPostService.getCertificationPostCommentList(postNo);

        CertificationPost certificationPost = (CertificationPost) map.get("certificationPost");

        List<String> certificationPostImages = new ArrayList<>();
        int imageCount = certificationPost.getCertificationPostImageCount();
        System.out.println("imageCount===" + imageCount);
        for (int i = 0; i < imageCount; i++) {
            String fileName = postNo + "_" + postType + "_" + (i + 1);
            String imageURL = objectStorageService.getImageURL(fileName);
            certificationPostImages.add(imageURL);
        }

        System.out.println("댓글" + postNo + userNo + certificationPostCommentList);
        model.addAttribute("certificationPost", map.get("certificationPost"));
        model.addAttribute("certificationPostCommentList", certificationPostCommentList);
        model.addAttribute("hashtagList", map.get("hashtagList"));
        model.addAttribute("certificationPostImages", certificationPostImages);

		System.out.println("������������"+certificationPostImages);
				
        System.out.println("이거맞지" + certificationPostCommentList);

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
    

    @GetMapping(value="getProfile")
    public String getProfile(@RequestParam int userNo, HttpSession session, Model model) throws Exception {
        User sessionUser = (User) session.getAttribute("user");

        if (sessionUser == null) {
            // 세션에 유저 정보가 없으면 로그인 페이지로 리디렉션
            return "redirect:/user/login";
        }

        int followerNo = sessionUser.getUserNo(); // 로그인된 사용자의 번호

        User user = userService.getUser(userNo);
        System.out.println("User Info: " + user);
        model.addAttribute("infouser", user);

        int followerCount = userEtcService.getFollowerCount(userNo);
        System.out.println("Follower Count: " + followerCount);
        model.addAttribute("followerCount", followerCount);

        int followingCount = userEtcService.getFollowingCount(userNo);
        System.out.println("Following Count: " + followingCount);
        model.addAttribute("followingCount", followingCount);

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
            String fileName = certificationPost.getPostNo() + "_" + postType + "_1"; // 첫 번째 사진 파일명
            String imageURL = objectStorageService.getImageURL(fileName);
            certificationPostImages.add(imageURL);
        }

        model.addAttribute("certificationPostImages", certificationPostImages);
        System.out.println("이미지" + certificationPostImages);

        return "forward:/certificationPost/getProfile.jsp";
    }

        
    }
    


    
    