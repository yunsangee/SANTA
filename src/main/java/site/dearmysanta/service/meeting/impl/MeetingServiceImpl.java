package site.dearmysanta.service.meeting.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import site.dearmysanta.service.meeting.MeetingService;
import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.meeting.MeetingParticipation;
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.domain.meeting.MeetingPostComment;
import site.dearmysanta.domain.meeting.MeetingPostSearch;
import site.dearmysanta.service.meeting.MeetingDAO;


@Service("meetingService")
public class MeetingServiceImpl implements MeetingService {
	
	@Autowired
	@Qualifier("meetingDAO")
	private MeetingDAO meetingDAO;
	
//	public MeetingServiceImpl() {
//		System.out.println(this.getClass());
//	} logger로 변경예정
	
	public void addMeetingPost(MeetingPost meetingPost) throws Exception {
		
		MeetingParticipation meetingParticipation = new MeetingParticipation();
		meetingParticipation.setParticipationStatus(1);
		meetingParticipation.setParticipationRole(0);
		
		meetingDAO.insertMeetingPost(meetingPost);
		
		int userNo = meetingPost.getUserNo();
		meetingParticipation.setUserNo(userNo);
		
		int postNo = meetingPost.getPostNo();
		meetingParticipation.setPostNo(postNo);
		
		meetingDAO.insertMeetingParticipation(meetingParticipation);
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
	
	public Map<String, Object> getMeetingPostAll(int postNo) throws Exception {
		
		MeetingPost meetingPost = meetingDAO.findMeetingPost(postNo);
		
		int likeCount = meetingDAO.getMeetingPostLikeCount(postNo);
		int commentCount = meetingDAO.getMeetingPostCommentCount(postNo);
		
		meetingPost.setMeetingPostLikeCount(likeCount);
		meetingPost.setMeetingPostCommentCount(commentCount);
		
		List<MeetingParticipation> meetingParticipationList = meetingDAO.getMeetingParticipationList(postNo);
		List<MeetingPostComment> meetingPostCommentList = meetingDAO.getMeetingPostCommentList(postNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("meetingPost", meetingPost);
		map.put("meetingParticipationList", meetingParticipationList);
		map.put("meetingPostCommentList", meetingPostCommentList);
		
		return map;
	}
	
	public MeetingPost getMeetingPost(int postNo) throws Exception {
		
		MeetingPost meetingPost = meetingDAO.findMeetingPost(postNo);
		
		return meetingPost;
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
	
	public int getMountainTotalCount(String appointedHikingMountain) throws Exception {
		
		return meetingDAO.getMountainTotalCount(appointedHikingMountain);
	}
	
	public List<MeetingParticipation> getMeetingParticipationList(int postNo) throws Exception {
		
		return meetingDAO.getMeetingParticipationList(postNo);
	}
	
	public List<MeetingPostComment> getMeetingPostCommentList(int postNo) throws Exception {
		
		return meetingDAO.getMeetingPostCommentList(postNo);
	}
	
	public void addMeetingParticipation(MeetingParticipation meetingParticipation) throws Exception {
		
		meetingParticipation.setParticipationStatus(0);
		meetingParticipation.setParticipationRole(1);
		
		meetingDAO.insertMeetingParticipation(meetingParticipation);
	}
	
	public void deleteMeetingParticipation(int participationNo) throws Exception {
		
		meetingDAO.deleteMeetingParticipation(participationNo);
	}
	
	public void updateMeetingParticipationStatus(int participationNo) throws Exception {
		
		meetingDAO.updateMeetingParticipationStatus(participationNo);
	}
	
	public void updateMeetingParticipationWithdrawStatus(int participationNo) throws Exception {
		
		meetingDAO.updateMeetingParticipationWithdrawStatus(participationNo);
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
		
		List<MeetingParticipation> meetingParticipationList = getMeetingParticipationList(postNo);
		
		for(int i = 0; i < meetingParticipationList.size(); i ++) {
			
			MeetingParticipation meetingParticipation = meetingParticipationList.get(i);
			int participationNo = meetingParticipation.getParticipationNo();
			
			meetingDAO.updateMeetingParticipationWithdrawStatus(participationNo);
			
		}
	}
	
	public void updateMeetingPostCertifiedStatus(int postNo) throws Exception {
		
		meetingDAO.updateMeetingPostCertifiedStatus(postNo);
	}
	
	public List<MeetingPost> getUnCertifiedMeetingPost(int userNo) throws Exception {
		return meetingDAO.getUnCertifiedMeetingPost(userNo);
	}

}
