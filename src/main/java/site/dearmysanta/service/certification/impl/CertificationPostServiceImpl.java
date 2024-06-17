package site.dearmysanta.service.certification.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;


import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.certificationPost.CertificationPostComment;
import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.service.certification.CertificationPostDao;
import site.dearmysanta.service.certification.CertificationPostService;
import site.dearmysanta.service.common.ObjectStorageService;

@Service("CertificationPostServiceImpl")
public class CertificationPostServiceImpl implements CertificationPostService {

    @Autowired
    @Qualifier("CertificationPostDao")
    private CertificationPostDao certificationPostDao;
    
    @Value("${bucketName}")
	private String bucketName;
	
	@Autowired
    private ObjectStorageService objectStorageService;
	
	public CertificationPostServiceImpl() {
		System.out.println(this.getClass());
	}
	
    
    //post
    @Override
    public void addCertificationPost(CertificationPost certificationPost) {
//    	 if (certificationPost.getCertificationPostImage() == null || certificationPost.getCertificationPostImage().isEmpty()) {
//    	        throw new IllegalArgumentException("이미지는 최소 한 개 이상 포함되어야 합니다.");
//    	    } else {
//    	        // 이미지의 개수를 설정
//    	        certificationPost.setCertificationPostImageCount(certificationPost.getCertificationPostImage().size());
//    	    }
        certificationPostDao.addCertificationPost(certificationPost);
        certificationPostDao.addHashtag(certificationPost);
    }
    

    @Override
    public Map<String, Object> getCertificationPost(int postNo,  int userNo) throws Exception {
       
    	CertificationPost certificationPost = certificationPostDao.getCertificationPost(postNo);
    	int likeStatus = certificationPostDao.getCertificationPostLikeStatus(postNo, userNo);
    	certificationPost.setCertificationPostLikeStatus(likeStatus);
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
	public void addHashtag(CertificationPost certificationPost) {
		certificationPostDao.addHashtag(certificationPost);
		
	}

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
		certificationPostDao.updateLikeCount(like);
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
	public void deleteCertificationPostComment(int certificationPostCommentNo, int userNo) throws Exception {
		certificationPostDao.deleteCertificationPostComment(certificationPostCommentNo, userNo);
		
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


	@Override
	public CertificationPost getCertificationPost(int postNo) throws Exception {
		CertificationPost certificationPost = certificationPostDao.getCertificationPost(postNo);
		
		return certificationPost;
	}





	}



