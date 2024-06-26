package site.dearmysanta.service.meeting.test;

import java.io.File;
import java.io.FileInputStream;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.mock.web.MockMultipartFile;

import site.dearmysanta.SantaApplication;
import site.dearmysanta.SantaApplicationTests;
import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.meeting.MeetingParticipation;
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.domain.meeting.MeetingPostComment;
import site.dearmysanta.service.meeting.MeetingDAO;
import site.dearmysanta.service.meeting.MeetingService;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SantaApplication.class)
//@RunWith(SpringRunner.class)
//@SpringBootTest(classes = MeetingPostServiceTest.class)
public class MeetingPostServiceTest {
	
	@Autowired
	@Qualifier("meetingService")
	private MeetingService meetingService;
	
	@Autowired
	@Qualifier("meetingDAO")
	private MeetingDAO meetingDAO;
	
//	@Test
	public void testAddMeetingPost() throws Exception {
		
		File file1 = new File("C:\\Users\\jaeho\\Desktop\\dang.jpeg");
        File file2 = new File("C:\\Users\\jaeho\\Desktop\\dangdang.jpeg");

        MultipartFile multipartFile1 = new MockMultipartFile("file1", file1.getName(), "image/jpeg", new FileInputStream(file1));
        MultipartFile multipartFile2 = new MockMultipartFile("file2", file2.getName(), "image/jpeg", new FileInputStream(file2));
		
		MeetingPost meetingPost = MeetingPost.builder()
				.userNo(1)
                .nickName("testUser")
                .profileImage("profileImagePath.jpg")
                .title("Hiking Meeting")
                .contents("Let's hike together!")
                .meetingName("Weekend Hike")
                .recruitmentDeadline(java.sql.Date.valueOf(LocalDate.of(2024, 6, 30)))
                .appointedDeparture("Central Park Entrance")
                .appointedDetailDeparture("gogogogogoGoGOGO")
                .appointedHikingMountain("Mountain XYZ")
                .appointedHikingDate(java.sql.Date.valueOf(LocalDate.of(2024, 7, 5)))
                .maximumPersonnel(10)
                .participationGrade(1)
                .participationGender(0)
                .participationAge("20-30")
                .meetingPostImage(Arrays.asList(multipartFile1, multipartFile2))
                .build();
		
		meetingService.addMeetingPost(meetingPost);
		
		MeetingPost post1 = meetingService.getMeetingPost(12);
		SantaLogger.makeLog("info", post1.toString());

		List<MeetingParticipation> meetingParticipationList1 = meetingService.getMeetingParticipationList(12);
		SantaLogger.makeLog("info", "meeting participation list size: " + meetingParticipationList1.size());
		
		for(int i = 0; i < meetingParticipationList1.size(); i ++) {
			SantaLogger.makeLog("info", meetingParticipationList1.get(i).toString());
		}
		
	}
	
//	@Test
	public void testGetMeetingPostAll() throws Exception {
		
		Map<String, Object> meetingPostAll = meetingService.getMeetingPostAll(3, 1);
		
		System.out.println(meetingPostAll.get("meetingPost"));
		System.out.println(meetingPostAll.get("meetingParticipations"));
		System.out.println(meetingPostAll.get("meetingPostComments"));
		System.out.println(meetingPostAll.get("meetingPostImages"));
		
		SantaLogger.makeLog("info", meetingPostAll.toString());
		
	}
	
//	@Test
	public void testUpdateMeetingPost() throws Exception {
		
		List<String> imageURL = new ArrayList<>();
		
		MeetingPost meetingPost = meetingService.getMeetingPost(2);
		
		SantaLogger.makeLog("info", meetingPost.toString());
		
		meetingPost.setContents("Hiking is Shit");
		meetingService.updateMeetingPost(meetingPost, imageURL);
		
		SantaLogger.makeLog("info", meetingPost.toString());		
		
	}
	
//	@Test
	public void testAddMeetingPostLike() throws Exception {
		
		Like like = Like.builder()
				.userNo(5)
				.postNo(1)
                .build();
		
		
		
		int likeCount1 = meetingDAO.getMeetingPostLikeCount(1);
		SantaLogger.makeLog("info", String.valueOf(likeCount1));
		
		meetingService.addMeetingPostLike(like);
		
		int likeCount2 = meetingDAO.getMeetingPostLikeCount(1);
		SantaLogger.makeLog("info", String.valueOf(likeCount1));
		
	}
	
//	@Test
	public void testDeleteMeeingPostLike() throws Exception {
		
		Like like = Like.builder()
				.userNo(5)
				.postNo(1)
                .build();
		
		int likeCount1 = meetingDAO.getMeetingPostLikeCount(1);
		SantaLogger.makeLog("info", String.valueOf(likeCount1));
		
		meetingService.deleteMeetingPostLike(like);
		
		int likeCount2 = meetingDAO.getMeetingPostLikeCount(1);
		SantaLogger.makeLog("info", String.valueOf(likeCount2));
		
	}
	
//	@Test
	public void testAddMeetingPostComment() throws Exception {
		
		MeetingPostComment meetingPostComment = MeetingPostComment.builder()
				.meetingPostNo(1)
				.meetingPostCommentContents("차라리 등산을 하고싶다.")
				.userNo(1)
				.nickname("testUser")
				.profileImage("profileImagePath.jpg")
				.build();
		
		int commentCount1 = meetingDAO.getMeetingPostCommentCount(1);
		SantaLogger.makeLog("info", String.valueOf(commentCount1));
		
		meetingService.addMeetingPostComment(meetingPostComment);
		
		int commentCount2 = meetingDAO.getMeetingPostCommentCount(1);
		SantaLogger.makeLog("info", String.valueOf(commentCount2));
				
		
	}
	
//	@Test
	public void testDeleteMeetingPostComment() throws Exception {
		
		MeetingPostComment meetingPostComment = MeetingPostComment.builder()
				.meetingPostNo(1)
				.meetingPostCommentContents("차라리 등산을 하고싶다.")
				.userNo(1)
				.nickname("testUser")
				.profileImage("profileImagePath.jpg")
				.build();
		
		int commentCount1 = meetingDAO.getMeetingPostCommentCount(1);
		SantaLogger.makeLog("info", String.valueOf(commentCount1));
		
//		meetingService.deleteMeetingPostComment(meetingPostCommentNo);
		
		int commentCount2 = meetingDAO.getMeetingPostCommentCount(1);
		SantaLogger.makeLog("info", String.valueOf(commentCount2));
		
	}
	
	
//	@Test
	public void testGetMountainTotalCount() throws Exception {
		
		int mountainCount = meetingService.getMountainTotalCount("Mountain XYZ");
		SantaLogger.makeLog("info", String.valueOf(mountainCount));
		
	}
	

//	@Test
	public void testGetMeetingPostCommentList() throws Exception {
		
		List<MeetingParticipation> meetingPostCommentList = meetingService.getMeetingParticipationList(1);
		SantaLogger.makeLog("info", "meeting post comment list size: " + meetingPostCommentList.size());
		
		for(int i = 0; i < meetingPostCommentList.size(); i ++) {
			SantaLogger.makeLog("info", meetingPostCommentList.get(i).toString());
		}
		
	}
	

//	@Test
	public void testAddMeetingParticipation() throws Exception {
		
		MeetingParticipation meetingParticipation = MeetingParticipation.builder()
				.postNo(5)
				.userNo(5)
				.build();
				
        List<MeetingParticipation> meetingParticipationList1 = meetingService.getMeetingParticipationList(5);
        SantaLogger.makeLog("info", "meeting participation list size: " + meetingParticipationList1.size());
		
		for(int i = 0; i < meetingParticipationList1.size(); i ++) {
			SantaLogger.makeLog("info", meetingParticipationList1.get(i).toString());
		}
		
		meetingService.addMeetingParticipation(meetingParticipation);
		
		List<MeetingParticipation> meetingParticipationList2 = meetingService.getMeetingParticipationList(5);
        SantaLogger.makeLog("info", "meeting participation list size: " + meetingParticipationList2.size());
        
        for(int i = 0; i < meetingParticipationList2.size(); i ++) {
			SantaLogger.makeLog("info", meetingParticipationList2.get(i).toString());
		}
		
	}
	
//	@Test
	public void testDeleteMeetingParticipation() throws Exception {
	
		List<MeetingParticipation> meetingParticipationList1 = meetingService.getMeetingParticipationList(4);
	    SantaLogger.makeLog("info", "meeting participation list size: " + meetingParticipationList1.size());
		
	    for(int i = 0; i < meetingParticipationList1.size(); i ++) {
			SantaLogger.makeLog("info", meetingParticipationList1.get(i).toString());
		}
	    
	    meetingService.deleteMeetingParticipation(meetingParticipationList1.get(0));
	    
	    List<MeetingParticipation> meetingParticipationList2 = meetingService.getMeetingParticipationList(4);
	    SantaLogger.makeLog("info", "meeting participation list size: " + meetingParticipationList2.size());
	    
	    for(int i = 0; i < meetingParticipationList2.size(); i ++) {
			SantaLogger.makeLog("info", meetingParticipationList2.get(i).toString());
		}
	
	}
	
//	@Test
	public void testUpdateMeetingParticipationStatus() throws Exception {
	
		List<MeetingParticipation> meetingParticipationList1 = meetingService.getMeetingParticipationList(1);
	    SantaLogger.makeLog("info", "meeting participation list size: " + meetingParticipationList1.size());
		
	    for(int i = 0; i < meetingParticipationList1.size(); i ++) {
			SantaLogger.makeLog("info", meetingParticipationList1.get(i).toString());
		}
	    
	    meetingService.updateMeetingParticipationStatus(2);
	    
	    List<MeetingParticipation> meetingParticipationList2 = meetingService.getMeetingParticipationList(1);
	    SantaLogger.makeLog("info", "meeting participation list size: " + meetingParticipationList2.size());
	    
	    for(int i = 0; i < meetingParticipationList2.size(); i ++) {
			SantaLogger.makeLog("info", meetingParticipationList2.get(i).toString());
		}
	
	}
	
//	@Test
	public void testUpdateMeetingParticipationWithdrawStatus() throws Exception {
	
		List<MeetingParticipation> meetingParticipationList1 = meetingService.getMeetingParticipationList(1);
	    SantaLogger.makeLog("info", "meeting participation list size: " + meetingParticipationList1.size());
		
	    for(int i = 0; i < meetingParticipationList1.size(); i ++) {
			SantaLogger.makeLog("info", meetingParticipationList1.get(i).toString());
		}
	    
	    meetingService.updateMeetingParticipationWithdrawStatus(2, 4);
	    
	    List<MeetingParticipation> meetingParticipationList2 = meetingService.getMeetingParticipationList(1);
	    SantaLogger.makeLog("info", "meeting participation list size: " + meetingParticipationList2.size());
	    
	    for(int i = 0; i < meetingParticipationList2.size(); i ++) {
	    	
			SantaLogger.makeLog("info", meetingParticipationList2.get(i).toString());
		}
	
	}
	
//	@Test
	public void testUpdateMeetingPostRecruitmentStatus() throws Exception {
	
		MeetingPost meetingPost1 = meetingService.getMeetingPost(1);
		SantaLogger.makeLog("info", String.valueOf(meetingPost1.getRecruitmentStatus()));
		
		meetingService.updateMeetingPostRecruitmentStatus(meetingPost1);
		
		MeetingPost meetingPost2 = meetingService.getMeetingPost(1);
		SantaLogger.makeLog("info", String.valueOf(meetingPost2.getRecruitmentStatus()));
	
	}
	
//	@Test
	public void testUpdateMeetingPostRecruitmentStatusToEnd() throws Exception {
	
		MeetingPost meetingPost1 = meetingService.getMeetingPost(1);
		SantaLogger.makeLog("info", String.valueOf(meetingPost1.getRecruitmentStatus()));
		
		meetingService.updateMeetingPostRecruitmentStatusToEnd(1);
		
		MeetingPost meetingPost2 = meetingService.getMeetingPost(1);
		SantaLogger.makeLog("info", String.valueOf(meetingPost2.getRecruitmentStatus()));
	
	}
	
//	@Test
	public void testUpdateMeetingPostDeletedStatus() throws Exception {
	
		MeetingPost meetingPost1 = meetingService.getMeetingPost(2);
		SantaLogger.makeLog("info", String.valueOf(meetingPost1.getMeetingPostDeletedFlag()));
		
		meetingService.updateMeetingPostDeletedStatus(2);
		
		MeetingPost meetingPost2 = meetingService.getMeetingPost(2);
		SantaLogger.makeLog("info", String.valueOf(meetingPost2.getMeetingPostDeletedFlag()));
		
		List<MeetingParticipation> meetingParticipationList1 = meetingService.getMeetingParticipationList(2);
		
		for(int i = 0; i < meetingParticipationList1.size(); i ++) {
			SantaLogger.makeLog("info", meetingParticipationList1.get(i).toString());
		}
	
	}
	
//	@Test
	public void testUpdateMeetingPostCertifiedStatus() throws Exception {
	
		MeetingPost meetingPost1 = meetingService.getMeetingPost(1);
		SantaLogger.makeLog("info", String.valueOf(meetingPost1.getMeetingPostCertifiedFlag()));
		
		meetingService.updateMeetingPostCertifiedStatus(1);
		
		MeetingPost meetingPost2 = meetingService.getMeetingPost(1);
		SantaLogger.makeLog("info", String.valueOf(meetingPost2.getMeetingPostCertifiedFlag()));
	
	}
	
//	@Test
	public void testGetUnCertifiedMeetingPost() throws Exception {
		
		int userNo = 1;
		
		List<MeetingPost> meetingPostList1 = meetingService.getUnCertifiedMeetingPost(1);
		SantaLogger.makeLog("info", "meeting post list size: " + meetingPostList1.size());
	
		for(int i = 0; i < meetingPostList1.size(); i ++) {
			SantaLogger.makeLog("info", meetingPostList1.get(i).toString());
		}
	
	}
	
	

}
