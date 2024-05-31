package site.dearmysanta.domain;

import java.sql.Date;
import java.util.List;

public class HikingGuide {
	private int userNo; //ȸ���ĺ���ȣ
	private int hikingRecordNo; //����Ϲ�ȣ
	private int mountainTrailNo; //���ι�ȣ
	private int userDistance; //ȸ���̵��Ÿ�
	private int ascentTime; //ȸ������ð�
	private int descentTime; //ȸ������ð�
	private int totalTime; //�Ѽҿ�ð�
	private Date hikingDate; //������� 
	private List<String> userCoordinates; //ȸ����ġ��ǥ
	private Mountain mountain; //������(mountain class)
	private Weather weather; //��������(weather class)
	private Meeting meeting; //���ӿ��ĺ���ȣ(meeting class)
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public int getHikingRecordNo() {
		return hikingRecordNo;
	}
	public void setHikingRecordNo(int hikingRecordNo) {
		this.hikingRecordNo = hikingRecordNo;
	}
	public int getMountainTrailNo() {
		return mountainTrailNo;
	}
	public void setMountainTrailNo(int mountainTrailNo) {
		this.mountainTrailNo = mountainTrailNo;
	}
	public int getUserDistance() {
		return userDistance;
	}
	public void setUserDistance(int userDistance) {
		this.userDistance = userDistance;
	}
	public int getAscentTime() {
		return ascentTime;
	}
	public void setAscentTime(int ascentTime) {
		this.ascentTime = ascentTime;
	}
	public int getDescentTime() {
		return descentTime;
	}
	public void setDescentTime(int descentTime) {
		this.descentTime = descentTime;
	}
	public int getTotalTime() {
		return totalTime;
	}
	public void setTotalTime(int totalTime) {
		this.totalTime = totalTime;
	}
	public Date getHikingDate() {
		return hikingDate;
	}
	public void setHikingDate(Date hikingDate) {
		this.hikingDate = hikingDate;
	}
	public List<String> getUserCoordinates() {
		return userCoordinates;
	}
	public void setUserCoordinates(List<String> userCoordinates) {
		this.userCoordinates = userCoordinates;
	}
	public Mountain getMountain() {
		return mountain;
	}
	public void setMountain(Mountain mountain) {
		this.mountain = mountain;
	}
	public Weather getWeather() {
		return weather;
	}
	public void setWeather(Weather weather) {
		this.weather = weather;
	}
	public Meeting getMeeting() {
		return meeting;
	}
	public void setMeeting(Meeting meeting) {
		this.meeting = meeting;
	}
	
	
	@Override
	public String toString() {
		return "hikingGuide [userNo=" + userNo + ", hikingRecordNo=" + hikingRecordNo + ", mountainTrailNo="
				+ mountainTrailNo + ", userDistance=" + userDistance + ", ascentTime=" + ascentTime + ", descentTime="
				+ descentTime + ", totalTime=" + totalTime + ", hikingDate=" + hikingDate + ", userCoordinates="
				+ userCoordinates + "]";
	}
	
	
	
}
