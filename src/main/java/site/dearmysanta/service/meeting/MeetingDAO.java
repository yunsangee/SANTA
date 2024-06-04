package site.dearmysanta.service.meeting;

import org.apache.ibatis.annotations.Mapper;

import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.domain.meeting.MeetingPostComment;
import site.dearmysanta.domain.meeting.MeetingPostSearch;

@Mapper
public interface MeetingDAO {
	
	public void insertMeetingPost(MeetingPost meetingPost) throws Exception;
	
	public void insertPostImage(MeetingPost meetingPost) throws Exception;
	
	public void updateMeetingPost(MeetingPost meetingPost) throws Exception;
	
	public void updatePostImage(MeetingPost meetingPost) throws Exception;
	
	public MeetingPost findMeetingPost(int postNo) throws Exception;
	
	public void insertMeetingPostLike(Like like) throws Exception;
	
	public void deleteMeetingPostLike(Like like) throws Exception;
	
	public void insertMeetingPostComment(MeetingPostComment meetingPostComment) throws Exception;
	
	public void deleteMeetingPostComment(MeetingPostComment meetingPostComment) throws Exception;
	
	public int getMeetingPostLikeCount(int postNo) throws Exception;
	
	public int getMeetingPostCommentCount(int postNo) throws Exception;
	//getTotalCount 할 때 insertMeetingPost Map 반환해야함.
	
	public int findMountainTotalCount(MeetingPostSearch meetingPostSearch) throws Exception;
	

}
