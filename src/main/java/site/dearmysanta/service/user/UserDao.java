package site.dearmysanta.service.user;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.user.QNA;
import site.dearmysanta.domain.user.Schedule;
import site.dearmysanta.domain.user.User;

@Mapper
@Component("userDao")

	public interface UserDao{
	
		// INSERT
		public void addUser(User user) throws Exception;
		
		// SELECT ONE
		public User getUser(int userNo) throws Exception;
		
		public User login(String userId, String password) throws Exception;
		
		public List<User> getUserList(Search search) throws Exception;
		
		public int getTotalCount(Search search) throws Exception;
		
		public List<User> withdrawUserList(Search search) throws Exception;
		
		public void updateUser(User user) throws Exception;
		
		public void deleteUser(User user) throws Exception;
		
		//
		//
		
		public String findUserId(String userName, String phoneNumber) throws Exception;
		
		public String findUserPassword(String userId, String phoneNumber) throws Exception;
		
		public void setUserPassword(String userId, String userPassword) throws Exception;
		
		public String findUserPhoneNumber(String phoneNumber) throws Exception;
		
		//
		//
		
		public int checkPassword(@Param("userId") String userId, @Param("userPassword") String userPassword) throws Exception;
		
		public String checkDuplicationId(@Param("userId") String userId) throws Exception; 
		
		public String checkDuplicationNickName(@Param("nickName") String nickName) throws Exception;
		
		public User checkPhoneNumber(String phoneNumber) throws Exception;
		
		public User sendVerifyCode(String phoneNumber);
		
		public User confirmId(String userId, String verifyCode) throws Exception;
		
		//
		//
		
		public void addQnA(QNA qna) throws Exception;
		
		public QNA getQnA(int postNo, int userNo) throws Exception;
		
		public List<QNA> getQnAList(Search search) throws Exception;
		
		public int getQnATotalCount(Search search) throws Exception;
		
		public void addAdminAnswer(QNA qna) throws Exception;
		
		public void updateAnswer(QNA qna) throws Exception;
		
		public void deleteQnA(int postNo, int userNo) throws Exception;
		
		//
		//
	
		public void addSchedule(Schedule schedule) throws Exception;
		
		public Schedule getSchedule(int postNo, int userNo) throws Exception;
		
		public List<Schedule> getScheduleList(int userNo, Search search) throws Exception;
		
		public void updateSchedule(Schedule schedule) throws Exception;
		
		public void deleteSchedule(int postNo, int userNo) throws Exception;
		
		//
		//
		
		public int getMountainTotalCount(String mountainName) throws Exception;

		public List<User> getUserByUserId(String userId) throws Exception;
		
		public String getUserPassword(String userPassword) throws Exception;
		
}
