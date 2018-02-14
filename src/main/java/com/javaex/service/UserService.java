package com.javaex.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javaex.dao.BlogDao;
import com.javaex.dao.UserDao;
import com.javaex.vo.BlogVo;
import com.javaex.vo.UserVo;

@Service
public class UserService {

	@Autowired
	UserDao userDao;
	@Autowired
	BlogDao blogDao;
	
	@Transactional
	public int join(Map<String,String> map) {
		int userNo = userDao.userInsert(map);
		blogDao.blogInsert(new BlogVo(userNo,"기본블로그","default logo"));
		return 1;
	}
	
//	public UserVo login(Map<String,String> map) {
//		return userDao.userSelect(map);
//	}
	
//	public UserVo modifyform(int no) {
//		return userDao.userSelectByNo(no);
//	}
	
	public boolean idCheck(String id) {
		boolean result;
		UserVo uvo = userDao.userIdCheck(id);
		if(uvo==null) {
			result = true;
		}else {
			result = false;
		}
		return result;
	}
	
//	public int modify(Map<String,String> map) {
//		return userDao.userUpdate(map);
//	}
//	
//	public int delete(Map<String,String> map) {
//		return userDao.userDelete(map);
//	}
}
