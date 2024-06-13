package site.dearmysanta.web.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.common.Search;
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
	private MeetingService meetingService;
	
	@Autowired 
	private CertificationPostService certificationPostService;
	
	@Autowired
	private UserService userService;
	
	@Value("${pageSize}")
	private int pageSize;
	
	@Value("${pageUnit}")
	private int pageUnit;
	
	@GetMapping("/")
	public String mainController(Model model) throws Exception {
		
		Search search = new Search();// 나중에 이거 없게 바꿔야지 
		
		search.setCurrentPage(1);
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		
		search.setSearchKeyword("");
		
		
		model.addAttribute("popularMountains", mountainService.getPopularMountainList(mountainService.getStatisticsMountainNameList(0),search));
		model.addAttribute("customMountains", mountainService.getCustomMountainList(mountainService.getStatisticsMountainNameList(0), userService.getUser(1)));
		model.addAttribute("meetingPost", meetingService.getMeetingPost(1));
		
		SantaLogger.makeLog("info","cp::" +  certificationPostService.getCertificationPostList(search));
		model.addAttribute("certificationPosts", certificationPostService.getCertificationPostList(search).get("list"));
		return "forward:/mountain/main.jsp";
//		return "redirect:/mountain/mapMountain.jsp";
	}
	
}
