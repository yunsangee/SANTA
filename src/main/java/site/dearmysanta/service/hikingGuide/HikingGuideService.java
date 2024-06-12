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
	
	public void getMeetingCoordination() throws Exception;
	
	public void addHikingRecord(HikingGuide hikingGuide) throws Exception;

	public List<HikingGuide> getHikingListRecord(int userNo) throws Exception;

	public HikingAlert getAlertSetting(int userNo) throws Exception;
	
	public void updateMeetingTime(int userNo, int meetingTimeAlert, String meetingTime) throws Exception;

	public void updateAlertSetting(int userNo, Map<String, Integer> settings) throws Exception;

	public int deleteHikingRecord(List<Integer> hrNo) throws Exception;
	
	public MeetingPost getMeetingParticipationList() throws Exception;
	
}
