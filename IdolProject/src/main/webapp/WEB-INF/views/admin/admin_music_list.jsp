<%@page import="java.util.StringTokenizer"%>
<%@page import="com.idol.model.MusicDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	
	.admin_music_wrapper {
		display: flex;
		flex-direction: column;
		height: 100vh;
		
	
	}
	.admin_music_container {
		display: flex;
	    flex-direction: row;
	    flex-wrap: wrap;
	    gap: 40px 20px;
	    justify-content: center;
	    
	}
	
	.music_boxes{
		border: 1px solid pink;
		width: 200px;
		height: 300px;
		color: white;
		display: flex;
		flex-direction: column;
	}
	
	.music_imgs_inbox {
		flex: 70%;
		width: 100%;
		overflow: hidden;
	}
	
	.music_link:hover{
		opacity: 0.7;
	}
	
	
	.music_imgs_inbox img {
		width: 100%;
	}
	.music_content_inbox {
		flex: 30%;
		font-family: 'Gugi', 'Jua', sans-serif;
		font-size: 1.2em;
		
	}
	
	.music_name {
		padding-left: 20px;
		padding-bottom: 7px;		
	}
	
	.group_name {
		padding-left: 20px;
		
	}
	
	.noData {
		color: red;
		font-family: 'Nosifer', cursive;
		
	}
</style>

<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&display=swap" rel="stylesheet">

</head>
<body>
	<c:set var="list" value="${musicList }" />
	
	<div class="admin_music_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_music_include.jsp" />
	
		<div class="admin_music_container">
			<c:if test="${!empty list }">
			
			<%
			List<MusicDTO> mList = (List<MusicDTO>)request.getAttribute("musicList");
			
			for(int i = 0; i <mList.size(); i++){
				
				MusicDTO dto = mList.get(i);
				
				String imgs = dto.getMusic_coverimage();
				
				StringTokenizer tokenizer = new StringTokenizer(imgs, "|");
				
				String[] musicImg = new String[tokenizer.countTokens()];
				
				for(int j = 0; j < musicImg.length; j++){
					
					musicImg[j] = tokenizer.nextToken();
				}
				
			
			
			
			%>
					<a class="music_link" href="<%=request.getContextPath()%>/admin_music_content.do?no=<%=dto.getMusic_no()%>">
						
						<div data-aos="fade-in" class="music_boxes">
							<div class="music_imgs_inbox">
								<img alt="" src="./resources/upload/music/<%=musicImg[0] %>">
							</div>
							
							<div class="music_content_inbox">
								<div class="music_name"><%=dto.getMusic_name() %></div>
							<% if(dto.getGroup_name().equals("solo")){
								%>

							<%}else {%>
								<div class="group_name"> <%=dto.getGroup_name() %></div>
								
							<%} %>	
							<% if(dto.getGroup_name().equals("solo")){
								%>
								<div class="group_name"><%=dto.getCeleb_name() %></div>
								
							<%}%>
							
							
							</div> <!--music_boxes  -->
								
							
						</div> <!-- admin_music_content -->
					</a>
				
			<% 	}%>
			</c:if>	
			<c:if test="${empty list }">
				<div class="noData"><h1>NO DATA AVAILABLE... </h1></div>
			</c:if>	
		</div> <!-- admin_music_container -->
	</div> <!-- admin_music_wrapper -->
	
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