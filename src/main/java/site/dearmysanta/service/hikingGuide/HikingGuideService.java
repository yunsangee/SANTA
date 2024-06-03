package site.dearmysanta.service.hikingGuide;

import java.util.List;
import java.util.Map;

import site.dearmysanta.service.domain.hikingguide.HikingAlert;
import site.dearmysanta.service.domain.hikingguide.HikingGuide;

public interface HikingGuideService {

//	public Mountain getMountain() throws Exception;
//	
//	public Weather getWeatherList() throws Exception;
//	
//	public MeetingPost getParticipationList() throws Exception;
		
	public void getAlert() throws Exception;
		
	public void getMeetingCoordination() throws Exception;
	
	public void getMountainInfo() throws Exception;
			
	public void addHikingRecord(HikingGuide hikingGuide) throws Exception;

	public List<HikingGuide> getHikingListRecord(int userNo) throws Exception;

	public HikingAlert getAlertSetting(int userNo) throws Exception;

	public void updateAlertSetting(int userNo, Map<String, Object> settings) throws Exception;

	public void deleteHikingRecord(int hrNo) throws Exception;

	
}
