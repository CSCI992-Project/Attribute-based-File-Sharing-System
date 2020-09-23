package com.ecpbm.service;

import java.util.List;
import java.util.Map;

import com.ecpbm.pojo.FileInfo;
import com.ecpbm.pojo.Pager;

public interface FileInfoService {
	
	//分页显示文件
	List<FileInfo> findFileInfo(FileInfo fileInfo, Pager pager);
		
	//文件计数
	Integer count(Map<String, Object> params);
	
	//分页显示个人文件
	List<FileInfo> findFileInfoByUserId(Pager pager, Integer userId);
	
	//个人文件计数
	Integer countByUserId(Integer userId);
	
	//find file id by file title
	Integer findFileIdByTitle(String title);
	
	//add file
	void addFileInfo(FileInfo fileInfo);
	void addFileAttributes(Integer fid, Integer cid, Integer aid);
	
	//delete file
	void deleteFileInfo(Integer id);
	
	//update file
	void updateFileInfo(FileInfo fileInfo);
	
	
}
