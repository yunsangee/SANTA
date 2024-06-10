package site.dearmysanta.service.user.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.user.QNA;
import site.dearmysanta.domain.user.Schedule;
import site.dearmysanta.domain.user.User;
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
	public Map<String, Object> getUserList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return userDao.getUserList(search);
	}
	
	public List<User> withdrawUserList(Search search) throws Exception {
		return userDao.withdrawUserList(search);
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
		
        //userDao.deleteUser(userNo);
		
	}

	@Override
	public String findUserId(String userName, String phoneNumber) throws Exception {
	    
	    String userId = userDao.findUserId(userName, phoneNumber); // confirm UserInfo
	    
	    if (userId == null) {
	       
	        throw new Exception("사용자를 찾을 수 없습니다."); //  not exist UserId
	    
	    } else {
	   
	    return userId;
	    
	    }
	}
	
	
	@Override
	public String findUserPassword(String userId, String phoneNumber) throws Exception {
		// TODO Auto-generated method stub
		
		String userPassword = userDao.findUserPassword(userId, phoneNumber);
		
		if (userPassword == null) {
			
			throw new Exception("비밀번호를 찾을 수 없습니다.");
		
		} else {
		
		return userPassword;
		
		}
		
	}

	@Override
	public User setUserPassword(String userId, String userPassword) throws Exception {
		// TODO Auto-generated method stub
		return userDao.setUserPassword(userId, userPassword);
		
	}

	@Override
	public int getPassword(String userId, String userPassword) throws Exception {
		// TODO Auto-generated method stub
		int checkPassword = userDao.checkPassword(userId, userPassword);
		if(checkPassword == 1) {
			
			return 1;
			
		} else {
			
			return 0;
		}
		
	}

	@Override
	public String getDuplicationId(String userId) throws Exception {
		// TODO Auto-generated method stub
		String duplicationId = userDao.checkDuplicationId(userId);
		if(duplicationId != null) {
			
			return duplicationId;
		
		} else {
			
			return null;
		}
		//return userDao.checkDuplicationId(userId);
	}

	@Override
	public String getDuplicationNickName(String nickName) throws Exception {
		// TODO Auto-generated method stub
		String duplicaionNickName = userDao.checkDuplicationNickName(nickName);
		if(duplicaionNickName != null) {
			
			return duplicaionNickName;
			
		} else {
			
			return null;
			
		}
		//return userDao.checkDuplicationNickName(nickName);
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
	public QNA getQnA(int postNo) throws Exception {
		return userDao.getQnA(postNo);
	}

	@Override
	public List<QNA> getQnAList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return userDao.getQnAList(search);
	}

	public void addAdminAnswer(QNA qna) {
		userDao.addAdminAnswer(qna);
	}
	@Override
	public void deleteQnA(int postNo, int userNo) throws Exception {
		// TODO Auto-generated method stub
		userDao.deleteQnA(postNo, userNo);
	}

	@Override
	public void addSchedule(Schedule schedule) throws Exception {
		// TODO Auto-generated method stub
		userDao.addSchedule(schedule);
	}

	@Override
	public Schedule getSchedule(int postNo) throws Exception {
		// TODO Auto-generated method stub
		return userDao.getSchedule(postNo);
	}

	@Override
	public List<Schedule> getScheduleList() throws Exception {
		// TODO Auto-generated method stub
		return userDao.getScheduleList();
	}

	@Override
	public void updateSchedule(Schedule schedule) throws Exception {
		// TODO Auto-generated method stub
		userDao.updateSchedule(schedule);
	}

	@Override
	public void deleteSchedule(int postNo, int userNo) throws Exception {
		// TODO Auto-generated method stub
		userDao.deleteSchedule(postNo, userNo);
	}

	@Override
	public int getMountainTotalCount(String mountainName) throws Exception {
		return userDao.getMountainTotalCount(mountainName);
	}

	@Override
	public String login(String userId, String password) throws Exception {
		// TODO Auto-generated method stub
		String login = userDao.login(userId, password);
		
		if (userId == null) {
		       
		        throw new Exception("사용자를 찾을 수 없습니다."); //  not exist UserId
		    
		    } else {
		   
		    return userId;
		    
		    }
	}

	@Override
	public String findUserPhoneNumber(String phoneNumber) throws Exception {
		// TODO Auto-generated method stub
		String phone = userDao.findUserPhoneNumber(phoneNumber); // confirm UserInfo
	    
	    if (phone == null) {
	       
	        throw new Exception("사용자를 찾을 수 없습니다."); //  not exist UserId
	    
	    } else {
	   
	    return phone;
	    
	    }
	}
	
	
}