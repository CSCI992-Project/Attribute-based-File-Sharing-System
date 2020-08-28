package com.ecpbm.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ecpbm.pojo.FileInfo;
import com.ecpbm.pojo.Functions;
import com.ecpbm.pojo.Pager;
import com.ecpbm.pojo.TreeNode;
import com.ecpbm.pojo.UserInfo;
import com.ecpbm.util.JsonFactory;

@Controller
@RequestMapping("/fileinfo")
public class FileInfoController {
	//实现All list功能
	@RequestMapping("/listallfiles")
	@ResponseBody
	public Map<String, Object> filelist(Integer page, Integer rows, FileInfo fileInfo){
		
		//创建分页类对象
		Pager pager = new Pager();
		pager.setCurPage(page);
		pager.setPerPageRows(rows);
		
	
		return null;
		
	}
	
	//实现根据userId查询用户上传的文件
	
	@RequestMapping("/listmyfiles")
	@ResponseBody
	public Map<String, Object> myFileList(@RequestParam(value = "userid") String userid, Integer page, Integer rows, FileInfo fileInfo){
		//创建分页类对象
		Pager pager = new Pager();
		pager.setCurPage(page);
		pager.setPerPageRows(rows);
				
			
		return null;
		
	}
	
}
