package com.javaex.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.UserService;
import com.javaex.vo.UserVo;

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
	public String join(@RequestParam Map<String,String> map, Model model) { //request 파라미터를 맵으로 받아서 그냥 바로 보내버렸다 꿀....핵꿀...
		System.out.println("join 진입");
		int result = 0;
		try {
			result = userService.join(map);
		} catch (DuplicateKeyException e) {
			model.addAttribute("failmsg", "이미 사용중인 아이디 입니다.");
			return "redirect:/user/joinFail";
		}
		if(result == 1) {
			return "redirect:/user/joinSuccess"; //mysiteFinal까지 적힌 상태이므로 이렇게 적는다
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

		UserVo uvo = userService.login(map);
		
		if(uvo == null) {
			System.out.println("로그인 실패");
			return "redirect:/user/loginForm?result=fail";
		}else {
			System.out.println("로그인 성공");
			session.setAttribute("authUser", uvo);
			
			return "redirect:/";
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		System.out.println("logout 진입");
		session.removeAttribute("authUser");
		session.invalidate();
		return "redirect:/";
	}
	
}
