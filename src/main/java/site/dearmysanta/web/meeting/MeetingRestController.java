package site.dearmysanta.web.meeting;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import site.dearmysanta.domain.meeting.MeetingParticipation;
import site.dearmysanta.service.meeting.MeetingService;

@RestController
@RequestMapping("/meeting/*")
public class MeetingRestController {
	
	@Autowired
	@Qualifier("meetingService")
	private MeetingService meetingService;
	
	public MeetingRestController() {
		System.out.println(this.getClass());
	}
	
	@GetMapping(value = "rest/addMeetingParticipation")
	public void addMeetingParticipation(@ModelAttribute MeetingParticipation meetingParticipation) throws Exception {
		meetingService.addMeetingParticipation(meetingParticipation);
	}
	
	@GetMapping(value = "rest/deleteMeetingParticipation")
	public void deleteMeetingParticipation(@RequestParam int participationNo) throws Exception {
		meetingService.deleteMeetingParticipation(participationNo);
	}
	
	@GetMapping(value = "rest/updateMeetingParticipationStatus")
	public void updateMeetingParticipationStatus(@RequestParam int participationNo) throws Exception {
		meetingService.updateMeetingParticipationStatus(participationNo);
	}

}
