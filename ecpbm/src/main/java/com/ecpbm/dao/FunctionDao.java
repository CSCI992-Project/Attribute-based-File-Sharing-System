package com.ecpbm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import com.ecpbm.pojo.Functions;

public interface FunctionDao {
	// 用户id,获取功能权限
		@Select("select * from functions where id in (select fid from powers where uid = #{uid} )")
		public List<Functions> selectByUserId(Integer uid);
}
