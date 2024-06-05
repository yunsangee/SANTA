package site.dearmysanta.service.correctionpost;

import java.util.List;

import site.dearmysanta.domain.correctionPost.CorrectionPost;

public interface CorrectionPostService {
	
	public void addCorrectionPost(CorrectionPost correctionPost);
	
	public List<CorrectionPost> getCorrectionPostList();
	
	public void deleteCorrectionPost(int userNo, int postNo);

}
