package site.dearmysanta.domain.message;

public class MessageInfo {
	
	private String userName;
	private String phoneNumber;
	private int validationNumber;
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phone) {
		this.phoneNumber = phone;
	}
	
	
	public int getValidationNumber() {
		return validationNumber;
	}
	public void setValidationNumber(int validationNumber) {
		this.validationNumber = validationNumber;
	}
	@Override
	public String toString() {
		return "Message [userName=" + userName + ", phoneNumber=" + phoneNumber + "]";
	}
	
}
