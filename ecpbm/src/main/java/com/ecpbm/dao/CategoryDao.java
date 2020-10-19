package com.ecpbm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.ecpbm.pojo.Category;

public interface CategoryDao {
	//list all category
	@Select("select * from category")
	public List<Category> selectAll();
	
	//get category name
	@Select("select category_name from category where category_id = #{categoryId}")
	public String getCategoryName(Integer categoryId);
}
