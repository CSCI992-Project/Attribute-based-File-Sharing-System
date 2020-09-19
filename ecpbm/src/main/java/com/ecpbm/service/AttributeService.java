package com.ecpbm.service;

import java.util.List;

import com.ecpbm.pojo.Attribute;

public interface AttributeService {
	//list all attribute by category id
	public List<Attribute> getAll(Integer categoryId);
}
