package com.my.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.my.pojo.UserInfo;
import com.my.service.UserInfoService;

@SessionAttributes(value = {"user"})
@Controller
@RequestMapping("/userinfo")
public class UserInfoController {

	@Autowired
	private UserInfoService userInfoService;
	
	@RequestMapping(value = "/login", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String login(UserInfo ui, ModelMap model) {
		UserInfo userinfo = userInfoService.login(ui);
		if(userinfo != null && userinfo.getUserName() != null)
		{
			model.put("user", userinfo);
			return "{\"success\":\"false\",\"message\":\"Success!\"}";
		}
		return "{\"success\":\"false\",\"message\":\"Failed\"}";
	}	
}