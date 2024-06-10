package site.dearmysanta.web.mountain;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import site.dearmysanta.common.SantaLogger;
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
	
	public MountainController() {
		SantaLogger.makeLog("info", this.getClass().toString());
	}
	
	
	@GetMapping(value="getMountain")
	public String getMountain(int mountainNo, double lat, double lon,Model model) { // 나중에 위도 경도는 현재 위치로 들어와야할듯? 
		mountainService.updateMountainViewCount(mountainNo);
		
		model.addAttribute("mountain", mountainService.getMountain(mountainNo));
		model.addAttribute("weatherList", weatherService.getWeatherList(lat, lon));
		
		
		
		return "forward:/mountain/getMountain.jsp";
	}
	
	

}
