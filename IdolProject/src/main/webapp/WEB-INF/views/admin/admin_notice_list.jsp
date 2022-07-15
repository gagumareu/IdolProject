<%@page import="java.util.StringTokenizer"%>
<%@page import="com.idol.model.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN NOTICE MAIN</title>


<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">


<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />

<style type="text/css">

	html, body {
		padding: 0px;
		margin: 0px;
		height: 100%;
		background-color: black;
	}
	
	
	a {
		text-decoration: none;
	}
	
	li {
		list-style-type: none;
		
	}
	
	.admin_notice_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	
	}
	
	
	.admin_notice_container {
		display: flex;
	    flex-direction: row;
	    flex-wrap: wrap;
	    width: 80%;
    	align-self: center;
	    justify-content: center;
	}
	
	.admin_notice_content{
		border: 1px solid pink;
		width: 360px;
		height: 320px;
		color: white;
		display: flex;
		flex-direction: row;
	}

	.notice_boxes {
		width: 100%;
		height: 100%;
		display: grid;
		grid-template-rows: 70% 30%;
		font-family: 'Jua', monospace;
		font-size: 1.1em;
	}
	
	
	.notice_img {
		grid-row: 1;
		width: 100%;
		height: 100%;
		display: flex;
		flex-direction: row;
	}
	.notice_img img {
		width: 70%;
		height: 100%;
	}
	
	.notice_list_title {
		grid-row: 2;
		margin-left: 20px;
		margin-top: 10px;
	}
	
	
	.notice_list_date {
		font-family: 'Press Start 2P', cursive;
		font-size: 0.5em;
		line-height: 1.5;
		margin-left: 20px;
		margin-top: 10px;
	}
	
	.date {
		display: flex;
    	flex-direction: column;
	}
	
	
</style>
</head>
<body>
	<c:set var="list" value="${noticeList }" />
	
	<div class="admin_notice_wrapper">
	
		<jsp:include page="../include/admin_top_include.jsp" />
		<jsp:include page="../include/admin_notice_include.jsp" />
	
	
	
	
		<div class="admin_notice_container">
		<c:if test="${!empty noticeList}">
			
			<%
			List<NoticeDTO> list = (List<NoticeDTO>)request.getAttribute("noticeList");
			
			for(int i = 0; i < list.size(); i++){
				
				NoticeDTO dto = list.get(i);
				
				String imgs = dto.getNotice_image();
				
				StringTokenizer str = new StringTokenizer(imgs, "|");
				
				String[] array = new String[str.countTokens()];
				
				for(int j = 0; j < array.length; j++){
					
					array[j] = str.nextToken();
				}
				
			
			
			%>
			
				<a class="admin_notice_content" data-aos="fade-up" data-aos-anchor=".other-element" href="<%=request.getContextPath()%>/admin_notice_content.do?no=<%=dto.getNotice_no()%>">
					<div class="notice_boxes">
						<div class="notice_img">
							
							<img alt="" src="./resources/upload/notice/<%=array[0]%>">
							<div class="notice_list_date">
								<div class="date">
								<%
								if(dto.getNotice_update() == null){
								%>
									<span>DATE:</span> <sapn><%=dto.getNotice_date().substring(0, 10) %></sapn>
								<%	} else {%>
									<span>END DATE:</span> <span><%=dto.getNotice_enddate().substring(0, 10) %></span>
								<% } %>	
		
								</div>
								
								<%
								if(dto.getNotice_enddate() == null){
								%>
									
								<%	} else {%>
									<div>
										<span>END DATE:</span> <span><%=dto.getNotice_enddate().substring(0, 10) %></span>
									</div>
								<% } %>	
							</div>
						</div>
						
						
						<div class="notice_list_title">
							<div style="text-transform: uppercase ">ADMIN ID: <%=dto.getAdmin_id()%></div>
							<div>TITLE: <%=dto.getNotice_title()%></div>
						</div>
						
						
						
					</div>	<!-- notice_boxes -->
				</a>
					
			<%}%>		
			</c:if>	
			<c:if test="${empty noticeList }">
			<div style="color: red">
			없어요오오오
			</div>
			</c:if>
		</div> <!-- admin_notice_container -->
	</div> <!-- admin_notice_wrapper -->
	


  <div
    data-aos="fade-up"
    data-aos-offset="200"
    data-aos-delay="50"
    data-aos-duration="1000"
    data-aos-easing="ease-in-out"
    data-aos-mirror="true"
    data-aos-once="false"
    data-aos-anchor-placement="top-center"
  >
  </div>
  
  	
<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
  <script>
    AOS.init();
 </script>
	
	
</body>
</html>