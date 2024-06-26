package site.dearmysanta.service.meeting;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.meeting.MeetingParticipation;
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.domain.meeting.MeetingPostComment;
import site.dearmysanta.domain.meeting.MeetingPostSearch;

@Mapper
public interface MeetingDAO {
	
	public void insertMeetingPost(MeetingPost meetingPost) throws Exception;
	
	public void insertPostImage(MeetingPost meetingPost) throws Exception;
	
	public void updateMeetingPost(MeetingPost meetingPost) throws Exception;
	
	public void updatePostImage(MeetingPost meetingPost) throws Exception;
	
	public MeetingPost getMeetingPost(int postNo) throws Exception;
	
	public List<MeetingPost> getMeetingPostList(MeetingPostSearch meetingPostSearch) throws Exception;
	
	public int getMeetingPostTotalCount(MeetingPostSearch meetingPostSearch) throws Exception;
	
	public MeetingParticipation getMeetingParticipation(int participationNo) throws Exception;
	
	public int getMeetingPostLikeStatus(int postNo, int userNo) throws Exception;
	
	public void insertMeetingPostLike(Like like) throws Exception;
	
	public void deleteMeetingPostLike(Like like) throws Exception;
	
	public MeetingPostComment getMeetingPostComment(int meetingPostCommentNo) throws Exception;
	
	public void insertMeetingPostComment(MeetingPostComment meetingPostComment) throws Exception;
	
	public void deleteMeetingPostComment(int meetingPostCommentNo) throws Exception;
	
	public int getMeetingPostLikeCount(int postNo) throws Exception;
	
	public int getMeetingPostCommentCount(int postNo) throws Exception;

	public int getMountainTotalCount(String appointedHikingMountain) throws Exception;
	
	public List<MeetingParticipation> getMeetingParticipationList(int postNo) throws Exception;
	
	public List<MeetingPostComment> getMeetingPostCommentList(int postNo) throws Exception;
	
	public void insertMeetingParticipation(MeetingParticipation meetingParticipation) throws Exception;
	
	public void deleteMeetingParticipation(int participationNo) throws Exception;
	
	public void updateMeetingParticipationStatus(int participationNo) throws Exception;
	
	public void updateMeetingParticipationWithdrawStatus(int postNo, int userNo) throws Exception;
	
	public void updateMeetingPostRecruitmentStatus(MeetingPost meetingPost) throws Exception;
	
	public void updateMeetingPostRecruitmentStatusToEnd(int postNo) throws Exception;
	
	public void updateMeetingPostDeletedStatus(int postNo) throws Exception;
	
	public void updateMeetingPostCertifiedStatus(int postNo) throws Exception;
	
	public List<MeetingPost> getUnCertifiedMeetingPost(int userNo) throws Exception;
	
	public void insertImageCount(int postNo, int imageCount) throws Exception;
	
	public List<MeetingPost> getChattingRoomList(int userNo) throws Exception;

}
