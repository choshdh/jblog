package com.javaex.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommentDao {

	@Autowired
	SqlSession ss;
	
	public Map<String,Object> commentList() {
		return ss.selectMap(("comment.list"),"userNo"); //셀렉해오는 컬럼 중에 어떤것을 키값으로 사용할 것인지.
	}

}
