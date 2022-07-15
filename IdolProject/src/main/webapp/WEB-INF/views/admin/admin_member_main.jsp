<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN MEMBER MAIN</title>
<style type="text/css">
	
	html, body {
		padding: 0px;
		margin: 0px;
		height: 100%;
		background-color: black;
		font-family: 'Press Start 2P', 'Jua', monospace;
	}
	
	.admin_member_main_wrapper{
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	
	}
	
	.admin_member_main_container{
		display: flex;
	    flex-direction: row;
	    flex-wrap: wrap;
		gap: 10px;
		justify-content: center;
		width: 80%;
    	align-self: center;
	}
	
	.member_info_box {
		width: 200px;
    	/*height: 300px;*/
    	display: flex;
    	flex-direction: column;
		align-items: center;
		text-transform: uppercase;
	}
	.member_atag {
		text-decoration: none;
		color: white;
	}
	
	.member_img {
		width: 200px;
		height: 200px;
		
	
	}
	.member_img img {
		width: 100%;
		height: 100%;
	}

	.member_info_box:hover {
		opacity: 0.4;
	
	}
	
	.idNname {
		margin: 4px;
	}

</style>
</head>
<body>
<c:set var="mlist" value="${mList }" />

	<div class="admin_member_main_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_member_include.jsp" />
	
		<div class="admin_member_main_container">
			<c:forEach items="${mlist }" var="dto">
			<div class="member_info_box">
				<a class="member_atag" href="<%=request.getContextPath()%>/admin_member_cont.do?no=${dto.member_no}&id=${dto.member_id}">
					<div class="member_img">
				 		<img alt="" src="./resources/upload/member_image/${dto.member_no }/${dto.member_image}">
					</div>
					<div class="member_info_box">
						<div class="idNname" style="color: gold">
							${dto.member_id }
						</div>
						<div class="idNname" style="color: #eeeeee">
							${dto.member_nickname }
						</div>
						
						
					</div>			
				</a>
			</div><!-- member_container -->
			</c:forEach>
		</div> <!-- admin_member_main_container -->
	
	</div> <!-- admin_member_main_wrapper -->


</body>
</html>