package site.dearmysanta.web.mountain;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import site.dearmysanta.common.SantaLogger;
import site.dearmysanta.domain.common.Like;
import site.dearmysanta.domain.common.Search;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.service.mountain.MountainService;
import site.dearmysanta.service.weather.WeatherService;

@Controller
@RequestMapping("mountain/*")
public class MountainController {
	
	@Autowired
	private MountainService mountainService;
	
	@Autowired
	private WeatherService weatherService;
	
	
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
	
	
	
	
	

}
