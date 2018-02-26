package VO;

public class Messages {
	
	int messageId;
	int messageSender;
	int messageReciever;
	String message;
	String date;
	String time;
	String flag;
	
	public int getMessageId() {
		return messageId;
	}
	public void setMessageId(int messageId) {
		this.messageId = messageId;
	}
	public int getMessageSender() {
		return messageSender;
	}
	public void setMessageSender(int messageSender) {
		this.messageSender = messageSender;
	}
	public int getMessageReciever() {
		return messageReciever;
	}
	public void setMessageReciever(int messageReciever) {
		this.messageReciever = messageReciever;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
}
