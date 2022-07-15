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
<title>ADMIN MUSIC ALBUM</title>
<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&display=swap" rel="stylesheet">

 <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />

<style type="text/css">
	
	html, body {
		margin: 0px;
		padding: 0px;
		height: 100%;
		background-color: black;
	
	}
	.album_wrapper {
		display: flex;
		flex-direction: column;
		height: 100%;
		
	}
	
	.album_container {
		display: flex;
		flex-direction: row;
		flex-wrap: wrap;
		justify-content: center;
		gap: 10px;
	}
	
	.album_box {
		width: 300px;
		height: auto;
	
	}
	
	.album_img {
		width: 100%;
		height: 100%;
	}
	
	.album_img img {
		width: 100%;
		height: 100%;
	}
</style>
</head>
<body>

	<c:set var="alist" value="${aList }" />
	
	<div class="album_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_album_include.jsp" />
		
		<div class="album_container">
		
		
		<%
		
		List<MusicDTO> mlist = (List<MusicDTO>)request.getAttribute("aList");
		
		for(int i =0; i < mlist.size(); i++){
			
			MusicDTO mdto = mlist.get(i);
			
			String mimgs = mdto.getMusic_coverimage();
			
			StringTokenizer tokenizer = new StringTokenizer(mimgs, "|");
			
			String[] tokenList = new String[tokenizer.countTokens()];
			
			for(int j = 0; j < tokenList.length; j++){
				
				tokenList[j] = tokenizer.nextToken();
				
			}
		%>
			
			<div data-aos="fade-in" class="album_box">
				<a href="<%=request.getContextPath()%>/admin_musicList_intAlbum.do?aname=<%=mdto.getMusic_aname()%>">
					<div class="album_img">
						<img alt="" src="./resources/upload/music/<%=tokenList[0]%>">
					</div> <!-- album_img -->
					<div class="album_name">
					
					
					
					</div> <!-- album_name -->
				</a>
			</div> <!-- album_box -->
			
		<%}	%>
		
		
		
		</div> <!-- album_container -->
			
	</div> <!-- album_wrapper -->

<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
  <script>
    AOS.init();
  </script>

</body>
</html>