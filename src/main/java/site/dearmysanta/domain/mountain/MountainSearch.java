package site.dearmysanta.domain.mountain;
//@Data // @Getter + @Setter + @ToString + @EqualsAndHashCode + @RequiredArgsContstructor

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;
import site.dearmysanta.domain.common.Search;

@Getter
@Setter
@SuperBuilder // use Builder pattern
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper=true)
public class MountainSearch extends Search{
	private List<String> searchRecord; // search record list
	private List<String> popularSearchKeyword; // popular search keyword list 
	
	// detail search condition
	private int locationNo; // location information. can chage to json
	private int altitudeNo; // altitude range information
	private int difficultyNo; // mountain trail difficulty information
	
	
}// mountain search class 
