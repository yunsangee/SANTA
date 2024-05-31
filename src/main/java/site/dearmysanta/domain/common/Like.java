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
	private int postNo; // unique post identifier (�씤利� 寃뚯떆湲�, 紐⑥엫 寃뚯떆湲� )
	private int postLikeType; // unique post type( 0: �씤利�, 1: 紐⑥엫,  2�궛)
	private Date likeDate; // like upload time
	
}// common like class
