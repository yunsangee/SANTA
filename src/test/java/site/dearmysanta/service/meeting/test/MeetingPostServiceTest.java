package site.dearmysanta.service.meeting.test;

import java.time.LocalDate;

import java.util.Date;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import site.dearmysanta.SantaApplication;
import site.dearmysanta.SantaApplicationTests;
import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.service.meeting.MeetingDAO;
import site.dearmysanta.service.meeting.MeetingService;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SantaApplication.class)
//@RunWith(SpringRunner.class)
//@SpringBootTest(classes = MeetingPostServiceTest.class)
public class MeetingPostServiceTest {
	
	@Autowired
	@Qualifier("MeetingService")
	private MeetingService meetingService;
	
//	@Test
	public void testAddMeetingPost() throws Exception {
		
		MeetingPost meetingPost = MeetingPost.builder()
				.userNo(1)
                .nickName("testUser")
                .profileImage("profileImagePath.jpg")
                .title("Hiking Meeting")
                .contents("Let's hike together!")
                .meetingName("Weekend Hike")
                .recruitmentDeadline(java.sql.Date.valueOf(LocalDate.of(2024, 6, 30)))
                .appointedDeparture("Central Park Entrance")
                .appointedHikingMountain("Mountain XYZ")
                .appointedHikingDate(java.sql.Date.valueOf(LocalDate.of(2024, 7, 5)))
                .maximumPersonnel(10)
                .participationGrade(1)
                .participationGender(0)
                .participationAge("20-30")
                .build();
		
		meetingPost.setPostNo(2);
		
		meetingService.addMeetingPost(meetingPost);
		
		MeetingPost post1 = meetingService.getMeetingPost(meetingPost.getPostNo());
		
		SantaLogger.makeLog("info", post1.toString());
		
		
	}
	
//	@Test
	public void testUpdateMeetingPost() throws Exception {
		
		MeetingPost meetingPost = meetingService.getMeetingPost(2);
		
		SantaLogger.makeLog("info", meetingPost.toString());
		
		meetingPost.setContents("Hiking is Shit");
		meetingService.updateMeetingPost(meetingPost);
		
		SantaLogger.makeLog("info", meetingPost.toString());		
		
	}
	
}
