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
	
	private int userNo; //
	private int hikingAlerFlag; //
	private String destinationAlert; //
	private String sunsetAlert; //
	private String locationOverAlert; //
	private String meetingTimeAlert; //
	private String meetingTime; //
	private String alertContent; //
	private String allAlert; //
	
}
