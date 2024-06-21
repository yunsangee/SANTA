package site.dearmysanta.service.correctionpost;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.correctionPost.CorrectionPost;

@Mapper
public interface CorrectionPostDao {
	public void addCorrectionPost(CorrectionPost correctionPost);
	
	public List<CorrectionPost> getCorrectionPostList(Search search);
	
	public int getCorrectionPostTotalCount(Search search);
	
	public void updateCorrectionPostStatus(int crpNo);
	
	public void deleteCorrectionPost(int userNo, int postNo);
}
