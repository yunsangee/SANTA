package site.dearmysanta.service.domain.user;

import java.util.List;

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

public class QNA extends Post {
	
	private String adminAnswer;
	private List<String> qnaPostCategory;
	private String answerState;

}
