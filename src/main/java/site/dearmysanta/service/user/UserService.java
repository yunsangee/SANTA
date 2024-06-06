package site.dearmysanta.service.user;

import java.util.List;

import site.dearmysanta.domain.user.QNA;
import site.dearmysanta.domain.user.Schedule;
import site.dearmysanta.domain.user.User;

public interface UserService {
	
	//
	// User
	//
	
	public void addUser(User user) throws Exception;
	
	public User getUser(int userNo) throws Exception; // plus login
	
	public List<User> getUserList() throws Exception;
	
	public void updateUser(User user) throws Exception;
	
	public void deleteUser(int userNo) throws Exception;
	
	//
	// User id, password
	// 
	
	public String findUserId(String userName, String phoneNumber) throws Exception;
	
	public String findUserPassword(String userId, String phoneNumber) throws Exception;
	
	public User setUserPassword(String userId, String userPassword) throws Exception;
	
	//
	// User check and confirm
	//
	
	public int getPassword(String userId, String userPassword) throws Exception;
	
	public String getDuplicationId(String userId) throws Exception; 
	
	public String getDuplicationNickName(String nickName) throws Exception;
	
	public User checkPhoneNumber(String phoneNumber) throws Exception;
	
	public User sendVerifyCode(String phoneNumber);
	
	public User confirmId(String userId, String verifyCode) throws Exception; //confirm id = email 
	
	//
	// QNA
	//
	
	public void addQnA(QNA qna) throws Exception;
	
	public QNA getQnA(int postNo) throws Exception;
	
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
