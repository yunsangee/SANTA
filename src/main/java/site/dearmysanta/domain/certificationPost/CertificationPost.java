package site.dearmysanta.domain.certificationPost;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;
import lombok.AllArgsConstructor;

import site.dearmysanta.domain.common.Post;
import site.dearmysanta.domain.correctionPost.CorrectionPost;

@Getter
@Setter
@SuperBuilder // use Builder pattern
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper=true)
public class CertificationPost extends Post {
	
	private String certificationPostMountainName;

}
