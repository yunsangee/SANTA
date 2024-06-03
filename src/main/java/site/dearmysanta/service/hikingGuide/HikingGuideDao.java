package site.dearmysanta.service.hikingGuide;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import site.dearmysanta.service.domain.hikingguide.HikingAlert;
import site.dearmysanta.service.domain.hikingguide.HikingGuide;

@Mapper
@Component("hikingGuideDao")
public interface HikingGuideDao {
    
    public void addHikingRecord(HikingGuide hikingGuide) throws Exception;

    public List<HikingGuide> getHikingListRecord(@Param("userNo") int userNo) throws Exception;

    public HikingAlert getAlertSetting(@Param("userNo") int userNo) throws Exception;

    public void updateAlertSetting(@Param("userNo") int userNo, 
    						@Param("hikingAlertFlag") Integer hikingAlertFlag,
                            @Param("destinationAlert") String destinationAlert, 
                            @Param("sunsetAlert") String sunsetAlert,
                            @Param("locationOverAlert") String locationOverAlert, 
                            @Param("meetingTimeAlert") String meetingTimeAlert,
                            @Param("meetingTime") String meetingTime, 
                            @Param("alertContent") String alertContent,
                            @Param("allAlert") String allAlert) throws Exception;

    public void deleteHikingRecord(@Param("hrNo") int hrNo) throws Exception;
}
