package site.dearmysanta.web.main;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

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
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.meeting.MeetingPostSearch;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.certification.CertificationPostService;
import site.dearmysanta.service.meeting.MeetingService;
import site.dearmysanta.service.mountain.MountainService;
import site.dearmysanta.service.user.UserService;
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
	
	@Value("${pageSize}")
	private int pageSize;
	
	@Value("${pageUnit}")
	private int pageUnit;
	
	@Value("${javaServerIp}")
	private String javaServerIp;
	
	@Value("${reactServerIp")
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
		if(search != null & search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		User user = (User)session.getAttribute("user");
		
		if(user != null) {
			search.setUserNo(user.getUserNo());
		}else {
			search.setUserNo(-1);
		}
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		MeetingPostSearch meetingPostSearch = new MeetingPostSearch();
		
		session.setAttribute("popularMountainList", mountainService.getPopularMountainList(mountainService.getStatisticsMountainNameList(1),search));
		session.setAttribute("customMountainList", mountainService.getCustomMountainList(mountainService.getStatisticsMountainNameList(1), user));
//		model.addAttribute("meetingPostList", meetingService.getMeetingPostList(meetingPostSearch));
//		model.addAttribute("certificationPostList",certificationPostService.getCertificationPostList(search));
		
		
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
