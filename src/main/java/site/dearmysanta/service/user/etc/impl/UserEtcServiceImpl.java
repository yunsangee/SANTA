package site.dearmysanta.service.user.etc.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

//	@Override
//	public void updateBadgeImage() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public void addFollower() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public List<User> getFollowerList() throws Exception {
//		// TODO Auto-generated method stub
//		return null;
//	}
//
//	@Override
//	public void getFollowerCount() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public void updateRecordFlag() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public void addLikeAlarm() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public void addCommentAlarm() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public List<User> getAlarmList() throws Exception {
//		// TODO Auto-generated method stub
//		return null;
//	}
//
//	@Override
//	public void updateAlarmSetting() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public void deleteAlarm() throws Exception {
//		// TODO Auto-generated method stub
//		
//	}

}
