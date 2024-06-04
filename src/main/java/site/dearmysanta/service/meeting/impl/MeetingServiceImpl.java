package site.dearmysanta.service.meeting.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import site.dearmysanta.service.meeting.MeetingService;
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.service.meeting.MeetingDAO;


@Service("MeetingService")
public class MeetingServiceImpl implements MeetingService {
	
	@Autowired
	@Qualifier("meetingDAO")
	private MeetingDAO meetingDAO;
	
//	public MeetingServiceImpl() {
//		System.out.println(this.getClass());
//	} logger로 변경예정
	
	public void addMeetingPost(MeetingPost meetingPost) throws Exception {
		meetingDAO.insertMeetingPost(meetingPost);
	}
	
	public void addPostImage(MeetingPost meetingPost) throws Exception {
		meetingDAO.insertPostImage(meetingPost);
	}
	
	public void updateMeetingPost(MeetingPost meetingPost) throws Exception {
		meetingDAO.updateMeetingPost(meetingPost);
	}
	
	public void updatePostImage(MeetingPost meetingPost) throws Exception {
		meetingDAO.updateMeetingPost(meetingPost);
	}
	
	public MeetingPost getMeetingPost(int postNo) throws Exception {
		return meetingDAO.findMeetingPost(postNo);
	}

}
