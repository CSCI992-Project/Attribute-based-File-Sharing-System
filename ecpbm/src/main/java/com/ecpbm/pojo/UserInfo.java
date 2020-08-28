package com.ecpbm.pojo;

import java.util.List;

public class UserInfo {
	private int id;
	private String userName;
	private String password;
	private int userType;
	private String email;
	private String phone;
	//关联属性
	private List<Functions> fs;
	
	public List<Functions> getFs() {
		return fs;
	}
	public void setFs(List<Functions> fs) {
		this.fs = fs;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getUserType() {
		return userType;
	}
	public void setUserType(int userType) {
		this.userType = userType;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
}
