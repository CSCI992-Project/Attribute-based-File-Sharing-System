package com.ecpbm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.ecpbm.dao.FileInfoDao;
import com.ecpbm.pojo.FileInfo;
import com.ecpbm.pojo.Pager;
import com.ecpbm.service.FileInfoService;

@Service("fileInfoService")
@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT)
public class FileInfoServiceImpl implements FileInfoService{
	@Autowired
	private FileInfoDao fileInfoDao;
	
	@Override
	public List<FileInfo> findFileInfo(FileInfo fileInfo, Pager pager) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("fileInfo", fileInfo);
		int recordCount = fileInfoDao.count(params);
		pager.setRowCount(recordCount);
		if (recordCount > 0) {
			params.put("pager", pager);
		}
		return fileInfoDao.selectByPage(params);
	}

	@Override
	public Integer count(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return fileInfoDao.count(params);
	}

	@Override
	public List<FileInfo> findFileInfoByUserId(Pager pager, Integer userId) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<String, Object>();
		int recordCount = fileInfoDao.counByUserId(userId);
		pager.setRowCount(recordCount);
		if (recordCount > 0) {
			params.put("pager", pager);
		}
		return fileInfoDao.selectByUserId(params, userId);
	}

	@Override
	public Integer countByUserId(Integer userId) {
		// TODO Auto-generated method stub
		return fileInfoDao.counByUserId(userId);
	}

	@Override
	public void addFileInfo(FileInfo fileInfo) {
		// TODO Auto-generated method stub
		fileInfoDao.add(fileInfo);
	}

	@Override
	public void addFileAttributes(Integer fid, Integer cid, Integer aid) {
		// TODO Auto-generated method stub
		fileInfoDao.addAttributes(fid, cid, aid);
	}

	@Override
	public Integer findFileIdByTitle(String title) {
		// TODO Auto-generated method stub
		return fileInfoDao.findFileIdByTitle(title);
	}
	
	@Override
	public String findFilePathById(Integer id) {
		// TODO Auto-generated method stub
		return fileInfoDao.findFilePathById(id);
	}

	@Override
	public void deleteFileInfo(Integer id) {
		// TODO Auto-generated method stub
		fileInfoDao.deleteFileInfo(id);
	}

	@Override
	public void updateFileInfo(FileInfo fileInfo) {
		// TODO Auto-generated method stub
		fileInfoDao.edit(fileInfo);
		fileInfoDao.updateAtt(fileInfo);
	}

}
