package site.dearmysanta.service.certification;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.certificationPost.CertificationPostComment;
import site.dearmysanta.domain.common.Like;


@Mapper
@Component("CertificationPostDao")
public interface CertificationPostDao {

	//post
	public void addCertificationPost(CertificationPost certificationPost) ;

	public CertificationPost getCertificationPost(int postNo) throws Exception;

	public void updateCertificationPost(CertificationPost certificationPost) throws Exception;
	
	//hashtag
		
	//public void addCertificationPostHashtags(CertificationPost certificationPost) throws Exception;
	
	public	 void deleteCertificationPostHashtags(int HashtagNo) throws Exception;

	public void addHashTag(int postNo, String certificationPostHashtagContents);
	
	
	
	//Like
	public void addCertificationPostLike(Like like);
	
	public void deleteCertificationPostLike(Like like);
	
	public int getCertificationPostLikeCount(int postNo);
	
	public List<CertificationPost> getCertificationPostLikeList(Like like);

	
	//Comment
	
	public void addCertificationPostComment(CertificationPostComment certificationPostComment) throws Exception;

	public void deleteCertificationPostComment(CertificationPostComment certificationPostComment) throws Exception;
	
	public CertificationPostComment getCertificationPostComment(int postNo) throws Exception;

}



