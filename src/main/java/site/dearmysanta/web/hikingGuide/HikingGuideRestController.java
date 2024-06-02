package site.dearmysanta.web.hikingGuide;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import site.dearmysanta.service.hikingGuide.HikingGuideService;

@CrossOrigin(origins = "http://192.168.0.51:3000")
@RestController
@RequestMapping("/hikingGuide/*")
public class HikingGuideRestController {
	
	@Autowired
	@Qualifier("hikingGuideServiceImpl")
	private HikingGuideService hikingGuideService;
	
	public HikingGuideRestController() {
		System.out.println(this.getClass());
	}
	 
	@RequestMapping(value="react/addHikingRecord", method=RequestMethod.POST)
}
