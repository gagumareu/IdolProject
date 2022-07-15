<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    
  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN GROUP INSERT</title>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">

<style type="text/css">

		html, body {
			padding: 0px;
			margin: 0px;
			height: 100%;
			background-color:black;
		}
		
		.admin_group_insertForm_wrapper {
			display: flex;
			flex-direction: column;
			min-height: 100vh;
			
		}
		
		.admin_group_insertForm_container {
			display: flex;
		    justify-content: center;
		    align-items: center;
			
		}
		
		
		
		.admin_celeb_insertForm_div {
			
		}
		
	
		.admin_group_insertForm_box {
			color: white;
			font-family: 'Jua', cursive;
			
		}
		
		.group_btn {
			display: flex;
    		flex-direction: row;
    		justify-content: flex-start;
		}
		
		
		.btn {
			font-family: 'Bungee Shade', cursive;
			color: white;
			background-color: black;
			font-size: 1.9em;
			cursor: pointer;
		}
		
		.btn:hover{
			color: red;
		}
		
		
		
</style>
	
</head>
<body>
	
	<div class="admin_group_insertForm_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_group_include.jsp" />
	
	
	<div class="admin_group_insertForm_container">
	
		<div class="admin_celeb_insertForm_div">
			<form class="group_form" enctype="multipart/form-data" method="post"  
				action="<%=request.getContextPath()%>/admin_group_insert_ok.do">
				
				<div class="admin_group_insertForm_box">
					
					<span>INSERT GROUP</span> 
					<div >
						<input name="group_name">
					</div>
					
					<div>
						<textarea rows="17" cols="25" name="group_info"></textarea>
					</div>
					
					<div>
						<input multiple="multiple" type="file" name="file1">
					</div>
				
				
					<div class="group_btn">
						<div>
							<input class="btn" type="submit" value="GO" id="inset_btn">
						</div>
						<div>
							<input class="btn" type="reset" value="RESET">
						</div>
						
					</div>
				</div>
			</form>
		</div> <!-- admin_celeb_insertForm_div -->
		
	</div>	
		
	</div> <!-- admin_group_insertForm_wrapper end -->

</body>
</html>