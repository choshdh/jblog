<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
</head>
<body>

	<div id="container">
		
		<!-- 블로그 해더 -->
		<c:import url="/WEB-INF/views/blog/includes/blog-header.jsp"></c:import>
		<!-- /블로그 해더 -->
		
		<div id="wrapper">
			<div id="content" class="full-screen">
				<ul class="admin-menu">
					<li><a href="${pageContext.request.contextPath}/${authUser.id}">내 블로그</a></li>
					<li class="selected"><a href="${pageContext.request.contextPath}/${authUser.id}/admin/basic">기본설정</a></li>
					<li><a href="${pageContext.request.contextPath}/${authUser.id}/admin/category">카테고리</a></li>
					<li><a href="${pageContext.request.contextPath}/${authUser.id}/admin/write">글작성</a></li>
				</ul>
				
				<form id="logochangeform" action="${pageContext.request.contextPath}/${authUser.id}/admin/logochange" method="post" enctype="multipart/form-data">
	 		      	<table class="admin-config">
			      		<tr>
			      			<td class="t">블로그 제목</td>
			      			<td><input type="text" size="40" name="title" value="${bVo.blogTitle }"></td>
			      		</tr>
			      		<tr>
			      			<td class="t">로고이미지</td>
			      			<td id="logoimg"></td>      			
			      		</tr>      		
			      		<tr>
			      			<td class="t">&nbsp;</td>
			      			<td><input type="file" name="logo-file"></td>      			
			      		</tr>           		
			      		<tr>
			      			<td class="t">&nbsp;</td>
			      			<td class="s"><input id="logochange" type="button" value="기본설정 변경"></td>      			
			      		</tr>           		
			      	</table>
				</form>
			</div>
		</div>
		
		<!-- 푸터 -->
		<c:import url="/WEB-INF/views/blog/includes/blog-footer.jsp"></c:import>
		<!-- 푸터 -->
	
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({
			url : "${pageContext.request.contextPath}/${authUser.id}/admin/logoselect",
			type : "post",
			contentType : "application/json",
			data : "${authUser.id}",
			
			dataType : "json",
			success : function(url){ /*성공시 처리해야될 코드 작성*/
				$("#logoimg")[0].innerHTML="<img src='${pageContext.request.contextPath}/"+url+"'>";
			},
			
			error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
				console.error(status + " : " + error);
			}
			
			
		});
	});
	
	$("#logochange").on("click", function(){
		$.ajax({
			url : "${pageContext.request.contextPath}/${authUser.id}/admin/logochange",
			type : "post",
			enctype: "multipart/form-data",
			data : $("#logochangeform"),
			
			dataType : "json",
			success : function(url){ /*성공시 처리해야될 코드 작성*/
				$("#logoimg")[0].innerHTML="<img src='${pageContext.request.contextPath}/"+url+"'>";
			},
			
			error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
				console.error(status + " : " + error);
			}
			
		});
		
	});
	
	
</script>
</html>