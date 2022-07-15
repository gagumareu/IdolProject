<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
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
		background-color: black;
		
	}

	.admin_celeb_update_wrapper {
		height: 100%;
		display: flex;
		flex-direction: column;
	}
	
	
	
	
	
	
	.admin_celeb_updateForm {
		display: flex;
		flex-direction: column;
		align-items: center;
		color: white;
		font-size: 1.9em;
	}
	
	.celeb_update_form {
		display: flex;
		flex-direction: row;
		font-family: 'VT323', monospace;
		line-height: 1.3em;
	}
	
	.celeb_update_left {
		margin-right: 20px;
	}
	.right_form input{
		height: 20px;
		font-family: 'Creepster','Gamja Flower', cursive;
		font-size: 0.7em;
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
	
	.select option {
	
	}
</style>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&display=swap" rel="stylesheet">	

</head>
<body>
	<c:set var="cont" value="${celebCont }" />
	<c:set var="clist" value="${gList }" />
	
	<div class="admin_celeb_update_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_link_include.jsp" />
	
		<div class="admin_celeb_container">
		
			<div class="admin_celeb_updateForm">
			
				<form method="post" enctype="multipart/form-data"
					action="<%=request.getContextPath() %>/admin_celeb_modify_ok.do?">
				<input type="hidden" value="${cont.celeb_no }" name="celeb_no">
				<input type="hidden" value="${cont.celeb_pimage }" name="originFiles">
				
				<div class="celeb_update_form">
				
					<div class="celeb_update_left">
						<div>NAME</div>
						<div>STAGE NAME</div>
						<div>GROUP</div>
						<div>AGENT</div>
						<div>BORN</div>
						<div>YEARS ACTIVE</div>
						<div>IMAGES</div>
					</div> <!-- celeb_update_left -->
					
					<div class="celeb_update_right">
						<div class="right_form">
							<input id="realNmae" value="${cont.celeb_realname}" name="celeb_realname" readonly>
						</div>
						
						<div class="right_form">
							<input id="name" value="${cont.celeb_name}" name="celeb_name">
						</div>
						<div class="right_form">
							<select name="celeb_group" class="select">
								<c:forEach items="${clist }" var="c">
									<c:if test="${c.group_name == cont.celeb_group }">
										<option value="${c.group_name}" selected>
											${c.group_name}
										</option>
									</c:if>
									<c:if test="${c.group_name != cont.celeb_group }">
										<option value="${c.group_name}">
											${c.group_name}
										</option>
									</c:if>	
								</c:forEach>
							</select>
						</div>
						<div class="right_form">
							<input id="agency" value="${cont.celeb_agency}" name="celeb_agency">
						</div>
						<div class="right_form">
							<input type="date" name="celeb_dateofbirth" value="${cont.celeb_dateofbirth.substring(0, 10)}">
						</div>
						<div class="right_form">
							<input type="date" name="celeb_debutdate" value="${cont.celeb_debutdate.substring(0, 10)}">
						</div>
						<div class="">
							<input type="file" multiple="multiple" name="file1" class="fileUpload">
						</div>
					</div> <!-- celeb_update_right -->
					
				</div> <!-- celeb_update_form -->
					
				<div class="celeb_btn">
					<input type="submit" value="UPDATE" class="inset_btn">
					<input type="reset" value="RESET" class="inset_btn rightBtn">
				</div> <!-- admin_celeb_update-btn end -->
					
					
				</form>	
			</div><!-- admin_celeb_updateForm end -->
		</div>	<!-- admin_celeb_container end -->
	</div> <!-- admin_celeb_update_wrapper end -->

</body>
</html>