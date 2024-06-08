package site.dearmysanta.service.certification;


import java.util.List;
import java.util.Map;


import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.certificationPost.CertificationPostComment;

import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.common.Search;

public interface CertificationPostService {

	//post
	public void addCertificationPost(CertificationPost certificationPost) throws Exception;
	
	public Map<String, Object> getCertificationPost(int postNo) throws Exception;
	
	public void updateCertificationPost(CertificationPost certificationPost) throws Exception;

	public Map<String, Object> getCertificationPostList(Search search) throws Exception;
	
	public	List<CertificationPost> getMyCertificationPostList(int userNo) throws Exception;

	//hashtag
	//public void addHashTag(CertificationPost certificationPost);
	
	public void deleteHashtag(int HashtagNo) throws Exception;
	
	//public CertificationPost getHashtag(int postNo) throws Exception;
	
	//Like
	public void addCertificationPostLike(Like like);
	
	public void deleteCertificationPostLike(Like like) ;
	
	//public int getTotalCertificationPostLikeCount(Like like); get에합쳐서안써도되나?
	
	public List<CertificationPost> getCertificationPostLikeList(Like like);


	//Comment 
	
	public void addCertificationPostComment(CertificationPostComment certificationPostComment) throws Exception;

	public void deleteCertificationPostComment(CertificationPostComment certificationPostComment) throws Exception;

	public List<CertificationPostComment> getCertificationPostCommentList(int postNo) throws Exception;

	
	//Search
		//public List<CertificationPostSearch> getCertificationPostSearch(int certificationPostListSearchCondition);
		




}
