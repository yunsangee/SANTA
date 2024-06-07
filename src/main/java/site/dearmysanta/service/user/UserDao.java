package site.dearmysanta.service.user;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

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
		
		public List<User> getUserList() throws Exception;
		
		public void updateUser(User user) throws Exception;
		
		public void deleteUser(int userNo) throws Exception;
		
		//
		//
		
		public String findUserId(String userName, String phoneNumber) throws Exception;
		
		public String findUserPassword(String userId, String phoneNumber) throws Exception;
		
		public User setUserPassword(String userId, String userPassword) throws Exception;
		
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
		
		public QNA getQnA(int postNo) throws Exception;
		
		public List<QNA> getQnAList() throws Exception;
		
		public void addAdminAnswer(int postNo, String adminAnswer);
		
		public void deleteQnA(int postNo, int userNo) throws Exception;
		
		//
		//
	
		public void addSchedule(Schedule schedule) throws Exception;
		
		public void getSchedule(int postNo) throws Exception;
		
		public List<User> getScheduleList() throws Exception;
		
		public void updateSchedule(Schedule schedule) throws Exception;
		
		public void deleteSchedule(int postNo) throws Exception;
		
		//
		//
		
		public void getMountainTotalCount() throws Exception;
		
}
