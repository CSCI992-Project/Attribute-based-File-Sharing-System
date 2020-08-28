package com.ecpbm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Many;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.mapping.FetchType;

import com.ecpbm.dao.provider.UserInfoDynaSqlProvider;
import com.ecpbm.pojo.UserInfo;


public interface UserInfoDao {
	@Select("select * from user_info where userName = #{userName} and password = #{password}")
	public UserInfo selectByNameAndPwd(UserInfo ui);

	//根据用户id获取用户对象及关联得功能集合
	@Select("select * from user_info where id = #{id}")
	@Results({ 
		@Result(id = true, column = "id", property = "id"),
		@Result(column = "userName", property = "userName"),
		@Result(column = "password", property = "password"),
		@Result(column = "id", property = "fs", many = @Many(select = "com.ecpbm.dao.FunctionDao.selectByUserId", fetchType = FetchType.EAGER))
	})
	UserInfo selectById(Integer id);
	
	//分页获取用户信息
	@SelectProvider(type = UserInfoDynaSqlProvider.class, method = "selectWithParam")
	List<UserInfo> selectByPage(Map<String, Object> params);
	
	//查询用户总数
	@SelectProvider(type = UserInfoDynaSqlProvider.class, method = "count")
	Integer count(Map<String, Object> params);
}
