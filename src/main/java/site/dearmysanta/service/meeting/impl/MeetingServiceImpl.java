package site.dearmysanta.service.meeting.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import site.dearmysanta.service.meeting.MeetingService;
import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.meeting.MeetingParticipation;
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.domain.meeting.MeetingPostComment;
import site.dearmysanta.domain.meeting.MeetingPostSearch;
import site.dearmysanta.service.common.ObjectStorageService;
import site.dearmysanta.service.meeting.MeetingDAO;


@Service("meetingService")
public class MeetingServiceImpl implements MeetingService {
	
	@Value("${bucketName}")
	private String bucketName;
	
	@Autowired
    private ObjectStorageService objectStorageService;
	
	@Autowired
	@Qualifier("meetingDAO")
	private MeetingDAO meetingDAO;
	
	public MeetingServiceImpl() {
		System.out.println(this.getClass());
	}
	
	public int addMeetingPost(MeetingPost meetingPost) throws Exception {
		
		int userNo = meetingPost.getUserNo();
		String appointedDetailDeparture = meetingPost.getAppointedDetailDeparture();		
		String appointedDeparture = meetingPost.getAppointedDeparture()+ "/" +appointedDetailDeparture;
		
		meetingPost.setAppointedDeparture(appointedDeparture);
		
		if (meetingPost.getMeetingPostImage() != null && !meetingPost.getMeetingPostImage().isEmpty()) {
            
            meetingPost.setMeetingPostImageCount(meetingPost.getMeetingPostImage().size());
        }
		
		meetingDAO.insertMeetingPost(meetingPost);
		
		int postNo = meetingPost.getPostNo();
		
		MeetingParticipation meetingParticipation = new MeetingParticipation();
		meetingParticipation.setParticipationStatus(1);
		meetingParticipation.setParticipationRole(0);
		meetingParticipation.setUserNo(userNo);
		meetingParticipation.setPostNo(postNo);
		
		meetingDAO.insertMeetingParticipation(meetingParticipation);
		
		return postNo;
		
	}
	
//	public void addPostImage(MeetingPost meetingPost) throws Exception {
//		
//		meetingDAO.insertPostImage(meetingPost);
//	}
	
	public void updateMeetingPost(MeetingPost meetingPost) throws Exception {
		
		meetingDAO.updateMeetingPost(meetingPost);
	}
	
//	public void updatePostImage(MeetingPost meetingPost) throws Exception {
//		
//		meetingDAO.updateMeetingPost(meetingPost);
//	}
	
	public Map<String, Object> getMeetingPostAll(int postNo, int userNo) throws Exception {
		
		MeetingPost meetingPost = meetingDAO.getMeetingPost(postNo);
		System.out.println(meetingPost);
		
		String[] AppointedDeparture = meetingPost.getAppointedDeparture().split("/", 2);
		meetingPost.setAppointedDeparture(AppointedDeparture[0]);
		
		if(AppointedDeparture.length > 1) {
			meetingPost.setAppointedDetailDeparture(AppointedDeparture[1]);
		}
		
		int likeStatus = meetingDAO.getMeetingPostLikeStatus(postNo, userNo);
		
		int likeCount = meetingDAO.getMeetingPostLikeCount(postNo);
		int commentCount = meetingDAO.getMeetingPostCommentCount(postNo);
		
		meetingPost.setMeetingPostLikeStatus(likeStatus);
		meetingPost.setMeetingPostLikeCount(likeCount);
		meetingPost.setMeetingPostCommentCount(commentCount);
		
		List<MeetingParticipation> meetingParticipations = meetingDAO.getMeetingParticipationList(postNo);
		List<MeetingPostComment> meetingPostComments = meetingDAO.getMeetingPostCommentList(postNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("meetingPost", meetingPost);
		map.put("meetingParticipations", meetingParticipations);
		map.put("meetingPostComments", meetingPostComments);

		
		return map;
	}
	
	public MeetingPost getMeetingPost(int postNo) throws Exception {
		
		MeetingPost meetingPost = meetingDAO.getMeetingPost(postNo);
		
		String[] AppointedDeparture = meetingPost.getAppointedDeparture().split("/", 2);
		meetingPost.setAppointedDeparture(AppointedDeparture[0]);

		if(AppointedDeparture.length > 1) {
			meetingPost.setAppointedDetailDeparture(AppointedDeparture[1]);
		}
		
		return meetingPost;
	}
	
	public Map<String, Object> getMeetingPostList(MeetingPostSearch meetingPostSearch, int userNo) throws Exception {
		
		List<MeetingPost> meetingPosts = meetingDAO.getMeetingPostList(meetingPostSearch, userNo);
		int meetingPostTotalCount = meetingDAO.getMeetingPostTotalCount(meetingPostSearch);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("meetingPosts", meetingPosts);
		map.put("meetingPostTotalCount", meetingPostTotalCount);
		
		return map;
	}

	public void addMeetingPostLike(Like like) throws Exception {
		
		meetingDAO.insertMeetingPostLike(like);
	}
	
	public void deleteMeetingPostLike(Like like) throws Exception {
		
		meetingDAO.deleteMeetingPostLike(like);
	}
	
	public MeetingPostComment getMeetingPostComment(int meetingPostCommentNo) throws Exception {
		
		return meetingDAO.getMeetingPostComment(meetingPostCommentNo);
	}
	
	public int addMeetingPostComment(MeetingPostComment meetingPostComment) throws Exception {
		
		meetingDAO.insertMeetingPostComment(meetingPostComment);
		int meetingPostCommentNo = meetingPostComment.getMeetingPostCommentNo();
		System.out.println(meetingPostCommentNo);
		
		return meetingPostCommentNo;
	}
	
	public void deleteMeetingPostComment(int meetingPostCommentNo) throws Exception {
		
		meetingDAO.deleteMeetingPostComment(meetingPostCommentNo);
	}
	
	public int getMountainTotalCount(String appointedHikingMountain) throws Exception {
		
		return meetingDAO.getMountainTotalCount(appointedHikingMountain);
	}
	
	public List<MeetingParticipation> getMeetingParticipationList(int postNo) throws Exception {
		
		return meetingDAO.getMeetingParticipationList(postNo);
	}
	
	public List<MeetingPostComment> getMeetingPostCommentList(int postNo) throws Exception {
		
		return meetingDAO.getMeetingPostCommentList(postNo);
	}
	
	public MeetingParticipation getMeetingParticipation(int participationNo) throws Exception {
		
		return meetingDAO.getMeetingParticipation(participationNo);
	}
	
	public int addMeetingParticipation(MeetingParticipation meetingParticipation) throws Exception {
		
		meetingParticipation.setParticipationStatus(0);
		meetingParticipation.setParticipationRole(1);
		
		meetingDAO.insertMeetingParticipation(meetingParticipation);
		
		int participationNo = meetingParticipation.getParticipationNo();
		
		return participationNo;
	}
	
	public void deleteMeetingParticipation(int participationNo) throws Exception {
		
		meetingDAO.deleteMeetingParticipation(participationNo);
	}
	
	public void updateMeetingParticipationStatus(int participationNo) throws Exception {
		
		meetingDAO.updateMeetingParticipationStatus(participationNo);
	}
	
	public void updateMeetingParticipationWithdrawStatus(int postNo, int userNo) throws Exception {
		
		meetingDAO.updateMeetingParticipationWithdrawStatus(postNo, userNo);
	}
	
	public void updateMeetingPostRecruitmentStatus(MeetingPost meetingPost) throws Exception {
		
		if(meetingPost.getRecruitmentStatus() == 0) {
			meetingPost.setRecruitmentStatus(1);
		} else {
			meetingPost.setRecruitmentStatus(0);
		}
		
		meetingDAO.updateMeetingPostRecruitmentStatus(meetingPost);
	}
	
	public void updateMeetingPostRecruitmentStatusToEnd(int postNo) throws Exception {
		
		meetingDAO.updateMeetingPostRecruitmentStatusToEnd(postNo);
	}
	
	public void updateMeetingPostDeletedStatus(int postNo) throws Exception {
		
		meetingDAO.updateMeetingPostDeletedStatus(postNo);
		
		List<MeetingParticipation> meetingParticipations = getMeetingParticipationList(postNo);
		
		for(int i = 0; i < meetingParticipations.size(); i ++) {
			
			MeetingParticipation meetingParticipation = meetingParticipations.get(i);
			int userNo = meetingParticipation.getUserNo();
			
			meetingDAO.updateMeetingParticipationWithdrawStatus(postNo, userNo);
			
		}
	}
	
	public void updateMeetingPostCertifiedStatus(int postNo) throws Exception {
		
		meetingDAO.updateMeetingPostCertifiedStatus(postNo);
	}
	
	public List<MeetingPost> getUnCertifiedMeetingPost(int userNo) throws Exception {
		
		return meetingDAO.getUnCertifiedMeetingPost(userNo);
	}
	
	public List<MeetingPost> getChattingRoomList(int userNo) throws Exception {
		
		return meetingDAO.getChattingRoomList(userNo);
	}
	
}
