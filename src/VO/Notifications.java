package VO;

public class Notifications 
{
	private int mid;
	private int uid;
	private int followerid;
	private String flag;
	private String date;
	
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public int getFollowerid() {
		return followerid;
	}
	public void setFollowerid(int followerid) {
		this.followerid = followerid;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getMid() {
		return mid;
	}
	public void setMid(int mid) {
		this.mid = mid;
	}
}
