package com.javaex.api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.UserService;
import com.javaex.vo.UserVo;

@Controller
@RequestMapping("/user/api")
public class ApiUserController {

	@Autowired
	UserService userService;
	
	@ResponseBody
	@RequestMapping(value="/idcheck", method=RequestMethod.POST)
	public boolean idCheck(@RequestBody String id) {
		return userService.idCheck(id);
	}
	
}
