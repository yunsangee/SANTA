package site.dearmysanta.web.meeting;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.domain.meeting.MeetingPostSearch;
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
	public String getMeetingPost(@RequestParam int postNo, Model model
//			, HttpSession session 이런식으로 controller에서 session쓴다고 선언해서 userNo 박는게 좋은지
//			jsp에서 session 써서 여기로 파라미터로 userNo 넘기는게 좋은지 ????
			) throws Exception {
		
//		int userNo = ((User)session.getAttribute("user")).getUserNo();
		int userNo = 1;
		int postType = 1;
		
		Map<String, Object> map = meetingService.getMeetingPostAll(postNo, userNo);
		
		MeetingPost meetingPost = (MeetingPost)map.get("meetingPost");
		System.out.println("meetingPost==="+meetingPost);
		
		List<String> meetingPostImages = new ArrayList<>();
		int imageCount = meetingPost.getMeetingPostImageCount();
		
		System.out.println("imageCount==="+imageCount);
		
		for (int i = 0; i < imageCount; i++) {
            String fileName = postNo+ "_" +postType+ "_" +(i+1);
            String imageURL = objectStorageService.getImageURL(fileName);
            meetingPostImages.add(imageURL);
        }
		
		model.addAttribute("meetingPost", meetingPost);
		model.addAttribute("meetingParticipations", map.get("meetingParticipations"));
		model.addAttribute("meetingPostComments", map.get("meetingPostComments"));
		model.addAttribute("meetingPostImages", meetingPostImages);
		
		return "forward:/meeting/getMeetingPost.jsp";
	}
	
	@GetMapping(value = "addMeetingPost")
	public String addMeetingPost() throws Exception {
		
		return "forward:/meeting/addMeetingPost.jsp";
	}
	
	@PostMapping(value = "addMeetingPost") // userNo to Session
	public String addMeetingPost(@ModelAttribute("meetingPost") MeetingPost meetingPost) throws Exception {
		
		int postNo = meetingService.addMeetingPost(meetingPost);
		int postType = 1;
		String appointedHikingMountain = meetingPost.getAppointedHikingMountain();
		
		//mountainService.addMountainStatistics(appointedHikingMountain, 1);
		
		chattingService.createChattingRoom(postNo);
		
		if (meetingPost.getMeetingPostImage() != null && !meetingPost.getMeetingPostImage().isEmpty()) {
			
            List<MultipartFile> images = meetingPost.getMeetingPostImage();
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
		
		MeetingPost meetingPost = meetingService.getMeetingPost(postNo);
		model.addAttribute(meetingPost);
		
		return "forward:/meeting/updateMeetingPost.jsp";
	}
	
	@PostMapping(value = "updateMeetingPost")
	public String updateMeetingPost(@ModelAttribute("meetingPost") MeetingPost meetingPost) throws Exception {
		
		meetingService.updateMeetingPost(meetingPost);	
		
		return "redirect:/meeting/getMeetingPost?postNo=" + meetingPost.getPostNo();
	}
	
	@GetMapping(value = "deleteMeetingPost")
	public String deleteMeetingPost(@RequestParam int postNo, Model model) throws Exception {
		
		meetingService.updateMeetingPostDeletedStatus(postNo);
		
		return "redirect:/meeting/getMeetingPostList.jsp";
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
