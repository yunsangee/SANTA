package site.dearmysanta.service.domain.user;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@ToString

public class User {
	
	private int userNo;
	private String userId;
	private String userName;
	private String userPassword;
	private String nickName;
	private String address;
	private String birthDate;
	private String phoneNumber;
	private int gender;
	private MultipartFile profileImage;
	private Date creationDate;
	private String hikingPurpose;
	private String hikingDifficulty;
	private String hikingLevel;
	private Date withdrawDate;
	private List<String> withdrawReason;
	private String withdrawContent;
	private int role;
	private MultipartFile badgeImage;
	private int certificationCount;
	private int meetingCount;
	private List<String> surveyContent;
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
