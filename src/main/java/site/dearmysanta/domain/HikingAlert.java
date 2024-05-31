package site.dearmysanta.domain;

public class HikingAlert {
	
	private int userNo; //회원식별번호
	private int hikingAlerFlag; //알림번호플래그
	private String destinationAlert; //목적지거리알림
	private String sunsetAlert; //일몰알림
	private String locationOverAlert; //위치이탈알림
	private String meetingTimeAlert; //모임시간알림
	private String meetingTime; //모임시간
	private String alertContent; //알림내용
	private String allAlert; //전체알림
	
	
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public int getHikingAlerFlag() {
		return hikingAlerFlag;
	}
	public void setHikingAlerFlag(int hikingAlerFlag) {
		this.hikingAlerFlag = hikingAlerFlag;
	}
	public String getDestinationAlert() {
		return destinationAlert;
	}
	public void setDestinationAlert(String destinationAlert) {
		this.destinationAlert = destinationAlert;
	}
	public String getSunsetAlert() {
		return sunsetAlert;
	}
	public void setSunsetAlert(String sunsetAlert) {
		this.sunsetAlert = sunsetAlert;
	}
	public String getLocationOverAlert() {
		return locationOverAlert;
	}
	public void setLocationOverAlert(String locationOverAlert) {
		this.locationOverAlert = locationOverAlert;
	}
	public String getMeetingTimeAlert() {
		return meetingTimeAlert;
	}
	public void setMeetingTimeAlert(String meetingTimeAlert) {
		this.meetingTimeAlert = meetingTimeAlert;
	}
	public String getMeetingTime() {
		return meetingTime;
	}
	public void setMeetingTime(String meetingTime) {
		this.meetingTime = meetingTime;
	}
	public String getAlertContent() {
		return alertContent;
	}
	public void setAlertContent(String alertContent) {
		this.alertContent = alertContent;
	}
	public String getAllAlert() {
		return allAlert;
	}
	public void setAllAlert(String allAlert) {
		this.allAlert = allAlert;
	}
	@Override
	public String toString() {
		return "HikingAlert [userNo=" + userNo + ", hikingAlerFlag=" + hikingAlerFlag + ", destinationAlert="
				+ destinationAlert + ", sunsetAlert=" + sunsetAlert + ", locationOverAlert=" + locationOverAlert
				+ ", meetingTimeAlert=" + meetingTimeAlert + ", meetingTime=" + meetingTime + ", alertContent="
				+ alertContent + ", allAlert=" + allAlert + "]";
	}
	
}
