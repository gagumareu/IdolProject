<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN IMAGES CONTENT</title>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">


<style type="text/css">
	
	html, body {
		margin: 0px;
		padding: 0px;
		height: 100%;
		background-color: black;
	}
	
	.admin_content_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	}
	
	ul {
		list-style-type: none;
	}
	
	

	
	.admin_content_container {
		display: flex;
	    flex-direction: column;
	    align-items: center;
		
	}
	
	.admin_content_box {
		color: white;
	
	}
	.admin_images_cont_img {
		width: 500px;
		height: 400px;
		display: flex;
    	justify-content: center;
	}
	
	
	.admin_images_cont_img img{
		width: 100%;	
	
	}
	
	.admin_content_box {
		display: flex;
	    flex-direction: column;
	    align-items: center;
	    margin-top: 30px;
	}
	
	.admin_content_text {
		display: flex;
	    flex-direction: column;
	    align-items: center;
	    font-family: 'Press Start 2P', cursive;
	    font-size: 0.8em;
	    line-height: 1.4;
	    argin-bottom: 18px;
	}
	
	.admin_images_content_btn {
		
	}
	
	.btn {
		color: white;
		background-color: black;
		font-family: 'Nosifer', cursive;
		font-size: 1.3em;
		cursor: pointer;
	}
	
	.btn:hover {
		color: red;
	}
	
</style>

<script type="text/javascript">



</script>

</head>
<body>

	<c:set var="cont" value="${imageCont }" />
	<c:set var="imgs" value="${arrayImgs }" />
	
	<div class="admin_content_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_images_include.jsp" />
	
		<div class="admin_content_container">
		
			<div class="admin_images_cont_img">
				<img alt="" src="./resources/upload/images/${cont.image_path }">
			</div>
		
			<div class="admin_content_box">
			
				<div class="admin_content_text">
					<div>
						NO. ${cont.image_no }
					</div>
					<div>
						IMAGE PATH: ${cont.image_path }
					</div>
					<div>
						IMAGE LINK: ${cont.image_link }
					</div>
					<div>
						IMAGE PRIORITY: <span style="color:gold">${cont.image_priority }</span>
					</div>
					<c:if test="${cont.image_visible == 1 }">
						<div>
							VISIBLE :<span style="color: gold"> ON</span>
						</div>
					</c:if>
					<c:if test="${cont.image_visible == 0 }">
						<div>
							VISIBLE :<span style="color: red"> OFF</span>
						</div>
					</c:if>
				</div> <!-- admin_content_text -->
				
				<div class="admin_images_content_btn">
					<input class="btn" type="button" value="MODIFY"
						onclick="location.href='admin_images_modify.do?no=${cont.image_no}'">
					<input class="btn" type="button" value="DELETE"
						onclick="if(confirm('삭제 하시겠습니까 ?? :(')){
						location.href='<%=request.getContextPath()%>/admin_images_delete.do?no=${cont.image_no }&imgs=${cont.image_path }'
						}else {return}">
					<input class="btn" type="button" value="BACK"
						onclick = "location.href='admin_images_list.do'">
				</div> <!-- admin_images_content_btn -->
				
			</div><!-- admin_content_box -->
			
		</div> <!-- the end of admin_content_container -->
		
	</div> <!-- the end of admin_content_wrapper -->
	
	
</body>
</html>