package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.FileVo;

@Repository
public class FileDao {

	@Autowired
	SqlSession sqlSession;
	
	public int fileInsert(FileVo file) {
		return sqlSession.insert("file.insert", file);
	}
	
	public List<FileVo> fileList(){
		return sqlSession.selectList("file.list");
	}
	
	public int filedelete(int fileNo) {
		return sqlSession.update("file.delete", fileNo);
	}
}
