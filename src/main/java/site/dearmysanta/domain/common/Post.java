package site.dearmysanta.domain.common;

import java.sql.Date;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;


//@Data // @Getter + @Setter + @ToString + @EqualsAndHashCode + @RequiredArgsContstructor

@Getter
@Setter
@SuperBuilder // use Builder pattern
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Post {
	
	private int userNo; // unique user identifier
	private String nickName; // unique user nickname
	private String profileImage; // object storage url
	
	private int postNo; // unique post identifier
	private String title; // post tile
	private String contents; // post contents
	
	private Date postDate; // post upload time
	
}// post super class (모든 게시글의 상위 클래스)
