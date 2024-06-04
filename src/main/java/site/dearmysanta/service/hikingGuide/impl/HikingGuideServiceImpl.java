package site.dearmysanta.service.hikingGuide.impl;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.domain.mountain.Weather;
import site.dearmysanta.service.domain.hikingguide.HikingAlert;
import site.dearmysanta.service.domain.hikingguide.HikingGuide;
import site.dearmysanta.service.hikingGuide.HikingGuideDao;
import site.dearmysanta.service.hikingGuide.HikingGuideService;

//import site.dearmysanta.service.hikingGuide.MeetingPost;
//import site.dearmysanta.service.hikingGuide.Mountain;
//import site.dearmysanta.service.hikingGuide.Weather;

@Service("HikingGuideServiceImpl")
@Transactional
public class HikingGuideServiceImpl implements HikingGuideService {

    @Autowired
    @Qualifier("HikingGuideDao")
    private HikingGuideDao hikingGuideDao;

    @Override
    public void addHikingRecord(HikingGuide hikingGuide) throws Exception {
        hikingGuideDao.addHikingRecord(hikingGuide);
    }

    @Override
    public HikingAlert getAlertSetting(int userNo) throws Exception {
        return hikingGuideDao.getAlertSetting(userNo);
    }

    @Override
    public void updateAlertSetting(int userNo, Integer hikingAlertFlag, String destinationAlert, String sunsetAlert,
            String locationOverAlert, String meetingTimeAlert) throws Exception {
    		
    	hikingGuideDao.updateAlertSetting(userNo, hikingAlertFlag, destinationAlert, sunsetAlert, locationOverAlert, meetingTimeAlert);
    }
    
    @Override
    public void updateMeetingTime(int userNo, int meetingTimeAlert, int meetingTime) throws Exception {
        hikingGuideDao.updateMeetingTime(userNo, meetingTimeAlert, meetingTime);
    }

    @Override
    public List<HikingGuide> getHikingListRecord(int userNo) throws Exception {
        return hikingGuideDao.getHikingListRecord(userNo);
    }

    @Override
    public void deleteHikingRecord(int hrNo) throws Exception {
        hikingGuideDao.deleteHikingRecord(hrNo);
    }

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

//	@Override
//	public MeetingPost getMeetingParticipationList() throws Exception {
//		// TODO Auto-generated method stub
//		return null;
//	}

	@Override
	public void getMeetingCoordination() throws Exception {
		// TODO Auto-generated method stub
		
	}

	  @Override
	    public MountainInfo getMountainInfo() throws Exception {
	        Mountain mountain = getMountain();
	        Weather weather = getWeatherList();
	        return new MountainInfo(mountain, weather);
	}
	

	@Override
	public void getAlert(int userNo, String alertContent) {
        
        System.out.println("User " + userNo + ": " + alertContent);
      
    }

	@Override
	public void getUserCoordination() throws Exception {
		// TODO Auto-generated method stub
		
	}
	

    @Override
    public void getUserCoordination(int userNo, double userLatitude, double userLongitude) throws Exception {
        HikingAlert alertSetting = getAlertSetting(userNo);
        if (alertSetting != null) {
            if (alertSetting.getHikingAlerFlag() == 0) {
                return;
            }

            if (checkAlertCondition(alertSetting)) {
                getAlert(userNo, "arrive destination.");
            }
        }
    }

    private boolean checkAlertCondition(HikingAlert alertSetting) {
        if (alertSetting.getDestinationAlert() != null && alertSetting.getDestinationAlert().equals("1")) {
            return true; 
        }
        if (alertSetting.getSunsetAlert() != null && alertSetting.getSunsetAlert().equals("1")) {
            return true; 
            }
        if (alertSetting.getLocationOverAlert() != null && alertSetting.getLocationOverAlert().equals("1")) {
            return true; 
        }
        if (alertSetting.getMeetingTimeAlert() != null && alertSetting.getMeetingTimeAlert().equals("1")) {
            return true; 
        }
        return false;
    }

  


}
