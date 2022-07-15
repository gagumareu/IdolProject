<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN IMAGES MODIFY</title>

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
	
	
	
	
	.admin_content_container {
		display: flex;
   		flex-direction: column;
		align-items: center;
	}
	
	
	.images_modify_text {
		color: white;
		font-family: 'Press Start 2P', cursive;
		line-height: 1.3;
	}
	
	.modify_btn {
		background-color: black;
		color: white;
		font-family: 'Creepster', cursive;
		font-size: 1.9em;
		cursor: pointer;
	}
	
	.modify_btn:hover {
		color: red;
	}
	
	.images_modify_btn {
		margin-left: 30px;
	}
</style>
</head>
<body>

	<c:set var="cont" value="${imagesModify }" />
	
	<div class="admin_content_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_images_include.jsp" />
	
		<div class="admin_content_container">
			
			
			<form method="post" enctype="multipart/form-data" 
				action="<%=request.getContextPath() %>/admin_images_modify_ok.do">
			
			<input type="hidden" name="image_no" value="${cont.image_no }">
			<input type="hidden" name="oldPath" value="${cont.image_path }">
			
				<div class="images_modify_text">
					
					<div>
						IMAGES PRIORITY : <input type="number" name="image_priority" value="${cont.image_priority }">
					</div>
					
					
					<div>
						IMAGES PATH: <input name="file" type="file" multiple="multiple">
					</div>
					<div>
						IMAGES LINK: <input name="image_link" value="${cont.image_link }">
					</div>
					<div>
					IMAGES VISIBLE
						<select name="image_visible">
							<option>
								ON/OFF 선택
							</option>
							<c:if test="${cont.image_visible == 1 }">
								<option value="1" selected>
									ON (VAL=1)
								</option>
								<option value="0">
									OFF (VAL=0)
								</option>
							</c:if>
							<c:if test="${cont.image_visible == 0 }">
								<option value="1">
									ON (VAL=1)
								</option>
								<option value="0" selected>
									OFF (VAL=0)
								</option>	
							</c:if>
						</select>
					</div>
				</div>
				
				<div class="images_modify_btn">
					<input class="modify_btn" type="submit" value="GO!!!">
					<input class="modify_btn" type="reset" value="RESET">
					<input class="modify_btn" type="button" value="BACK"
						onclick = "location.href='admin_images_content.do?no=${cont.image_no}'">
				</div>	
			</form>
			
		</div> <!-- the end of admin_content_container -->
	</div> <!-- the end of admin_content_wrapper -->
</body>
</html>