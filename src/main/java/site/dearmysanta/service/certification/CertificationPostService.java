package site.dearmysanta.service.certification;


import java.util.List;
import java.util.Map;


import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.certificationPost.CertificationPostComment;

import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.meeting.MeetingPost;

public interface CertificationPostService {

	//post
	public void addCertificationPost(CertificationPost certificationPost) throws Exception;
	
	public Map<String, Object> getCertificationPost(int postNo, int userNo) throws Exception;
	
	public CertificationPost getCertificationPost(int postNo) throws Exception;
	
	public void updateCertificationPost(CertificationPost certificationPost, List<String> updateImageURL) throws Exception;
	
	public void updateCertificationPostDeleteFlag(int postNo) throws Exception; //����

	public Map<String, Object> getCertificationPostList(Search search) throws Exception;
	
	public	List<CertificationPost> getMyCertificationPostList(int userNo) throws Exception;

	//hashtag	
	//public void addHashtag(CertificationPost certificationPost);
	public void addHashtag(int postNo, String certificationPostHashtagContents);
	public void deleteHashtag(int hashtagNo) throws Exception;
	
	public List<String> getHashtag(int postNo) throws Exception;
	
	//Like
	public void addCertificationPostLike(Like like);
	
	public void deleteCertificationPostLike(Like like) ;
	
	//public int getTotalCertificationPostLikeCount(Like like); 
	
	public List<CertificationPost> getCertificationPostLikeList(int userNo);


	//Comment 
	
	public void addCertificationPostComment(CertificationPostComment certificationPostComment) throws Exception;

	public void deleteCertificationPostComment(int certificationPostCommentNo, int userNo) throws Exception;

	public List<CertificationPostComment> getCertificationPostCommentList(int postNo) throws Exception;
	

	public int getTotalMountainCount(String certificationPostMountainName) throws Exception;

	void updateHashtag(int hashtagNo, String certificationPostHashtagContents);


	

}