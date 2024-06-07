package site.dearmysanta.web.hikingGuide;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

import site.dearmysanta.domain.hikingguide.HikingAlert;
import site.dearmysanta.domain.hikingguide.HikingGuide;
import site.dearmysanta.service.hikingGuide.HikingGuideService;
import site.dearmysanta.service.hikingGuide.HikingGuideService.MountainInfo;

import java.util.List;
import java.util.Map;

@CrossOrigin(origins = "http://192.168.0.51:3000")
@RestController
@RequestMapping("/hikingGuide/*")
public class HikingGuideRestController {

    @Autowired
    @Qualifier("HikingGuideServiceImpl")
    private HikingGuideService hikingGuideService;

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


    @PostMapping(value = "/react/updateAlertSetting/{userNo}", consumes = "application/json")
    public void updateAlertSetting(@PathVariable int userNo,
                                   @RequestBody Map<String, Integer> payload) throws Exception {
        System.out.println("Payload: " + payload);
        hikingGuideService.updateAlertSetting(userNo, payload);
    }



    @PostMapping(value = "/react/updateMeetingTime/{userNo}", consumes = "application/json")
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
    

    @GetMapping(value = "/react/getMountainInfo")
    public MountainInfo getMountainInfo() throws Exception {
        return hikingGuideService.getMountainInfo();
    }
    
    @PostMapping(value = "/react/getUserCoordination")
    public void getUserCoordination(@RequestBody HikingGuide userLocation) {
        System.out.println("Receive user location: " + userLocation.getUserNo() + 
            " Latitude: " + userLocation.getUserLatitude() + 
            " Longitude: " + userLocation.getUserLongitude());
      
    }
        
    
}
