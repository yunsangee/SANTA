package site.dearmysanta.service.certification.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
        if (certificationPost.getCertificationPostImage() == null || certificationPost.getCertificationPostImage().isEmpty()) {
            throw new IllegalArgumentException("�̹����� �ּ� �� �� �̻� ���ԵǾ�� �մϴ�.");
        } else {
            // �̹����� ������ ����
            certificationPost.setCertificationPostImageCount(certificationPost.getCertificationPostImage().size());
        }
        certificationPostDao.addCertificationPost(certificationPost);
    }

    @Override
    public void addHashtag(int postNo, String certificationPostHashtagContents) {
        certificationPostDao.addHashtag(postNo, certificationPostHashtagContents);
    }

    @Override
    public Map<String, Object> getCertificationPost(int postNo,  int userNo) throws Exception {
       
    	CertificationPost certificationPost = certificationPostDao.getCertificationPost(postNo);
    	int likeStatus = certificationPostDao.getCertificationPostLikeStatus(postNo, userNo);
    	certificationPost.setCertificationPostLikeStatus(likeStatus);
    	int likeCount = certificationPostDao.getCertificationPostLikeCount(postNo);
    	certificationPost.setCertificationPostLikeCount(likeCount);
    	
    	
    	 List<String> hashtagList = certificationPostDao.getHashtag(postNo);
    	 System.out.println("hashtagList" + hashtagList);
    	List<CertificationPostComment> certificationPostCommentList = certificationPostDao.getCertificationPostCommentList(postNo);
    	Map<String, Object> map = new HashMap<String, Object>();
		map.put("certificationPost", certificationPost);
		
		map.put("certificationPostCommentList", certificationPostCommentList);
		System.out.println("댓글"+postNo+userNo+certificationPostCommentList);
		map.put("hashtagList", hashtagList);
    	return map;
    }
  
  
    @Override
    public void updateCertificationPost(CertificationPost certificationPost, List<String> updateImageURL) throws Exception {
        // 해시태그를 가져오고 콘솔에 출력합니다.
        List<String> hashtagList = certificationPostDao.getHashtag(certificationPost.getPostNo());
        System.out.println("해시태그 확인: " + hashtagList);
        
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("hashtagList", hashtagList);

        // appendImageCount를 초기화합니다.
        int appendImageCount = 0;

        // certificationPost에 이미지가 있는지 확인하고, 비어있지 않은 이미지를 필터링합니다.
        if (certificationPost.getCertificationPostImage() != null) {
            List<MultipartFile> images = certificationPost.getCertificationPostImage().stream()
                .filter(image -> !image.isEmpty())
                .collect(Collectors.toList());
            
            // 필터링된 이미지 리스트의 크기를 appendImageCount에 저장합니다.
            appendImageCount = images.size();
            System.out.println("필터링된 이미지 수: " + appendImageCount);  // 디버깅용 출력
        }
        
        // updateImageURL 리스트의 크기와 appendImageCount의 합을 구하여 certificationPost 객체의 이미지 개수를 설정합니다.
        certificationPost.setCertificationPostImageCount(updateImageURL.size() + appendImageCount);
        System.out.println("최종 이미지 개수: " + certificationPost.getCertificationPostImageCount());  // 디버깅용 출력
        
        // certificationPost를 업데이트합니다.
        certificationPostDao.updateCertificationPost(certificationPost);
        System.out.println("업데이트 완료: " + certificationPost);  // 디버깅용 출력
    }

    

    @Override
    public Map<String, Object> getCertificationPostList(Search search) throws Exception {
    
        List<CertificationPost> list = certificationPostDao.getCertificationPostList(search);

      
        for (CertificationPost post : list) {
  
            int likeCount = certificationPostDao.getCertificationPostLikeCount(post.getPostNo());
            post.setCertificationPostLikeCount(likeCount); 
        }

        Map<String, Object> map = new HashMap<>();
        map.put("list", list);

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
	public void deleteHashtag(int hashtagNo) {
        certificationPostDao.deleteHashtag(hashtagNo);
    }

    @Override
    public void updateHashtag(int hashtagNo, String certificationPostHashtagContents) {
        certificationPostDao.updateHashtag(hashtagNo, certificationPostHashtagContents);
    }


//
//    @Override
//    public void deleteHashtag(int HashtagNo) throws Exception {
//    		certificationPostDao.deleteHashtag(HashtagNo);
//		
//    }
    
	
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


	@Override
	public List<String> getHashtag(int postNo) throws Exception {
	
		return certificationPostDao.getHashtag(postNo);
	}


	

	}



