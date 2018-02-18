package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.BlogVo;
import com.javaex.vo.CateVo;

@Repository
public class BlogDao {

	@Autowired
	SqlSession ss;

	public int blogInsert(BlogVo bvo) {
		return ss.insert("blog.insert", bvo);
	}

	public BlogVo blogSelect(String id) {
		return ss.selectOne("blog.select", id);
	}
	
}
