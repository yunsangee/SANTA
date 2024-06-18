package site.dearmysanta.domain.user;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

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
	private int Transportation;
	private Date scheduleDate;
	private String stringDate;
	
	public void setScheduleDate(String date) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date parsedDate = sdf.parse(date);

        // java.util.Date를 java.sql.Date로 변환
        Date sqlDate = new Date(parsedDate.getTime());
        this.scheduleDate = sqlDate;
	}
	
}
