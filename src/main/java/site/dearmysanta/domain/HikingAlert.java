package site.dearmysanta.domain;

public class HikingAlert {
	
	private int userNo; //ȸ���ĺ���ȣ
	private int hikingAlerFlag; //�˸���ȣ�÷���
	private String destinationAlert; //�������Ÿ��˸�
	private String sunsetAlert; //�ϸ��˸�
	private String locationOverAlert; //��ġ��Ż�˸�
	private String meetingTimeAlert; //���ӽð��˸�
	private String meetingTime; //���ӽð�
	private String alertContent; //�˸�����
	private String allAlert; //��ü�˸�
	
	
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
