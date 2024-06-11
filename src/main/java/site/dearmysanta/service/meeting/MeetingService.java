package site.dearmysanta.service.meeting;

import site.dearmysanta.domain.meeting.MeetingParticipation;
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.domain.meeting.MeetingPostComment;
import site.dearmysanta.domain.meeting.MeetingPostSearch;
import site.dearmysanta.domain.common.Like;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;



public interface MeetingService {
	
	public void addMeetingPost(MeetingPost meetingPost) throws Exception;
	
//	public void addPostImage(MeetingPost meetingPost) throws Exception;
	
	public void updateMeetingPost(MeetingPost meetingPost) throws Exception;
	
//	public void updatePostImage(MeetingPost meetingPost) throws Exception;
	
	public Map<String, Object> getMeetingPostAll(int postNo) throws Exception;
	
	public MeetingPost getMeetingPost(int postNo) throws Exception;
	
//	public Map<String, Object> getMeetingPostList(MeetingPostSearch meetingPostSearch) throws Exception;
	
	public void addMeetingParticipation(MeetingParticipation meetingParticipation) throws Exception;
	
	public void deleteMeetingParticipation(int participationNo) throws Exception;
	
	public void updateMeetingParticipationStatus(int participationNo) throws Exception;
	
	public void updateMeetingParticipationWithdrawStatus(int participationNo) throws Exception;
	
	public void updateMeetingPostRecruitmentStatus(MeetingPost meetingPost) throws Exception;
	
	public void updateMeetingPostRecruitmentStatusToEnd(int postNo) throws Exception;
	
	public void updateMeetingPostDeletedStatus(int postNo) throws Exception;
	
	public void updateMeetingPostCertifiedStatus(int postNo) throws Exception;
	
	public List<MeetingParticipation> getMeetingParticipationList(int postNo) throws Exception; 
	
	public void addMeetingPostLike(Like like) throws Exception;
	
	public void deleteMeetingPostLike(Like like) throws Exception;
	
	public List<MeetingPostComment> getMeetingPostCommentList(int postNo) throws Exception;
	
	public void addMeetingPostComment(MeetingPostComment meetingPostComment) throws Exception;
	
	public void deleteMeetingPostComment(MeetingPostComment meetingPostComment) throws Exception;
	
	public int getMountainTotalCount(String appointedHikingMountain) throws Exception;
	
	public List<MeetingPost> getUnCertifiedMeetingPost(int userNo) throws Exception;
	
	public void uploadMeetingPostImages(List<MultipartFile> images, String postNo) throws Exception;
	
    public MultipartFile downloadMeetingPostImage(String postNo, String fileName) throws Exception;

}
