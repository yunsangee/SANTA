package site.dearmysanta.service.domain.hikingguide;

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
	
	private int userNo; // user Number
	private int hikingAlerFlag; // alert flag
	private String destinationAlert; // destination alert flag
	private String sunsetAlert; // sunset alert flag
	private String locationOverAlert; // location over alert flag
	private String meetingTimeAlert; // meeting time alert flag
	private String meetingTime; // set meeting time
	private String alertContent; // alert content 
	private String allAlert; // all alert flag
	
}
