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
}
