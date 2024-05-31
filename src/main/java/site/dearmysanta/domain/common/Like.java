package site.dearmysanta.domain.common;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.Builder;

//@Data // @Getter + @Setter + @ToString + @EqualsAndHashCode + @RequiredArgsContstructor

@Getter
@Setter
@Builder // use Builder pattern
@NoArgsConstructor
@AllArgsConstructor
public class Like {
	private int userNo; // unique user identifier
	private int postNo; // unique post identifier (인증 게시글, 모임 게시글 )
	private int postLikeType; // unique post type( 0: 인증, 1: 모임,  2산)
	private Date likeDate; // like upload time
	
}// common like class
