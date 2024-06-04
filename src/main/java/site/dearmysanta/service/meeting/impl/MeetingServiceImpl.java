package site.dearmysanta.service.meeting.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import site.dearmysanta.service.meeting.MeetingService;
import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.domain.meeting.MeetingPostComment;
import site.dearmysanta.domain.meeting.MeetingPostSearch;
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
	
	public void addMeetingPostLike(Like like) throws Exception {
		meetingDAO.insertMeetingPostLike(like);
	}
	
	public void deleteMeetingPostLike(Like like) throws Exception {
		meetingDAO.deleteMeetingPostLike(like);
	}
	
	public void addMeetingPostComment(MeetingPostComment meetingPostComment) throws Exception {
		meetingDAO.insertMeetingPostComment(meetingPostComment);
	}
	
	public void deleteMeetingPostComment(MeetingPostComment meetingPostComment) throws Exception {
		meetingDAO.deleteMeetingPostComment(meetingPostComment);
	}
	
	public int getMountainTotalCount(MeetingPostSearch meetingPostSearch) throws Exception {
		return meetingDAO.findMountainTotalCount(meetingPostSearch);
	}

}
