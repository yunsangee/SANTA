package site.dearmysanta.domain.user;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;
import site.dearmysanta.domain.common.Post;

@Getter
@Setter
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper=true)

public class Schedule extends Post {

	private String mountainName;
	private int hikingDifficulty;
	private String hikingTotalTime;
	private String hikingDescentTime;
	private String hikingAscentTime;
	private int Transportaion;
	private Date scheduleDate;
	
}
