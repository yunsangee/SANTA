package site.dearmysanta.service.meeting.test;

import java.util.ArrayList;
import java.util.Date;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Test;
import org.junit.jupiter.api.Assertions;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.service.meeting.MeetingDAO;
import site.dearmysanta.service.meeting.MeetingService;

//@RunWith(SpringRunner.class)
//@SpringBootTest(classes = SantaApplication.class)
@RunWith(SpringRunner.class)
@SpringBootTest(classes = MeetingPostServiceTest.class)
public class MeetingPostServiceTest {
	
	private static final Logger logger = LogManager.getLogger(MeetingPostServiceTest.class);
	
	@Autowired
	@Qualifier("MeetingService")
	private MeetingService meetingService;
	
	@Autowired
	@Qualifier("MeetingDAO")
	private MeetingDAO meetingDAO;
	
	@Test
	public void testAddMeetingPost() throws Exception {

		logger.info("=============================================\n");
		
		
		MeetingPost meetingPost = MeetingPost.builder()
				.meetingPostImage(new ArrayList<>()) // Post images
			    .meetingName("Meeting Name") // Name of meeting
			    .recruitmentDeadline(new Date()) // Recruitment deadline
			    .appointedDeparture("Departure Location") // Expected departure location
			    .appointedHikingMountain("Hiking Mountain") // Expected hiking mountain
			    .appointedHikingDate(new Date()) // Expected hiking date
			    .participationAge("Preferred Age Range") // Preferred age range of participants
			    .maximumPersonnel(10) // Maximum number of participants
			    .participationGrade(1) // Grade restriction for users
			    .participationGender(1) // Gender restriction
			    .recruitmentStatus(1) // Recruitment status
			    .meetingPostDeletedFlag(0) // Flag to check if the post is deleted
			    .meetingPostCertifiedFlag(0) // Flag to check if a certification post for the meeting is completed
			    .meetingPostLikeCount(0) // Total number of likes on the post
			    .meetingPostCommentCount(0) // Total number of comments on the post
			    .build(); // Build MeetingPost object
		
		meetingService.addMeetingPost(meetingPost);
		
		
		Assertions.assertEquals(1, meetingService.addMeetingPost(meetingPost));
		
		System.out.println(meetingPost.toString());
		logger.info("meetingPost:" + meetingPost.toString() + "\n"); // realization test
		
	}
	
	

}
