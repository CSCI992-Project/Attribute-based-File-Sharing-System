package com.ecpbm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.ecpbm.pojo.Category;

public interface CategoryDao {
	//list all category
	@Select("select * from category")
	public List<Category> selectAll();
}
