package com.ecpbm.dao.provider;

import java.util.Map;

import org.apache.ibatis.jdbc.SQL;

import com.ecpbm.pojo.UserInfo;

public class UserInfoDynaSqlProvider {
	//分页动态查询
	public String selectWithParam(Map<String, Object> params) {
		String sql = new SQL() {
			{
				SELECT("*");
				SELECT("a.attribute_name as attribute");
				SELECT("c.category_name as category");
				FROM("user_info u");
				LEFT_OUTER_JOIN("user_att ut on u.id = ut.user_id");
				LEFT_OUTER_JOIN("attribute a on ut.attribute_id = a.attribute_id");
				LEFT_OUTER_JOIN("category c on ut.category_id = c.category_id");
				if (params.get("userInfo") != null ) {
					UserInfo userInfo = (UserInfo) params.get("userInfo");
					if (userInfo.getUserName() != null && !userInfo.getUserName().equals("")) {
						WHERE(" userName LIKE CONCAT ('%',#{userInfo.userName},'%') ");
					}
				}

				
			}
		}.toString();
		if (params.get("pgper") != null) {
			sql += " limit #{pager.firstLimitParam} , #{pager.perPageRows }";
		}
		return sql;
		
	}
	
	//根据条件动态查询总记录条数
	public String count(Map<String, Object> params) {
		return new SQL() {
			{
				SELECT("count(*)");
				FROM("user_info");
				if (params.get("userInfo") != null) {
					UserInfo userInfo = (UserInfo) params.get("userInfo");
					if (userInfo.getUserName() != null && !userInfo.getUserName().equals("")) {
						WHERE(" userName LIKE CONCAT ('%',#{userInfo.userName},'%') ");
					}
				}
			}
		}.toString();
		
	}
	
	//delete user info by user id
	public String deleteUserInfo(Integer id) {
		return new SQL() {
			{
				DELETE_FROM("user_info");
				if (id !=null) {
					WHERE("id = #{id}");
				}
			}
		}.toString();
	}
}
