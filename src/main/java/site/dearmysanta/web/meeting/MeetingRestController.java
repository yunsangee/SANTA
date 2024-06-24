package site.dearmysanta.web.meeting;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.meeting.MeetingParticipation;
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.domain.meeting.MeetingPostComment;
import site.dearmysanta.service.meeting.MeetingService;
import site.dearmysanta.service.user.etc.UserEtcService;

@RestController
@RequestMapping("/meeting/*")
public class MeetingRestController {
	
	@Autowired
	@Qualifier("meetingService")
	private MeetingService meetingService;
	
	@Autowired
	private UserEtcService userEtcService;
	
	public MeetingRestController() {
		System.out.println(this.getClass());
	}
	
	@GetMapping(value = "rest/addMeetingParticipation") // postNo, userNo
	public MeetingParticipation addMeetingParticipation(@ModelAttribute MeetingParticipation meetingParticipation) throws Exception {
		
		int participationNo = meetingService.addMeetingParticipation(meetingParticipation);
		
		return meetingService.getMeetingParticipation(participationNo);
	}
	
	@GetMapping(value = "rest/deleteMeetingParticipation")
	public void deleteMeetingParticipation(@RequestParam int participationNo) throws Exception {
		
		meetingService.deleteMeetingParticipation(participationNo);
	}
	
	@GetMapping(value = "rest/updateMeetingParticipationStatus")
	public MeetingParticipation updateMeetingParticipationStatus(@RequestParam int participationNo) throws Exception {
		
		meetingService.updateMeetingParticipationStatus(participationNo);
		
		return meetingService.getMeetingParticipation(participationNo);
	}
	
	@PostMapping(value = "rest/addMeetingPostComment") // meetingPostNo, userNo, meetingPostCommentContents
	public MeetingPostComment addMeetingPostComment(@RequestBody MeetingPostComment meetingPostComment) throws Exception {
		
		int meetingPostCommentNo = meetingService.addMeetingPostComment(meetingPostComment);
		
		return meetingService.getMeetingPostComment(meetingPostCommentNo);
	}
	
	@GetMapping(value = "rest/deleteMeetingPostComment")
	public void deleteMeetingPostComment(@RequestParam int meetingPostCommentNo) throws Exception {
		
		meetingService.deleteMeetingPostComment(meetingPostCommentNo);
	}
	

	// 아래 테스트 필요.
	
	// if success, change like image
	@GetMapping(value = "rest/updateMeetingPostLikeStatus") // postNo, userNo
	public void updateMeetingPostLikeStatus(@RequestParam int meetingPostLikeStatus, @ModelAttribute Like like) throws Exception {
		
		System.out.println(meetingPostLikeStatus);
		
		if(meetingPostLikeStatus == 0) {
			meetingService.addMeetingPostLike(like);
		} else {
			meetingService.deleteMeetingPostLike(like);
		}
		
	}
	
	// 직접 탈퇴, 강제퇴장 공통이라서 postNo, userNo
	@GetMapping(value = "rest/updateMeetingParticipationWithdrawStatus")
	public void updateMeetingParticipationWithdrawStatus(@RequestParam int postNo, @RequestParam int userNo) throws Exception {
		
		meetingService.updateMeetingParticipationWithdrawStatus(postNo, userNo);
	}
	
	
	@GetMapping(value = "rest/updateMeetingPostRecruitmentStatus")
	public void updateMeetingPostRecruitmentStatus(@ModelAttribute MeetingPost meetingPost) throws Exception {
		
		if (meetingPost.getRecruitmentStatus() == 0) {
			meetingPost.setRecruitmentStatus(1);
		} else {
			meetingPost.setRecruitmentStatus(0);
		}
		
		System.out.println("자 확인해보자!!!!!!"+meetingPost);
		
		meetingService.updateMeetingPostRecruitmentStatus(meetingPost);
	}
	
	@GetMapping(value= "rest/updateMeetingPostRecruitmentStatusToEnd")
	public void updateMeetingPostRecruitmentStatusToEnd(@RequestParam int postNo) throws Exception {
		
		meetingService.updateMeetingPostRecruitmentStatusToEnd(postNo);
		
		List<MeetingParticipation> meetingParticipationList = meetingService.getMeetingParticipationList(postNo);
		
		for (int i = 0; i < meetingParticipationList.size(); i++) {
        	
            MeetingParticipation meetingParticipation = meetingParticipationList.get(i);
            int userNo = meetingParticipation.getUserNo();
            
            userEtcService.updateMeetingCount(userNo, 1);
            
        }
		
	}
	
}
