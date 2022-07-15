<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js" integrity="sha256-xH4q8N0pEzrZMaRmd7gQVcTZiFei+HfRTBPJ1OGXC0k=" crossorigin="anonymous"></script>

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
	a{
		text-decoration: none;
		color: white;
	}
	.killing_btn{
		padding-right: 20px;
	}
	
	.killing:hover {
		color:red;
	}
</style>
</head>
<body>

	<div class="celeb_link_tag">
	
		<div class="killing_btn">
			<a class="killing" href="<%=request.getContextPath()%>/admin_killing_member.do">
				KILLING-FIELD
			</a>
		</div>
		
		<div class="insert_btn">
			<a href="<%=request.getContextPath()%>/admin_member_contact.do">
				CONTACT
			</a>
		</div>
		<form method="post" action="<%=request.getContextPath()%>/admin_member_search.do">
			<input type="submit" class="search_btn" value="SEARCH" >
			<input name="member_id" class="search_text" minlength="1">
		</form>
	</div>

</body>
</html>