package site.dearmysanta.web.main;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

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
	
//	@GetMapping("/")
//	public String mainTemp() {
//		return "forward:/mountain/mainTemp.jsp";
//	}
	
	@GetMapping("/")
	public String getStatistics(Model model) throws JsonProcessingException {

		LocalDate today = LocalDate.now().minusDays(3);

        // 날짜를 "YYYY-MM-DD" 형식으로 포맷
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String formattedDate = today.format(formatter);
        ObjectMapper objectMapper = new ObjectMapper();
        SantaLogger.makeLog("info", mountainService.getStatisticsDaily(formattedDate).toString());
        SantaLogger.makeLog("info", mountainService.getStatisticsWeekly().toString());
		model.addAttribute("dailyStats", objectMapper.writeValueAsString(mountainService.getStatisticsDaily(formattedDate)));
		model.addAttribute("weeklyStats", objectMapper.writeValueAsString(mountainService.getStatisticsWeekly()));

		return "forward:/mountain/getStatistics.jsp";
	}
	
}
