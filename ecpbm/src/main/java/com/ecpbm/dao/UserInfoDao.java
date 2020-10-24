package com.ecpbm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.DeleteProvider;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Many;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.Update;
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
	
	//select user id by userName
	@Select("select id from user_info where userName = #{userName}")
	Integer findUserId(String userName);
	
	// add user
	@Insert("insert into user_info(userName,password,userType,email,phone) "
				+ "values(#{userName},#{password},#{userType},#{email},#{phone})")
	@Options(useGeneratedKeys = true, keyProperty = "id")
	void add(UserInfo ui);
	@Insert("insert into powers(uid,fid)"
				+ "values(#{uid},#{fid})")
	void addPowers(@Param("uid")Integer uid, @Param("fid")Integer fid);
	@Insert("insert into user_att(user_id,category_id,attribute_id)"
				+ "values(#{uid},#{cid},#{aid})")
	void addAttributes(@Param("uid")Integer uid, @Param("cid")Integer cid, @Param("aid")Integer aid);
	
	//update user information
	@Update("update user_info set userName=#{userName},password=#{password},userType=#{userType},email=#{email},phone=#{phone} where id=#{id}")
	void edit(UserInfo ui);
	@Update("update user_att set category_id=#{category_id},attribute_id=#{attribute_id} where user_id=#{id}")
	void updateAtt(UserInfo ui);
	
	//delete user
	@DeleteProvider(type = UserInfoDynaSqlProvider.class, method = "deleteUserInfo")
	void deleteUserInfo(Integer id);
	
	//select user category from user id
	@Select("select category_id from user_att where user_id = #{userid}")
	Integer findCategory(Integer userid);
	
	//select user attribute form user id
	@Select("select attribute_id from user_att where user_id = #{userid}")
	Integer findAttribute(Integer userid);
}
