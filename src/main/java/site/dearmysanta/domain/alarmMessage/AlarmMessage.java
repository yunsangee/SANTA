package site.dearmysanta.domain.alarmMessage;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;
import site.dearmysanta.domain.user.User;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString

public class AlarmMessage {
	private int alarmNo;
	private int userNo;
	private String userName;
	private String title;
	
	private int alarmTypeNo; //0: like 1: comment
	private int postTypeNo; // 0: certification 1: meeting
	
	private int checkedFlag;

	private String message;
}
