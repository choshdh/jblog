package com.javaex.api.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.CommentService;

@Controller
public class ApiCommentController {

	@Autowired
	CommentService cService;
	
	@ResponseBody
	@RequestMapping("/{id}/commentlist")
	public Map<String,Object> commentList(){
		System.out.println("/{id}/commentlist 진입");
		return cService.commentList();
	}
}
