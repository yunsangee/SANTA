package site.dearmysanta.web.hikingGuide;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

import site.dearmysanta.domain.hikingguide.HikingAlert;
import site.dearmysanta.domain.hikingguide.HikingGuide;
import site.dearmysanta.domain.mountain.Weather;
import site.dearmysanta.service.hikingGuide.HikingGuideService;
import site.dearmysanta.service.weather.WeatherService;

@CrossOrigin(origins = "http://localhost:3000")
@RestController
@RequestMapping("/hikingGuide/*")
public class HikingGuideRestController {

    @Autowired
    @Qualifier("HikingGuideServiceImpl")
    private HikingGuideService hikingGuideService;

    @Autowired
    private WeatherService weatherService;

    public HikingGuideRestController() {
        System.out.println(this.getClass());
    }

    @PostMapping(value = "/react/addHikingRecord")
    public void addHikingRecord(@RequestBody HikingGuide hikingGuide) throws Exception {
        System.out.println("HikingGuide: " + hikingGuide);
        hikingGuideService.addHikingRecord(hikingGuide);
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

    @DeleteMapping(value = "/react/deleteHikingRecord/{hrNo}")
    public void deleteHikingRecord(@PathVariable int hrNo) throws Exception {
        hikingGuideService.deleteHikingRecord(hrNo);
    }

    @GetMapping(value = "/react/getWeatherInfo")
    public Weather getWeatherInfo(@RequestParam double latitude, @RequestParam double longitude) throws Exception {
        System.out.println("User location: Latitude: " + latitude + " Longitude: " + longitude);

        Weather weather = weatherService.getWeather(latitude, longitude);
        if (weather == null) {
            throw new IllegalStateException("Weather information could not be retrieved.");
        }

        return weather;
    }

    @PostMapping(value = "/react/getUserCoordination")
    public void getUserCoordination(@RequestBody HikingGuide userLocation) {
        System.out.println("Receive user location: " + userLocation.getUserNo() + 
            " Latitude: " + userLocation.getUserLatitude() + 
            " Longitude: " + userLocation.getUserLongitude());
    }
}
