package site.dearmysanta.service.mountain;

import java.io.IOException;
import java.util.List;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;

import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.domain.mountain.MountainSearch;
import site.dearmysanta.domain.mountain.MountainTrail;
import site.dearmysanta.domain.mountain.Statistics;
import site.dearmysanta.domain.user.User;

public interface MountainService {
	
	//
	// mountain
	//
	
	public void addMountain(Mountain mountain);
	
	public Mountain getMountain(String mountainName) throws Exception;
	
	public Mountain getMountain(int mountainNo);
	
	public int checkMountainExist(int mountainNo);
	
	public List<Mountain> getMountainListByCoord(double lat, double lon) throws IOException;
	
	public List<Mountain> getMountainListByAddress(String address) throws IOException;// include wish list
	
	public List<Mountain> getMountainListByName(String mountainName); 
	
	public void updateMountain(Mountain mountain);   //이거할 때, correction_post status update
	
	public void updateMountainViewCount(int mountainNo);
	
	public List<Mountain> getPopularMountainList(List<String> mountainNames) throws Exception;
	
	public List<Mountain> getCustomMountainList(List<Statistics> statistics,User user);
	
	
	
	public void addMountainTrail(MountainTrail mountainTrail);
	//
	//Like
	//
	
	public void addMountainLike(Like like);
	
	public void deleteMountainLike(Like like);
	
	public int getTotalMountainLikeCount(Like like);
	
	public List<Mountain> getMountainLikeList(Search search);
	
	//
	//search
	//
	
	public void addSearchKeyword(MountainSearch mountainSearch);
//	
	public void deleteSearchKeyword(MountainSearch mountainSearch);
//	
	public List<MountainSearch> getSearchKeywordList(int userNo,Search search);
//	
	public void updateSearchSetting(int userNo, int settingValue);
	
	//statistics
	
	public void addMountainStatistics(String mountainName, int which);  // need to call in search, addPost 
	
	public int checkStatisticsMountainColumnExist(String mountainName);
	
	public List<Statistics> getStatisticsList(int which);
	
//	public void updateMountainSearchKeywordCount(); // in add
//	
//	public void updateMountainKeywordCount(); // in add
//	
//	public List<String> getPopularSearchKeywordList(); //getStatisticsList
//	
//	public List<Mountain> getPopularMountainList(); 
//	
//	public List<Mountain> getCustomMountainList();
//	public Statistics getMountainStatistics();
	

}
