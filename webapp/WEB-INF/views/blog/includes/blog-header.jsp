<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="header">
	<h1>블로그타이틀 출력해야함</h1>
	<ul>
		<c:choose>
			<c:when test="${ empty sessionScope.authUser }">
				<!-- 로그인 전 메뉴 -->
				<li><a href="">로그인</a></li>
			</c:when>
			<c:otherwise>
				<!-- 로그인 후 메뉴 -->
				<li><a href="">로그아웃</a></li>
				<li><a href="">내블로그 관리</a></li>
			</c:otherwise>
		</c:choose>
	</ul>
</div>