package site.dearmysanta.service.hikingGuide;

import site.dearmysanta.service.hikingGuide.Meeting;
import site.dearmysanta.service.hikingGuide.Mountain;
import site.dearmysanta.service.hikingGuide.Weather;

public interface HikingGuideService {

	public Mountain getMountain() throws Exception;
	
	public Weather getWeatherList() throws Exception;
	
	public Meeting getParticipationList() throws Exception;
	
	public void addHikingRecord(int userNo) throws Exception;

	public void getHikingListRecord() throws Exception;
	
	public void getAlertSetting() throws Exception;
	
	public void getAlert() throws Exception;
	
	public void updateAlertSetting() throws Exception;
	
	public void getMeetingCoordination() throws Exception;
	
	public void getMountainInfo() throws Exception;
	
}
