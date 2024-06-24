package site.dearmysanta.web.hikingGuide;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import site.dearmysanta.domain.hikingguide.HikingAlert;
import site.dearmysanta.domain.hikingguide.HikingGuide;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.domain.mountain.Weather;
import site.dearmysanta.service.hikingGuide.HikingGuideService;
import site.dearmysanta.service.mountain.MountainService;
import site.dearmysanta.service.weather.WeatherService;

@CrossOrigin(origins = "https://www.dearmysanata.site")
@RestController
@RequestMapping("/hiking/*")
public class HikingGuideRestController {

    @Autowired
    @Qualifier("HikingGuideServiceImpl")
    private HikingGuideService hikingGuideService;

    @Autowired
    private WeatherService weatherService;
    
    @Autowired
    private MountainService mountainService;

    private HikingGuide userLocation; // Store the user location

    public HikingGuideRestController() {
        System.out.println(this.getClass());
        this.userLocation = new HikingGuide();  // Initialize the userLocation
    }

    @PostMapping(value = "/react/addHikingRecord")
    public void addHikingRecord(@RequestBody HikingGuide hikingGuide, Model model) throws Exception {
        System.out.println("HikingGuide: " + hikingGuide);
        hikingGuideService.addHikingRecord(hikingGuide);
        model.addAttribute("hikingGuide", hikingGuide);
    }

    @PostMapping(value = "/react/getHikingListRecord/{userNo}")
    public List<HikingGuide> getHikingListRecord(@PathVariable int userNo) throws Exception {
        return hikingGuideService.getHikingListRecord(userNo);
    }

    @PostMapping(value = "/react/getAlertSetting/{userNo}")
    public HikingAlert getAlertSetting(@PathVariable int userNo) throws Exception {
        return hikingGuideService.getAlertSetting(userNo);
    }

    @PostMapping(value = "/react/updateAlertSetting/{userNo}")
    public void updateAlertSetting(@PathVariable int userNo,
                                   @RequestBody Map<String, Integer> payload) throws Exception {
        System.out.println("Payload: " + payload);
        hikingGuideService.updateAlertSetting(userNo, payload);
    }

    @PostMapping(value = "/react/updateMeetingTime/{userNo}")
    public void updateMeetingTime(@PathVariable int userNo,
                                  @RequestBody Map<String, Object> payload) throws Exception {
        int meetingTimeAlert = (int) payload.get("meetingTimeAlert");
        String meetingTime = (String) payload.get("meetingTime");
        hikingGuideService.updateMeetingTime(userNo, meetingTimeAlert, meetingTime);
        System.out.println(meetingTime);
    }

    @PostMapping(value = "/react/deleteHikingRecord")
    public void deleteHikingRecord(@RequestBody List<Integer> hrNo) throws Exception {
        hikingGuideService.deleteHikingRecord(hrNo);
    }

    @PostMapping(value = "/react/getWeather")
    public Weather getWeather() throws Exception {
        if (userLocation.getUserLatitude() == 0 || userLocation.getUserLongitude() == 0) {
            throw new IllegalStateException("User coordinates are not set.");
        }

        System.out.println("User location: Latitude: " + userLocation.getUserLatitude() + " Longitude: " + userLocation.getUserLongitude());

        Weather weather = weatherService.getWeather(userLocation.getUserLatitude(), userLocation.getUserLongitude());
        if (weather == null) {
            throw new IllegalStateException("Weather information could not be retrieved.");
        }

        return weather;
    }
    
    @PostMapping(value = "/react/getMountain")
    public List<Mountain> getMountainsByUserCoordination() throws Exception {
        if (userLocation == null) {
            throw new IllegalStateException("User coordinates are not set.");
        }

        System.out.println("Fetching mountains for coordinates: Latitude: " + userLocation.getUserLatitude() 
        				+ " Longitude: " + userLocation.getUserLongitude());

        List<Mountain> mountains = mountainService.getMountainListByCoord(userLocation.getUserLatitude(),
        																	userLocation.getUserLongitude());
        return mountains;
    }

    @PostMapping(value = "/react/getUserCoordination")
    public void getUserCoordination(@RequestBody HikingGuide userLocation) {
        System.out.println("Receive user location: " + userLocation.getUserNo() + 
            " Latitude: " + userLocation.getUserLatitude() + 
            " Longitude: " + userLocation.getUserLongitude());

        this.userLocation = userLocation;
    }
}
