package site.dearmysanta.service.hikingGuide.impl;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    public void updateAlertSetting(int userNo, Map<String, Object> settings) throws Exception {
        Integer hikingAlertFlag = (Integer) settings.get("hikingAlertFlag");
        String destinationAlert = (String) settings.get("destinationAlert");
        String sunsetAlert = (String) settings.get("sunsetAlert");
        String locationOverAlert = (String) settings.get("locationOverAlert");
        String meetingTimeAlert = (String) settings.get("meetingTimeAlert");
        String meetingTime = (String) settings.get("meetingTime");
        String alertContent = (String) settings.get("alertContent");
        String allAlert = (String) settings.get("allAlert");
        
        hikingGuideDao.updateAlertSetting(userNo, hikingAlertFlag, destinationAlert, sunsetAlert, locationOverAlert, meetingTimeAlert, meetingTime, alertContent, allAlert);
    }

    @Override
    public List<HikingGuide> getHikingListRecord(int userNo) throws Exception {
        return hikingGuideDao.getHikingListRecord(userNo);
    }

    @Override
    public void deleteHikingRecord(int hrNo) throws Exception {
        hikingGuideDao.deleteHikingRecord(hrNo);
    }

//	@Override
//	public Mountain getMountain() throws Exception {
//		// TODO Auto-generated method stub
//		return null;
//	}
//
//	@Override
//	public Weather getWeatherList() throws Exception {
//		// TODO Auto-generated method stub
//		return null;
//	}
//
//	@Override
//	public MeetingPost getParticipationList() throws Exception {
//		// TODO Auto-generated method stub
//		return null;
//	}

	@Override
	public void getMeetingCoordination() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getMountainInfo() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getAlert() throws Exception {
		// TODO Auto-generated method stub
		
	}

}
