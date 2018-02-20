package com.javaex.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.CommentDao;

@Service
public class CommentService {
	
	@Autowired
	CommentDao cDao;
	
	public Map<String,Object> commentList() {
		return cDao.commentList();
	}

}
