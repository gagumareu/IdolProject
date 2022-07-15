<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN MEMBER INQUIRY_REPLY</title>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">

<style type="text/css">

	html, boty {
		padding: 0px;
		margin: 0px;
		height: 100%;
		background-color: black;
	}
	
	.admin_member_inquiryReply_wrapper{
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	}

	.admin_member_inquiryReply_container {
		display: flex;
	    justify-content: center;
	    align-items: center;
	    
	}
	
	.reply_form_box{
		margin-top: 10%;
	}
	

	
	
	
	.reply_btn_box {
		display: flex;
	    flex-direction: row;
	    justify-content: center;
	}
	
	.btn {
		background-color: black;
		color: white;
		font-family: 'Creepster', cursive;
		font-size: 1.8em;
	}
	
	.title {
		width: 252px;
	}
	
	.inquiry_title {
		width: 100%;
		background-color: black;
		
	}
</style>
</head>
<body>
<c:set var="icont" value="${iCont }" />
<c:set var="oldNo" value="${oldNo }" />
	
	<div class="admin_member_inquiryReply_wrapper">
	 <jsp:include page="../include/admin_top_include.jsp"/>
	 <jsp:include page="../include/admin_member_include.jsp"/>
	 	
	 	
	 	<div class="admin_member_inquiryReply_container">
	 	
	 		<form class="reply_form_box" method="post" action="<%=request.getContextPath()%>/admin_inquiry_replayOk.do">
	 			<input type="hidden" name="inquiry_no" value="${icont.inquiry_no }">
	 			<input type="hidden" name="inquiry_group" value="${icont.inquiry_group }">
	 			<input type="hidden" name="inquiry_step" value="${icont.inquiry_step }">
	 			<input type="hidden" name="inquiry_indent" value="${icont.inquiry_indent }">
	 			<input type="hidden" name="inquiry_status" value="1">
	 			<input type="hidden" name="inquiry_userid" value="${admin_id}">
	 			<input type="hidden" name="product_no" value="${icont.product_no }">
	 			<input type="hidden" name="order_no" value="${icont.order_no }">
	 			<input type="hidden" name="inquiry_image" value="${icont.inquiry_image }">
	 			<input type="hidden" name="category_inofk" value="${icont.category_inofk }">
	 			<input type="hidden" name="originNo" value="${oldNo }">
				<div class="title">
					<input name="inquiry_title" value="(RE)${icont.inquiry_title }">
				</div>
		 		<div>
		 			<textarea name="inquiry_cont" rows="20" cols="33"></textarea>
		 		</div>
		 		<div class="reply_btn_box">
					<input class="btn" type="submit" value="GO!!">
					<input class="btn" type="reset" value="RESET">
				</div>
	 		</form>
	 		
	 	</div> <!-- admin_member_inquiryReply_container -->
	 	
	</div> <!-- admin_member_inquiryReply_wrapper -->



</body>
</html>