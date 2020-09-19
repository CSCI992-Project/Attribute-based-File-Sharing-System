package com.ecpbm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ecpbm.pojo.Category;
import com.ecpbm.service.CategoryService;

@Controller
@RequestMapping("/category")
public class CategoryController {
	@Autowired
	private CategoryService categoryService;
	
	@RequestMapping("/getcategory")
	@ResponseBody
	public List<Category> getCaregory() {
		List<Category> categoryList = categoryService.getAll();
		
		return categoryList;
		
	}
	
}
