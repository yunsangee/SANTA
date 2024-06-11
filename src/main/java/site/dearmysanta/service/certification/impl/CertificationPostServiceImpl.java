package site.dearmysanta.service.certification.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;


import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.certificationPost.CertificationPostComment;
import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.meeting.MeetingPostComment;
import site.dearmysanta.service.certification.CertificationPostDao;
import site.dearmysanta.service.certification.CertificationPostService;

@Service("CertificationPostServiceImpl")
public class CertificationPostServiceImpl implements CertificationPostService {

    @Autowired
    @Qualifier("CertificationPostDao")
    private CertificationPostDao certificationPostDao;
    
    
    //post
    @Override
    public void addCertificationPost(CertificationPost certificationPost) {
        certificationPostDao.addCertificationPost(certificationPost);
        certificationPostDao.addHashtag(certificationPost);
    }
    

    @Override
    public Map<String, Object> getCertificationPost(int postNo) throws Exception {
       
    	CertificationPost certificationPost = certificationPostDao.getCertificationPost(postNo);
    	
    	int likeCount = certificationPostDao.getCertificationPostLikeCount(postNo);
    	certificationPost.setCertificationPostLikeCount(likeCount);
    	
    	 List<String> hashtagList = certificationPostDao.getHashtag(postNo);
    	List<CertificationPostComment> certificationPostCommentList = certificationPostDao.getCertificationPostCommentList(postNo);
    	Map<String, Object> map = new HashMap<String, Object>();
		map.put("certificationPost", certificationPost);
		map.put("certificationPostCommentList", certificationPostCommentList);
		map.put("hashtagList", hashtagList);
    	return map;
    }
  
  
    @Override
    public void updateCertificationPost(CertificationPost certificationPost) throws Exception {
        certificationPostDao.updateCertificationPost(certificationPost);
    }
    
	@Override
	public Map<String, Object> getCertificationPostList(Search search) throws Exception {
		List<CertificationPost> list= certificationPostDao.getCertificationPostList(search);
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
	
		return map;
	}

	@Override
	public List<CertificationPost> getMyCertificationPostList(int userNo) throws Exception {
		return certificationPostDao.getMyCertificationPostList(userNo);
	}
    
	
	@Override
	public void updateCertificationPostDeleteFlag(int postNo) throws Exception {
		certificationPostDao.updateCertificationPostDeleteFlag(postNo);
		
	}
	
	
	
	
    //hashtag

    @Override
    public void deleteHashtag(int HashtagNo) throws Exception {
    		certificationPostDao.deleteHashtag(HashtagNo);
		
    }
    
	
    //Like
	@Override
	public void addCertificationPostLike(Like like) {
		certificationPostDao.addCertificationPostLike(like);
		certificationPostDao.updateLikeCount(like);
		

		
	}

	@Override
	public void deleteCertificationPostLike(Like like) {
		certificationPostDao.deleteCertificationPostLike(like);
	}


	@Override
	public List<CertificationPost> getCertificationPostLikeList(int userNo) {
		return certificationPostDao.getCertificationPostLikeList(userNo);
	}

	

	//comment
	@Override
	public void addCertificationPostComment(CertificationPostComment certificationPostComment) throws Exception {
		certificationPostDao.addCertificationPostComment(certificationPostComment);
		
	}


	@Override
	public void deleteCertificationPostComment(CertificationPostComment certificationPostComment) throws Exception {
		certificationPostDao.deleteCertificationPostComment(certificationPostComment);
		
	}

	@Override
	public List<CertificationPostComment> getCertificationPostCommentList(int postNo) throws Exception {
		
		return certificationPostDao.getCertificationPostCommentList(postNo);
	}


	//getTotalMountain
	@Override
	public int getTotalMountainCount(String certificationPostMountainName) throws Exception {
		return certificationPostDao.getTotalMountainCount(certificationPostMountainName);
	}





	}



