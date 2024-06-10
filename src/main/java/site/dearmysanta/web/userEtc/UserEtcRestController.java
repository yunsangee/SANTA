package site.dearmysanta.web.userEtc;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.service.user.etc.UserEtcService;

@RestController
@RequestMapping("/userEtc/*")
public class UserEtcRestController {
	@Autowired
	private UserEtcService userEtcService;
	
	public UserEtcRestController(){
		SantaLogger.makeLog("info", this.getClass().toString());
	}
	
	
	@GetMapping(value="rest/addFollow")
	public int addFollow(@RequestParam int followerUserNo, int followingUserNo ) {
		userEtcService.addFollow(followerUserNo, followingUserNo);
		
		return userEtcService.getFollowerCount(followingUserNo);//following users Follower Count
	}
	
	@GetMapping(value="rest/deleteFollow")
	public int deleteFollow(@RequestParam int followerUserNo, int followingUserNo ) {
		userEtcService.deleteFollow(followerUserNo, followingUserNo);
		
		return userEtcService.getFollowerCount(followingUserNo);//following users Follower Count
	}
	

}
