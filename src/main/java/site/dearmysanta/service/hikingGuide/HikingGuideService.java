package site.dearmysanta.service.hikingGuide;

import java.util.List;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.domain.mountain.Weather;
import site.dearmysanta.service.domain.hikingguide.HikingAlert;
import site.dearmysanta.service.domain.hikingguide.HikingGuide;


public interface HikingGuideService {

	public Mountain getMountain() throws Exception;
	
	public Weather getWeatherList() throws Exception;
	
//	public MeetingPost getParticipationList() throws Exception;
	
	public void getUserCoordination() throws Exception;
		
	public void getMeetingCoordination() throws Exception;
	
	public MountainInfo getMountainInfo() throws Exception;

	public void getAlert(int userNo, String alertContent) throws Exception;		
	
	public void addHikingRecord(HikingGuide hikingGuide) throws Exception;

	public List<HikingGuide> getHikingListRecord(int userNo) throws Exception;

	public HikingAlert getAlertSetting(int userNo) throws Exception;
	
	public void updateMeetingTime(int userNo, int meetingTimeAlert, int meetingTime) throws Exception;

	public void updateAlertSetting(int userNo, Integer hikingAlertFlag, String destinationAlert, String sunsetAlert,
									String locationOverAlert, String meetingTimeAlert
									) throws Exception;

	public void deleteHikingRecord(int hrNo) throws Exception;
	
	public void getUserCoordination(int userNo, double latitude, double longitude) throws Exception;

//	public MeetingPost getMeetingParticipationList() throws Exception;
	
	
	@Getter
	@Setter
	@AllArgsConstructor
	public class MountainInfo{
		private Mountain mountain;
		private Weather weather;
	}




	

}
