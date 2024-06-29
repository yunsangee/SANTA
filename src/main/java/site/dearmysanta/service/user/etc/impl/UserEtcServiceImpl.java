package site.dearmysanta.service.user.etc.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import site.dearmysanta.domain.alarmMessage.AlarmMessage;
import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.user.UserService;
import site.dearmysanta.service.user.etc.UserEtcDao;
import site.dearmysanta.service.user.etc.UserEtcService;
import site.dearmysanta.service.user.impl.UserServiceImpl;

@Service
@Transactional

	public class UserEtcServiceImpl implements UserEtcService {
	
	@Autowired
	@Qualifier("userEtcDao")
	private UserEtcDao userEtcDao;
	
	
	@Autowired
	private UserServiceImpl userSerivceImpl;

	@Override
	public int getCertificationCount(int userNo) throws Exception {
		// TODO Auto-generated method stub
		return userEtcDao.getCertificationCount(userNo);
	}//directly use

	@Override
	public int getMeetingCount(int userNo) throws Exception {
		// TODO Auto-generated method stub
		return userEtcDao.getMeetingCount(userNo);
		
	}//directly use

	@Override
	public void updateCertificationCount(int userNo,int type) throws Exception {
		// TODO Auto-generated method stub
		userEtcDao.updateCertificationCount(userNo,type);
		
		
		int sumVal = userEtcDao.getCertificationCount(userNo) + userEtcDao.getMeetingCount(userNo);
		
		if(sumVal == 200) {
			userSerivceImpl.updateBadgeImage("badge2.png", userNo);
		}else if(sumVal==300) {
			userSerivceImpl.updateBadgeImage("badge3.png", userNo);
		}else if(sumVal==400) {
			userSerivceImpl.updateBadgeImage("badge4.png", userNo);
		}else if(sumVal==500) {
			userSerivceImpl.updateBadgeImage("badge5.png", userNo);
		}
		else if(sumVal==600) {
			userSerivceImpl.updateBadgeImage("badge6.png", userNo);
		}
		else if(sumVal==700) {
			userSerivceImpl.updateBadgeImage("badge7.png", userNo);
		}
		
	} //directly use

	@Override
	public void updateMeetingCount(int userNo,int type) throws Exception {
		// TODO Auto-generated method stub
		userEtcDao.updateMeetingCount(userNo,type);
		

		int sumVal = userEtcDao.getCertificationCount(userNo) + userEtcDao.getMeetingCount(userNo);
		
		if(sumVal == 200) {
			userSerivceImpl.updateBadgeImage("badge2.png", userNo);
		}else if(sumVal==300) {
			userSerivceImpl.updateBadgeImage("badge3.png", userNo);
		}else if(sumVal==400) {
			userSerivceImpl.updateBadgeImage("badge4.png", userNo);
		}else if(sumVal==500) {
			userSerivceImpl.updateBadgeImage("badge5.png", userNo);
		}
		else if(sumVal==600) {
			userSerivceImpl.updateBadgeImage("badge6.png", userNo);
		}
		else if(sumVal==700) {
			userSerivceImpl.updateBadgeImage("badge7.png", userNo);
		}
		
	} //directly use

	
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
	} //directly use
	
	public int getFollowingCount(int userNo) {
		return userEtcDao.getFollowingCount( userNo);
	}//directly use
	
	
	public int isFollowing(int followerNo, int followingNo) {
		return userEtcDao.isFollowing(followerNo, followingNo);
	}
	
	
	public void addAlarmMessage(AlarmMessage alarmMessage) throws Exception{
		
		
		userEtcDao.addAlarmMessage(alarmMessage);
	}
	
	public List<AlarmMessage> getAlarmMessageList(int userNo) throws Exception{
		List<AlarmMessage> list = userEtcDao.getAlarmMessageList(userNo);
		
		for(AlarmMessage alarmMessage : list) {
			String sentence = alarmMessage.getUserName()+"님!" + alarmMessage.getTitle();
			
			if(alarmMessage.getPostTypeNo() == 0) {
				sentence += " 인증게시글에 ";
			}else {
				sentence += " 모임게시글에 ";
			}
			
			if(alarmMessage.getAlarmTypeNo() == 0) {
				sentence += "좋아요가 달렸어요!";
			}else {
				sentence += "댓글이 달렸어요!";
			}
				
			alarmMessage.setMessage(sentence);
				
		}
		return list;
	}
	
	public void updateSearchRecordFlag(int userNo) throws Exception{
		userEtcDao.updateSearchRecordFlag(userNo);
	}
	
	public void deleteAlarmMessage(int alarmNo) throws Exception{
		userEtcDao.deleteAlarmMessage(alarmNo);
	}
	
	public void updateAlarmSetting(int userNo, int alarmSettingType) throws Exception{
		userEtcDao.updateAlarmSetting(userNo, alarmSettingType);
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
