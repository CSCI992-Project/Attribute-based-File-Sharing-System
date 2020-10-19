package com.ecpbm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ecpbm.dao.AttributeDao;
import com.ecpbm.pojo.Attribute;
import com.ecpbm.service.AttributeService;

@Service("attributeService")
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT)
public class AttributeServiceImpl implements AttributeService{
	@Autowired
	private AttributeDao attributeDao;
	
	@Override
	public List<Attribute> getAll(Integer categoryId) {
		// TODO Auto-generated method stub
		return attributeDao.selectAll(categoryId);
	}

	@Override
	public String getAttributeName(Integer attributeId) {
		// TODO Auto-generated method stub
		return attributeDao.getAttributeName(attributeId);
	}

}
