package site.dearmysanta.web.userEtc;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.alarmMessage.AlarmMessage;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.common.ObjectStorageService;
import site.dearmysanta.service.user.UserService;
import site.dearmysanta.service.user.etc.UserEtcService;

@RestController
@RequestMapping("/userEtc/*")
public class UserEtcRestController {
	@Autowired
	private UserEtcService userEtcService;
	
	@Autowired
	private UserService userService;
	
	public UserEtcRestController(){
		SantaLogger.makeLog("info", this.getClass().toString());
	}
	
	@Autowired
	private ObjectStorageService objectStorageService;
	
	@GetMapping(value="rest/addFollow")
	public int addFollow(@RequestParam int followerUserNo, int followingUserNo ) {
		userEtcService.addFollow(followerUserNo, followingUserNo);
		
		return userEtcService.getFollowerCount(followingUserNo);//following users Follower Count
	}//o
	
	@GetMapping(value="rest/deleteFollow")
	public int deleteFollow(@RequestParam int followerUserNo, int followingUserNo ) {
		userEtcService.deleteFollow(followerUserNo, followingUserNo);
		
		return userEtcService.getFollowerCount(followingUserNo);//following users Follower Count
	}//o
	
	
	@GetMapping(value="rest/getFollowerList")
	public List<User> getFollowerList(@RequestParam int userNo) {
	    List<User> followers = userEtcService.getFollowerList(userNo);
	    
	    for (User user : followers) {
	        if (user.getProfileImage() != null && !user.getProfileImage().contains("ncloudstorage")) {
	            user.setProfileImage(objectStorageService.getImageURL(user.getProfileImage()));
	        }
	        if (user.getBadgeImage() != null && !user.getBadgeImage().contains("ncloudstorage")) {
	            user.setBadgeImage(objectStorageService.getImageURL(user.getBadgeImage()));
	        }
	    }
	    
	    return followers;
	}

	
	@GetMapping(value="rest/getFollowingList")
	public List<User> getFollowingList(@RequestParam int userNo) {
	    List<User> following = userEtcService.getFollowingList(userNo);
	    
	    for (User user : following) {
	        if (user.getProfileImage() != null && !user.getProfileImage().contains("ncloudstorage")) {
	            user.setProfileImage(objectStorageService.getImageURL(user.getProfileImage()));
	        }
	        if (user.getBadgeImage() != null && !user.getBadgeImage().contains("ncloudstorage")) {
	            user.setBadgeImage(objectStorageService.getImageURL(user.getBadgeImage()));
	        }
	    }
	    
	    return following;
	}

	
	
	@PostMapping(value="rest/addAlarmMessage")
	public void addAlarmMessage(@RequestBody AlarmMessage alarmMessage) throws Exception {
		
		SantaLogger.makeLog("info", "alarmMessage:" + alarmMessage);
		User userSetting = User.builder().userNo(alarmMessage.getUserNo()).build();
		SantaLogger.makeLog("info", "userSetting:" + userSetting);
		userSetting = userEtcService.getUserSettings(userSetting);
		
		SantaLogger.makeLog("info", "userSetting:" + userSetting);
		if(userSetting.getAllAlertSetting() == 1 & ((alarmMessage.getPostTypeNo() == 0 & userSetting.getCertificationPostAlertSetting() == 1) | (alarmMessage.getPostTypeNo() == 1 & userSetting.getMeetingPostAlertSetting() == 1)) ) {
			userEtcService.addAlarmMessage(alarmMessage);
		}
	}//o
	
	
	@GetMapping(value="rest/deleteAlarmMessage")
	public void deleteAlarmMessage(@RequestParam int alarmNo) throws Exception {
		userEtcService.deleteAlarmMessage(alarmNo);
	}//o
	
	
	@GetMapping(value="rest/updateSearchRecordFlag")
	public void updateSearchRecordFlag(@RequestParam int userNo) throws Exception {
		userEtcService.updateSearchRecordFlag(userNo);
	}//o
	
	@GetMapping(value="rest/updateAlarmSetting")
	public void updateAlarmSetting(@RequestParam int userNo, int alarmSettingType, HttpSession session) throws Exception {
		SantaLogger.makeLog("info","userNo, alarmSettingType:" + userNo + " " + alarmSettingType);
		userEtcService.updateAlarmSetting(userNo, alarmSettingType);
		session.setAttribute("user", userService.getUser(userNo));
	}//o
	
	@GetMapping(value="rest/getUserSettings")
	public User getUserSettings(@RequestParam User user) {
		return userEtcService.getUserSettings(user);
	}//o
	
	@CrossOrigin(origins = "http://dearmysanta.site")
	@GetMapping(value="rest/getCount")
	public Map<String,Integer> getCount(HttpSession session) throws Exception{
		Map<String,Integer> map = new HashMap<String,Integer>();
		
		
		int userNo = ((User)session.getAttribute("user")).getUserNo();
		map.put("meetingPostCount", userEtcService.getMeetingCount(userNo));
		map.put("certificationPostCount", userEtcService.getCertificationCount(userNo));
		
		
		SantaLogger.makeLog("info",map.toString()+" :::::::");
		return map;
	}
	

}
