package site.dearmysanta.service.certification;


import java.util.List;

import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.certificationPost.CertificationPostComment;
import site.dearmysanta.domain.common.Like;

public interface CertificationPostService {

	
	public void addCertificationPost(CertificationPost certificationPost) throws Exception;
	public CertificationPost getCertificationPost(int postNo) throws Exception;
	public void updateCertificationPost(CertificationPost certificationPost) throws Exception;
	
	public List<CertificationPost> getCertificationPostList() throws Exception;
	public	List<CertificationPost> getMyCertificationPostList(int userNo) throws Exception;

	
//	 public  void deleteCertificationPost(int certificationPostNo) throws Exception;
//	public void deleteCertificationPost();
//	
//	public void getCertificationPostList();
//	
//	public void addCertificationPostComment();
//	public void deleteCertificationPostComment();
	
	
	//hashtag
	//public void addCertificationPostHashtags(int postNo, String certificationPostHashtagContents);
//public void addCertificationPostHashtags(CertificationPost certificationPost) throws Exception ;
	
	public void addHashTag(CertificationPost certificationPost);
	public int deleteCertificationPostHashtags(int HashtagNo) throws Exception;
	

	
	
	//Comment 
	
	public void addCertificationPostComment(CertificationPostComment certificationPostComment) throws Exception;

	public void deleteCertificationPostComment(CertificationPostComment certificationPostComment) throws Exception;

	//public List<CertificationPostComment> getCertificationPostCommentList(int postNo) throws Exception;

	
	//Like
	
	public void addCertificationPostLike(Like like);
	
	public void deleteCertificationPostLike(Like like) ;
	
	//public int getTotalCertificationPostLikeCount(Like like);
	
	public List<CertificationPost> getCertificationPostLikeList(Like like);






}
