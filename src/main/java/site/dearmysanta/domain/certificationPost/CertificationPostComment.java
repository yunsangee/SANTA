package site.dearmysanta.domain.certificationPost;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.ToString;

@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class CertificationPostComment {

	private int userNo;
	private String nickName;
	private String profileImage;
	
	private int certificationPostNo;
	private int certificationCommentNo;
	private String certificationPostCommentContent;
	private Date certificationPostCommentCreationDate;

}
