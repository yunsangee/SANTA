package site.dearmysanta.service.certification;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;
import org.apache.ibatis.annotations.Param;

import site.dearmysanta.domain.certificationPost.CertificationPost;

@Mapper
@Component("CertificationPostDao")
public interface CertificationPostDao {

	
	public void addCertificationPost(CertificationPost certificationPost) throws Exception;

	public CertificationPost getCertificationPost(int certificationPostNo) throws Exception;

	public void updateCertificationPost(CertificationPost certificationPost) throws Exception;

	
	//postImage
	public void addCertificationPostImage(CertificationPost certificationPost) throws Exception;
	
	public void updateCertificationPostImage(CertificationPost certificationPost) throws Exception;
	
	//hashtag
	public void addCertificationPostHashtags(Map<String, Object> map) throws Exception;
	
	public List<String> getHashtagsByPostNo(int certificationPostNo) throws Exception;

	public	 void deleteHashtagsByPostNo(int certificationPostNo) throws Exception;
	
	
}



