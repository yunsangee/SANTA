package site.dearmysanta.domain.common;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.Builder;

//@Data // @Getter + @Setter + @ToString + @EqualsAndHashCode + @RequiredArgsContstructor

@Getter
@Setter
@Builder // use Builder pattern
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Like {
	private int userNo; // unique user identifier
	private int postNo; // unique post identifier
	private int postLikeType; // unique post type
	private Date likeDate; // like upload time
	
}// common like class
