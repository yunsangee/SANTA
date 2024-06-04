package site.dearmysanta.service.hikingGuide;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import site.dearmysanta.domain.hikingguide.HikingAlert;
import site.dearmysanta.domain.hikingguide.HikingGuide;

@Mapper
@Component("HikingGuideDao")
public interface HikingGuideDao {
    
    public void addHikingRecord(HikingGuide hikingGuide) throws Exception;

    public List<HikingGuide> getHikingListRecord(@Param("userNo") int userNo) throws Exception;
 
    public HikingAlert getAlertSetting(@Param("userNo") int userNo) throws Exception;

    public void updateAlertSetting(@Param("userNo") int userNo, 
    						@Param("hikingAlertFlag") int hikingAlertFlag,
                            @Param("destinationAlert") int destinationAlert, 
                            @Param("sunsetAlert") int sunsetAlert,
                            @Param("locationOverAlert") int locationOverAlert, 
                            @Param("meetingTimeAlert") int meetingTimeAlert) throws Exception;
    
    public void updateMeetingTime(@Param("userNo") int userNo, @Param("meetingTimeAlert") int meetingTimeAlert, 
    						 	  @Param("meetingTime") int meetingTime) throws Exception;

    public void deleteHikingRecord(@Param("hrNo") int hrNo) throws Exception;
}
