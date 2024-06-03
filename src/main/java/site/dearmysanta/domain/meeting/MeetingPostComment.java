package site.dearmysanta.domain.meeting;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

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
	private int meetingPostNo;
	private int meetingPostCommentNo;
	private String meetingPostCommentContent;
	private Date meetingPostCommentCreationDate;
	private int userNo;
	private String nickName;
	private MultipartFile profileImage;

}
