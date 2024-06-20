package site.dearmysanta.service.correctionpost.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.correctionPost.CorrectionPost;
import site.dearmysanta.service.correctionpost.CorrectionPostDao;
import site.dearmysanta.service.correctionpost.CorrectionPostService;

@Service("correctionPostServiceImpl")
@Transactional
public class CorrectionPostServiceImpl implements CorrectionPostService{
	
	@Autowired
	CorrectionPostDao correctionPostDao;
	public void addCorrectionPost(CorrectionPost correctionPost) {
		correctionPostDao.addCorrectionPost(correctionPost);
		
	}
	
	public List<CorrectionPost> getCorrectionPostList(Search search){
		return correctionPostDao.getCorrectionPostList(search);
	}
	
	public void deleteCorrectionPost(int userNo, int postNo) {
		correctionPostDao.deleteCorrectionPost(userNo, postNo);
	}
	
	public void updateCorrectionPostStatus(int crpNo) {
		correctionPostDao.updateCorrectionPostStatus(crpNo);
	}
	
	public int getCorrectionPostTotalCount(Search search) {
		return correctionPostDao.getCorrectionPostTotalCount(search);
	}
}
