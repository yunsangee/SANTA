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
	
	public Mountain getMountain(int userNo,int mountainNo);
	
	public int checkMountainExist(int mountainNo);
	public int isMountain(String mountainName);
	
	public List<Mountain> getMountainListByCoord(double lat, double lon) throws IOException;
	
	public List<Mountain> getMountainListByAddress(String address) throws IOException;// include wish list
	
	public List<Mountain> getMountainListByName(int userNo, String mountainName); 
	
	public void updateMountain(Mountain mountain);   //이거할 때, correction_post status update
	
	public void updateMountainViewCount(int mountainNo);
	
	public List<Mountain> getPopularMountainList(List<String> mountainNames,Search search) throws Exception;
	
	public List<Mountain> getCustomMountainList(List<String> statistics,User user);
	
	public int getTotalMountainLikeListCount(int userNo);
	
	
	
	public void addMountainTrail(MountainTrail mountainTrail);
	//
	//Like
	//
	
	public void addMountainLike(Like like);
	
	public void deleteMountainLike(Like like);
	
	public int getTotalMountainLikeCount(int mountainNo);
	
	public int isLiked(int mountainNo, int userNo);
	
	public List<Mountain> getMountainLikeList(Search search);
	
	
	public List<MountainTrail> getMountainTrailListFromVWorld(int mountainNo, String mountainName, String emdCd) throws IOException;
	
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
	
	public int checkStatisticsMountainColumnExist(String mountainName);
	
	public List<Statistics> getStatisticsWeekly();

	public List<Statistics> getStatisticsDaily();
	
	public List<String> getStatisticsMountainNameList(int which);
	
//	public void getMountainImageFromGoogle() throws IOException; //for test
	
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
