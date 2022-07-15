<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
  	
  	<c:set var="cont" value="${musicCont }" />
	<c:set var="imgs" value="${arrtokened }" />
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	
	html, body {
		margin: 0px;
		padding: 0px;
		height: 100%;
		background-color: black;
		
	}
	ul {
		list-style-type: none;
	}
	.admin_music_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	
	}
	
	.wrapper {
		display: flex;
		justify-content: center;
	}
	
	.admin_music_container {
		display: flex;
   		flex-direction: row;
		font-family: 'Gugi', 'Jua', sans-serif;
		width: 70%;
	}
	
	.admin_music_box_left {
		flex: 70%;
		color: white;
	}
	
	.music_img {
		width: 450px;
		height: 500px;
		border: 1px solid white;
	}
	
	.music_img img {
		width: 100%;
	}
	
	.admin_music_box_right {
		flex: 30%;
		color: white;
		overflow: autu;
		display: flex;
		flex-direction: row;
	}

	.music_movie {
		position: sticky;
		top: 100px;
		background-color: black;
		padding-bottom: 20px;
	}
	
	.music_lyrics textarea{
		background-color: black;
	    color: white;
	    width: 500px;
	    height: 1900px;
	    font-size: large;
	    font-family: 'Gugi', 'Jua', sans-serif;
	    overflow:hidden;
	    border: gold;
	    padding-left: 100px;
	  }
	  
	  .album_cont {
		line-height: 1.6em;	  
		width: 560px;
		display: flex;
  		flex-direction: column;
   		align-items: center;
   		margin-top: 100px;
	  }
	  
	  .music_composer {
	  
	  }
	  
	  .music_lyricst{
	  
	  }
		
	.music_title{
		font-size: 1.3em;
	}
	
	.name {
		margin-bottom: 13px;
	}
	
	.music_cont_btn {
		display: flex;
		flex-direcion: row;
		background-color: black;
		display: flex;
    	justify-content: center;
		width: 560px;
   
	}
	
	.music_cont_btn input {
		color: white;
  	  	background-color: black;
		font-family: 'Creepster', cursive;
		font-size: 1.5em;
		cursor: pointer;
	}
	
	.btn:hover {
		color: red;
	}
	
	.celeb_name {
		width: 200px;
		position: sticky;
		top: 100px;
	}
	
	.admin_music_box_left {
	}
	
	.admin_music_box_right {
	}
	
	.box-wrapper {
	
	}
</style>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&display=swap" rel="stylesheet">

</head>
<body>

	
	
	<div class="admin_music_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_music_include.jsp" />
	
	<div class="wrapper">
		<div class="admin_music_container">
			<div class=admin_music_box_left>
				
				<div class="music_movie">
				
					 ${cont.music_movie_link }
					 
					 <div class="music_cont_btn">
						<input class="btn" type="button" value="MODIFY"
						onclick="location.href='<%=request.getContextPath()%>/music_content.do?no=${cont.music_no }&img=${cont.music_coverimage }'">
						
						<input class="btn" type="button" value="DELETE"
						onclick="if(confirm('삭제 하시겠습니까 ?? :(')){
							location.href='<%=request.getContextPath()%>/music_delete.do?no=${cont.music_no }&img=${cont.music_coverimage }'
						}else {return}">
						
						<input class="btn" type="button" value="BACK"
						onclick="location.href='admin_main.do'">
					</div> <!-- music_cont_btn -->
				
					
				</div>	
				
				
				
				<div class="album_cont">
					<div class="music_title">
						ALBUM: ${cont.music_aname }
					</div>
					<div class="music_title name">
						 ${cont.music_name }
					</div>
					<div class="music_composer">
						작곡: ${cont.music_composer }
					</div>
					<div class="music_lyricst">
						작사: ${cont.music_lyricst }
					</div>
					<div class="music_release_date">
						발매일: ${cont.music_release_date.substring(0, 10) }
					</div>
					
					
				</div>
					
				
			</div> <!-- admin_music_box_left -->
			
			
			<div class="admin_music_box_right">
			<!--  
				<c:forEach items="${arrtokened }" var="imgs">
					<div class="music_img">
						<img alt="" src="./resources/upload/music/${imgs }">
					</div>
				</c:forEach>
				
				
				<div class="celeb_name">
					<c:if test="${cont.group_name != null }">
						 ${cont.group_name }
					</c:if>
					<c:if test="${cont.celeb_name == null }">
						
					</c:if>
					<c:if test="${cont.celeb_name != null }">
						가수명 : ${cont.celeb_name }
					</c:if>
				</div>-->	
				<div class="music_lyrics">
					 <textarea rows="13" cols="33" id="lyrics" name="music_lyrics" readonly>${cont.music_lyrics }</textarea> 
					
				</div>
				

			</div> <!-- admin_music_box_right -->
				
			
		</div> <!-- the end of admin_music_container -->
	</div>
	</div> <!-- the end of admin_music_wrapper -->
</body>
</html>