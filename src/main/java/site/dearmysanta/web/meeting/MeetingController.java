package site.dearmysanta.web.meeting;

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

import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.service.meeting.MeetingService;

@Controller
@RequestMapping("/meeting/*")
public class MeetingController {
	
	@Autowired
	@Qualifier("meetingService")
	private MeetingService meetingService;
	
	public MeetingController() {
		System.out.println(this.getClass());
	}
	
	@GetMapping(value = "getMeetingPost")
	public String getMeetingPost(@RequestParam int postNo, Model model) throws Exception {
		
		Map<String, Object> map = meetingService.getMeetingPostAll(postNo);
		
		model.addAttribute("meetingPost", map.get("meetingPost"));
		model.addAttribute("meetingParticipations", map.get("meetingParticipations"));
		model.addAttribute("meetingPostComments", map.get("meetingPostComments"));
		model.addAttribute("meetingPostImages", map.get("meetingPostImages"));
		
		return "forward:/meeting/getMeetingPost.jsp";
	}
	
	@GetMapping(value = "addMeetingPost")
	public String addMeetingPost() throws Exception {
		
		return "forward:/meeting/addMeetingPost.jsp";
	}
	
	@PostMapping(value = "addMeetingPost")
	public String addMeetingPost(@ModelAttribute("meetingPost") MeetingPost meetingPost) throws Exception {
		
		meetingService.addMeetingPost(meetingPost);
		
		return "redirect:/meeting/getMeetingPost?postNo=" + meetingPost.getPostNo();
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
	
//	@RequestMapping(value = "listMeetingPost")
//	public String listMeetingPost()
	
	

}
