package site.dearmysanta.service.meeting;

import site.dearmysanta.domain.meeting.MeetingParticipation;
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.domain.meeting.MeetingPostComment;
import site.dearmysanta.domain.meeting.MeetingPostSearch;
import site.dearmysanta.domain.common.Like;

import java.util.Map;



public interface MeetingService {
	
	public void addMeetingPost(MeetingPost meetingPost) throws Exception;
	
	public void addPostImage(MeetingPost meetingPost) throws Exception;
	
	public void updateMeetingPost(MeetingPost meetingPost) throws Exception;
	
	public void updatePostImage(MeetingPost meetingPost) throws Exception;
	
	public MeetingPost getMeetingPost(int postNo) throws Exception;
	
//	public Map<String, Object> getMeetingPostList(MeetingPostSearch meetingPostSearch) throws Exception;
//	
//	public void addMeetingParticipation(MeetingParticipation meetingParticipation) throws Exception;
//	
//	public void deleteMeetingParticipation(MeetingParticipation meetingParticipation) throws Exception;
//	
//	public void updateMeetingParticipationStatus(MeetingParticipation meetingParticipation) throws Exception;
//	
//	public void updateMeetingPostStatus(MeetingPost meetingPost) throws Exception;
//	
//	public Map<String, Object> getMeetingParticipationList(MeetingPostSearch meetingPostSearch);
//	
	public void addMeetingPostLike(Like like) throws Exception;
//	
	public void deleteMeetingPostLike(Like like) throws Exception;
//	
//	public Map<String, Object> getMeetingPostCommentList(MeetingPostComment meetingPostComment) throws Exception;
//	
	public void addMeetingPostComment(MeetingPostComment meetingPostComment) throws Exception;
//	
	public void deleteMeetingPostComment(MeetingPostComment meetingPostComment) throws Exception;
//	
	public int getMountainTotalCount(MeetingPostSearch meetingPostSearch) throws Exception;
	
	
	
	

}
