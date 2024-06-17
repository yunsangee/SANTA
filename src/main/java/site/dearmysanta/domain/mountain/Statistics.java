package site.dearmysanta.domain.mountain;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Builder // use Builder pattern
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Statistics {
	private String mountainName;
	private int searchCount;
	private int postCount;
	Date searchDate;
}
