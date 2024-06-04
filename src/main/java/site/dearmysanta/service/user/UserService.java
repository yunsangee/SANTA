package site.dearmysanta.service.user;

import java.util.List;

import site.dearmysanta.service.domain.user.QNA;
import site.dearmysanta.service.domain.user.Schedule;
import site.dearmysanta.service.domain.user.User;

public interface UserService {
	
	//
	// User
	//
	
	public void addUser(User user) throws Exception;
	
	public void addSurvey(User user) throws Exception;
	
	public User getUser(int userNo) throws Exception; // plus login
	
	public List<User> getUserList() throws Exception;
	
	public void updateUser(User user) throws Exception;
	
	public void deleteUser(int userNo) throws Exception;
	
	//
	// User id, password
	// 
	
	public User findUserId(String userId) throws Exception;
	
	public User findUserPassword(String userId) throws Exception;
	
	public User setUserPassword(String userId, String userPassword) throws Exception;
	
	//
	// User check and confirm
	//
	
	public User checkPassword(String userId, String userPassword) throws Exception;
	
	public User checkDuplicationId(String userId) throws Exception; 
	
	public User checkDuplicationNickname(String nickName) throws Exception;
	
	public User checkPhoneNumber(String phoneNumber) throws Exception;
	
	public User sendVerifyCode(String phoneNumber);
	
	public User confirmId(String userId, String verifyCode) throws Exception; //confirm id = email 
	
	//
	// QNA
	//
	
	public void addQnA(QNA qna) throws Exception;
	
	public void getQnA(int postNo) throws Exception;
	
	public List<User> getQnAList() throws Exception;
	
	public void deleteQnA(int postNo) throws Exception;
	
	//
	// Schedule
	//
	
	public void addSchedule(Schedule schedule) throws Exception;
	
	public void getSchedule(int postNo) throws Exception;
	
	public List<User> getScheduleList() throws Exception;
	
	public void updateSchedule(Schedule schedule) throws Exception;
	
	public void deleteSchedule(int postNo) throws Exception;
	
	
	//
	// etc : inherit
	//
	
	public void getMountainTotalCount() throws Exception;
	
	
}
