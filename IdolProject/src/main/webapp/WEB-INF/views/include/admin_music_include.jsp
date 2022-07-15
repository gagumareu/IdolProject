<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

	/*********** celeb_link_tag  **************/
	.celeb_link_tag {
		color: white;
		font-family: 'Press Start 2P', cursive;
		display: flex;
		flex-direction: row;
		/*border: 1px solid white;*/
		justify-content: end;
    	margin-right: 4.5%;
   	 	align-items: center;
   	 	padding-bottom: 20px;
	}	
	
	.search_text {
		height: 23px;
    	width: 213px;
    	background-color: black;
    	color: white;
    	font-size: 1.5em;
    	font-family: 'Creepster','Kirang Haerang', cursive;
    	
	}
	
	.search_btn {
		padding: 0px 18px;
		color: white;
		background-color: black;
		font-family: 'Press Start 2P', cursive;
		font-size: 1em;
	}
	
	.insert_btn a {
		color: white;
		text-decoration: none;
	}
	.search_btn:hover {
		color: red;
		cursor: pointer;
	}
	
	.insert_btn a:hover {
		color: red;
		cursor: pointer;
	}
	
  	/*********** celeb_link_tag **************/

</style>
</head>
<body>

	<div class="celeb_link_tag">
	
		
		<div class="insert_btn">
		
			<a href="<%=request.getContextPath()%>/admin_album_list.do">
				ALBUM
			</a>
			<a href="<%=request.getContextPath()%>/admin_music_insert.do">
				INSERT
			</a>
		</div>
		<form method="post" action="<%=request.getContextPath()%>/admin_music_search.do">
			<input type="submit" class="search_btn" value="SEARCH">
			<input name="music_search" class="search_text" minlength="1">
		</form>
	</div>

</body>
</html>