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
	
	private int userNo; // unique user identifier
	private String profileImage; // user profile Image
	private String nickname; // user nickname
	private int participationStatus; // indicates whether the user has applied or is registered
	private int participationRole; // Indicates whether the user is a group leader or a regular member
	private int withdrawFlag; // indicates whether the participant has withdrawn

}
