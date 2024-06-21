package site.dearmysanta.web.mountain;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.domain.mountain.MountainSearch;
import site.dearmysanta.domain.mountain.Weather;
import site.dearmysanta.domain.user.User;
import site.dearmysanta.service.certification.CertificationPostService;
import site.dearmysanta.service.correctionpost.CorrectionPostService;
import site.dearmysanta.service.meeting.MeetingService;
import site.dearmysanta.service.mountain.MountainService;
import site.dearmysanta.service.user.UserService;
import site.dearmysanta.service.weather.WeatherService;

@Controller
@RequestMapping("mountain/*")
public class MountainController {
	
	@Autowired
	private MountainService mountainService;
	
	@Autowired
	private WeatherService weatherService;
	
	@Autowired
	private CorrectionPostService correctionPostService;
	
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
	
	
	ObjectMapper objectMapper = new ObjectMapper();
	
	public MountainController() {
		SantaLogger.makeLog("info", this.getClass().toString());
	}
	
	
	@GetMapping(value="getMountain")
	public String getMountain(@RequestParam int mountainNo, double lat, double lon,Model model, HttpSession session) throws Exception { // 나중에 위도 경도는 현재 위치로 들어와야할듯? 
		mountainService.updateMountainViewCount(mountainNo);
		
		SantaLogger.makeLog("info", mountainService.getMountain(mountainNo).getMountainImage());
		
		Mountain mountain =  mountainService.getMountain(mountainNo);
		
		session.setAttribute("mountain", mountain);
		model.addAttribute("weatherList", weatherService.getWeatherList(lat, lon));
		
		model.addAttribute("meetingCount", meetingService.getMountainTotalCount(mountain.getMountainName()));
		model.addAttribute("certificationCount", certificationPostService.getTotalMountainCount(mountain.getMountainName()));
		model.addAttribute("scheduleCount", userService.getMountainTotalCount(mountain.getMountainName()));
		
		
		return "forward:/mountain/getMountain.jsp";
	}//o
	
	@GetMapping(value="updateMountain")
	public String updateMountain(@RequestParam int crpNo, @RequestParam int mountainNo, Model model) {
		
		//
		// need to get mountain info
		//
		SantaLogger.makeLog("info","updateMountainView");
		model.addAttribute("crpNo", crpNo);
		model.addAttribute("mountain",mountainService.getMountain(mountainNo));
		
		return "forward:/mountain/updateMountain.jsp";
	}
	
	
	
	@GetMapping(value="getMountainLikeList")
	public String getMountainLikeList(@ModelAttribute Search search, Model model) {
		
		if(search != null & search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		model.addAttribute("mountainList", mountainService.getMountainLikeList( search));
		
		return "forward:/mountain/getMountainLikeList.jsp";
	}//o
	
	
	@GetMapping(value="searchMountain")
	public String searchMountain(Model model, HttpSession session) {
		
		//
		//need to get userNo from session 
		//
		
		int userNo = -1;
		
		if(session.getAttribute("user") != null) {
			userNo = ((User)session.getAttribute("user")).getUserNo();
		}
		
		
		model.addAttribute("mountainSearchKeywords", mountainService.getSearchKeywordList(userNo)); //change to userno
		
		model.addAttribute("popularSearchKeywords",mountainService.getStatisticsMountainNameList(0));  //change to userNo
		
		
		
		return "forward:/mountain/searchMountain.jsp";
	}
	
	
	@RequestMapping(value="mapMountain")
	public String mapMountain(@ModelAttribute MountainSearch mountainSearch, Model model, HttpSession session) throws Exception {

		//
		//나중에 jsp쪽에 search Condition 추가하기    
		//

		SantaLogger.makeLog("info", "mountainSearch:" + mountainSearch.toString());
		if (mountainSearch.getSearchKeyword() != null) {

			if (mountainSearch.getSearchCondition() == 0 & session.getAttribute("user") != null) { // if condition is mountain
				mountainService.deleteSearchKeyword(mountainSearch);				
				mountainService.addSearchKeyword(mountainSearch);
			}

			List<Mountain> list = mountainService.getMountainListByName(mountainSearch.getSearchKeyword());
			List<String> weatherList = new ArrayList<>();
			
			List<String> jsonList = new ArrayList<>();
			for (Mountain mt : list) {
				SantaLogger.makeLog("info", mt.toString());

				jsonList.add(objectMapper.writeValueAsString(mt));
				weatherList.add(objectMapper.writeValueAsString(weatherService.getWeather(mt.getMountainLatitude(), mt.getMountainLongitude())));	
			}
			
			model.addAttribute("mountainList", jsonList);
			model.addAttribute("weatherList", weatherList);

		}

		return "forward:/mountain/mapMountain.jsp";
	}

	@GetMapping(value="getStatistics")
	public String getStatistics(Model model) throws JsonProcessingException {

		LocalDate today = LocalDate.now().minusDays(7);

        // 날짜를 "YYYY-MM-DD" 형식으로 포맷
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDate = today.format(formatter);

        SantaLogger.makeLog("info", mountainService.getStatisticsDaily(formattedDate).toString());
        SantaLogger.makeLog("info", mountainService.getStatisticsWeekly().toString());
		model.addAttribute("dailyStats", objectMapper.writeValueAsString(mountainService.getStatisticsDaily(formattedDate)));
		model.addAttribute("weeklyStats", objectMapper.writeValueAsString(mountainService.getStatisticsWeekly()));

		return "forward:/mountain/getStatistics.jsp";
	}

//	@GetMapping(value="main")
//	
//	public String getMain(Model model) throws Exception {
//		
//		Search search = new Search();
//		
//		
//		//
//		//나중에 세션 유저로 
//		//
//		
//		model.addAttribute("popularMountains", mountainService.getPopularMountainList(mountainService.getStatisticsMountainNameList(1)));
//		model.addAttribute("customMountains", mountainService.getCustomMountainList(mountainService.getStatisticsList(1), userService.getUser(1)));
//		model.addAttribute("meetingPosts", meetingService.getMeetingPost(1));
//		model.addAttribute("certificationPosts", certificationPostService.getCertificationPostList(search));
//		return "forward:/mountain/main.jsp";
//	}
	
	//
	//searchMountain
	//
//	@GetMapping(value="searchMountain")
//	public List<Mountain> getMountainListByName(String mountainName, Model model){
//		
//		model.addAttribute("mountainList", mountainService.getMountainListByName(mountainName));
//		return 
//	}
//	
	
	
	

}