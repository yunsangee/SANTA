package site.dearmysanta.service.user.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import site.dearmysanta.service.domain.user.QNA;
import site.dearmysanta.service.domain.user.Schedule;
import site.dearmysanta.service.domain.user.User;
import site.dearmysanta.service.user.UserDao;
import site.dearmysanta.service.user.UserService;

@Service("userServiceImpl")
@Transactional

	public class UserServiceImpl implements UserService {
	
	@Autowired
	@Qualifier("userDao")
	private UserDao userDao;

	@Override
	public void addUser(User user) throws Exception {
		// TODO Auto-generated method stub
		userDao.addUser(user);
		
	}

	@Override
	public User getUser(int userNo) throws Exception {
		return userDao.getUser(userNo);
	}

	@Override
	public List<User> getUserList() throws Exception {
		// TODO Auto-generated method stub
		return userDao.getUserList();
	}

	@Override
	public void updateUser(User user) throws Exception {
		// TODO Auto-generated method stub
		 userDao.updateUser(user);
		
	}

	@Override
	public void deleteUser(int userNo) throws Exception {
		// TODO Auto-generated method stub
		userDao.deleteUser(userNo);
		
	}

	@Override
	public User findUserId(String userId) throws Exception {
		// TODO Auto-generated method stub
		return userDao.findUserId(userId);
		
	}

	@Override
	public User findUserPassword(String userId) throws Exception {
		// TODO Auto-generated method stub
		return userDao.findUserPassword(userId);
		
	}

	@Override
	public User setUserPassword(String userId, String userPassword) throws Exception {
		// TODO Auto-generated method stub
		return userDao.setUserPassword(userId, userPassword);
		
	}

	@Override
	public User checkPassword(String userId, String userPassword) throws Exception {
		// TODO Auto-generated method stub
		return userDao.checkPassword(userId, userPassword);
		
	}

	@Override
	public User checkDuplicationId(String userId) throws Exception {
		// TODO Auto-generated method stub
		return userDao.checkDuplicationId(userId);
	}

	@Override
	public User checkDuplicationNickname(String nickName) throws Exception {
		// TODO Auto-generated method stub
		return userDao.checkDuplicationNickname(nickName);
	}

	@Override
	public User checkPhoneNumber(String phoneNumber) throws Exception {
		// TODO Auto-generated method stub
		return userDao.checkPhoneNumber(phoneNumber);
	}

	@Override
	public User sendVerifyCode(String phoneNumber) {
		// TODO Auto-generated method stub
		return userDao.sendVerifyCode(phoneNumber);
	}

	@Override
	public User confirmId(String userId, String verifyCode) throws Exception {
		// TODO Auto-generated method stub
		return userDao.confirmId(userId, verifyCode);
	}

	@Override
	public void addQnA(QNA qna) throws Exception {
		// TODO Auto-generated method stub
		userDao.addQnA(qna);
	}

	@Override
	public void getQnA(int postNo) throws Exception {
		// TODO Auto-generated method stub
		userDao.getQnA(postNo);
	}

	@Override
	public List<User> getQnAList() throws Exception {
		// TODO Auto-generated method stub
		return userDao.getQnAList();
	}

	@Override
	public void deleteQnA(int postNo) throws Exception {
		// TODO Auto-generated method stub
		userDao.deleteQnA(postNo);
	}

	@Override
	public void addSchedule(Schedule schedule) throws Exception {
		// TODO Auto-generated method stub
		userDao.addSchedule(schedule);
	}

	@Override
	public void getSchedule(int postNo) throws Exception {
		// TODO Auto-generated method stub
		userDao.getSchedule(postNo);
	}

	@Override
	public List<User> getScheduleList() throws Exception {
		// TODO Auto-generated method stub
		return userDao.getScheduleList();
	}

	@Override
	public void updateSchedule(Schedule schedule) throws Exception {
		// TODO Auto-generated method stub
		userDao.updateSchedule(schedule);
	}

	@Override
	public void deleteSchedule(int postNo) throws Exception {
		// TODO Auto-generated method stub
		userDao.deleteSchedule(postNo);
	}

	@Override
	public void getMountainTotalCount() throws Exception {
		// TODO Auto-generated method stub
		userDao.getMountainTotalCount();
	}

	
	
}