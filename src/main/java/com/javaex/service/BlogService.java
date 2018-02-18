package com.javaex.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.BlogDao;
import com.javaex.vo.BlogVo;

@Service
public class BlogService {

	@Autowired
	BlogDao bDao;
	
	public int blogInsert(BlogVo bvo) {
		return bDao.blogInsert(bvo);
	}

	public BlogVo myblog(String id) {
		return bDao.blogSelect(id);
		
	}

}
