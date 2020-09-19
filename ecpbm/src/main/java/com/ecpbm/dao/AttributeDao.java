package com.ecpbm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.ecpbm.pojo.Attribute;

public interface AttributeDao {
	//list attribute by category_id
	@Select("select * from attribute where category_id = #{categoryId}")
	public List<Attribute> selectAll(Integer categoryId);
}
