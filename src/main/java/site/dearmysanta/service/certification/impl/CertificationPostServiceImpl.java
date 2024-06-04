package site.dearmysanta.service.certification.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.service.certification.CertificationPostDao;
import site.dearmysanta.service.certification.CertificationPostService;

@Service("CertificationService")
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

    
    @Override
    public void addCertificationPostImage(CertificationPost certificationPost) throws Exception {
        certificationPostDao.addCertificationPostImage(certificationPost);
    }

    @Override
    public void updateCertificationPostImage(CertificationPost certificationPost) throws Exception {
        certificationPostDao.updateCertificationPostImage(certificationPost);
    }
	
	
 

}
