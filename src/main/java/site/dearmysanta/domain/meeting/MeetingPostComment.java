package site.dearmysanta.domain.meeting;

import java.util.Date;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.ToString;

@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MeetingPostComment {
	private int meetingPostNo; // unique meeting post identifier
	private int meetingPostCommentNo; // unique meeting post comment identifier
	private String meetingPostCommentContents; // Content of the comment on the meeting post
	private Date meetingPostCommentCreationDate; // Date the comment was created
	private int userNo; // unique user identifier
	private String nickname; // user nickname
	private String profileImage; // user profile image

}
