package com.my.dao;

import org.apache.ibatis.annotations.Select;

import com.my.pojo.UserInfo;

public interface UserInfoDao {
	// 根据登录名和密码查询管理员
	@Select("select * from user_info where userName = #{userName} and password = #{password}")
	public UserInfo selectByNameAndPwd(UserInfo ui);
}
