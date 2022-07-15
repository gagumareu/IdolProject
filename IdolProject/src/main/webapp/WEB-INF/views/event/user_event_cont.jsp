<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="./resources/css/global.css" />
	<link rel="stylesheet" href="./resources/css/main.css" />
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	
	.event_wrap{
		width: 980px;
		height: auto;
		margin: 0 auto;
		margin-top: 40px;
	}
	#event_h2{
		text-align: center;
		font-size: 40px;
		font-weight: 700;
		
	}
	
	event_wrap ul li a{
		text-decoration: none;
	}
	
	.event_title ul{
		display: flex;
	}
	
	.event_title ul li{
		border-bottom: 2px solid lightgray;
		width: 50%;
		margin: 70px auto;
		height: 45px;
		line-height:45px;
	}
	
	.event_title ul li.active{
		border-bottom-color: red;
		color: red;
	}
	
	.event_menu ul{
		display: flex;
	}
	
	.event_menu ul li{
		color: lightgray;
	}
	
	.event_menu ul li a.active{
		color: red;
		font-weight: bold;
	}
	
	.event_title ul li a{
		text-align: center;
		font-size: 16px;
		display: block;
		
	}
	
	.event_menu ul li { 
		height: 20px;
	    line-height: 20px;
	    margin-right: 16px;
	}
	
	
	
	#event_cont_title{
	padding: 16px;
	
	}
	
	.event_cont_wrap {
		margin: 30px auto;
		width: 980px;
		height: auto;
	}
	
	.event_cont_wrap .event_cont_content_wrap {
		text-align: center;
		padding: 24px 0;
		margin: 36px 0;
		box-shadow: 0px 0px 10px 4px rgb(0, 0, 0, 0.1);
	}
	
	.event_cont_wrap .event_cont_link_wrap {
		text-align: right;
	}
	
	.event_cont_wrap .event_cont_link {
		width: 120px;
		height: 40px;
		line-height: 40px;
		border: 1px dotted;
		border-radius: 20px;
		display: inline-block;
		text-align: center;
		border-color: lightgray;
	}
	
	.event_cont_wrap .event_cont_link:hover{
	 border: 2px solid orange;
	}
	
	.event_cont_wrap .event_cont_info {
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding: 16px 0;
	}
	
	
	
</style>
</head>
<body>
<%@include file="../include/user_top.jsp" %>

	
		
		<div class="event_wrap">
			<div class="event_content">
				<div class="event_title">
					<a href="<%=request.getContextPath() %>/event_list.do?board_id=1&category_id=1"><h2 id="event_h2">EVENT</h2></a>
					<ul>
						<li class="tab_li"><a href="<%=request.getContextPath()%>/event_list.do?board_id=1&category_id=1">CELEB EVENT</a></li>
						<li class="tab_li"><a href="<%=request.getContextPath()%>/event_list.do?board_id=1001&category_id=1">CONCERT INFO</a></li>
					</ul>

				</div>
			
			<div class="event_menu">	
				<ul>
					<li class="event_category_li">
						<a href="<%=request.getContextPath()%>/event_list.do?board_id=1&category_id=1" id="doEvent">진행중 이벤트</a>
					</li>
					
					<li class="event_category_li">
						<a href="<%=request.getContextPath()%>/event_list.do?board_id=1&category_id=2" id="endEvent">종료 이벤트</a>
					</li>
				</ul>
			</div>
			</div>
		</div>
		
		<c:set var="dto" value="${Cont }"/>
		<c:set var="paging" value="${Page }"/>
		<div class="event_cont_wrap">
		
			<h3 class="event_cont_title">${dto.notice_title }</h3>
			
			<div class="event_cont_content_wrap"> 
				<c:forEach items="${dto.notice_images }" var="filename">
					<div>
						<img src="./resources/upload/notice/${filename }">
					</div>
				</c:forEach>
				
				<div class="event_cont_content">
					<% pageContext.setAttribute("replaceChar", "\n"); %>
				  	<c:set var="content" value="${fn:replace(dto.notice_cont, replaceChar, '<br>') }"/>
					${content }
				</div>
			</div>
			
			<c:if test="${dto.notice_update==null }">
				<div class="event_cont_info">
					<span id="event_cont_td">
						${dto.notice_date }
					</span>
					<span id="event_cont_hit">
						조회수 ${dto.notice_hit }
					</span>
				</div>
			</c:if>
			
			<c:if test="${dto.notice_update!=null }">
				<div class="event_cont_info"> 
					<span>
						${dto.notice_update }
					</span>
					<span id="event_cont_hit">
					조회수 
						${dto.notice_hit }
					</span>
				</div>
			</c:if>
			
			<div class="event_cont_link_wrap">
				<a class="event_cont_link" href="<%=request.getContextPath()%>/event_list.do?board_id=1&category_id=1">전체 목록</a>
			</div>
		</div>
		
		
		
<%@include file="../include/user_bottom.jsp" %>
</body>
<script type="text/javascript">
	var search=window.location.search
	var schema=new URLSearchParams(search)
	var tablis = document.querySelectorAll(".tab_li")
	var categories = document.querySelectorAll(".event_category_li a")
	
	if(schema.get("board_id") === "1"){
		tablis[0].classList.add("active")
	}else if(schema.get("board_id")==="1001"){
		tablis[1].classList.add("active")
	}
	
	if(schema.get("category_id")==="1"){
		categories[0].classList.add("active")
	}else if(schema.get("category_id")==="2"){
		categories[1].classList.add("active")
	}
	
	categories.forEach(function(anchor, i){
		anchor.addEventListener("click",function(ev){
			ev.preventDefault()
			window.location.href="<%=request.getContextPath()%>/event_list.do?board_id="+schema.get("board_id")+"&category_id="+(i+1)
		})
	})
</script>
</html>