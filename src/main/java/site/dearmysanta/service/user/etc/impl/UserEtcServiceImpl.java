package site.dearmysanta.service.user.etc.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import site.dearmysanta.domain.alarmMessage.AlarmMessage;
import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.user.etc.UserEtcDao;
import site.dearmysanta.service.user.etc.UserEtcService;

@Service("userEtcServiceImpl")
@Transactional

	public class UserEtcServiceImpl implements UserEtcService {
	
	@Autowired
	@Qualifier("userEtcDao")
	private UserEtcDao userEtcDao;

	@Override
	public int getCertificationCount(int userNo) throws Exception {
		// TODO Auto-generated method stub
		return userEtcDao.getCertificationCount(userNo);
	}

	@Override
	public int getMeetingCount(int userNo) throws Exception {
		// TODO Auto-generated method stub
		return userEtcDao.getMeetingCount(userNo);
		
	}

	@Override
	public void updateCertificationCount(int userNo) throws Exception {
		// TODO Auto-generated method stub
		userEtcDao.updateCertificationCount(userNo);
		
	}

	@Override
	public void updateMeetingCount(int userNo) throws Exception {
		// TODO Auto-generated method stub
		userEtcDao.updateMeetingCount(userNo);
		
	}

	
	public void addFollow(int followerUserNo, int followingUserNo) {
		userEtcDao.addFollow(followerUserNo, followingUserNo);
	}
	
	public void deleteFollow(int followerUserNo, int followingUserNo) {
		userEtcDao.deleteFollow( followerUserNo,  followingUserNo);
		
	}

	
	public List<User> getFollowerList(int userNo){
		return userEtcDao.getFollowerList( userNo);
	}
	
	public List<User> getFollowingList(int userNo){
		return userEtcDao.getFollowingList( userNo);
	}
	
	public int getFollowerCount(int userNo) {
		return userEtcDao.getFollowerCount( userNo);
	}
	
	public int getFollowingCount(int userNo) {
		return userEtcDao.getFollowingCount( userNo);
	}
	
	
	public void addAlarmMessage(AlarmMessage alarmMessage) throws Exception{
		userEtcDao.addAlarmMessage(alarmMessage);
	}
	
	public List<AlarmMessage> getAlarmMessageList(int userNo) throws Exception{
		return userEtcDao.getAlarmMessageList(userNo);
	}
	
	public void updateSearchRecordFlag(int userNo) throws Exception{
		userEtcDao.updateSearchRecordFlag(userNo);
	}
	
	public void deleteAlarmMessage(int alarmNo) throws Exception{
		userEtcDao.deleteAlarmMessage(alarmNo);
	}
	
	public void updateAlarmSetting(int userNo, int alarmSettingType) throws Exception{
		userEtcDao.deleteAlarmMessage(alarmSettingType);
	}
	
	public User getUserSettings(User user) {
		return userEtcDao.getUserSettings(user);
	}
	
//	public int addCertificationPost(CertificationPost certificationPost) throws Exception {
//		return userEtcDao.addCertificationPost(certificationPost);
//    }

//	@Override
//	public void updateBadgeImage() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}
//


//
//	@Override
//	public void updateAlarmSetting() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}
//

}
