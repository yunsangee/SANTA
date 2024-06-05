package site.dearmysanta.service.mountain;

import java.util.List;

import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.domain.mountain.MountainSearch;
import site.dearmysanta.domain.mountain.Statistics;

public interface MountainService {
	
	//
	// mountain
	//
	
	public void addMountain(Mountain mountain);
	
	public Mountain getMountain(String mountainName) throws Exception;
	
//	public List<Mountain> getMountainList(); // include wish list
	
	public void updateMountain(Mountain mountain);   //이거할 때, correction_post status update
	
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
	
	public void addSearchKeyword(MountainSearch mountainSearch);
//	
	public void deleteSearchKeyword(MountainSearch mountainSearch);
//	
	public List<MountainSearch> getSearchKeywordList(int userNo);
//	
	public void updateSearchSetting(int userNo, int settingValue);
	
	//statistics
	
	public void addMountainStatistics(String mountainName, int which);  // need to call in search, addPost 
	
	public int checkMountainColumnExist(String mountainName);
	
	public List<Statistics> getStatisticsList();
	
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
