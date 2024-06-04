package site.dearmysanta.service.meeting;

import org.apache.ibatis.annotations.Mapper;

import site.dearmysanta.domain.meeting.MeetingPost;

@Mapper
public interface MeetingDAO {
	
	public void insertMeetingPost(MeetingPost meetingPost) throws Exception;
	
	public void insertPostImage(MeetingPost meetingPost) throws Exception;
	
	public void updateMeetingPost(MeetingPost meetingPost) throws Exception;
	
	public void updatePostImage(MeetingPost meetingPost) throws Exception;
	
	public MeetingPost findMeetingPost(int postNo) throws Exception;
	

}
