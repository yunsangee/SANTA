package site.dearmysanta.service.user;

import java.util.Date;
import java.util.List;
import java.util.Map;

import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.user.QNA;
import site.dearmysanta.domain.user.Schedule;
import site.dearmysanta.domain.user.User;

public interface UserService {
	
	//
	// User
	//
	
	public void addUser(User user) throws Exception;
	
	public User getUser(int userNo) throws Exception; 
	
	public User login(String userId, String password) throws Exception;
	
	public List<User> getUserList(Search search) throws Exception;
	
	public List<User> withdrawUserList(Search search) throws Exception;
	
	public void updateUser(User user) throws Exception;
	
	public void deleteUser(User user) throws Exception;
	
	//
	// User id, password
	// 
	
	public String findUserId(String userName, String phoneNumber) throws Exception;
	
	public String findUserPassword(String userId, String phoneNumber) throws Exception;
	
	public void setUserPassword(String userId, String userPassword) throws Exception;
	
	public String findUserPhoneNumber(String phoneNumber) throws Exception;
	
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
	
	public QNA getQnA(int postNo, int userNo) throws Exception;
	
	public List<QNA> getQnAList(Search search) throws Exception;
	
	public void addAdminAnswer(QNA qna) throws Exception;
	
	public void deleteQnA(int postNo, int userNo) throws Exception;
	
	//
	// Schedule
	//
	
	public void addSchedule(Schedule schedule) throws Exception;
	
	public Schedule getSchedule(int postNo, int userNo) throws Exception;
	
	public List<Schedule> getScheduleList(Search search) throws Exception;
	
	public void updateSchedule(Schedule schedule) throws Exception;
	
	public void deleteSchedule(int postNo, int userNo) throws Exception;
	
	
	//
	// etc : inherit
	//
	
	public int getMountainTotalCount(String mountainName) throws Exception;

	public User getUserByUserId(String userId) throws Exception;

	
	
}
