package site.dearmysanta.service.domain.user.etc;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

import site.dearmysanta.service.domain.user.User;

@Mapper
@Component("etcDao")

	public interface EtcDao {
    
    // Certification, Meeting
	//
	
    public void getCertificationCount() throws Exception;
    
    public void getMeetingCount() throws Exception;
    
    public void updateCertificationCount() throws Exception;
    
    public void updateMeetingCount() throws Exception;
    
    // Badge
    //
    
    public void updateBadgeImage() throws Exception;
    
    // Follow
    //
    
    public void addFollower() throws Exception;
    
    public List<User> getFollowerList() throws Exception;
    
    public void getFollowerCount() throws Exception;
    
    // updateRecord
    public void updateRecordFlag() throws Exception;
    
    // Alarm
    public void addLikeAlarm() throws Exception;
    
    public void addCommentAlarm() throws Exception;
    
    public List<User> getAlarmList() throws Exception;
    
    public void updateAlarmSetting() throws Exception;
    
    public void deleteAlarm() throws Exception;
}
