<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
		<link rel="stylesheet" href="./resources/css/global.css" />
	    <link rel="stylesheet" href="./resources/css/main.css" />
	    <link rel="stylesheet" href="./resources/css/event_cont.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	
	.event_wrap{
		width: 980px;
		min-height: 100%;
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
	
	.event_menu_wrap .event_menu ul{
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
	
	.event_list_wrap{
		width: 100%;
	    min-width: 1216px;
	    font-size: 0;
	    line-height: 0;
	    margin: 0 auto;
	    padding-top: 20px;
	}
	
	.event_list_wrap ul li{
		display:inline-block;
		width: 470px;
		margin: 20px 0 40px 16px;
		font-size: 12px;
		color: #757575;
		ling-height: 16px;
		vertical-align: top;
	}
	
	.event_list_wrap li {
	text-align: center;
	}
	
	.event_list_wrap img{
		width:470px;
		height:360px;
		margin: 0 auto 20px;
		display: block;
	
	}
	
	.event_page_section{
	text-align:center;
	}
</style>
</head>
<body>
<%@include file="../include/user_top.jsp" %>

	<div class="event_wrap">
		<div class="event_content">
			<div class="event_title">
				<h2 id="event_h2">EVENT</h2>
				<ul>
					<li class="tab_li"><a href="<%=request.getContextPath()%>/event_list.do?board_id=1&category_id=1">CELEB EVENT</a></li>
					<li class="tab_li"><a href="<%=request.getContextPath()%>/event_list.do?board_id=1001&category_id=1">CONCERT INFO</a></li>
				</ul>

			</div>
			
		<div class="event_menu_wrap">
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

			
			<c:set var="list" value="${noticeList }"/>
			<c:set var="paging" value="${Paging }"/>
			<c:set var="cid" value="${cid }"/>
			<c:set var="bid" value="${bid }"/>
			
			<c:if test="${list.size() > 0}">
				<div class="event_list_wrap">
					<ul>
					<c:forEach items="${list}" var="dto">
						<li>
							<a href="<%=request.getContextPath() %>/event_cont.do?no=${dto.notice_no}&page=${paging.getPage()}&board_id=${bid}&category_id=${cid}" class="img_link"><img src="./resources/upload/notice/${dto.getNotice_image() }"></a>
							<a href="<%=request.getContextPath() %>/event_cont.do?no=${dto.notice_no}&page=${paging.getPage()}&board_id=${bid}&category_id=${cid}" class="img_link">${dto.notice_title }</a>
						</li>					
					</c:forEach>
					</ul>
				</div>
			</c:if> 
			
			<c:if test="${list.size() == 0}">
				<div>
					<ul>
						<li>
							<p>검색 결과가 없습니다</p>
						</li>
					</ul>
				</div>
			</c:if>
			
			<div class="event_page_section">
			
			<c:if test="${paging.getPage() > paging.getBlock() }">
				<a href="event_list.do?page=1&board_id=${bid }&category_id=${cid}">[처음으로]</a>
				<a href="event_list.do?page=${paging.getStartBlock()-1 }&board_id=${bid }&category_id=${cid}">◀</a>
			</c:if>	

			<c:forEach begin="${paging.getStartBlock() }"
							end="${paging.getEndBlock() }" var="i">
			<c:if test="${i == paging.getPage() }">
				<b><a href="event_list.do?page=${i }&board_id=${bid }&category_id=${cid}">[${i }]</a></b>
			</c:if>
			
			<c:if test="${i != paging.getPage() }">
				<a href="event_list.do?page=${i }&board_id=${bid }&category_id=${cid}">[${i }]</a>
			</c:if>
		
			</c:forEach>

	
			<c:if test="${paging.getEndBlock() < paging.getAllPage() }">
				<a href="board_list.do?page=${paging.getEndBlock()+1 }&board_id=${bid }&category_id=${cid}">▶</a>
				<a href="board_list.do?page=${paging.getAllPage() }&board_id=${bid }&category_id=${cid}">[마지막으로]</a>
			</c:if>	
		
			</div>
		</div>
	</div>
	<script type="text/javascript">
		
	var search=window.location.search
	var schema=new URLSearchParams(search)
	
	console.log(schema.get("board_id"))
	
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
	<%@include file="../include/user_bottom.jsp" %>
</body>
</html>