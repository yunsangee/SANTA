package site.dearmysanta.hikingguide;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import site.dearmysanta.SantaApplication;
import site.dearmysanta.domain.hikingguide.HikingGuide;
import site.dearmysanta.service.hikingGuide.HikingGuideDao;
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

   // @Test
    public void addHikingRecord() throws Exception {
        // Create a HikingGuide object with sample data
        HikingGuide hikingGuide = new HikingGuide();
        hikingGuide.setHrNo(1);
        hikingGuide.setUserNo(1);
        hikingGuide.setTotalTime("3:30");
        hikingGuide.setUserDistance(10);
        hikingGuide.setAscentTime(120);
        hikingGuide.setDescentTime(90);
        hikingGuide.setHikingDate(java.sql.Date.valueOf("2023-06-01"));
        
        // Add the hiking record
        hikingGuideServiceImpl.addHikingRecord(hikingGuide);
     
    }
    
    
    @Test
    public void getHikingListRecord() throws Exception {
        // Create a HikingGuide object with sample data
        HikingGuide hikingGuide = new HikingGuide();
        
  
        // Test retrieving hiking records for the user with userNo 1
        List<HikingGuide> records = hikingGuideDao.getHikingListRecord(1);
      for(HikingGuide record : records) {
        System.out.println("getHiking :"+record);
      }
    }
}
