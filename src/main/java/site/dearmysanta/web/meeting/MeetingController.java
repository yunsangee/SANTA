package site.dearmysanta.web.meeting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.service.meeting.MeetingService;

@Controller
@RequestMapping("/meetingController/*")
public class MeetingController {
	
	@Autowired
	@Qualifier("meetingService")
	private MeetingService meetingService;
	
	public MeetingController() {
		System.out.println(this.getClass());
	}
	
//	@PostMapping(value = "addMeetingPost")
//	public String addMeetingPost(@ModelAttibute("meetingPost") MeetingPost meetingPost,
//			) throws Exception {
		
		
		
//	}


}
