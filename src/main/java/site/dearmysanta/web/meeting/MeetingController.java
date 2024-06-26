package site.dearmysanta.web.meeting;

import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import site.dearmysanta.domain.common.Page;
import site.dearmysanta.domain.meeting.MeetingParticipation;
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.domain.meeting.MeetingPostSearch;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.chatting.ChattingService;
import site.dearmysanta.service.common.ObjectStorageService;
import site.dearmysanta.service.meeting.MeetingService;
import site.dearmysanta.service.mountain.MountainService;

@Controller
@RequestMapping("/meeting/*")
public class MeetingController {
	
	@Value("${bucketName}")
	private String bucketName;
	
	@Value("${pageSize}")
	private int pageSize;
	
	@Value("${pageUnit}")
	private int pageUnit;
	
	@Autowired
	@Qualifier("objectStorageService")
	private ObjectStorageService objectStorageService;
	
	@Autowired
	@Qualifier("mountainServiceImpl")
	private MountainService mountainService;
	
	@Autowired
	@Qualifier("chattingService")
	private ChattingService chattingService;
	
	@Autowired
	@Qualifier("meetingService")
	private MeetingService meetingService;
	
	public MeetingController() {
		System.out.println(this.getClass());
	}
	
	@GetMapping(value = "getMeetingPost")
	public String getMeetingPost(@RequestParam int postNo, Model model) throws Exception {
		
//		int userNo = ((User)session.getAttribute("user")).getUserNo();
		int userNo = 1;
		int postType = 1;
		
		Map<String, Object> map = meetingService.getMeetingPostAll(postNo, userNo);
		
		MeetingPost meetingPost = (MeetingPost)map.get("meetingPost");
		System.out.println("meetingPost==="+meetingPost);
		
		List<String> meetingPostImages = new ArrayList<>();
		int imageCount = meetingPost.getMeetingPostImageCount();
		
//		System.out.println("imageCount==="+imageCount);
		
		for (int i = 0; i < imageCount; i++) {
            String fileName = postNo+ "_" +postType+ "_" +(i+1);
            String imageURL = objectStorageService.getImageURL(fileName);
            meetingPostImages.add(imageURL);
        }
		
		List<MeetingParticipation> meetingParticipation = (List<MeetingParticipation>)map.get("meetingParticipations");
		
		System.out.println("사진사진사진"+meetingPostImages);
				
		
		model.addAttribute("meetingPost", meetingPost);
		model.addAttribute("meetingParticipations", map.get("meetingParticipations"));
		model.addAttribute("meetingPostComments", map.get("meetingPostComments"));
		model.addAttribute("meetingPostImages", meetingPostImages);
		model.addAttribute("isMember", map.get("isMember"));
		
		return "forward:/meeting/getMeetingPost.jsp";
	}
	
	@GetMapping(value = "addMeetingPost")
	public String addMeetingPost() throws Exception {
		
		return "forward:/meeting/addMeetingPost.jsp";
	}
	
	@PostMapping(value = "addMeetingPost") // userNo to Session
	public String addMeetingPost(@ModelAttribute("meetingPost") MeetingPost meetingPost) throws Exception {
		
//		int userNo = ((User)session.getAttribute("user")).getUserNo();
		
		int userNo = 1;
		
		meetingPost.setUserNo(userNo);
		
		
		int postNo = meetingService.addMeetingPost(meetingPost);
		int postType = 1;
		String appointedHikingMountain = meetingPost.getAppointedHikingMountain();
		
		
		mountainService.addMountainStatistics(appointedHikingMountain, 1);
		
		chattingService.createChattingRoom(postNo);
		
		if (meetingPost.getMeetingPostImage() != null) {
	        List<MultipartFile> images = meetingPost.getMeetingPostImage().stream()
	            .filter(image -> !image.isEmpty())
	            .collect(Collectors.toList());
			
            int imageCount = images.size();
            System.out.println("imageCount : "+imageCount);
            
            for (int i = 0; i < imageCount; i++) {
            	
                MultipartFile image = images.get(i);
                String fileName = postNo+ "_" +postType+ "_" +(i+1);
                
                System.out.println("fileName : "+fileName);
                
                objectStorageService.uploadFile(image, fileName);
                
            }
		}
		
		return "redirect:/meeting/getMeetingPost?postNo=" + postNo;
	}
	
	@GetMapping(value = "updateMeetingPost")
	public String updateMeetingPost(@RequestParam int postNo, Model model) throws Exception {
		
		int postType = 1;
		
		MeetingPost meetingPost = meetingService.getMeetingPost(postNo);
		
		List<String> meetingPostImages = new ArrayList<>();
		int imageCount = meetingPost.getMeetingPostImageCount();
		
		for (int i = 0; i < imageCount; i++) {
            String fileName = postNo+ "_" +postType+ "_" +(i+1);
            String imageURL = objectStorageService.getImageURL(fileName);
            meetingPostImages.add(imageURL);
        }
		
		
        SimpleDateFormat formatterUntilDay = new SimpleDateFormat("yyyy-MM-dd");

        String formattedRecruitmentDeadline = formatterUntilDay.format(meetingPost.getRecruitmentDeadline());
        String formattedAppointedHikingDate = formatterUntilDay.format(meetingPost.getAppointedHikingDate());
        
        model.addAttribute("formattedRecruitmentDeadline", formattedRecruitmentDeadline);
        model.addAttribute("formattedAppointedHikingDate", formattedAppointedHikingDate);
        model.addAttribute("meetingPostImages", meetingPostImages);
		model.addAttribute(meetingPost);
		
		return "forward:/meeting/updateMeetingPost.jsp";
	}
	
	@PostMapping(value = "updateMeetingPost")
	public String updateMeetingPost(@ModelAttribute("meetingPost") MeetingPost meetingPost, @RequestParam("updateImageURL") List<String> updateImageURL) throws Exception {
		
		System.out.println("meetingPostImage 뭐찍히나 확인"+meetingPost);
		System.out.println("updateImageUrl 확인==="+updateImageURL);
		
		int postNo = meetingPost.getPostNo();
		int postType = 1;
		
		meetingService.updateMeetingPost(meetingPost, updateImageURL);
		
		
		List<String> fileNames = new ArrayList<>();
		
		for (String imageURL : updateImageURL) {
			
			int lastIndex = imageURL.lastIndexOf("/");
			String fileName = imageURL.substring(lastIndex + 1);
			
			System.out.println(fileName);
			
			fileNames.add(fileName);
		}
		
		
		System.out.println("정렬시킬 이미지이름들 : "+fileNames);
		
		int appendImageStartIndex = objectStorageService.updateObjectStorageImage(fileNames);
		
		if (meetingPost.getMeetingPostImage() != null) {
	        List<MultipartFile> images = meetingPost.getMeetingPostImage().stream()
	            .filter(image -> !image.isEmpty())
	            .collect(Collectors.toList());
			
            int imageCount = images.size();
            System.out.println("imageCount : "+imageCount);
            
            for (int i = 0; i < imageCount; i++) {
            	
                MultipartFile image = images.get(i);
                String fileName = postNo+ "_" +postType+ "_" +(appendImageStartIndex);
                
                System.out.println("fileName : "+fileName);
                
                objectStorageService.uploadFile(image, fileName);
                
                appendImageStartIndex += 1;
            }
		}
		
		return "redirect:/meeting/getMeetingPost?postNo=" + meetingPost.getPostNo();
	}
	
	@GetMapping(value = "deleteMeetingPost")
	public String deleteMeetingPost(@RequestParam int postNo, Model model) throws Exception {
		
		meetingService.updateMeetingPostDeletedStatus(postNo);
		
		return "redirect:/meeting/getMeetingPostList";
	}
	
	@RequestMapping(value = "getMeetingPostList") // currentPage
	public String getMeetingPostList(@ModelAttribute("meetingPostSearch") MeetingPostSearch meetingPostSearch, 
			Model model) throws Exception {
		
		System.out.println("/meeting/getMeetingPostList : GET/Post");
		System.out.println("meetingPostSearch ===== "+meetingPostSearch);
		
//		int userNo = ((User)session.getAttribute("user")).getUserNo();
//		meetingPostSearch.setUserNo(userNo);
		int userNo = 1;
		
		if(meetingPostSearch.getCurrentPage() ==0 ){
			meetingPostSearch.setCurrentPage(1);
		}
		meetingPostSearch.setPageSize(pageSize);
		
		meetingPostSearch.setUserNo(userNo);
		
		System.out.println("Before calling meetingService.getMeetingPostList");
	    System.out.println("meetingPostSearch: " + meetingPostSearch);
		
		Map<String, Object> map = meetingService.getMeetingPostList(meetingPostSearch);
		
		System.out.println("After calling meetingService.getMeetingPostList");
	    System.out.println("map: " + map);
	    
	    System.out.println("meetingPostSearch.getCurrentPage ==="+meetingPostSearch.getCurrentPage());
	    System.out.println("totalcount intvalue ==="+((Integer)map.get("meetingPostTotalCount")).intValue());
	    System.out.println("pageunit, pagesize==="+pageUnit +" "+pageSize);
	    
		
		Page resultPage = new Page(meetingPostSearch.getCurrentPage(), ((Integer)map.get("meetingPostTotalCount")).intValue(), pageUnit, pageSize);
		
		System.out.println("resultPage ======="+resultPage);
		
		model.addAttribute("meetingPosts", map.get("meetingPosts"));
		model.addAttribute("meetingPostSearch", meetingPostSearch);
		model.addAttribute("resultPage", resultPage);
		
		return "forward:/meeting/listMeetingPost.jsp";
	}
	
}
