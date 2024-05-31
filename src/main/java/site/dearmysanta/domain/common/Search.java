package site.dearmysanta.domain.common;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

//@Data // @Getter + @Setter + @ToString + @EqualsAndHashCode + @RequiredArgsContstructor

@Getter
@Setter
@SuperBuilder // use Builder pattern
@NoArgsConstructor
@AllArgsConstructor
public class Search {
	private int userNo;
	private int searchCondition;
	private String searchKeyword;
	private Date searchDate;

}// search super class(모든 검색의 상위 클래스)
