package site.dearmysanta.domain.user;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString

public class User {
	
	private int userNo;
	private String userId;
	private String userName;
	private String userPassword;
	private String checkPassword;
	private String nickName;
	private String address;
	private String detailaddress;
	private String birthDate;
	private String phoneNumber;
	private int gender;
	private String profileImage;
	private Date creationDate;
	private int hikingPurpose;
	private int hikingDifficulty;
	private int hikingLevel;
	private Date withdrawDate;
	private int withdrawReason;
	private String withdrawContent;
	private int role;
	private String badgeImage;
	private int certificationCount;
	private int meetingCount;
	//private List<String> surveyContent;
	private String verifyCode;
	private String passwordNew;
	private String introduceContent;
	private int searchRecordFlag;
	private int allAlertSetting;
	private int certificationPostAlertSetting;
	private int meetingPostAlertSetting;
	private int hikingGuideAlertSetting;
	private int timeAlertSetting;
	private int locationOverSetting;
	private int destinationOverSetting;
	private int sunsetAlertSetting;
	private String timeSetting;
	
}
