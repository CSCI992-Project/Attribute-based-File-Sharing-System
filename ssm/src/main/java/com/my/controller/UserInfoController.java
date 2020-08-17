package com.my.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	@RequestMapping("/login")
	@ResponseBody
	public String login(UserInfo ui) {
		UserInfo userInfo = userInfoService.login(ui);
		System.out.println(userInfo.getUserName());
		if (userInfo != null) {
			return "{\"success\":\"true\",\"message\":\"Login successful\"}";
		} else {
			return "{\"success\":\"false\",\"message\":\"..\"}";
		}
	}

}
