package site.dearmysanta.service.mountain;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.domain.mountain.MountainSearch;
import site.dearmysanta.domain.mountain.Statistics;

@Mapper
//@Component
//@Service("mountainDao")
public interface MountainDao {
	
	public void addMountainLike(Like like);
	
	public void deleteMountainLike(Like like);
	
	public int getTotalMountainLikeCount(Like like);
	
	public List<Mountain> getMountainLikeList(Like like);
	
	public void addSearchKeyword(MountainSearch mountainSearch);
	
	public void deleteSearchKeyword(MountainSearch mountainSearch);
	
	public List<MountainSearch> getSearchKeywordList(int userNo);
	
	public void updateSearchSetting(int userNo, int settingValue);
	
	public void addMountainStatistics(String mountainName);
	
	public int checkMountainColumnExist(String mountainName);
	
	public void updateMountainStatistics(String mountainName, int which);
	public List<Statistics> getStatisticsList();
}