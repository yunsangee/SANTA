package site.dearmysanta.domain.correctionPost;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import lombok.AllArgsConstructor;

import site.dearmysanta.domain.common.Post;

//@Data // @Getter + @Setter + @ToString + @EqualsAndHashCode + @RequiredArgsContstructor

@Getter
@Setter
@SuperBuilder // use Builder pattern
@NoArgsConstructor
@AllArgsConstructor

public class CorrectionPost extends Post {
	private int mountainNo; // unique mountain identifier
	private String mountainName; // mountain name
	private int status; // answer status

}// correction post(Post 하위 클래스)
