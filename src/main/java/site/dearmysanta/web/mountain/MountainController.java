package site.dearmysanta.web.mountain;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.service.certification.CertificationPostService;
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
	private MeetingService meetingService;
	
	@Autowired 
	private CertificationPostService certificationPostService;
	
	@Autowired
	private UserService userService;
	
	
	@Value("${pageSize}")
	private int pageSize;
	
	@Value("${pageUnit}")
	private int pageUnit;
	
	public MountainController() {
		SantaLogger.makeLog("info", this.getClass().toString());
	}
	
	
	@GetMapping(value="getMountain")
	public String getMountain(@RequestParam int mountainNo, double lat, double lon,Model model) { // 나중에 위도 경도는 현재 위치로 들어와야할듯? 
		mountainService.updateMountainViewCount(mountainNo);
		
		SantaLogger.makeLog("info", mountainService.getMountain(mountainNo).getMountainImage());
		model.addAttribute("mountain", mountainService.getMountain(mountainNo));
		model.addAttribute("weatherList", weatherService.getWeatherList(lat, lon));
		
		
		
		return "forward:/mountain/getMountain.jsp";
	}//o
	
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
	public String searchMountain(Model model) {
		
		//
		//need to get userNo from session 
		//
		
		
		model.addAttribute("mountainSearchKeywords", mountainService.getSearchKeywordList(1));
		
		model.addAttribute("popularSearchKeywords",mountainService.getStatisticsList(0,0));
		
		
		
		return "forward:/mountain/searchMountain.jsp";
	}
	
	
	@GetMapping(value="mapMountain")
	public String mapMountain(Search search, Model model) throws JsonProcessingException {
		
		
		List<Mountain> list = mountainService.getMountainListByName(search.getSearchKeyword());
		
		List<String> jsonList = new ArrayList<>();
		ObjectMapper objectMapper = new ObjectMapper();
		for (Mountain mt: list) {
			SantaLogger.makeLog("info", mt.toString());
			
		   jsonList.add(objectMapper.writeValueAsString(mt));
		}
		
		model.addAttribute("mountainList", jsonList);
		
		return "forward:/mountain/mapMountain.jsp";
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
