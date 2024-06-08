package site.dearmysanta.service.certification;

import java.util.List;

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
	
//	public List<CertificationPost> getCertificationPostList() throws Exception;
	public List<CertificationPost> getCertificationPostList(Search search) throws Exception;
	
	public List<CertificationPost> getMyCertificationPostList(int usrNo) throws Exception;
	
	
	//hashtag
	public void addHashtag(CertificationPost certificationPost);
	
	public	 void deleteHashtag(int HashtagNo) throws Exception;
	
	public CertificationPost getHashtag(int postNo) throws Exception;
	
	
	
	//Like
	public void addCertificationPostLike(Like like);
	
	public void deleteCertificationPostLike(Like like);
	
	public void updateLikeCount(Like like);
	
	public int getCertificationPostLikeCount(int postNo);
	
	public List<CertificationPost> getCertificationPostLikeList(Like like);

	
	//Comment
	public void addCertificationPostComment(CertificationPostComment certificationPostComment) throws Exception;

	public void deleteCertificationPostComment(CertificationPostComment certificationPostComment) throws Exception;
	
	public List<CertificationPostComment> getCertificationPostCommentList(int postNo) throws Exception;

	
	//Search
	//public List<CertificationPostSearch> getCertificationPostSearch(int certificationPostListSearchCondition);
	

}



