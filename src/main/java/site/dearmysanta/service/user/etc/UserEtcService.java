package site.dearmysanta.service.user.etc;

import java.util.List;

import site.dearmysanta.domain.alarmMessage.AlarmMessage;
import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.user.User;

public interface UserEtcService {
			
		//
		// Certification, Meeting
		//
	
		public int getCertificationCount(int userNo) throws Exception;
			
		public int getMeetingCount(int userNo) throws Exception;
		
		public void updateCertificationCount(int userNo,int type) throws Exception;
		
		public void updateMeetingCount(int userNo,int type) throws Exception;
		
		//
		// Badge
		//
		
//		public void updateBadgeImage() throws Exception;
//		
//		//
//		// Follow
//		//
//		
		public void addFollow(int followerUserNo, int followingUserNo);
		
		public void deleteFollow(int followerUserNo, int followingUserNo);
		//followerUserNo == me : delete my following
		//followingUserNo == me : delete my follower
		
		public List<User> getFollowerList(int userNo); 
		
		public List<User> getFollowingList(int userNo);
		
		public int getFollowerCount(int userNo);
		
		public int getFollowingCount(int userNo);
//		
//		
//		//
//		// updateRecord
//		//
//		
		public void updateSearchRecordFlag(int userNo) throws Exception;
//		
//		//
//		// Alarm
//		//
//		
		public void addAlarmMessage(AlarmMessage alarmMessage) throws Exception;
	
		public List<AlarmMessage> getAlarmMessageList(int userNo) throws Exception;
		
		public void updateAlarmSetting(int userNo,int alarmSettingType) throws Exception;
		//0:ALL_ALERT_SETTING				    
//		 1:CP_SETTING					   
//		 2:MP_SETTING					    
//		 3:HG_SETTING					   
		
		public void deleteAlarmMessage(int alarmNo ) throws Exception;
		
		public User getUserSettings(User user);
//		public int addCertificationPost(CertificationPost certificationPost) throws Exception ;
}
