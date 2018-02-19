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
			<div id="content">
				<div class="blog-content">
					<h4>Spring Camp 2016 참여기</h4>
					<p>
						스프링 캠프에서는 JVM(Java Virtual Machine) 기반 시스템의 백엔드(Back-end) 또는 서버사이드(Server-side)라고 칭하는 영역을 개발하는 애플리케이션 서버 개발에 관한 기술과 정보, 경험을 공유하는 컨퍼런스입니다.<br>
						 핵심주제로 Java와 Spring IO Platform을 다루고 있으며, 그외 Architecture나 JVM Language, Software Development Process 등 애플리케이션 서버 개발에 필요한 다양한 주제를 다루려고 노력하고 있습니다.<br>
						 우리는 같은 일을 하고, 같은 관심사를 가진 개발자들이지만 서로를 모릅니다.<br>
						 스프링 캠프라는 컨퍼런스에 찾아온 낯선 개발자들 사이에서 자신을 소개하고 이야기를 나누고 웃고 즐기며면서 어색함을 떨쳐내고 우리가 같은 분야에서 함께 일하고 있는 친구이자 동료라는 것을 인지하고 새로운 인연의 고리를 연결하고 이어갈 수 있는 순간으로 만들어가려 합니다.
					<p>
				</div>
				
				<ul class="blog-list">
				</ul>
			</div>
		</div>

		<div id="extra">
			<div id="bloglogo" class="blog-logo" style="height: 200px;">
				
			</div>
		</div>

		<div id="navigation">
			<h2>카테고리</h2>
			<ul id="catelist">
				<li data-no="-1">전체</li>
				
			</ul>
		</div>
		<div style="font-weight:bold; padding:10px; background-color:white; border:1px solid #5D5D5D; border-radius: 5px 5px 5px 5px; width:300px; height:100px; z-index:10; display:none; z-index:10;" id=hdiv></div>
		<!-- 푸터 -->
		<c:import url="/WEB-INF/views/blog/includes/blog-footer.jsp"></c:import>
		<!-- 푸터 -->
		
	</div>
</body>

<script type="text/javascript">
	var pListSave; //포스트 리스트
	var cListSave; //카테고리 리스트
	var pTotal; //전체 포스트 수
	var cTotal; //전체 카테고리 수
	$(document).ready(function(){
		
		$.ajax({
			url : "${pageContext.request.contextPath}/${requestScope.id}/admin/postlist",
			type : "post",		
			
			dataType : "json",
			success : function(pList){ /*성공시 처리해야될 코드 작성*/
				pListSave = pList;
				pTotal = pList.length;
				for(var i=0; i<pList.length; i++){
					if(i==0){
						$(".blog-content").children()[0].innerHTML=pList[0].postTitle;
						$(".blog-content").children()[1].innerHTML=pList[0].postContent;
					}
					postrender(pList[i] , i);
				}
			
			},
			
			error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
				console.error(status + " : " + error);
			}
		});
		
		$.ajax({
			url : "${pageContext.request.contextPath}/${requestScope.id}/admin/catelist",
			type : "post",		
			
			dataType : "json",
			success : function(cList){ /*성공시 처리해야될 코드 작성*/
				cListSave = cList;
				cTotal = cList.length;
				for(var i=0; i<cList.length; i++){
					caterender(cList[i] , i);
				}
			
			},
			
			error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
				console.error(status + " : " + error);
			}
		});
		
		$.ajax({
			url : "${pageContext.request.contextPath}/${requestScope.id}/logoselect",
			type : "post",
			contentType : "application/json",
			data : "${requestScope.id}",
			
			dataType : "json",
			success : function(url){ /*성공시 처리해야될 코드 작성*/
				$("#bloglogo")[0].innerHTML="<img src='${pageContext.request.contextPath}/"+url+"'>";
			},
			
			error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
				console.error(status + " : " + error);
			}
			
		});
		
	});
	
	//포스트 그리기
	function postrender(pVo , i){
		str = "<li data-no='"+i+"'>"+pVo.postTitle+"<span>"+pVo.regDate+"</span></li>";
		
		$(".blog-list").append(str);
	}
	
	//카테고리 그리기
	function caterender(cVo , i){
		str = "<li data-no='"+i+"'>"+cVo.cateName+"</li>";
		
		$("#catelist").append(str);
	}
	
	//클릭한 포스트 내용 보여주기
	$(".blog-list").on("click","li", function(){
		var index = $(this).data("no");
		$(".blog-content").children()[0].innerHTML=pListSave[index].postTitle;
		$(".blog-content").children()[1].innerHTML=pListSave[index].postContent;
	});
		
	//카테고리 마우스 hover 시
	//동적으로 생성된 li 객체에  hover 이벤트를 사용 할 수 있는 방법을 찾아도 나와있지를 않아서 mouse 이벤트 2개를 동시에 넣고 발생되는 이벤트에 따라서 css 추가함
	$("#catelist").delegate("li","mouseenter mouseleave", function(event) { 
		x = $(this).position().left;
		y = $(this).position().top;
		var index = $(this).data("no");
		if(index==-1){
			$("#hdiv")[0].innerHTML="전체 포스트 수 : "+pTotal;
		}else{
			$("#hdiv")[0].innerHTML="카테고리 : "+cListSave[index].cateName+"<br>카테고리 설명 : "+cListSave[index].description+"<br>카테고리 포스트 수 : "+cListSave[index].postCnt;
		}
	    $("#hdiv").css({"display":"block","position":"absolute","left":x+100,"top":y}).toggle( event.type === 'mouseenter' );  
	});
	
	//카테고리 클릭시 해당 포스트만 보여주기
	$("#catelist").delegate("li","click", function(){
		$(".blog-list").children().remove();
		var index = $(this).data("no");
		if(index==-1){ //전체 카테고리 선택시
			for(var i=0; i<pListSave.length; i++){
				if(i==0){ //blog-content 내용을 해당 카테고리의 첫번째글로 업데이트 해주기 
					$(".blog-content").children()[0].innerHTML=pListSave[0].postTitle;
					$(".blog-content").children()[1].innerHTML=pListSave[0].postContent;
				}
				postrender(pListSave[i] , i);
			}
		}else{ //다른 카테고리 선택시
			var printfirst = 1;
			for(var i=0; i<pListSave.length; i++){
				if(cListSave[index].cateNo==pListSave[i].cateNo){
					if(printfirst ==1){ //blog-content 내용을 해당 카테고리의 첫번째글로 업데이트 해주기 
						$(".blog-content").children()[0].innerHTML=pListSave[i].postTitle;
						$(".blog-content").children()[1].innerHTML=pListSave[i].postContent;
						printfirst = -99999;
					}
					postrender(pListSave[i] , i);
				}
			}
		}
		
		
	});

</script>
</html>