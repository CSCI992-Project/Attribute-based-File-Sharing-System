package com.ecpbm.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ecpbm.pojo.FileInfo;
import com.ecpbm.pojo.Pager;
import com.ecpbm.service.AttributeService;
import com.ecpbm.service.CategoryService;
import com.ecpbm.service.CpabeService;
import com.ecpbm.service.FileInfoService;
import com.ecpbm.service.UserInfoService;

@Controller
@RequestMapping("/fileinfo")
public class FileInfoController {
	
	@Autowired
	FileInfoService fileInfoService;
	
	@Autowired
	CpabeService cpabeService;
	
	@Autowired
	AttributeService attributeService;
	
	@Autowired
	CategoryService categoryService;
	
	@Autowired
	UserInfoService userInfoservice;
	
	  static String pubfile =
	  "C:\\Users\\miaomiao\\992 project\\Attribute-based-File-Sharing-System\\ecpbm\\demo\\cpabe\\pub_key"
	  ; static String mskfile =
	  "C:\\Users\\miaomiao\\992 project\\Attribute-based-File-Sharing-System\\ecpbm\\demo\\cpabe\\master_key"
	  ;
	
	/*
	 * static String pubfile =
	 * "G:\\Project\\Attribute-based-File-Sharing-System\\ecpbm\\demo\\cpabe\\pub_key";
	 * static String mskfile =
	 * "G:\\Project\\Attribute-based-File-Sharing-System\\ecpbm\\demo\\cpabe\\master_key";
	 */
//	static String pubfile = "root\\apache-tomcat-9.0.39\\webapps\\ecpbm\\demo\\cpabe\\pub_key";
//	static String mskfile = "root\\apache-tomcat-9.0.39\\webapps\\ecpbm\\demo\\cpabe\\master_key";
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
            	String Cpath = request.getSession().getServletContext().getRealPath("/uploads/");		//cipher file
            	String Ppath = request.getSession().getServletContext().getRealPath("/storeuploads/"); // plain file
    			
    			System.out.println(Ppath);
    			
    			String filename = file.getOriginalFilename();
    			File filepath = new File(Ppath,filename);
                //判断路径是否存在，如果不存在就创建一个
                if (!filepath.getParentFile().exists()) {
                    filepath.getParentFile().mkdirs();
                }
            
                File encpath = new File(Cpath, filename);
                if(!encpath.getParentFile().exists())
                {
                	encpath.getParentFile().mkdirs();
                }
                
                //将上传文件保存到一个目标文件当中
                file.transferTo(filepath);
               
                String encfilename = Cpath + filename;
                String attributes = attributeService.getAttributeName(fi.getAttribute_id());
                String categorys = categoryService.getCategoryName(fi.getCategory_id());
                String policy = categorys + ":" + attributes + " admin:admin 1of2";
                
                String inputfile = Ppath + filename;
                //System.out.println(inputfile);
                cpabeService.enc(pubfile, policy, inputfile, encfilename);
                
                //输出文件上传最终的路径 测试查看
                //System.out.println(path + File.separator + filename);
                System.out.println(encfilename);
                filepath.delete();
                fi.setFile_path(encfilename);
                
    			fileInfoService.addFileInfo(fi);
    			
    			int file_id = fileInfoService.findFileIdByTitle(fi.getFile_title());
    			
    			fileInfoService.addFileAttributes(file_id, fi.getCategory_id(), fi.getAttribute_id());
    			
    			str = "{\"success\":\"true\",\"message\":\"File information added successfully!\"}";
    		} catch (Exception e) {
    			e.printStackTrace();
    			str = "{\"success\":\"false\",\"message\":\"Failed to add file information!\"}";
    		}
		}
		else {
			str = "{\"success\":\"false\",\"message\":\"Failed to add file information! " + file.getOriginalFilename() + " was empty\"}";
		}	
		
		return str;	
	}
	//download file
	@RequestMapping(value = "/downloadFileinfo", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public void downloadFileinfo(@RequestParam(value = "id") String id, 
								@RequestParam(value = "userid") String userid,
			HttpServletRequest request, HttpServletResponse response) throws IOException, Exception {
		String str = "";
		
		String filePath = fileInfoService.findFilePathById(Integer.parseInt(id));
		System.out.println("download filename: "+filePath);
		
		// Get decrypted file path
		String path = request.getSession().getServletContext().getRealPath("/uploads/");	//cipher file
		// Decrypte ciphertext to plaintext
		String Dpath = request.getSession().getServletContext().getRealPath("/Decuploads/");// plain file
		File tmpFile = new File(filePath);
		String fileName = tmpFile.getName();
        File decpath = new File(Dpath, fileName);
        if(!decpath.getParentFile().exists())
        {
        	decpath.getParentFile().mkdirs();
        }
        System.out.println("Download file: " + path + fileName);

        Integer categ_id = userInfoservice.findCategory(Integer.parseInt(userid));
            
        String attr_str = categoryService.getCategoryName(categ_id)+":"+attributeService.getAttributeName(userInfoservice.findAttribute(Integer.parseInt(userid))) ;
	Integer uid = Integer.parseInt(userid);
        if(userInfoservice.getUserInfoAndFunctions(uid).getUserType() == 1) {
        	attr_str = attr_str + " admin:admin";
        }
		byte[] prvkey = cpabeService.keygen(pubfile, mskfile, attr_str);
		String encFile = path + fileName;
		String decFile = Dpath + fileName;
		cpabeService.dec(pubfile, prvkey, encFile, decFile);
		
		
//		System.out.println(path);
		File filepath = new File(decFile);
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
			    filepath.delete();
//			    str = "{\"success\":\"true\",\"message\":\"Download file successfully!\"}";
		    }
		    catch (IOException e){
		    	e.printStackTrace();
//		    	str = "{\"success\":\"false\",\"message\":\"Failed to download file!\"}";
		    	response.setContentType("text/html; charset=UTF-8"); //转码
	             PrintWriter out = response.getWriter();
	             out.flush();
	             out.println("<script defer='defer' type='text/javascript'>");
	             out.println("alert('Failed to download file! Please download again.');");
	             out.println("history.back();");
	             out.println("</script>");
		    }
		}
		else {
//			str = "{\"success\":\"false\",\"message\":\"You don't have the authority to download this file!\"}";
			 response.setContentType("text/html; charset=UTF-8"); //转码
             PrintWriter out = response.getWriter();
             out.flush();
             out.println("<script defer='defer' type='text/javascript'>");
             out.println("alert('You have no authority to download this file!');");
             out.println("history.back();");
             out.println("</script>");
		}
			return;
//		return str;
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
