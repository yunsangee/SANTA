package site.dearmysanta.hikingguide;

import org.junit.Assert;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import site.dearmysanta.SantaApplication;
import site.dearmysanta.domain.hikingguide.HikingAlert;
import site.dearmysanta.domain.hikingguide.HikingGuide;
import site.dearmysanta.service.hikingGuide.HikingGuideDao;
import site.dearmysanta.service.hikingGuide.HikingGuideService;
import site.dearmysanta.service.hikingGuide.impl.HikingGuideServiceImpl;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = SantaApplication.class)
public class HikingGuideApplicationTest {

    @Autowired
    private HikingGuideServiceImpl hikingGuideServiceImpl;

    @Autowired
    private HikingGuideDao hikingGuideDao;
    
    @Autowired
    private HikingGuideService hikingGuideService;

    //@Test
    public void addHikingRecord() throws Exception {
        // Create a HikingGuide object with sample data
        HikingGuide hikingGuide = new HikingGuide();
       
        hikingGuide.setUserNo(1);
        hikingGuide.setTotalTime("3:30");
        hikingGuide.setUserDistance(10);
        hikingGuide.setAscentTime("20");
        hikingGuide.setDescentTime("30");
        hikingGuide.setHikingDate(java.sql.Date.valueOf("2023-06-01"));
        
        // Add the hiking record
        hikingGuideServiceImpl.addHikingRecord(hikingGuide);
        System.out.println(hikingGuide);
    }
    
    
    //@Test
    public void getHikingListRecord() throws Exception {
        // Create a HikingGuide object with sample data
        HikingGuide hikingGuide = new HikingGuide();
        
  
        // Test retrieving hiking records for the user with userNo 1
        List<HikingGuide> records = hikingGuideServiceImpl.getHikingListRecord(1);
        //List<HikingGuide> records = hikingGuideDao.getHikingListRecord(1);
        
        System.out.println(records.get(0));
      for(HikingGuide record : records) {
        System.out.println("getHiking :"+record);
      }
    }
    
    @Test
//    public void updateAlertSetting() throws Exception {
//        // 1. Initial setup: Get the existing alert settings for a user with userNo 1
//        HikingAlert hikingAlert = hikingGuideService.getAlertSetting(1);
//        Assert.assertNotNull(hikingAlert);
//        
//        // 2. Verify initial conditions: Check the initial userNo or any other relevant initial values
//        Assert.assertEquals(1, hikingAlert.getUserNo()); // assuming userNo is a field in HikingAlert
//
//        // 3. Update settings: Set new alert values
//        hikingAlert.setHikingAlertFlag(1);
//        hikingAlert.setDestinationAlert(0);
//        hikingAlert.setLocationOverAlert(0);
//        hikingAlert.setSunsetAlert(0);
//        hikingAlert.setMeetingTimeAlert(0);
//
//         // 4. Perform the update: Call the service method to update the settings
//       hikingGuideService.updateAlertSetting(
//            hikingAlert.getUserNo(), 
//            hikingAlert.getHikingAlertFlag(), 
//            hikingAlert.getDestinationAlert(), 
//            hikingAlert.getLocationOverAlert(), 
//            hikingAlert.getSunsetAlert(), 
//            hikingAlert.getMeetingTimeAlert()
//        );
//
//        // 5. Verify the update: Get the updated settings and verify the changes
//        HikingAlert updatedHikingAlert = hikingGuideService.getAlertSetting(1);
//        Assert.assertNotNull(updatedHikingAlert);
//        Assert.assertEquals(1, updatedHikingAlert.getHikingAlertFlag());
//        Assert.assertEquals(0, updatedHikingAlert.getDestinationAlert());
//        Assert.assertEquals(0, updatedHikingAlert.getLocationOverAlert());
//        Assert.assertEquals(0, updatedHikingAlert.getSunsetAlert());
//        Assert.assertEquals(0, updatedHikingAlert.getMeetingTimeAlert());
//
//        // Optionally print the updated settings for debugging
//        System.out.println(updatedHikingAlert);
//    }

    
  //@Test
    public void getAlertSetting() throws Exception{
    	
     	
    	HikingAlert alert = hikingGuideServiceImpl.getAlertSetting(1);
    	
    	System.out.println(alert);
    	   	
    }
    
    @Test
    public void deleteHikingRecord() throws Exception{
             
        int rowsAffected = hikingGuideService.deleteHikingRecord(2);

        assertEquals(1, rowsAffected, "Number of rows deleted should be 1");
    }
}
