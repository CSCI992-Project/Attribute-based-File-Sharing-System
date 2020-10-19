package com.ecpbm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ecpbm.dao.CategoryDao;
import com.ecpbm.pojo.Category;
import com.ecpbm.service.CategoryService;

@Service("categoryService")
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT)
public class CategoryServiceImpl implements CategoryService{
	@Autowired
	private CategoryDao categoryDao;

	@Override
	public List<Category> getAll() {
		// TODO Auto-generated method stub
		return categoryDao.selectAll();
	}

	@Override
	public String getCategoryName(Integer categoryId) {
		// TODO Auto-generated method stub
		return categoryDao.getCategoryName(categoryId);
	}
	
	
}
