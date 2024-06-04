package site.dearmysanta.service.certification;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.common.Like;

@Mapper
@Component("CertificationPostDao")
public interface CertificationPostDao {

	
	public void addCertificationPost(CertificationPost certificationPost) throws Exception;

	public CertificationPost getCertificationPost(int certificationPostNo) throws Exception;

	public void updateCertificationPost(CertificationPost certificationPost) throws Exception;
	
	//hashtag
		
//	public void addCertificationPostHashtags(int certificationPostNo) throws Exception;
	
	public	 void deleteCertificationPostHashtags(int certificationPostNo) throws Exception;
	public void addCertificationPostHashtags(int postNo, String hashtag);
	
	//postImage
	
	//Like
	public void addCertificationPostLike(Like like);
	
	public void deleteCertificationPostLike(Like like);
	
	public int getTotalCertificationPostLikeCount(Like like);
	
	public List<CertificationPost> getCertificationPostLikeList(Like like);


}



