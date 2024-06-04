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
        // CertificationPost를 먼저 저장합니다.
        certificationPostDao.addCertificationPost(certificationPost);
        
        // CertificationPost의 해시태그를 저장합니다.
        List<String> hashtags = certificationPost.getCertificationPostHashtag();
        if (hashtags != null && !hashtags.isEmpty()) {
            for (String hashtag : hashtags) {
                // 각 해시태그를 해시태그 테이블에 저장합니다.
                certificationPostDao.addCertificationPostHashtag(certificationPost.getCpNo(), hashtag);
            }
        }
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
	public void addCertificationPostHashtags(int certificationPostNo) throws Exception {
		certificationPostDao.addCertificationPostHashtags(certificationPostNo);
	}
	
    @Override
    public void deleteCertificationPostHashtags(int certificationPostNo) throws Exception {
        certificationPostDao.deleteCertificationPostHashtags(certificationPostNo);
    }

    
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




}
