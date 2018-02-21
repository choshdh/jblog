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
					<li><a href="${pageContext.request.contextPath}/${authUser.id}/admin/basic">기본설정</a></li>
					<li class="selected"><a href="${pageContext.request.contextPath}/${authUser.id}/admin/category">카테고리</a></li>
					<li><a href="${pageContext.request.contextPath}/${authUser.id}/admin/write">글작성</a></li>
				</ul>
				
		      	<table class="admin-cat" id="catelist">
		      		<tr>
		      			<th width="10%">번호</th>
		      			<th width="25%">카테고리명</th>
		      			<th width="35%">설명</th>
		      			<th width="20%">포스트 수</th>
		      			<th width="10%">삭제</th>
		      		</tr>
				</table>
      	
      			<h4 class="n-c">새로운 카테고리 추가</h4>
		      	<table id="admin-cat-add">
		      		<tr>
		      			<td class="t">카테고리명</td>
		      			<td><input type="text" id="catename" name="name"></td>
		      		</tr>
		      		<tr>
		      			<td class="t">설명</td>
		      			<td><input type="text" id="description" name="desc"></td>
		      		</tr>
		      		<tr>
		      			<td class="s">&nbsp;</td>
		      			<td><input id="cateadd" type="button" value="카테고리 추가"></td>
		      		</tr>      		      		
		      	</table> 
			</div>
		</div>

		<!-- 푸터 -->
		<c:import url="/WEB-INF/views/blog/includes/blog-footer.jsp"></c:import>
		<!-- 푸터 -->
		
	</div>
</body>
<script type="text/javascript">
	var cListSave;
	$(document).ready(function(){
		
		$.ajax({
			url : "${pageContext.request.contextPath}/${authUser.id}/admin/catelist",
			type : "post",
						
			dataType : "json",
			success : function(cList){ /*성공시 처리해야될 코드 작성*/
				cListSave = cList;
				for(var i=0; i<cList.length; i++){
					render(cList[i]);
				}
			},
			
			error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
				console.error(status + " : " + error);
			}
		});
		
	});
	
	$("#cateadd").on("click",function(){
		var userNo = ${authUser.userNo};
		var cateName = $("#catename").val();
		var description = $("#description").val();
		var cateNameCheck = 1;
		for(var i=0; i<cListSave.length; i++){
			if(cListSave[i].cateName==cateName){
				cateNameCheck = 0;
			}
		}
		if(cateNameCheck==1){
			$.ajax({
				url : "${pageContext.request.contextPath}/${authUser.id}/admin/cateadd",
				type : "post",
				contentType : "application/json",
				data : JSON.stringify({userNo:userNo,cateName:cateName,description:description}) ,        
				dataType : "json",
				success : function(cVo){ /*성공시 처리해야될 코드 작성*/
					if(cVo==null){
						alert("카테고리 추가 실패.");
					}else{
						cListSave.push(cVo);
						render(cVo);
					}
				},
				
				error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
					console.error(status + " : " + error);
				}
			});
		}else{
			alert("이미 존재 하는 카테고리 이름입니다.");
		}
		
		$("#catename").val("");
		$("#description").val("");
	});
	
	$("#catelist").on("click","#del",function(){
		var no = $(this).parent().data("no");
		
		if($(this).parent().children()[3].innerHTML ==0 ){ //클릭한 이미지의 부모의 3번째 자식 : 포스트 수가 0 이면 실행
			$.ajax({
				url : "${pageContext.request.contextPath}/${authUser.id}/admin/catedel",
				type : "post",
				contentType : "application/json",
				data : JSON.stringify(no) ,        
				dataType : "json",
				success : function(result){ /*성공시 처리해야될 코드 작성*/
					if(result==1){
						console.log("카테고리 삭제 성공");
						$("[data-no="+no+"]").remove();
					}else{
						console.log("카테고리 삭제 실패");
					}
				
				
				},
				
				error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
					console.error(status + " : " + error);
				}
			});
		}else{
			alert("해당 카테고리에 포스트가 있어서 삭제 할 수 없습니다.");
		}
		
	});
	
	
	function render(cVo){
		str = 
		"<tr data-no='"+ cVo.cateNo +"'>"+
			"<td>"+cVo.cateNo+"</td>"+
			"<td>"+cVo.cateName+"</td>"+
			"<td>"+cVo.description+"</td>"+
			"<td>"+cVo.postCnt+"</td>"+
			"<td id='del'><img src='${pageContext.request.contextPath}/assets/images/delete.jpg' ></td>"+
		"</tr>";
		
		$("#catelist").append(str);
	}
	
</script>
</html>