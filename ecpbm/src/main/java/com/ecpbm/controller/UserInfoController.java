package com.ecpbm.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.ecpbm.pojo.Functions;
import com.ecpbm.pojo.Pager;
import com.ecpbm.pojo.TreeNode;
import com.ecpbm.pojo.UserInfo;
import com.ecpbm.service.UserInfoService;
import com.ecpbm.util.JsonFactory;

@SessionAttributes(value= {"user"})
@Controller
@RequestMapping("/userinfo")
public class UserInfoController {
	@Autowired
	private UserInfoService userInfoService;
	
	@RequestMapping(value = "/login", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String login(UserInfo ui, ModelMap model) {
		
		UserInfo userInfo = userInfoService.login(ui);
		
		if(userInfo != null && userInfo.getUserName() != null) {
			model.put("user", userInfo);
			return "{\"success\":\"true\",\"message\":\"Login Successful\"}";
			
		}else {
			return "{\"success\":\"false\",\"message\":\"Login failed check your account or password!\"}";
		}
		
	}
	
	@RequestMapping("getTree")
	@ResponseBody
	public List<TreeNode> getTree(@RequestParam(value = "userid") String userid){
	//根据用户编号，获取UserInfo对象
	UserInfo userinfo = userInfoService.getUserInfoAndFunctions(Integer.parseInt(userid));
	//UserInfo userinfo = userInfoService.getUserInfoAndFunctions(1);
	List<TreeNode> nodes = new ArrayList<TreeNode>();
	//获取关联得Functions对象集合
	List<Functions> functionsList = userinfo.getFs();
	//对List<Functions>类型的Functions对象集合排序
	Collections.sort(functionsList);
	//将排序后的Functions对象集合转换到List<Treenode>类型的列表nodes
	for (Functions functions : functionsList) {
		TreeNode treeNode = new TreeNode();
		treeNode.setId(functions.getId());
		treeNode.setFid(functions.getPapentid());
		treeNode.setText(functions.getName());
		nodes.add(treeNode);
	}
	//调用自定义的工具类JsonFactory的buildtree方法，为nodes列表中的各个TreeNode元素
	//中的children属性赋值
	List<TreeNode> treeNodes = JsonFactory.buildtree(nodes, 0);
	return treeNodes;
		
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public Map<String, Object> userlist(Integer page, Integer rows, UserInfo userInfo){
		//创建分页类对象
		Pager pager = new Pager();
		pager.setCurPage(page);
		pager.setPerPageRows(rows);
		
		//创建对象params，封装查询条件
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userInfo", userInfo);
		
		//获取用户数
		int totalCount = userInfoService.count(params);
		
		//分页查询用户
		List<UserInfo> userinfos = userInfoService.findUserInfo(userInfo, pager);
		
		//创建对象result，保存查询结果数据
		Map<String, Object> result = new HashMap<String, Object>(2);
		result.put("total", totalCount);
		result.put("rows", userinfos);
		return result;
		
	}
	
	//add user info
	@RequestMapping(value = "/addUserinfo", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String addUserInfo(UserInfo ui) {
		String str = "";
		try {
			userInfoService.addUserInfo(ui);
			int user_id = userInfoService.findUserId(ui.getUserName());
			userInfoService.addUserPowers(user_id, 3);
			userInfoService.addUserPowers(user_id, 5);
			userInfoService.addUserPowers(user_id, 8);
			userInfoService.addAttributes(user_id, ui.getCategory_id(), ui.getAttribute_id());
			str = "{\"success\":\"true\",\"message\":\"User information added successfully!\"}";
		} catch (Exception e) {
			str = "{\"success\":\"false\",\"message\":\"Failed to add user information!\"}";
		}
		/*
		 * if (ui.getUserName() != null) { int user_id =
		 * userInfoService.findUserId(ui.getUserName());
		 * userInfoService.addUserPowers(user_id, 3);
		 * userInfoService.addUserPowers(user_id, 5);
		 * userInfoService.addUserPowers(user_id, 8); if (ui.getCategory_id() !=null) {
		 * userInfoService.addAttributes(user_id, ui.getCategory_id(),
		 * ui.getAttribute_id()); } }
		 */
		return str;	
	}
	
	//update user info
	@RequestMapping(value = "updateUserinfo", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String editUserInfo(UserInfo ui) {
		String str = "";
		try {
			userInfoService.editUserInfo(ui);
			str = "{\"success\":\"true\",\"message\":\"User information updating successfully!\"}";
		} catch (Exception e) {
			str = "{\"success\":\"false\",\"message\":\"Failed to update user information!\"}";
		}
		return str;	
	}
	
	//delete user info
	@RequestMapping(value = "/deleteUserInfo", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String deleteUserInfo(@RequestParam(value = "id") String id) {
		String str = "";
		try {
			userInfoService.deleteUserInfo(Integer.parseInt(id));
			str = "{\"success\":\"true\",\"message\":\"User information deleted successfully!\"}";
		} catch (Exception e) {
			str = "{\"success\":\"false\",\"message\":\"Failed to delete user information!\"}";
		}
		return str;		
	}
	
	//log out
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	@ResponseBody
	public String logout(SessionStatus status) {
		status.setComplete();
		return "{\"success\":\"true\",\"message\":\"Logout\"}";
	}
}
