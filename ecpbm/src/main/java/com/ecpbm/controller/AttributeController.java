package com.ecpbm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ecpbm.pojo.Attribute;
import com.ecpbm.service.AttributeService;

@Controller
@RequestMapping("/attribute")
public class AttributeController {
	@Autowired
	private AttributeService attributeService;
	
	@RequestMapping("/getattribute")
	@ResponseBody
	public List<Attribute> getAttribute(@RequestParam(value = "categoryId") Integer categoryId) {
		List<Attribute> attributeList = attributeService.getAll(categoryId);
		
		return attributeList;
	}
	
}
