package site.dearmysanta.service.mountain;

import java.util.List;

import site.dearmysanta.domain.mountain.Mountain;

public interface MountainService {
	
	//
	// mountain
	//
	
	public Mountain addMountain();
	
	public Mountain getMountain();
	
	public List<Mountain> getMountainList(); // include wish list
	
	public void updateMountain();
	
	//
	//Like
	//
	
	public void addMountainLike();
	
	public void deleteMountainLike();
	
	public int getTotalMountainLikeCount();
	
	//
	//search
	//
	
	public void addSearchKeyword();
	
	public void deleteSearchKeyword();
	
	public List<String> getSearchKeywordList();
	
	public void updateSearchSetting();
	
	//statistics
	
	public void updateMountainSearchKeywordCount();
	
	public void updateMountainKeywordCount();
	
	public List<String> getPopularSearchKeywordList();
	
	public List<Mountain> getPopularMountainList();
	
	public List<Mountain> getCustomMountainList();
//	public Statistics getMountainStatistics();
	

}
