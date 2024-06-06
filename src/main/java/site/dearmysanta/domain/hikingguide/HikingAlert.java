package site.dearmysanta.domain.hikingguide;

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
	private int hikingAlertFlag; // alert flag
	private int destinationAlert; // destination alert flag
	private int sunsetAlert; // sunset alert flag
	private int locationOverAlert; // location over alert flag
	private int meetingTimeAlert; // meeting time alert flag
	private String meetingTime; // set meeting time
	
}
