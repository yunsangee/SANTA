package site.dearmysanta.mountain;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import site.dearmysanta.SantaApplication;
import site.dearmysanta.domain.alarmMessage.AlarmMessage;
import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.certification.CertificationPostService;
import site.dearmysanta.service.user.UserService;
import site.dearmysanta.service.user.etc.UserEtcService;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SantaApplication.class)
//@Transactional
public class UserEtcApplicationTest {

	@Autowired
	UserEtcService userEtcService;
	
	@Autowired
	CertificationPostService certificationPostService;
	
	@Autowired
	UserService userService;
	
	//@Test
	public void userEtcTest() throws Exception {
		
		System.out.println(userEtcService.getCertificationCount(1));
		System.out.println(userEtcService.getCertificationCount(1));
		
		userEtcService.updateCertificationCount(1);
		userEtcService.updateMeetingCount(1);
		
		System.out.println(userEtcService.getCertificationCount(1));
		System.out.println(userEtcService.getCertificationCount(1));
		
		
		
	}
	
	
//	@Test
	public void userFollowTest() {
		
		userEtcService.addFollow(1, 2);
		userEtcService.addFollow(1, 3);
		userEtcService.addFollow(2, 1);
		
		
		List<User> list = userEtcService.getFollowingList(1);
		
		for(User user: list) {
			System.out.println(user.getUserNo());
		}
		System.out.println(userEtcService.getFollowingCount(1));
		System.out.println("=============");
		
		list = userEtcService.getFollowerList(1);
		for(User user: list) {
			System.out.println(user.getUserNo());
		}
		System.out.println(userEtcService.getFollowerCount(1));
		System.out.println("=============");
		
		userEtcService.deleteFollow(1,2);
		userEtcService.deleteFollow(1,3);
		userEtcService.deleteFollow(2,1);
		
		
		
	}
	
//	@Test
	public void alarmMessageTest() throws Exception {
		AlarmMessage alarmMessage = 
				AlarmMessage.builder().userNo(1).title("title1").alarmTypeNo(0).postTypeNo(0).build();
		
		AlarmMessage alarmMessage2 = 
				AlarmMessage.builder().userNo(1).title("title2").alarmTypeNo(0).postTypeNo(1).build();
		AlarmMessage alarmMessage3 = 
				AlarmMessage.builder().userNo(1).title("title3").alarmTypeNo(1).postTypeNo(0).build();
		AlarmMessage alarmMessage4 = 
				AlarmMessage.builder().userNo(1).title("title4").alarmTypeNo(1).postTypeNo(1).build();
	
	
		userEtcService.addAlarmMessage(alarmMessage);
		userEtcService.addAlarmMessage(alarmMessage2);
		userEtcService.addAlarmMessage(alarmMessage3);
		userEtcService.addAlarmMessage(alarmMessage4);
		
		List<AlarmMessage> list = userEtcService.getAlarmMessageList(1);
		
		for(AlarmMessage alarmMessage5 : list) {
			String sentence = alarmMessage5.getUserName()+"nim! " + alarmMessage5.getTitle();
			
			if(alarmMessage5.getPostTypeNo() == 0) {
				sentence += " certification Post ";
			}else {
				sentence += " meeting Post ";
			}
			
			if(alarmMessage5.getAlarmTypeNo() == 0) {
				sentence += "add like!";
			}else {
				sentence += "add comment!";
			}
				
			System.out.println(alarmMessage5);
			System.out.println(sentence);
				
		}
		
		System.out.println("====================");
		
		for(AlarmMessage alarmMessage5 : list) {
			userEtcService.deleteAlarmMessage(alarmMessage5.getAlarmNo());
		}
		
		for(AlarmMessage alarmMessage5 : list) {
			System.out.println(alarmMessage5);
		}
		
	}
	
	@Test
	public void settingTest() throws Exception {
		
		User user = userService.getUser(1);
		System.out.println(user);
		
		
		User userA = userEtcService.getUserSettings(user);
		System.out.println(userA);
		
		userEtcService.updateSearchRecordFlag(1);
		userEtcService.updateAlarmSetting(1,0);
		userEtcService.updateAlarmSetting(1,1);
		userEtcService.updateAlarmSetting(1,2);
		userEtcService.updateAlarmSetting(1,3);
		
		user.setAllAlertSetting(userA.getAllAlertSetting());
        user.setCertificationPostAlertSetting(userA.getCertificationPostAlertSetting());
        user.setMeetingPostAlertSetting(userA.getMeetingPostAlertSetting());
        user.setHikingGuideAlertSetting(userA.getHikingGuideAlertSetting());
        
        System.out.println(user);
		
		
	}
	
	
	
//	@Test
//	   public void testAddCertificationPost() throws Exception {
//	       // CertificationPost 객체를 생성합니다.
//	       CertificationPost certificationPost = CertificationPost.builder()
//	           .userNo(2)
//	           .title("Certification Post")
//	           .contents("This is a certification post.")
//	           .certificationPostMountainName("1111")
//	           .certificationPostHikingTrail("Base Camp")
//	           .certificationPostTotalTime("4:30")
//	           .certificationPostAscentTime("2:00")
//	           .certificationPostDescentTime("2:30")
//	           .certificationPostHikingDate("2024-06-01")
//	           .certificationPostTransportation(1)
//	           .certificationPostHikingDifficulty(1)
//	          // .certificationPostHashtagContents( "222")
//	           .build();
//
//	       // addCertificationPost 메서드 호출
////	       certificationPost.setCertificationPostNo(userEtcService.addCertificationPost(certificationPost));
//	       userEtcService.addCertificationPost(certificationPost);
//	       
//	       userETcService.addHashTag(int postNo, String hashtags);
//	       
//	       
//	       public void addHashTag(int postNo, String hashtags);
//	       // 로그 출력
//	       System.out.println(certificationPost.toString());
//	   }
//	
//	
//	public void addCertification(CertificationPost certificationPost) {
//		certificationPostDao.addCertificationPost(certificationPost);
//		certificationPostDao.addHashTags(certificationPost.getCertificationPostNo(), certificationPost.getCertificationPostHashtag());
//	}
//	
//	<insert id="addHashTags" parameterType="map">
//		INSERT INTO HASHTAG (HASHTAG_NO, CP_NO, HASHTAG_CONTENT)
//		VALUES (seq_HASHTAG_NO, #{postNo}, #{hashtags})
//	</insert>

	
	
	
	
	
}
