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
public class MeetingParticipation {
	private int userNo;
	private MultipartFile profileImage;
	private String nickname;
	private int participationStatus;
	private Date chattingRoomExitTime;
	private int participationRole;
	private int withdrawFlag;

}
