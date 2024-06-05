package site.dearmysanta.web.hikingGuide;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

import site.dearmysanta.domain.hikingguide.HikingAlert;
import site.dearmysanta.domain.hikingguide.HikingGuide;
import site.dearmysanta.service.hikingGuide.HikingGuideService;
import site.dearmysanta.service.hikingGuide.HikingGuideService.MountainInfo;

import java.util.List;

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

    @PostMapping(value = "react/addHikingRecord")
    public void addHikingRecord(@RequestBody HikingGuide hikingGuide) throws Exception {
        hikingGuideService.addHikingRecord(hikingGuide);
    }

    @GetMapping(value = "react/getHikingListRecord/{userNo}")
    public List<HikingGuide> getHikingListRecord(@PathVariable int userNo) throws Exception {
        return hikingGuideService.getHikingListRecord(userNo);
    }

    @GetMapping(value = "react/getAlertSetting/{userNo}")
    public HikingAlert getAlertSetting(@PathVariable int userNo) throws Exception {
        return hikingGuideService.getAlertSetting(userNo);
    }

    @PostMapping(value = "react/updateAlertSetting/{userNo}")
    public void updateAlertSetting(@PathVariable int userNo,
                                   @RequestParam(required = false) int hikingAlertFlag,
                                   @RequestParam(required = false) int destinationAlert,
                                   @RequestParam(required = false) int sunsetAlert,
                                   @RequestParam(required = false) int locationOverAlert,
                                   @RequestParam(required = false) int meetingTimeAlert) throws Exception {
        hikingGuideService.updateAlertSetting(userNo, hikingAlertFlag, destinationAlert, sunsetAlert, locationOverAlert, meetingTimeAlert);
    }


    @PostMapping(value = "react/updateMeetingTime/{userNo}")
    public void updateMeetingTime(@PathVariable int userNo,
                                  @RequestParam int meetingTimeAlert,
                                  @RequestParam int meetingTime) throws Exception {
        hikingGuideService.updateMeetingTime(userNo, meetingTimeAlert, meetingTime);
    }
    
    @DeleteMapping(value = "react/deleteHikingRecord/{hrNo}")
    public void deleteHikingRecord(@PathVariable int hrNo) throws Exception {
        hikingGuideService.deleteHikingRecord(hrNo);
    }
    

    @GetMapping(value = "react/getMountainInfo")
    public MountainInfo getMountainInfo() throws Exception {
        return hikingGuideService.getMountainInfo();
    }
    
    @PostMapping(value = "react/getUserCoordination")
    public void getUserCoordination(@RequestParam double userLatitude, @RequestParam double userLongitude, @RequestParam int userNo) throws Exception {
        hikingGuideService.getUserCoordination(userNo, userLatitude, userLongitude);
    }
    
}
