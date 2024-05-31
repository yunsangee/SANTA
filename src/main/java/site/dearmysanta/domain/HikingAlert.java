package site.dearmysanta.domain;

import java.sql.Date;
import java.util.List;

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

public class HikingAlert {
	
	private int userNo; //회원식별번호
	private int hikingAlerFlag; //알림번호플래그
	private String destinationAlert; //목적지거리알림
	private String sunsetAlert; //일몰알림
	private String locationOverAlert; //위치이탈알림
	private String meetingTimeAlert; //모임시간알림
	private String meetingTime; //모임시간
	private String alertContent; //알림내용
	private String allAlert; //전체알림
	
}
