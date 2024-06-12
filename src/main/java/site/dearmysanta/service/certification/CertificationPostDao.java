package site.dearmysanta.service.certification;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;


import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.certificationPost.CertificationPostComment;

import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.common.Search;




@Mapper
@Component("CertificationPostDao")
public interface CertificationPostDao {

	//post
	public void addCertificationPost(CertificationPost certificationPost) ;

	public CertificationPost getCertificationPost(int postNo) throws Exception;

	public void updateCertificationPost(CertificationPost certificationPost) throws Exception;
	
	public void updateCertificationPostDeleteFlag(int postNo) throws Exception; //ªË¡¶
	
	public List<CertificationPost> getCertificationPostList(Search search) throws Exception;
	
	public List<CertificationPost> getMyCertificationPostList(int usrNo) throws Exception;
	
	
	//hashtag
	public void addHashtag(CertificationPost certificationPost);
	
	public	 void deleteHashtag(int HashtagNo) throws Exception;
	
	public List<String> getHashtag(int postNo) throws Exception;
	
	
	
	//Like
	public void addCertificationPostLike(Like like);
	
	public void deleteCertificationPostLike(Like like);
	
	public void updateLikeCount(Like like);
	
	public int getCertificationPostLikeCount(int postNo);
	
	public List<CertificationPost> getCertificationPostLikeList(int userNo);

	
	//Comment
	public void addCertificationPostComment(CertificationPostComment certificationPostComment) throws Exception;

	public void deleteCertificationPostComment(int certificationPostCommentNo) throws Exception;
	
	public List<CertificationPostComment> getCertificationPostCommentList(int postNo) throws Exception;

	public int getTotalMountainCount(String certificationPostMountainName);


}


