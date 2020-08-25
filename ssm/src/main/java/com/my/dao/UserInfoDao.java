package com.my.dao;

import org.apache.ibatis.annotations.Select;

import com.my.pojo.UserInfo;

public interface UserInfoDao {
	// ���ݵ�¼���������ѯ����Ա
	@Select("select * from user_info where userName = #{userName} and password = #{password}")
	public UserInfo selectByNameAndPwd(UserInfo ui);
}
