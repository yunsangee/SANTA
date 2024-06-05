package site.dearmysanta.service.hikingGuide;

import java.util.List;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import site.dearmysanta.domain.hikingguide.HikingAlert;
import site.dearmysanta.domain.hikingguide.HikingGuide;
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.domain.mountain.Weather;


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

	public void updateAlertSetting(int userNo, int hikingAlertFlag, int destinationAlert, int sunsetAlert,
									int locationOverAlert, int meetingTimeAlert
									) throws Exception;

	public void deleteHikingRecord(int hrNo) throws Exception;
	
	public void getUserCoordination(int userNo, double latitude, double longitude) throws Exception;

	public MeetingPost getMeetingParticipationList() throws Exception;
	
	
	@Getter
	@Setter
	@AllArgsConstructor
	public class MountainInfo{
		private Mountain mountain;
		private Weather weather;
	}




	

}
