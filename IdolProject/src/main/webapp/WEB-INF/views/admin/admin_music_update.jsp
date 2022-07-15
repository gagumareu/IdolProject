<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN MUSIC UPDATE</title>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">

<style type="text/css">
	
	html, body {
		margin: 0px;
		padding: 0px;
		height: 100%;
		background-color: black;
	}
	
	.admin_music_modify_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	}
	
	.admin_music_modify_container{
		width: 100%;
		height: 100%;
		display: flex;
		flex-direction: row;
	}
	
	.music_img_container {
		max-width: 50%;
		flex: 50%;
		display: flex;
	    align-items: center;
	    justify-content: center;
		
	}
	
	.music_imgBoxes {
		width: 60%;
   	 	height: 60%;
   	 	margin-left: 20%;

	}
	
	.music_imgBoxes img{
		width: 100%;
		height: 100%;
	}
	
	.music_modify_form {
		flex: 50%;
		max-width: 50%;
		flex-direction: column;
    	display: flex;
    	align-items: center;
	}
	
	
	
	#link {
		height: 200px;
		width: 300px;
	}
	
	
	.music_update_form {
		font-family: 'Jua', sans-serif;
		color: white;
		margin-right: 20%;
	}
	
	·update_btn {
	
	}
	
	.btn {
		background-color: black;
		color: white;
		font-family: 'Creepster', cursive;
		font-size: 1.9em;
		cursor: pointer;
	}
	.btn:hover{
		color: red;
	}
</style>
</head>
<body>
	<c:set var="mCont" value="${musicCont }" />
	<c:set var="imgs" value="${arrimgs }" />
	<c:set var="clist" value="${cList }" />
	<c:set var="glist" value="${gList }" />
	
	<div class="admin_music_modify_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_music_include.jsp" />
	
		<div class="admin_music_modify_container">
		
			<div class="music_img_container">
				<c:forEach items="${arrimgs }" var="imgs">
					<div class="music_imgBoxes">
						<img alt="" src="./resources/upload/music/${imgs }">
					</div>
				</c:forEach>
			</div> <!-- music_img_container -->
		
			<div class="music_modify_form">
			
				<form class="music_update_form" enctype="multipart/form-data" method="post" 
					action="<%=request.getContextPath() %>/admin_music_update_ok.do">
					
					<input type="hidden" value="${mCont.music_coverimage }" name="oldimgs">
					
					<input type="hidden" value="${mCont.music_no }" name="music_no">
					
					<div class="music_update_form_selecter">
						<div>그룹 선택 </div>
						<select name="group_name">	
							<c:forEach items="${glist }" var="gdto">
								<c:if test="${gdto.group_name == mCont.group_name }">
									<option value="${gdto.group_name }" selected>
										${gdto.group_name }
									</option>	
								</c:if>
								<c:if test="${gdto.group_name != mCont.group_name }">
									<option value="${gdto.group_name}">
										${gdto.group_name }
									</option>
								</c:if>
									
							</c:forEach>	
						</select>
						
						<div>셀럽 선택</div>
						<select name="celeb_name">	
							<option value="">
							선택 안함
							</option>
							<c:forEach items="${clist }" var="cdto">
								<c:if test="${cdto.celeb_name == mCont.celeb_name }">
									<option value="${cdto.celeb_name }" selected>
										${cdto.celeb_name }
									</option>
								</c:if>
								<c:if test="${cdto.celeb_name != mCont.celeb_name }">
									<option value="${cdto.celeb_name }">
										${cdto.celeb_name }
									</option>
								</c:if>
							</c:forEach>	
						</select>
					</div>
					<div>
						<div>앨범 이름 </div>
						<input id="aname" name="music_aname" value="${mCont.music_aname }" >
					</div>
					<div>
						<div>곡명</div>
						<input id="name" name="music_name" value="${mCont.music_name }">
					</div>
					<div>
						<textarea rows="20" cols="50" id="lyrics" name="music_lyrics">${mCont.music_lyrics }</textarea>
					</div>
					<div>
						<div>작곡가</div>
						<input id="composer" name="music_composer" value="${mCont.music_composer }">
					</div>
					<div>
						<div>작사가</div>
						<input id="lyricst" name="music_lyricst" value="${mCont.music_lyricst }">
					</div>
					
					<div>
						<div>뮤비 링크</div>
						<textarea name="music_movie_link" rows="15" cols="25">${mCont.music_movie_link }</textarea> 
					</div>
					<div>
						<div>발매일</div>
						<input id="release" type="date" name="music_release_date" value="${mCont.music_release_date.substring(0, 10) }">
					</div>
					
					<div>
						<input type="file" name="file1" multiple="multiple">
					</div>
					<div class="update_btn">
						<input class="btn" type="submit" value="GO!!!">
						<input class="btn" type="reset" value="RESET">
					</div>
				</form>
				
			</div> <!--music_modify_form -->
			
			
			
			
			
			
			
		</div> <!-- admin_music_modify_container -->
	</div> <!-- admin_music_modify_wrapper -->

</body>
</html>





