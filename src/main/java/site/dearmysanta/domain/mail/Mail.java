package site.dearmysanta.domain.mail;

public class Mail {
	
	private String receiverMail;
	private int authCode;
	

	public Mail() {
		// TODO Auto-generated constructor stub
	}

	public String getReceiverMail() {
		return receiverMail;
	}

	public void setReceiverMail(String receiverMail) {
		this.receiverMail = receiverMail;
	}

	public int getAuthCode() {
		return authCode;
	}

	public void setAuthCode(int authCode) {
		this.authCode = authCode;
	}

	@Override
	public String toString() {
		return "Mail [receiverMail=" + receiverMail + "]";
	}
	
	

}