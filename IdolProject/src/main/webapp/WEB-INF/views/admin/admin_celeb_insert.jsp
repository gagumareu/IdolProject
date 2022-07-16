<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
    
  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style type="text/css">
	
		html, body {
			padding: 0px;
			margin: 0px;
			height: 100%;
			padding: 0px;
			margin: 0px;
			height: 100%;
			/*font-family: 'Kanit', sans-serif;*/
			background-color: black;
		}
		
		li {
		list-style-type: none;
		color: black;
		}
		
		a {
			text-decoration: none;
		}
		.admin_celeb_insertForm_wrapper {
			display: flex;
			flex-direction: column;
			height: 100%;
			
		}
		
		.admin_celeb_insertForm_container {
			display: flex;
			justify-content: center;
		
		}
		
		.admin_celeb_insertForm {
			color: white;
			font-family: 'VT323', monospace;
			font-size: 1.9em;
			line-height: 1.3em;
			margin-top: 10%;
		}
		
		.celeb_insert_content {
			display: flex;
			flex-direction: row;
		}
		
		.insert_form_left {
			margin-right: 20px;
		}
		
		.right_content input{
			height: 20px;
			font-family: 'Creepster','Gamja Flower', cursive;
			font-size: 0.8em;
			
		}
		
		.celeb_btn {
			display: flex;
			flex-direction: row;
			justify-content: center;
		}
		
		.celeb_btn input {
			color: white;
			background-color: black;
		}
		
		.inset_btn {
			font-family: 'Nosifer', cursive;
			font-size: 0.7em;
			cursor: pointer;	
		}
		
		.inset_btn:hover {
			color: red;
		}
		
		.rightBtn {
			margin-right: 80px;
		}
		
		.select {
			height: 27px;
		}
		
	</style>
	
	
<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&display=swap" rel="stylesheet">	
	
</head>
<body>
	<!-- 그룹 이름 리스트 -->
	<c:set var="gList" value="${groupList }" />
	
	<div class="admin_celeb_insertForm_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_link_include.jsp" />
	
		<div class="admin_celeb_insertForm_container">
		
			<div class="admin_celeb_insertForm">
				<form class="celeb_form" enctype="multipart/form-data" method="post"  
					action="<%=request.getContextPath()%>/admin_celeb_insert_ok.do">
				
				<div class="celeb_insert_content">
					<div class="insert_form_left">
						<div>
							SELECT GROUP
						</div>
						<div>
							STAGE NAME
						</div>
						<div>
							 NAME
						</div>
						<div>
							AGENT
						</div>
						<div>
							BORN
						</div>
						<div>
							YEARS ACTIVE
						</div>
						<div>
							IMAGES
						</div>
					</div> <!--  -->
				
					<div class="insert_form_right">
						<div class="right_content">
							<select name=celeb_group class="select">
								<c:forEach items="${groupList }" var="g">
									<option value="${g.group_name }">
										${g.group_name }
									</option>
									
								</c:forEach>
							</select>
						</div> <!-- celeb_insertForm_right -->
						<div class="right_content">
							<input name="celeb_name">
						</div>										
						<div class="right_content">
							 <input name="celeb_realname">
						</div>									
						<div class="right_content">
							<input name="celeb_agency">
						</div>							
						<div class="right_content"> 
							<input type="date" name="celeb_dateofbirth">
						</div>
						<div class="right_content">
							<input type="date" name="celeb_debutdate">
						</div>
						<div>
							<input multiple="multiple" type="file" name="file1">
						</div>
					
					
					</div><!-- insert_right -->
				</div><!-- celeb_insert_content -->
				
				
					<div class="celeb_btn">
						<div>
							<input type="submit" value="INSERT" class="inset_btn">
						</div>
						<div>
							<input type="reset" value="RESET" class="inset_btn rightBtn">
						</div>
					</div> <!-- celeb_btn -->
					
				</form>
			</div><!-- admin_celeb_insertForm_container -->
		</div> <!-- admin_celeb_insertForm_container -->
	</div> <!-- admin_celeb_insertForm_wrapper -->
 
</body>
</html>