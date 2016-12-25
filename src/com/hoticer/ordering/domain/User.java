package com.hoticer.ordering.domain;

import java.util.LinkedHashSet;
import java.util.Set;

public class User {
	private Integer userId;
	private String username;
	private String password;
	private int access;
	private Set<Trade> trades = new LinkedHashSet<Trade>();
	
	public void setTrades(Set<Trade> trades) {
		this.trades = trades;
	}
	
	public Set<Trade> getTrades() {
		return trades;
	}
	
	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getAccess() {
		return access;
	}

	public void setAccess(int access) {
		this.access = access;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", username=" + username + ", password=" + password + ", access=" + access
				+ "]";
	}

	public User(Integer userId, String username, String password, int access) {
		super();
		this.userId = userId;
		this.username = username;
		this.password = password;
		this.access = access;
	}

	public User() {
		// TODO Auto-generated constructor stub
	}
}
