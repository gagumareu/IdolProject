<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">


<style type="text/css">
	
	html, body {
		padding: 0px;
		margin: 0px;
		height: 100%;
		background-color: black;
	}
	
	.admin_music_wrapper {
		min-height: 100vh;
		display: flex;
		flex-direction: column;
		
	}
	
	.admin_music_container {
		display: flex;
    	justify-content: center;
	}
	
	.admin_music_inputForm {
		display: flex;
    	flex-direction: row;
    	margin-bottom: 100px;
	}
	

	.admin_music_rightSide {
		display: flex;
    	flex-direction: column;
    	color: white;
    	font-family: 'Press Start 2P', cursive;
    	line-height: 1.5;
	}
	
	.music_insert_btn {
		display: flex;
	    flex-direction: row;
	    justify-content: center;
	    margin-top: 18px;

		
	}
	
	.btn {
		font-family: 'Creepster', cursive;
		background-color: black;
	    color: white;
	    font-size: 1.8em;
	}
	
	.btn:hover {
		color: red;
		cursor: pointer;
	}
	
	
</style>
</head>
<body>

	<c:set var="clist" value="${cList }" />
	<c:set var="glist" value="${gList }" />

	<div class="admin_music_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_music_include.jsp" />
	
		<div class="admin_music_container">
			<div class="admin_music_inputForm">
				<form method="post" enctype="multipart/form-data" 
					action="<%=request.getContextPath()%>/admin_music_insertOk.do">
					<div class="admin_music_rightSide">
						ALBUM TITLE <input name="music_aname">
						MUSIC TITLE <input name="music_name">
						SELECT GROUP
						<select name="group_name">	
							<c:forEach items="${glist }" var="gdto">
								<option value="${gdto.group_name }">
									${gdto.group_name }
								</option>
							</c:forEach>	
						</select>
						
						SELECT CElEB
						<select name="celeb_name">	
							<option value="">
							NONE
							</option>
							<c:forEach items="${clist }" var="cdto">
								<option value="${cdto.celeb_name }">
									${cdto.celeb_name }
								</option>
							</c:forEach>	
						</select>
						
						LYRICS <textarea rows="15" cols="25" name="music_lyrics"></textarea>
						COMPOSER <input name="music_composer">
						LYRICST <input name="music_lyricst">
						COVER-IMAGE <input type="file" multiple="multiple" name='file'>
						MOVIE-LINK <!-- <input class="link" name="music_movie_link">-->
						<textarea name="music_movie_link" rows="15" cols="25"></textarea> 
						RELEASE-DATE <input type="date" name="music_release_date">
					</div>
					<div class="music_insert_btn">
						<input class="btn" type="submit" value="GO">
						<input class="btn" type="reset" value="RESET">
					</div>
				</form>
			</div> <!-- admin_music_inputForm -->
		</div> <!-- admin_music_container -->
		
	</div><!-- admin_music_wrapper -->



</body>
</html>