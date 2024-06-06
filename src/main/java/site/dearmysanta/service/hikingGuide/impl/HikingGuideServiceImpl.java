package site.dearmysanta.service.hikingGuide.impl;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import site.dearmysanta.domain.hikingguide.HikingAlert;
import site.dearmysanta.domain.hikingguide.HikingGuide;
import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.domain.mountain.Mountain;
import site.dearmysanta.domain.mountain.Weather;
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
    public void updateMeetingTime(int userNo, int meetingTimeAlert, String meetingTime) throws Exception {
        hikingGuideDao.updateMeetingTime(userNo, meetingTimeAlert, meetingTime);
    }

    @Override
    public List<HikingGuide> getHikingListRecord(int userNo) throws Exception {
    	System.out.println("impl :"+userNo);
        return hikingGuideDao.getHikingListRecord(userNo);
    }

    @Override
    public int deleteHikingRecord(int hrNo) throws Exception {
        return hikingGuideDao.deleteHikingRecord(hrNo);
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
	

    private boolean checkAlertCondition(HikingAlert alertSetting) {
        if (alertSetting.getDestinationAlert()==1) {
            return true; 
        }
        if (alertSetting.getSunsetAlert()==1) {
            return true; 
            }
        if (alertSetting.getLocationOverAlert()==1) {
            return true; 
        }
        if (alertSetting.getMeetingTimeAlert()==1) {
            return true; 
        }
        return false;
    }

	@Override
	public MeetingPost getMeetingParticipationList() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateAlertSetting(int userNo, Map<String, Integer> settings) throws Exception {
		settings.put("userNo",userNo);
		System.out.println("settings"+settings);
		hikingGuideDao.updateAlertSetting(userNo, settings);
	}

  


}
