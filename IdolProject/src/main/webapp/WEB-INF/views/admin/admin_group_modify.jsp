<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN GROUP UPDATE PAGE</title>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">


<style type="text/css">

	html, body {
		padding: 0px;
		margin: 0px;
		height: 100%;
		background-color: black;
	}
	
	.admin_group_modify_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
		
	}
	
	.admin_group_modify_container {
		color: white;
		display: flex;
		flex-direction: column;
		align-items: center;
		font-family: 'Jua', sans-serif;
		line-height: 1.6;
	}
	
	.group_update_btn {
		
	}
	
	.btn{
		background-color: black;
		color: white;
		font-family: 'Creepster', cursive;
		font-size: 1.9em;
	}
</style>
</head>
<body>
	
	<c:set var="dto" value="${groupCont }" />
	
	<div class="admin_group_modify_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_group_include.jsp" />
		
		<div class="admin_group_modify_container">
		
			<form method="post" enctype="multipart/form-data" 
				action="<%=request.getContextPath()%>/admin_group_modify_ok.do">
			
			<input type="hidden" value="${dto.group_no }" name="group_no">
			<input type="hidden" value="${dto.group_image }" name="oldImgs">
			
				<div class="admin_group_modify_form">
					
					<div>
						GROUP
					</div>
					<div>
						<input value="${dto.group_name }" name="group_name" readonly>
					</div>
					<div>
						<textarea rows="17" cols="25" name="group_info">${dto.group_info }</textarea>			
					</div>
					<div>
						<input multiple="multiple" type="file" name="file1">
					</div>
				</div>		
				<div class="group_update_btn">
					<input class="btn" type="submit" value="GO!!"> 
					<input class="btn" type="reset" value="RESET"> 
				</div>
			</form>
			
		</div> <!-- admin_group_modify_wrapper -->
	
	</div> <!-- admin_group_modify_wrapper -->
	

</body>
</html>