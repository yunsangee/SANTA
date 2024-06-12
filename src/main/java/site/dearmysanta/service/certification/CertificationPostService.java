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
	
	public void updateCertificationPostDeleteFlag(int postNo) throws Exception; //����

	public Map<String, Object> getCertificationPostList(Search search) throws Exception;
	
	public	List<CertificationPost> getMyCertificationPostList(int userNo) throws Exception;

	//hashtag	
	public void deleteHashtag(int HashtagNo) throws Exception;
	
	//public CertificationPost getHashtag(int postNo) throws Exception;
	
	//Like
	public void addCertificationPostLike(Like like);
	
	public void deleteCertificationPostLike(Like like) ;
	
	//public int getTotalCertificationPostLikeCount(Like like); 
	
	public List<CertificationPost> getCertificationPostLikeList(int userNo);


	//Comment 
	
	public void addCertificationPostComment(CertificationPostComment certificationPostComment) throws Exception;

	public void deleteCertificationPostComment(int certificationPostCommentNo) throws Exception;

	public List<CertificationPostComment> getCertificationPostCommentList(int postNo) throws Exception;
	

	public int getTotalMountainCount(String certificationPostMountainName) throws Exception;
	

}