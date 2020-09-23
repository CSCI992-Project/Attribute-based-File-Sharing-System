package com.ecpbm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ecpbm.pojo.FileInfo;
import com.ecpbm.pojo.Pager;
import com.ecpbm.pojo.UserInfo;
import com.ecpbm.service.FileInfoService;

@Controller
@RequestMapping("/fileinfo")
public class FileInfoController {
	
	@Autowired
	FileInfoService fileInfoService;
	
	//实现All list功能
	@RequestMapping("/listallfiles")
	@ResponseBody
	public Map<String, Object> filelist(Integer page, Integer rows, FileInfo fileInfo){
		
		//创建分页类对象
		Pager pager = new Pager();
		pager.setCurPage(page);
		pager.setPerPageRows(rows);
		
		//创建对象params，封装查询条件
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("fileInfo", fileInfo);
				
		//获取文件数
		int totalCount = fileInfoService.count(params);
				
		//分页查询文件
		List<FileInfo> fileinfos = fileInfoService.findFileInfo(fileInfo, pager);
				
		//创建对象result，保存查询结果数据
		Map<String, Object> result = new HashMap<String, Object>(2);
		result.put("total", totalCount);
		result.put("rows", fileinfos);
		return result;
		
	}
	
	//实现根据userId查询用户上传的文件
	@RequestMapping("/listmyfiles")
	@ResponseBody
	public Map<String, Object> myFileList(@RequestParam(value = "userid") String userid, Integer page, Integer rows){
		//创建分页类对象
		Pager pager = new Pager();
		pager.setCurPage(page);
		pager.setPerPageRows(rows);
		
		//创建对象params，封装查询条件
		Map<String, Object> params = new HashMap<String, Object>();
						
		//获取文件数
		int totalCount = fileInfoService.countByUserId(Integer.parseInt(userid));
						
		//分页查询文件
		List<FileInfo> fileinfos = fileInfoService.findFileInfoByUserId(pager, Integer.parseInt(userid));
						
		//创建对象result，保存查询结果数据
		Map<String, Object> result = new HashMap<String, Object>(2);
		result.put("total", totalCount);
		result.put("rows", fileinfos);
		return result;
	}
	
	//add file info
	@RequestMapping(value = "/addFileinfo", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String addFileInfo(FileInfo fi) {
		String str = "";
		try {
			fileInfoService.addFileInfo(fi);
			int file_id = fileInfoService.findFileIdByTitle(fi.getFile_title());
			fileInfoService.addFileAttributes(file_id, fi.getCategory_id(), fi.getAttribute_id());
			str = "{\"success\":\"true\",\"message\":\"File information added successfully!\"}";
		} catch (Exception e) {
			str = "{\"success\":\"false\",\"message\":\"Failed to add file information!\"}";
		}
		return str;	
	}
	
	//delete file
	@RequestMapping(value = "/deleteFileinfo", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String deleteFileInfo(@RequestParam(value = "id") String id) {
		String str = "";
		try {
			fileInfoService.deleteFileInfo(Integer.parseInt(id));
			str = "{\"success\":\"true\",\"message\":\"File information deleted successfully!\"}";
		} catch (Exception e) {
			str = "{\"success\":\"false\",\"message\":\"Failed to delete file information!\"}";
		}
		return str;		
	}
	
	//update file info
	@RequestMapping(value = "updateFileinfo", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String editFileInfo(FileInfo fi) {
		String str = "";
		try {
			fileInfoService.updateFileInfo(fi);;
			str = "{\"success\":\"true\",\"message\":\"File information updating successfully!\"}";
		} catch (Exception e) {
			str = "{\"success\":\"false\",\"message\":\"Failed to update file information!\"}";
		}
		return str;	
	}
	
}
