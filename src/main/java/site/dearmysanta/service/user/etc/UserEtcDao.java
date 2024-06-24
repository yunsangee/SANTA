package site.dearmysanta.service.user.etc;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

import site.dearmysanta.domain.alarmMessage.AlarmMessage;
import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.user.User;

@Mapper
@Component("userEtcDao")

	public interface UserEtcDao {
    
    // Certification, Meeting
	//
	
    public int getCertificationCount(int userNo) throws Exception;
    
    public int getMeetingCount(int userNo) throws Exception;
    
    public void updateCertificationCount(int userNo,int type) throws Exception;
    
    public void updateMeetingCount(int userNo,int type) throws Exception;
    
    //
    //follow
    //
    
    public void addFollow(int followerUserNo, int followingUserNo);
	
	public void deleteFollow(int followerUserNo, int followingUserNo);
	//followerUserNo == me : delete my following
	//followingUserNo == me : delete my follower
	
	public List<User> getFollowerList(int userNo); 
	
	public List<User> getFollowingList(int userNo);
	
	public int getFollowerCount(int userNo);
	
	public int getFollowingCount(int userNo);
	
	public int isFollowing(int followerNo, int followingNo);
	
	
	public void addAlarmMessage(AlarmMessage alarmMessage) throws Exception;
	//0: certification 1: meeting
	
	public List<AlarmMessage> getAlarmMessageList(int userNo) throws Exception;
	
	
	public void deleteAlarmMessage(int alarmNo ) throws Exception;
	
	public void updateSearchRecordFlag(int userNo) throws Exception;
	
	public void updateAlarmSetting(int userNo,int alarmSettingType) throws Exception;
    
	public User getUserSettings(User user);
	
//	public int addCertificationPost(CertificationPost certificationPost) throws Exception ;
    // Badge
//    //
//    
//    public void updateBadgeImage() throws Exception;
//    

//    
//    // updateRecord
//    public void updateRecordFlag() throws Exception;
//    
//    public void updateAlarmSetting() throws Exception;
//    
}
