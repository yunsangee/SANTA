package site.dearmysanta.service.certification;

import site.dearmysanta.domain.certificationPost.CertificationPost;


public interface CertificationPostService {

	
	public void addCertificationPost(CertificationPost certificationPost) throws Exception;
	
	public CertificationPost getCertificationPost(int certificationPostNo) throws Exception;
	
	public void updateCertificationPost(CertificationPost certificationPost) throws Exception;

	 public void addCertificationPostImage(CertificationPost certificationPost) throws Exception;
		
	public void updateCertificationPostImage(CertificationPost certificationPost) throws Exception;
		
//	public void deleteCertificationPost();
//	
//	public void getCertificationPostList();
//	
//	public void addCertificationPostComment();
//	public void deleteCertificationPostComment();
//	public void deleteCertificationPostHashtags(int certificationPostNo) throws Exception;
	
	

}
