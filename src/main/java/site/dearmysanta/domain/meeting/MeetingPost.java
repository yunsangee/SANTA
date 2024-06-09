package site.dearmysanta.domain.meeting;

import site.dearmysanta.domain.common.Post;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.experimental.SuperBuilder;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.ToString;

@SuperBuilder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper=true)
public class MeetingPost extends Post{
//	private List<MultipartFile> meetingPostImage;
	private int meetingPostImage;
//	private int meetingPostImagecount; // the post images
	private String meetingName; // name of meeting
	private Date recruitmentDeadline; // date for the recruitment deadline
    private String appointedDeparture; // expected departure location
    private String appointedHikingMountain; // expected hiking mountain
    private Date appointedHikingDate; // expected hiking date
    private String participationAge; // Preferred age range of participants
    private int maximumPersonnel; // maximum number of participants
    private int participationGrade; // grade restriction for users
    private int participationGender; // gender restriction
    private int recruitmentStatus; // indicates whether the meeting is recruiting, recruitment is closed, or the meeting has ended
    private int meetingPostDeletedFlag; // Flag to check if the post is deleted
    private int meetingPostCertifiedFlag; // Flag to check if a certification post for the meeting is completed
    
    private int meetingPostLikeCount; // total number of likes on the post
    private int meetingPostCommentCount; // total number of comments on the post

}


