package site.dearmysanta.service.mountain;

import java.util.List;

import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.mountain.Mountain;

public interface MountainService {
	
	//
	// mountain
	//
	
//	public Mountain addMountain();
	
	public Mountain getMountain() throws Exception;
	
//	public List<Mountain> getMountainList(); // include wish list
	
//	public void updateMountain();
	
	//
	//Like
	//
	
	public void addMountainLike(Like like);
	
	public void deleteMountainLike(Like like);
	
	public int getTotalMountainLikeCount(Like like);
	
	public List<Mountain> getMountainLikeList(Like like);
	
	//
	//search
	//
	
//	public void addSearchKeyword();
//	
//	public void deleteSearchKeyword();
//	
//	public List<String> getSearchKeywordList();
//	
//	public void updateSearchSetting();
	
	//statistics
	
//	public void updateMountainSearchKeywordCount();
//	
//	public void updateMountainKeywordCount();
//	
//	public List<String> getPopularSearchKeywordList();
//	
//	public List<Mountain> getPopularMountainList();
//	
//	public List<Mountain> getCustomMountainList();
//	public Statistics getMountainStatistics();
	

}
