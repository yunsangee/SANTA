package site.dearmysanta.service.mountain;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.mountain.Mountain;

@Mapper
//@Component
//@Service("mountainDao")
public interface MountainDao {
	
	public void addMountainLike(Like like);
	
	public void deleteMountainLike(Like like);
	
	public int getTotalMountainLikeCount(Like like);
	
	public List<Mountain> getMountainLikeList(Like like);
	
}