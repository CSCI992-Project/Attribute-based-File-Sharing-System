package com.ecpbm.service;

import java.util.List;
import java.util.Map;

import com.ecpbm.pojo.Pager;
import com.ecpbm.pojo.UserInfo;

public interface UserInfoService {
	//登录验证
	public UserInfo login(UserInfo ui);
	
	//根据用户编号，获取权限
	public UserInfo getUserInfoAndFunctions(Integer id);
	
	//分页显示用户
	List<UserInfo> findUserInfo(UserInfo userInfo, Pager pager);
	
	//用户计数
	Integer count(Map<String, Object> params);
	
	//select user id by user name
	Integer findUserId(String userName);
	
	//add user
	void addUserInfo(UserInfo userInfo);
	
	//add user power
	void addUserPowers(Integer uid, Integer fid);
	
	//add attributes
	void addAttributes(Integer uid, Integer cid, Integer aid);
	
	//update user information
	void editUserInfo(UserInfo userInfo);
	
	//delete user
	void deleteUserInfo(Integer id);
}
