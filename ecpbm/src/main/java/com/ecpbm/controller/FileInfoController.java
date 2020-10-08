package com.ecpbm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.taglibs.standard.extra.spath.Path;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
	public String addFileInfo(FileInfo fi,
			HttpServletRequest request,
			@RequestParam(value="file") MultipartFile file) throws Exception {
		String str = "";
		if(!file.isEmpty())
		{
            try {
            	String path = request.getSession().getServletContext().getRealPath("/uploads/");
    			
    			System.out.println(path);
    			
    			String filename = file.getOriginalFilename();
    			File filepath = new File(path,filename);
                //判断路径是否存在，如果不存在就创建一个
                if (!filepath.getParentFile().exists()) {
                    filepath.getParentFile().mkdirs();
                }
                //将上传文件保存到一个目标文件当中
                file.transferTo(filepath);
                //输出文件上传最终的路径 测试查看
                //System.out.println(path + File.separator + filename);
                fi.setFile_path(filename);
                
    			fileInfoService.addFileInfo(fi);
    			int file_id = fileInfoService.findFileIdByTitle(fi.getFile_title());
    			fileInfoService.addFileAttributes(file_id, fi.getCategory_id(), fi.getAttribute_id());
    			str = "{\"success\":\"true\",\"message\":\"File information added successfully!\"}";
    		} catch (Exception e) {
    			str = "{\"success\":\"false\",\"message\":\"Failed to add file information!\"}";
    		}
		}
		else {
			str = "{\"success\":\"false\",\"message\":\"Failed to add file information! " + file.getOriginalFilename() + " was empty\"}";
//			return "You failed to upload \" +  file.getOriginalFilename() + \" because the file was empty.";
		}	
		
		return str;	
	}
	//download file
	@RequestMapping(value = "/downloadFileinfo", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String downloadFileinfo(@RequestParam(value = "id") String id, 
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		String str = "";
		
		String fileName = fileInfoService.findFilePathById(Integer.parseInt(id));
		//System.out.print("filename: "+fileName);
		
		String path = request.getSession().getServletContext().getRealPath("/uploads/");
//		System.out.println(path);
		File filepath = new File(path,fileName);
		System.out.println("File path: "+filepath);
		
		if(filepath.getAbsoluteFile().exists())
		{
			response.setContentType("application/x-msdownload;charset=utf-8");
			
			response.setHeader("Content-Disposition", "attachment;filename=" + fileName/* "goals.docx" */ );
			response.setHeader("Content-Length",String.valueOf(filepath.length()));
			
		    try {
			    FileInputStream inputStream = new FileInputStream(filepath);
			    ServletOutputStream outputStream = response.getOutputStream();
			    int num = 0;
			    byte[] b = new byte[1024]; 
			    while ((num = inputStream.read(b)) != -1) {
			    	outputStream.write(b, 0, num);
				}
			    
			    inputStream.close();
			    outputStream.close();
			    outputStream.flush();
			    str = "{\"success\":\"true\",\"message\":\"Download file successfully!\"}";
		    }
		    catch (IOException e){
		    	str = "{\"success\":\"false\",\"message\":\"Failed to download file!\"}";
		    }
		}
		else {
			str = "{\"success\":\"false\",\"message\":\"File not exists!\"}";
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
