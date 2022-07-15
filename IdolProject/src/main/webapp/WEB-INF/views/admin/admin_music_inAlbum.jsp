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

	html, body{
		mapping: 0px;
		margin: 0px;
		background-color: black;
		
	}
	
	.music_inAlbum_container {
		align-items: center;
    	display: flex;
	   	flex-direction: column;
	    /* justify-content: center;*/
	}


	
	.music_list a {
		text-decoration: none;
		color: white;
		
	}
	
	.music_list a:hover {
		color: gold;
	}


	.music_list {
		color: white;
		font-family: 'Press Start 2P', 'Gugi', cursive;
		line-height: 1.5;
	
	}
	
	
	.album_image{
		width: 300px;
		height: 300px;
	}
	
	.album_image img {
		width: 100%;
		height: 100%;
	}
	
</style>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&display=swap" rel="stylesheet">
   


</head>
<body>

	<c:set var="mlist" value="${mList }" />
	<c:set var="img" value="${timg }" />
	
	<div class="music_inAlbum_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_album_include.jsp" />
		
		<div class="music_inAlbum_container">
			
			<div class="album_image">
				<img alt="" src="./resources/upload/music/${img }">
			</div>
			
			
			<div class="music_list">
				<div>
					<ul>
						<c:forEach items="${mlist }" var="m">
							<li>
								<a href="<%=request.getContextPath()%>/admin_music_content.do?no=${m.music_no }">
									${m.music_name }
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>	<!-- music_list -->

			
		
			
			
		
			
		
		
		</div> <!-- music_inAlbum_wrapper -->
		
	</div> <!-- music_inAlbum_wrapper -->


</body>
</html>