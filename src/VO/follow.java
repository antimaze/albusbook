package VO;

import java.util.HashSet;
import java.util.Set;

public class follow {
	
	int tid;
	int followed;
	int follower;
	String lable;
	
	Set<User> users = new HashSet<User>();
	
	public void addUser(User user) {
        this.users.add(user);
    }
	
	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	public int getFollowed() {
		return followed;
	}
	public void setFollowed(int followed) {
		this.followed = followed;
	}
	public int getFollower() {
		return follower;
	}
	public void setFollower(int follower) {
		this.follower = follower;
	}
	public String getLable() {
		return lable;
	}
	public void setLable(String lable) {
		this.lable = lable;
	}
}
