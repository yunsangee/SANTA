package site.dearmysanta.domain.mountain;
//@Data // @Getter + @Setter + @ToString + @EqualsAndHashCode + @RequiredArgsContstructor

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import site.dearmysanta.domain.common.Search;

@Getter
@Setter
@SuperBuilder // use Builder pattern
@NoArgsConstructor
@AllArgsConstructor
public class mountainSearch extends Search{
	private List<String> searchRecord; // search record list
	private List<String> popularSearchKeyword; // popular search keyword list 
	
	// detail search condition
	private String locationCategory; // location information. can chage to json
	private int altitudeNo; // altitude range information
	private int difficultyNo; // mountain trail difficulty information
	
	
}// mountain search class (Search 하위 클래스)
