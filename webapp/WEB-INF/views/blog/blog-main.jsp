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
				<div class="blog-content" style="background: #FFF5F0">
					<h4>Spring Camp 2016 참여기</h4>
					<p>
						스프링 캠프에서는 JVM(Java Virtual Machine) 기반 시스템의 백엔드(Back-end) 또는 서버사이드(Server-side)라고 칭하는 영역을 개발하는 애플리케이션 서버 개발에 관한 기술과 정보, 경험을 공유하는 컨퍼런스입니다.<br>
						 핵심주제로 Java와 Spring IO Platform을 다루고 있으며, 그외 Architecture나 JVM Language, Software Development Process 등 애플리케이션 서버 개발에 필요한 다양한 주제를 다루려고 노력하고 있습니다.<br>
						 우리는 같은 일을 하고, 같은 관심사를 가진 개발자들이지만 서로를 모릅니다.<br>
						 스프링 캠프라는 컨퍼런스에 찾아온 낯선 개발자들 사이에서 자신을 소개하고 이야기를 나누고 웃고 즐기며면서 어색함을 떨쳐내고 우리가 같은 분야에서 함께 일하고 있는 친구이자 동료라는 것을 인지하고 새로운 인연의 고리를 연결하고 이어갈 수 있는 순간으로 만들어가려 합니다.
					<p>
					
					<table id="comments" style="width: 100%; padding:5px; height:25px;">
						<tr style="width: 100%; background:#F6F6F6;">
							<td style="width: 15%; height: 100%; padding: 0 5px 0 5px">서유정</td>
							<td style="width: 70%; height: 100%; padding: 0 5px 0 5px">댓글 내용</td>
							<td style="width: 15%; height: 100%; padding: 0 5px 0 5px">2018/06/05</td>
						</tr>
						<tr style="width: 100%; background:#F0F0F0;">
							<td style="width: 15%; height: 100%; padding: 0 5px 0 5px">정호윤</td>
							<td style="width: 70%; height: 100%; padding: 0 5px 0 5px">댓글 내용</td>
							<td style="width: 15%; height: 100%; padding: 0 5px 0 5px">2018/07/05</td>
						</tr>
					</table>
					
					<div id="commentsendtable" style="display: none">
						<table id="commentsend" style="width: 100%; padding:5px; height:45px; background:white;">
							<tr style="width: 100%">
								<th style="width: 15%; height: 100%; padding: 0 5px 0 5px">작성자</th>
								<th style="width: 70%; height: 100%; padding: 0 5px 0 5px">댓글 내용</th>
								<th style="width: 15%; height: 100%; padding: 0 5px 0 5px"></th>
							</tr>
							<tr style="width: 100%">
								<td style="width: 15%; height: 100%; padding: 0 5px 0 5px">
									<input type="text" name="commentusername" style ="width:100%; height: 100%;">
								</td>
								<td style="width: 70%; height: 100%; padding: 0 5px 0 5px">
									<input type="text" name="comment" style ="width:100%; height: 100%;">
								</td>
								<td style="width: 15%; height: 100%; padding: 0 5px 0 5px">
									<input type="button" id="commentsave" value="댓글달기" style ="width:100%; height: 100%;">
								</td>
							</tr>
						</table>
					</div>
				</div>
				
				<label for="bl" style="padding:0 0 0 10px;">포스트</label>
				<ul id="bl" class="blog-list">
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
	var selectPostNo = -999; //현재 선택된 포스트 번호 임의값 -999로 초기화
	$(document).ready(function(){
		
		//포스트 리스트 그리기
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
						selectPostNo = pList[0].postNo;
						
						commentload(selectPostNo);
					}
					postrender(pList[i] , i);
				}
			
			},
			
			error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
				console.error(status + " : " + error);
			}
		});
		
		//카테고리 리스트 그리기
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
		
		//로고 그리기
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
	
	//클릭한 포스트 내용 보여주기
	$(".blog-list").on("click","li", function(){
		var index = $(this).data("no");
		$(".blog-content").children()[0].innerHTML=pListSave[index].postTitle;
		$(".blog-content").children()[1].innerHTML=pListSave[index].postContent;
		selectPostNo = pListSave[index].postNo;
		
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
		
		selectPostNo = -999; //선택한 포스트 번호를 받아오기전에 초기화
		
		if(pListSave==null){ // 포스트가 하나도 없을떄
			$(".blog-content").children()[0].innerHTML="";
			$(".blog-content").children()[1].innerHTML="";
		}else{ //포스트가 하나라도 있을때
			
			if(index==-1){ //전체 카테고리 선택시
				for(var i=0; i<pListSave.length; i++){
					if(i==0){ //blog-content 내용을 해당 카테고리의 첫번째글로 업데이트 해주기 
						$(".blog-content").children()[0].innerHTML=pListSave[0].postTitle;
						$(".blog-content").children()[1].innerHTML=pListSave[0].postContent;
						selectPostNo = pListSave[0].postNo;
					}
					postrender(pListSave[i] , i);
				}
			}else{ //다른 카테고리 선택시
				var printfirst = 1; //전체 카테고리와 다르게 선택적 카테고리에서 첫번째 포스트만 창에 띄우기 위해서 변수 사용
				for(var i=0; i<pListSave.length; i++){
					if(cListSave[index].cateNo==pListSave[i].cateNo){
						if(printfirst ==1){ //blog-content 내용을 해당 카테고리의 첫번째글로 업데이트 해주기 
							$(".blog-content").children()[0].innerHTML=pListSave[i].postTitle;
							$(".blog-content").children()[1].innerHTML=pListSave[i].postContent;
							selectPostNo = pListSave[i].postNo;
							printfirst = -99999;
							console.log(selectPostNo);
						}
						postrender(pListSave[i] , i);
					}
				}
			}

		}
		
		if(selectPostNo==-999){
			$(".blog-content").children()[0].innerHTML="포스트가 존재 하지 않습니다.";
			$(".blog-content").children()[1].innerHTML="";
			$("#commentsendtable").hide(); //보여지는 포스트가 없을때 숨기기
		}else{
			$("#commentsendtable").show(); //보여지는 포스트가 있을때 보이기
		}
		
		
	});
	
	//포스트 그리기 함수
	function postrender(pVo , i){
		str = "<li data-no='"+i+"' data-cateno='"+pVo.postNo+"'>"+pVo.postTitle+"<span>"+pVo.regDate+"</span></li>";
		
		$(".blog-list").append(str);
	}
	
	//카테고리 그리기 함수
	function caterender(cVo , i){
		str = "<li data-no='"+i+"'>"+cVo.cateName+"</li>";
		
		$("#catelist").append(str);
	}
	
	//댓글 로드 함수
	function commentload(postNo){
		$.ajax({
			url : "${pageContext.request.contextPath}/${requestScope.id}/commentlist",
			type : "post",
			data : postNo,
			
			dataType : "json",
			success : function(comments){ /*성공시 처리해야될 코드 작성*/
				console.log(comments);
				
				for(var i=0; i<comments.length; i++){
					var color = (i%2==0?  "#F6F6F6" : "##F0F0F0");
					var str =
						"<tr>"+
							"<tr style=width: 100%; background:"+color+";>"+
							"<td style='width: 15%; height: 100%; padding: 0 5px 0 5px'>"+comments[i].userName+"</td>"+
							"<td style='width: 70%; height: 100%; padding: 0 5px 0 5px'>"+comments[i].cmtContent+"</td>"+
							"<td style='width: 15%; height: 100%; padding: 0 5px 0 5px'>"+comments[i].regDate+"</td>"+
						"</tr>";
					$("#comments").append(str);
				}
			},
			
			error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
				console.error(status + " : " + error);
			}
		})
	}

</script>
</html>