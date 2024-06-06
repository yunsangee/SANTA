package site.dearmysanta.service.certification.impl;

import java.util.List;

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
//  
    @Override
    public void addCertificationPost(CertificationPost certificationPost) throws Exception {
    certificationPostDao.addCertificationPost(certificationPost);

    }
    
    //µµøÕ¡‡
//    @Override
//    public void addCertificationPost(CertificationPost certificationPost) {
//        certificationPostDao.addCertificationPost(certificationPost);
//        certificationPostDao.addHashTag(certificationPost.getPostNo(), certificationPost.getCertificationPostHashtagContents());
//    }

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

//	@Override
//	public void addCertificationPostHashtags(CertificationPost certificationPost) throws Exception {
//		 certificationPostDao.addCertificationPostHashtags(certificationPost);
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

	



	
	

	}




