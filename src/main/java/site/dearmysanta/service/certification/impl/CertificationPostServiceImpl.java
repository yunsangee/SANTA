package site.dearmysanta.service.certification.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;


import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.certificationPost.CertificationPostComment;
import site.dearmysanta.domain.common.Like;

import site.dearmysanta.service.certification.CertificationPostDao;
import site.dearmysanta.service.certification.CertificationPostService;

@Service("CertificationServiceImpl")
public class CertificationPostServiceImpl implements CertificationPostService {

    @Autowired
    @Qualifier("CertificationPostDao")
    private CertificationPostDao certificationPostDao;
    
    
//    @Override
//    public void addCertificationPost(CertificationPost certificationPost) throws Exception {
//        // 게시글 삽입
//        certificationPostDao.addCertificationPost(certificationPost);
//        
//        // 삽입된 게시글의 postNo 가져오기
//        int postNo = certificationPost.getPostNo();
//        
//        // 해시태그 삽입
//        List<String> hashtags = certificationPost.getCertificationPostHashtagContents();
//        for (String hashtagContent : hashtags) {
//            certificationPostDao.addHashTag(postNo, hashtagContent);
//        }
//    }

    
  
//    @Override
//    public void addCertificationPost(CertificationPost certificationPost) throws Exception {
//    certificationPostDao.addCertificationPost(certificationPost);
//
//    }
    
    
    @Override
    public void addCertificationPost(CertificationPost certificationPost) {
        certificationPostDao.addCertificationPost(certificationPost);
        certificationPostDao.addHashTag(certificationPost);
    }
    

    @Override
    public CertificationPost getCertificationPost(int postNo) throws Exception {
       
    	CertificationPost certificationPost = certificationPostDao.getCertificationPost(postNo);
    	
    	int likeCount = certificationPostDao.getCertificationPostLikeCount(postNo);
    	
    	certificationPost.setCertificationPostLikeCount(likeCount);
    	
    	return certificationPost;
    }
  
  
    @Override
    public void updateCertificationPost(CertificationPost certificationPost) throws Exception {
        certificationPostDao.updateCertificationPost(certificationPost);
    }
    
    //hashtag
//
//	@Override
//	public void addHashTag(CertificationPost certificationPost)  {
//		 certificationPostDao.addHashTag(certificationPost);
//		
//	}

    @Override
    public int deleteCertificationPostHashtags(int HashtagNo) throws Exception {
        certificationPostDao.deleteCertificationPostHashtags(HashtagNo);
		return HashtagNo;
		
    }
    
    //Like
	@Override
	public void addCertificationPostLike(Like like) {
		certificationPostDao.addCertificationPostLike(like);
		
	}

	@Override
	public void deleteCertificationPostLike(Like like) {
		certificationPostDao.deleteCertificationPostLike(like);
	}


	@Override
	public List<CertificationPost> getCertificationPostLikeList(Like like) {
		return certificationPostDao.getCertificationPostLikeList(like);
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
	public List<CertificationPost> getCertificationPostList() throws Exception {
		
		return certificationPostDao.getCertificationPostList();
	}


	@Override
	public void addHashTag(CertificationPost certificationPost) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public List<CertificationPost> getMyCertificationPostList(int userNo) throws Exception {
		// TODO Auto-generated method stub
		return certificationPostDao.getMyCertificationPostList(userNo);
	}


//	@Override
//	public List<String> getMyCertificationPostList(int userNo) throws Exception {
//		// TODO Auto-generated method stub
//		return certificationPostDao.getMyCertificationPostList(userNo);
//	}



	

	}




