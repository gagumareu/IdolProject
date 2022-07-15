<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN REPLY UPDATE</title>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">

<style type="text/css">

	html, body {
		padding: 0px;
		margin: 0px;
		height: 100%;
		background-color: black;
	}

	.admin_replay_updateForm_wrapper {
		min-height: 100vh;
		display: flex;
		flex-direction: column;
	}
	
	.reply_update_form {
		color: white;
		display: flex;
    	flex-direction: column;
    	width: 400px;
    	font-size: 1.3em;
    	font-family: 'Jua', sans-serif;
    	
	}
	
	.reply_form{
		display: flex;
	    flex-direction: column;
	    align-items: center;
	}
	
	.reply_update_btn{
		
	
	}
	
	.btn {
		color: white;
		background-color: black;
		font-size: 1.9em;
		font-family: 'Creepster', cursive;
		cursor: pointer;
	}
	
	.btn:hover{
		color: red;
	}
</style>
</head>
<body>
<c:set var="dto" value="${replyCont }" />
<c:set var="origin" value="${originNo }" />

<div class="admin_replay_updateForm_wrapper">

	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_member_include.jsp" />
	
	
	<div class="admin_reply_updateForm_container">
		<form class="reply_form" method="post" action="<%=request.getContextPath()%>/admin_reply_update_ok.do">
			<input type="hidden" name="inquiry_no" value="${dto.inquiry_no }">
			<input type="hidden" name="originNo" value="${origin }">
			<input type="hidden" name="product_no" value="${dto.product_no }">
			<input type="hidden" name="order_no" value="${dto.order_no }">
			
			<div class="reply_update_form">
				<span>
					${dto.inquiry_title }
				</span>
				<span>
					작성자: ${dto.inquiry_userid }
				</span>
				<div>
				원글 번호 :  ${origin }
				</div>
				<span>
				<c:if test="${empty dto.inquiry_update }">
					${dto.inquiry_date.substring(0, 10) }
				</c:if>
				<c:if test="${!empty dto.inquiry_update }">
					${dto.inquiry_update.substring(0, 10) }
				</c:if>
				</span>
				<textarea rows="20" cols="30" name="inquiry_cont">${dto.inquiry_cont }</textarea>
			</div>
			
			<div class="reply_update_btn">
				<input class="btn" type="submit" value="GO!!">
				<input class="btn" type="reset" value="RESET">				
			</div> <!-- reply_update_btn -->
		</form> 
	</div> <!-- admin_reply_updateForm_container -->
</div><!-- admin_replay_updateForm_wrapper -->



</body>
</html>