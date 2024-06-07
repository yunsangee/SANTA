package site.dearmysanta.domain.certificationPost;

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
public class CertificationPostSearch extends Search {

	private int certificationPostListSearchCondition;
}
