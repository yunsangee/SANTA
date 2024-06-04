package site.dearmysanta.service.user;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import site.dearmysanta.service.domain.user.QNA;
import site.dearmysanta.service.domain.user.Schedule;
import site.dearmysanta.service.domain.user.User;

@Mapper
@Component("userDao")

	public interface UserDao{
	
		// INSERT
		public void addUser(User user) throws Exception;
		
		public void addSurvey(User user) throws Exception;
		
		// SELECT ONE
		public User getUser(int userNo) throws Exception;
		
		public List<User> getUserList() throws Exception;
		
		public void updateUser(User user) throws Exception;
		
		public void deleteUser(int userNo) throws Exception;
		
		//
		//
		
		public User findUserId(String userId) throws Exception;
		
		public User findUserPassword(String userId) throws Exception;
		
		public User setUserPassword(String userId, String userPassword) throws Exception;
		
		//
		//
		
		public User checkPassword(String userId, String userPassword) throws Exception;
		
		public User checkDuplicationId(String userId) throws Exception; 
		
		public User checkDuplicationNickname(String nickName) throws Exception;
		
		public User checkPhoneNumber(String phoneNumber) throws Exception;
		
		public User sendVerifyCode(String phoneNumber);
		
		public User confirmId(String userId, String verifyCode) throws Exception;
		
		//
		//
		
		public void addQnA(QNA qna) throws Exception;
		
		public void getQnA(int postNo) throws Exception;
		
		public List<User> getQnAList() throws Exception;
		
		public void deleteQnA(int postNo) throws Exception;
		
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
