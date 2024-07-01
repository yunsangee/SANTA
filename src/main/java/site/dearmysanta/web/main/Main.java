package site.dearmysanta.web.main;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.certificationPost.CertificationPost;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.meeting.MeetingPostSearch;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.certification.CertificationPostService;
import site.dearmysanta.service.common.ObjectStorageService;
import site.dearmysanta.service.meeting.MeetingService;
import site.dearmysanta.service.mountain.MountainService;
import site.dearmysanta.service.user.UserService;
import site.dearmysanta.service.user.etc.UserEtcService;
import site.dearmysanta.service.weather.WeatherService;

@Controller
public class Main {
	
	@Autowired
	private MountainService mountainService;
	
	@Autowired 
	WeatherService weatherService;
	
	@Autowired
	private MeetingService meetingService;
	
	@Autowired 
	private CertificationPostService certificationPostService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private UserEtcService userEtcService;
	
	@Autowired
	private ObjectStorageService objectStorageService;
	
	@Value("${pageSize}")
	private int pageSize;
	
	@Value("${pageUnit}")
	private int pageUnit;
	
	@Value("${javaServerIp}")
	private String javaServerIp;
	
	@Value("${reactServerIp}")
	private String reactServerIp;
	
	
//	@GetMapping(value="/")
//	public String getMountain(@RequestParam int mountainNo, double lat, double lon,Model model) { // 나중에 위도 경도는 현재 위치로 들어와야할듯? 
//		mountainService.updateMountainViewCount(mountainNo);
//		
//		SantaLogger.makeLog("info", mountainService.getMountain(mountainNo).getMountainImage());
//		model.addAttribute("mountain", mountainService.getMountain(mountainNo));
//		model.addAttribute("weatherList", weatherService.getWeatherList(lat, lon));
//		
//		
//		
//		return "forward:/mountain/getMountain.jsp";
//	}//o
	@GetMapping("/")
	public String mainTemp(Model model, HttpSession session) throws Exception {
		
		session.setAttribute("javaServerIp", javaServerIp);
		session.setAttribute("reactServerIp", reactServerIp);
		
		Search search = new Search();
		
		
		User user = (User)session.getAttribute("user");
		
		if(user != null) {
			search.setUserNo(user.getUserNo());
			
			if(user.getProfileImage() != null &   !user.getProfileImage().contains("ncloudstorage")&   !user.getProfileImage().contains("kakaocdn")) { // 이쪽 null check 필요 
				user.setProfileImage(objectStorageService.getImageURL(user.getProfileImage()));
			}
			session.setAttribute("alarmMessageList",userEtcService.getAlarmMessageList(user.getUserNo()));
			
		}else {
			search.setUserNo(-1);
			user = new User();
			user.setHikingDifficulty(-1);
			user.setUserNo(-1);
		}
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		MeetingPostSearch meetingPostSearch = new MeetingPostSearch();
		meetingPostSearch.setCurrentPage(1);
		meetingPostSearch.setPageSize(pageSize);
		meetingPostSearch.setPageUnit(pageUnit);
		
		
		List<CertificationPost> certificationPostList = (List<CertificationPost>) certificationPostService.getCertificationPostList(search).get("list");
        System.out.println(" certificationPostList  " + certificationPostList );
        List<String> certificationPostImages = new ArrayList<>();
        for (CertificationPost certificationPost : certificationPostList) {
            String fileName = certificationPost.getPostNo() + "_0_1"; // ù ��° ���� ���ϸ�
            String imageURL = objectStorageService.getImageURL(fileName);
            SantaLogger.makeLog("info", imageURL);
            certificationPostImages.add(imageURL);
        }
		
        if(search != null & search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

        
        
		session.setAttribute("popularMountainList", mountainService.getPopularMountainList(mountainService.getStatisticsMountainNameList(1),search));
		session.setAttribute("customMountainList", mountainService.getCustomMountainList(mountainService.getStatisticsMountainNameList(1), user));
		session.setAttribute("meetingPostList", meetingService.getMeetingPostList(meetingPostSearch).get("meetingPosts"));
		session.setAttribute("certificationPostList",certificationPostList);
		session.setAttribute("certificationPostImages", certificationPostImages);
		session.setAttribute("alarmMessageList", userEtcService.getAlarmMessageList(user.getUserNo()));
		
		
		
		return "forward:/common/main.jsp";
	}
//	
//	@GetMapping("/")
//	public String getStatistics(Model model) throws JsonProcessingException {
//
//		LocalDate today = LocalDate.now().minusDays(6);
//
//        // 날짜를 "YYYY-MM-DD" 형식으로 포맷
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
//        String formattedDate = today.format(formatter);
//        ObjectMapper objectMapper = new ObjectMapper();
//        SantaLogger.makeLog("info", mountainService.getStatisticsDaily(formattedDate).toString());
//        SantaLogger.makeLog("info", mountainService.getStatisticsWeekly().toString());
//		model.addAttribute("dailyStats", objectMapper.writeValueAsString(mountainService.getStatisticsDaily(formattedDate)));
//		model.addAttribute("weeklyStats", objectMapper.writeValueAsString(mountainService.getStatisticsWeekly()));
//
//		return "forward:/mountain/getStatistics.jsp";
//	}
	
}
