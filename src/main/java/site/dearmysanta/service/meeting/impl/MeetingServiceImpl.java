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
	
	public void addMeetingPost(MeetingPost meetingPost) throws Exception {
		
		int userNo = meetingPost.getUserNo();
		String appointedDetailDeparture = meetingPost.getAppointedDetailDeparture();		
		String appointedDeparture = meetingPost.getAppointedDeparture()+ "/" +appointedDetailDeparture;
		
		meetingPost.setAppointedDeparture(appointedDeparture);
		
		if (meetingPost.getMeetingPostImage() != null && !meetingPost.getMeetingPostImage().isEmpty()) {
            
            meetingPost.setMeetingPostImageCount(meetingPost.getMeetingPostImage().size());
        }
		
		meetingDAO.insertMeetingPost(meetingPost);
		
		int postNo = meetingPost.getPostNo();
		
		if (meetingPost.getMeetingPostImage() != null && !meetingPost.getMeetingPostImage().isEmpty()) {
			
            List<MultipartFile> images = meetingPost.getMeetingPostImage();
            int imageCount = images.size();
            
            for (int i = 0; i < imageCount; i++) {
            	
                MultipartFile image = images.get(i);
                String fileName = postNo+ "_" +i;
                
                System.out.println(fileName);
                
                objectStorageService.uploadFile(image, fileName);
            }
        }
		
		int participationPostNo = meetingPost.getPostNo(); 
		
		MeetingParticipation meetingParticipation = new MeetingParticipation();
		meetingParticipation.setParticipationStatus(1);
		meetingParticipation.setParticipationRole(0);
		meetingParticipation.setUserNo(userNo);
		meetingParticipation.setPostNo(participationPostNo);
		
		meetingDAO.insertMeetingParticipation(meetingParticipation);
		
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
	
	public Map<String, Object> getMeetingPostAll(int postNo) throws Exception {
		
		MeetingPost meetingPost = meetingDAO.findMeetingPost(postNo);
		
		String[] AppointedDeparture = meetingPost.getAppointedDeparture().split("/", 2);
		meetingPost.setAppointedDeparture(AppointedDeparture[0]);
		
		if(AppointedDeparture.length > 1) {
			meetingPost.setAppointedDetailDeparture(AppointedDeparture[1]);
		}
		
		int likeCount = meetingDAO.getMeetingPostLikeCount(postNo);
		int commentCount = meetingDAO.getMeetingPostCommentCount(postNo);
		
		meetingPost.setMeetingPostLikeCount(likeCount);
		meetingPost.setMeetingPostCommentCount(commentCount);
		
		List<MeetingParticipation> meetingParticipations = meetingDAO.getMeetingParticipationList(postNo);
		List<MeetingPostComment> meetingPostComments = meetingDAO.getMeetingPostCommentList(postNo);
		
		
		List<MultipartFile> meetingPostImages = new ArrayList<>();
        int imageCount = meetingPost.getMeetingPostImageCount();
        
        for (int i = 0; i < imageCount; i++) {
            String fileName = postNo + "_" + i;
            MultipartFile downloadedImage = downloadMeetingPostImage(String.valueOf(postNo), fileName);
            meetingPostImages.add(downloadedImage);
        }
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("meetingPost", meetingPost);
		map.put("meetingParticipations", meetingParticipations);
		map.put("meetingPostComments", meetingPostComments);
		map.put("meetingPostImages", meetingPostImages);
		
		return map;
	}
	
	public MeetingPost getMeetingPost(int postNo) throws Exception {
		
		MeetingPost meetingPost = meetingDAO.findMeetingPost(postNo);
		
		String[] AppointedDeparture = meetingPost.getAppointedDeparture().split("/", 2);
		meetingPost.setAppointedDeparture(AppointedDeparture[0]);

		if(AppointedDeparture.length > 1) {
			meetingPost.setAppointedDetailDeparture(AppointedDeparture[1]);
		}
		
		return meetingPost;
	}
	
	public void addMeetingPostLike(Like like) throws Exception {
		
		meetingDAO.insertMeetingPostLike(like);
	}
	// 얘네 updateMeetingPostLikeStatus 하나로 되겠다..
	
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
		
		List<MeetingParticipation> meetingParticipations = getMeetingParticipationList(postNo);
		
		for(int i = 0; i < meetingParticipations.size(); i ++) {
			
			MeetingParticipation meetingParticipation = meetingParticipations.get(i);
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
	
	public void uploadMeetingPostImages(List<MultipartFile> images, String postNo) throws Exception {
        for (MultipartFile image : images) {
            String fileName = postNo + "_" + image.getOriginalFilename();
            objectStorageService.uploadFile(image, fileName);
        }
    }

	
    public MultipartFile downloadMeetingPostImage(String postNo, String fileName) throws Exception {
        String fullFileName = postNo + "_" + fileName;
        return objectStorageService.downloadFile(bucketName, fullFileName);
    }


}
