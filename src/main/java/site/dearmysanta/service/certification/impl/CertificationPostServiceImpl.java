package site.dearmysanta.service.certification.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.common.Like;
import site.dearmysanta.service.certification.CertificationPostDao;
import site.dearmysanta.service.certification.CertificationPostService;

@Service("CertificationServiceImpl")
public class CertificationPostServiceImpl implements CertificationPostService {

    @Autowired
    @Qualifier("CertificationPostDao")
    private CertificationPostDao certificationPostDao;

    @Override
    public void addCertificationPost(CertificationPost certificationPost) throws Exception {
        certificationPostDao.addCertificationPost(certificationPost);
    }

    @Override
    public CertificationPost getCertificationPost(int certificationPostNo) throws Exception {
        return certificationPostDao.getCertificationPost(certificationPostNo);
    }

    @Override
    public void updateCertificationPost(CertificationPost certificationPost) throws Exception {
        certificationPostDao.updateCertificationPost(certificationPost);
    }
    
    //hashtag

	@Override
	public void addCertificationPostHashtags(CertificationPost certificationPost) throws Exception {
		 certificationPostDao.addCertificationPostHashtags(certificationPost);
		
	}
    
    
    @Override
    public int deleteCertificationPostHashtags(int HashtagNo) throws Exception {
        certificationPostDao.deleteCertificationPostHashtags(HashtagNo);
		return HashtagNo;
		
    }


    
  
    
    //hashtag 
    
    
    
    
    
    
    
    //Like
	@Override
	public void addCertificationPostLike(Like like) {
		certificationPostDao.addCertificationPostLike(like);
		
	}

	@Override
	public void deleteCertificationPostLike(Like like) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int getTotalCertificationPostLikeCount(Like like) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<CertificationPost> getCertificationPostLikeList(Like like) {
		// TODO Auto-generated method stub
		return null;
	}



	   //Like
	
	

	}




