package com.my.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.my.dao.UserInfoDao;
import com.my.pojo.UserInfo;
import com.my.service.UserInfoService;
@Service("userInfoService")
public class UserInfoServiceImpl implements UserInfoService {

	@Autowired
	private UserInfoDao userInfoDao;

	@Override
	public UserInfo login(UserInfo ui) {
	
		return userInfoDao.selectByNameAndPwd(ui);
	}
	
}
