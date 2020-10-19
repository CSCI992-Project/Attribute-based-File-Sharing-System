package com.ecpbm.service;

import java.util.List;

import com.ecpbm.pojo.Category;

public interface CategoryService {
	//list all category
	public List<Category> getAll();
	
	//get category name
	public String getCategoryName(Integer categoryId);
}
