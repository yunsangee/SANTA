package site.dearmysanta.service.mountain;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.domain.mountain.MountainSearch;
import site.dearmysanta.domain.mountain.MountainTrail;
import site.dearmysanta.domain.mountain.Statistics;
import site.dearmysanta.domain.user.User;

@Mapper
//@Component
//@Service("mountainDao")
public interface MountainDao {
	
	//
	//
	//
	
	public void addMountain(Mountain mountain);
	
	public Mountain getMountain(int mountainNo);
	
	public List<Mountain> getMountainListByAddress(String address);
	
	public List<Mountain> getMountainListByName(String mountainName); 
	
	public void updateMountainViewCount(int mountainNo);
	
	public void updateMountain(Mountain mountain);
	
	public int checkMountainExist(int mountainNo);
	
	public int isMountain(String mountainName);
	
	public List<Mountain> getCustomMountainList(List<String> mountainNames, User user);
	
	
	public void addMountainTrail(MountainTrail mountainTrail);
	
	//
	//
	//
	
	public void addMountainLike(Like like);
	
	public void deleteMountainLike(Like like);
	
	public int getTotalMountainLikeCount(Like like);
	
	public List<Mountain> getMountainLikeList(Search search);
	
	public List<String> getStatisticsMountainNameList(int which);
	
	//
	//
	//
	
	public void addSearchKeyword(MountainSearch mountainSearch);
	
	public void deleteSearchKeyword(MountainSearch mountainSearch);
	
	public List<MountainSearch> getSearchKeywordList(int userNo);
	
	public void updateSearchSetting(int userNo, int settingValue);
	
	//
	//
	//
	
	public void addMountainStatistics(String mountainName);
	
	public int checkStatisticsMountainColumnExist(String mountainName);
	
	public void updateMountainStatistics(String mountainName, int which);
	
	public List<Statistics> getStatisticsWeekly();
	
	public List<Statistics> getStatisticsDaily(String date);
	//
	//
	//
}