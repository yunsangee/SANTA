package site.dearmysanta.service.hikingGuide.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import site.dearmysanta.service.hikingGuide.HikingGuideDao;
import site.dearmysanta.service.hikingGuide.HikingGuideService;
import site.dearmysanta.service.hikingGuide.Meeting;
import site.dearmysanta.service.hikingGuide.Mountain;
import site.dearmysanta.service.hikingGuide.Weather;


@Service("HikingGuideServiceImpl")
public class HikingGuideServiceImpl implements HikingGuideService{

	@Autowired
	@Qualifier("HikingGudieDaoImpl")
	private HikingGuideDao hikingGuideDao;
	
	
	@Override
	public Mountain getMountain() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Weather getWeatherList() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Meeting getParticipationList() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void addHikingRecord(int userNo) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getHikingListRecord() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getAlertSetting() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getAlert() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateAlertSetting() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getMeetingCoordination() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getMountainInfo() throws Exception {
		// TODO Auto-generated method stub
		
	}
	


}
