<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <c:set var="t" value="${test }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IdolProject Admin Login Form</title>

	<style type="text/css">
	
	
		html, body {
			padding: 0px;
			margin: 0px;
			height: 100%;
			background-color: black;
		}
		
		.admin_main_wrapper {
			/*height: 100%;*/
			display: flex;
			flex-direction: column;
			
		}
		
		.admin_login_form_container {
			flex:1 ;
			display: flex;
   			flex-direction: column;
			align-items: center;
		}
		
		.login_btn {
			display: flex;
   			flex-direction: row;
			justify-content: center;
		}
		
		.subBtn {
			font-family: 'Creepster', cursive;
			background-color: black;
			color: white;
			font-size: 1.8em;
			cursor: pointer;
			
		}
		.subBtn:hover {
			color: red;
		}
		
		.admin_login_form{
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
			z-index: 10;
		
		}
		
		#text {
			font-family: 'Nosifer', cursive;
			font-size: 1.2em;
			width:250px;
		}
		
	</style>
	
	<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&display=swap" rel="stylesheet">
	
</head>
<body>
	
	<div class="admin_main_wrapper">
	
		<jsp:include page="../include/admin_top_include.jsp" />	
			

			<div class="admin_login_form_container">
				
			<div class="admin_login_form">
				<form method="post" action="<%=request.getContextPath() %>/admin_login_ok.do">
					<div>
						<div class="admin_id" ></div>
						<input id="text" name="admin_id"></input>
					</div>
					<div>
						<div class="admin_pwd" ></div>
						<input id="text" type="password" name="admin_pwd"></input>
						
					</div>
			
					<div class="login_btn">
						<input type="submit" value="LOGIN" class="subBtn">
						<input type="reset" value="RESET" class="subBtn">
					</div>
			 	</form>  
			</div> <!-- admin_login_form -->
			
		</div> <!-- admin_login_form_container -->
			
	</div> <!-- admin_main_wrapper -->
	

</body>
</html>