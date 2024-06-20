package site.dearmysanta.domain.certificationPost;
import java.util.Date;
import java.util.List;


import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

@SuperBuilder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class CertificationPostComment {

	private int userNo;
	private String nickname;
	private String profileImage; //??
	
	private int certificationPostNo;
	private int certificationPostCommentNo;
	private String certificationPostCommentContents;
	private Date certificationPostCommentCreationDate;
	//private int PostTypeNo;

}
