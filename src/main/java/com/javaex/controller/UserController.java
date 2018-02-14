package com.javaex.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@RequestMapping(value = "/joinform" , method = RequestMethod.GET)
	public String joinform() {
		System.out.println("joinform 진입");
		return "user/joinForm";
	}
	
	@RequestMapping(value = "/join" , method = RequestMethod.POST)
	public String join(@RequestParam Map<String,String> map, Model model) {//param(UserName, id, password, agree-prov)
		System.out.println("join 진입");
		int result = 0;
		result = userService.join(map);
		if(result == 1) {
			return "redirect:/user/joinSuccess";
		}else {
			return "redirect:/user/joinFail";
		}
	}
	
	@RequestMapping(value = "/joinsuccess" , method = RequestMethod.GET)
	public String joinsuccess() {
		System.out.println("joinsuccess 진입");
		return "user/joinSuccess";
	}
	
	@RequestMapping(value = "/joinfail" , method = RequestMethod.GET)
	public String joinfail() {
		System.out.println("joinfail 진입");
		return "user/joinFail";
	}
	
	@RequestMapping(value = "/loginform" , method = RequestMethod.GET)
	public String loginform() {
		System.out.println("loginform 진입");
		return "user/loginForm";
	}
	
	@RequestMapping(value = "/login" , method = RequestMethod.POST)
	public String login(HttpSession session , @RequestParam Map<String,String> map) {
		System.out.println("login 진입");
		System.out.println("로그인 요청 : " + map.get("id") + "/" + map.get("password"));

//		UserVo uvo = userService.login(map);
		
//		if(uvo == null) {
//			System.out.println("로그인 실패");
//			return "redirect:/user/loginForm?result=fail";
//		}else {
//			System.out.println("로그인 성공");
//			session.setAttribute("authUser", uvo);
//			
			return "redirect:/";
//		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		System.out.println("logout 진입");
		session.removeAttribute("authUser");
		session.invalidate();
		return "redirect:/";
	}
	
}
