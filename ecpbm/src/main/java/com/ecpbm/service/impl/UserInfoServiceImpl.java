package com.ecpbm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ecpbm.dao.UserInfoDao;
import com.ecpbm.pojo.Pager;
import com.ecpbm.pojo.UserInfo;
import com.ecpbm.service.UserInfoService;

@Service("userInfoService")
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT)
public class UserInfoServiceImpl implements UserInfoService {
	@Autowired
	private UserInfoDao userInfoDao;

	@Override
	public UserInfo login(UserInfo ui) {
		return userInfoDao.selectByNameAndPwd(ui);
	}

	@Override
	public UserInfo getUserInfoAndFunctions(Integer id) {
		return userInfoDao.selectById(id);
	}

	@Override
	public List<UserInfo> findUserInfo(UserInfo userInfo, Pager pager) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userInfo", userInfo);
		int recordCount = userInfoDao.count(params);
		pager.setRowCount(recordCount);
		if (recordCount > 0) {
			params.put("pager", pager);
		}
		return userInfoDao.selectByPage(params);
	}

	@Override
	public Integer count(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return userInfoDao.count(params);
	}

	@Override
	public void deleteUserInfo(Integer id) {
		// TODO Auto-generated method stub
		userInfoDao.deleteUserInfo(id);
	}

	@Override
	public void addUserInfo(UserInfo userInfo) {
		// TODO Auto-generated method stub
		userInfoDao.add(userInfo);
	}

	@Override
	public void addUserPowers(Integer uid, Integer fid) {
		// TODO Auto-generated method stub
		userInfoDao.addPowers(uid, fid);
	}

	@Override
	public Integer findUserId(String userName) {
		// TODO Auto-generated method stub
		return userInfoDao.findUserId(userName);
	}

	@Override
	public void addAttributes(Integer uid, Integer cid, Integer aid) {
		// TODO Auto-generated method stub
		userInfoDao.addAttributes(uid, cid, aid);
	}

	@Override
	public void editUserInfo(UserInfo userInfo) {
		// TODO Auto-generated method stub
		userInfoDao.edit(userInfo);
		userInfoDao.updateAtt(userInfo);
	}

}
