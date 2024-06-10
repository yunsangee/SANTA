package site.dearmysanta.web.meeting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import site.dearmysanta.service.meeting.MeetingService;

@Controller
@RequestMapping("/meetingController/*")
public class MeetingController {
	
	@Autowired
	@Qualifier("meetingServiceImpl")
	private MeetingService meetingService;
	
	public MeetingController() {
		System.out.println(this.getClass());
	}
	
//	@RequestMapping(value = "addMeetingPost", method=RequestMethod.GET)
//	public String addMeetingPost() throws Exception {
//		
//	}


}
