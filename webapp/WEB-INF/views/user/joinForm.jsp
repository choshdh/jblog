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
	<div class="center-content">
		
		<!-- 메인해더 -->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
 		<!-- /메인해더 -->
 		
 		
 		<!-- param -->
		<!-- name : userName,id,password,agreeProv -->
		<!-- id : id,btn-checkid,agree-prov -->
		<form class="join-form" id="join-form" method="post" action="${pageContext.request.contextPath}/user/join">
			<label class="block-label" for="name">이름</label>
			<input type="text" name="userName"  value="" />
			
			<label class="block-label" for="id">아이디</label>
			<input id="id" type="text" name="id"  value="" />
			<input id="btn-checkid" type="button" value="id 중복체크">
			<img id="img-checkid" style="visibility: hidden;" src="${pageContext.request.contextPath}/assets/images/check.png">
			<p class="form-error">
			</p>

			<label class="block-label" for="password">패스워드</label>
			<input type="password" name="password"  value="" />

			<fieldset>
				<legend>약관동의</legend>
				<input id="agree-prov" type="checkbox" name="agreeProv" value="y">
				<label class="l-float">서비스 약관에 동의합니다.</label>
			</fieldset>

			<input type="submit" value="가입하기">

		</form>
	</div>

</body>

	<script type="text/javascript">
		$("#btn-checkid").on("click",function(){
			var id = $("#id").val();
			console.log("id 중복 체크 버튼");
			
			//ajax 를 사용 하기위해서 필요한 포맷
			$.ajax({

				url : "${pageContext.request.contextPath }/user/api/idcheck",
				type : "post",
				contentType : "application/json", //json 형태로 바디에 담에 보내겠다고 타입 지정
				data : JSON.stringify({id: id}),
				
				/* dataType : "json", */
				success : function(result){ /*성공시 처리해야될 코드 작성*/
					if(result == true){
						$("#img-checkid").css("visibility","visible");
					}else{
						$("#img-checkid").css("visibility","hidden");
					}
				},
				
				
				error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
					/* console.error(status + " : " + error); */
				}
			});
			
		});
		
		$("#id").keydown(function(){
			$("#img-checkid").css("visibility","hidden");
		});
		
	</script>
</html>