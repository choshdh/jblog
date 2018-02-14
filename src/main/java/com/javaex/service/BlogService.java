package com.javaex.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.BlogDao;
import com.javaex.vo.BlogVo;

@Service
public class BlogService {

	@Autowired
	BlogDao bdao;
	
	public int blogInsert(BlogVo bvo) {
		return bdao.blogInsert(bvo);
	}

}
