package site.dearmysanta.hikingguide;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import site.dearmysanta.domain.hikingguide.HikingGuide;
import site.dearmysanta.service.hikingGuide.HikingGuideDao;
import site.dearmysanta.service.hikingGuide.impl.HikingGuideServiceImpl;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest(classes = HikingGuideApplicationTest.class)
public class HikingGuideApplicationTest {

    @Autowired
    private HikingGuideServiceImpl hikingGuideServiceImpl;

    @Autowired
    private HikingGuideDao hikingGuideDao;

    @Test
    public void testAddHikingRecord() throws Exception {
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

        // Retrieve the added record and verify it
        HikingGuide retrievedRecord = hikingGuideDao.getHikingListRecord(1).get(0);
        assertNotNull(retrievedRecord);
        assertEquals(hikingGuide.getHrNo(), retrievedRecord.getHrNo());
        assertEquals(hikingGuide.getUserNo(), retrievedRecord.getUserNo());
        assertEquals(hikingGuide.getTotalTime(), retrievedRecord.getTotalTime());
        assertEquals(hikingGuide.getUserDistance(), retrievedRecord.getUserDistance());
        assertEquals(hikingGuide.getAscentTime(), retrievedRecord.getAscentTime());
        assertEquals(hikingGuide.getDescentTime(), retrievedRecord.getDescentTime());
        assertEquals(hikingGuide.getHikingDate(), retrievedRecord.getHikingDate());
     
    }
}
