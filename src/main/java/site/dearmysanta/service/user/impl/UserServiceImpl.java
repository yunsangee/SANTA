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
	public List<User> getUserList(Search search) throws Exception {
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
	public void deleteUser(User user) throws Exception {
		// TODO Auto-generated method stub
        userDao.deleteUser(user);
		
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
	public void setUserPassword(String userId, String userPassword) throws Exception {
		// TODO Auto-generated method stub
		userDao.setUserPassword(userId, userPassword);

	}

	@Override
	public int checkPassword(String userId, String userPassword) throws Exception {
		// TODO Auto-generated method stub
		int checkPassword = userDao.checkPassword(userId, userPassword);
		if(checkPassword == 1) {
			
			return 1;
			
		} else {
			
			return 0;
		}
		
	}

	@Override
	public String checkDuplicationId(String userId) throws Exception {
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
	public String checkDuplicationNickName(String nickName) throws Exception {
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
	public QNA getQnA(int postNo, int userNo) throws Exception {
		return userDao.getQnA(postNo, userNo);
	}

	@Override
	public List<QNA> getQnAList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return userDao.getQnAList(search);
	}

	public void addAdminAnswer(QNA qna) throws Exception {
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
	public Schedule getSchedule(int postNo, int userNo) throws Exception {
		// TODO Auto-generated method stub
		return userDao.getSchedule(postNo, userNo);
	}

	@Override
	public List<Schedule> getScheduleList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return userDao.getScheduleList(search);
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
//	public User login(String userId, String password) throws Exception {
//		// TODO Auto-generated method stub
//		String login = userDao.login(userId, password);
//		
//		if (userId == null) {
//		       
//		        throw new Exception("사용자를 찾을 수 없습니다."); //  not exist UserId
//		    
//		    } else {
//		   
//		    return;
//		    
//		    }
//	}
	public User login(String userId, String password) throws Exception {
        // userId와 password를 사용하여 사용자를 조회
        //User user = userDao.login(userId, password);
        return userDao.login(userId, password);
        // 사용자가 존재하면 사용자 정보 반환, 존재하지 않으면 null 반환
        //return user;
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

	@Override
	public User getUserByUserId(String userId) throws Exception {
		// TODO Auto-generated method stub
		return userDao.getUserByUserId(userId);
	}

	@Override
	public String getUserPassword(String userPassword) throws Exception {
		// TODO Auto-generated method stub
		return userDao.getUserPassword(userPassword);
	}

	@Override
	public void updateAnswer(QNA qna) throws Exception {
		// TODO Auto-generated method stub
		userDao.updateAnswer(qna);
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return userDao.getTotalCount(search);
	}

	@Override
	public int getQnATotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return userDao.getQnATotalCount(search);
	}
	
}