package site.dearmysanta.service.user.etc.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.domain.user.etc.EtcDao;
import site.dearmysanta.service.domain.user.etc.EtcService;

@Service("etcServiceImpl")
@Transactional

	public class EtcServiceImpl implements EtcService {
	
	@Autowired
	@Qualifier("EtcDao")
	private EtcDao etcDao;

	@Override
	public void getCertificationCount() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getMeetingCount() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateCertificationCount() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateMeetingCount() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateBadgeImage() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addFollower() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<User> getFollowerList() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void getFollowerCount() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateRecordFlag() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addLikeAlarm() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addCommentAlarm() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<User> getAlarmList() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateAlarmSetting() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteAlarm() throws Exception {
		// TODO Auto-generated method stub
		
	}

}
