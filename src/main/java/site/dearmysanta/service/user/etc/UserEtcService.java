package site.dearmysanta.service.user.etc;

import java.util.List;

import site.dearmysanta.domain.user.User;

public interface UserEtcService {
			
		//
		// Certification, Meeting
		//
	
		public int getCertificationCount(int userNo) throws Exception;
			
		public int getMeetingCount(int userNo) throws Exception;
		
		public void updateCertificationCount(int userNo) throws Exception;
		
		public void updateMeetingCount(int userNo) throws Exception;
		
		//
		// Badge
		//
		
//		public void updateBadgeImage() throws Exception;
//		
//		//
//		// Follow
//		//
//		
//		public void addFollower() throws Exception;
//		
//		public List<User> getFollowerList() throws Exception;
//		
//		public void getFollowerCount() throws Exception;
//		
//		
//		//
//		// updateRecord
//		//
//		
//		public void updateRecordFlag() throws Exception;
//		
//		//
//		// Alarm
//		//
//		
//		public void addLikeAlarm() throws Exception;
//		
//		public void addCommentAlarm() throws Exception;
//		
//		public List<User> getAlarmList() throws Exception;
//		
//		public void updateAlarmSetting() throws Exception;
//		
//		public void deleteAlarm() throws Exception;
		
}
