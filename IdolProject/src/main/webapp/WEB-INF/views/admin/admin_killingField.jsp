<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>


<style type="text/css">

	html, body {
	
		margin: 0px;
		padding: 0px;
		height: 100%;
		background-color: black;
	}
	
	.killing_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	
	}
	
	.killing_container {
		display: flex;
    	flex-direction: column;
    	align-items: center;
    	
	}
	
	.field_img {
	
	}
	
	.dead_men {
		color: white;
	}
	
	.person_img {
		width: 100px;
		height: 100px;
		
	}
	
	.parents {
		position: relative;
	}
	
	.person_link:hover{
		opacity:0.6;
	}
	.angelRing {
		width: 200px;
	}
	
	
</style>
</head>
<body>
	
	<c:set var="list" value="${people }" />
	<c:set var="mlist" value="${mList }" />
	
	<div class="killing_wrapper">
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_member_include.jsp" />
	
		<div class="killing_container">
		
			<div class="field_img_box">
				<img class="field_img" alt="" src="./resources/icon/killingfield.gif">
			</div>
			
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="dto">
					<div class="dead_men">
						<a class="person_link" href="<%=request.getContextPath()%>/admin_dead_people.do?no=${dto.member_no}">
							
							<div class="parents">
								<img class="person_img" alt="" src="./resources/icon/itss.jpg">								
							</div>
							
							<div>							
								ID: ${dto.member_id }							
							</div>
							<div>							
								NICKNAME: ${dto.member_nickname }							
							</div>
							<div>							
								NAME: ${dto.member_name }							
							</div>
						</a>
						
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${empty list }">
				<div>
					<div>정지 회원 리스트가 없습니다.</div>
				</div>
			</c:if>
			
			
			<div>
				<select>
					<c:forEach items="${mlist }" var="mdto">
						<option>
							${mdto.member_id }
						</option>
					</c:forEach> 
				</select>
			
			</div>
			
		</div> <!-- killing_container -->
	</div> <!-- killing_wrapper -->


</body>
</html>