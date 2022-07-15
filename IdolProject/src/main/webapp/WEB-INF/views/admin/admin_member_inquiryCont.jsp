<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN INQUIRY CONTENT</title>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">


<style type="text/css">
	
	html, body {
		padding: 0px;
		margin: 0px;
		height: 100%;
		background-color: black;
	}
	a{
		color:white;
		text-decoration: none;
	}
	.admin_member_inquiry_cont_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	}
	
	.admin_member_inquiry_container {
		display: flex;
		align-items: center;
	}
	.right_side {
		flex: 50%;
		max-width: 50%;
	}
	.left_side {
		flex: 50%;
		max-width: 50%;
	}
	
	
	
	.inquiry_images_box{
		font-family: 'Jua', sans-serif;
    	color: white;
    	display: flex;
	    flex-direction: column;
	    justify-content: center;
	    align-items: center;
	    position: sticky;
	    top: 50px;
	}
	
	.inquiry_img {
		display: flex;
    	flex-direction: column;
    	width: 400px;
    	height: 400px;
    	
	}
	.inquiry_img img {
		width: 100%;
		height: 100%;
	}
	
	.member_order_imgageBox {
		display: flex;
    	flex-direction: column;
    	width: 400px;
    	height: 400px;
	}
	.member_order_imgageBox img {
		width: 100%;
		height: 100%;
	}
	
	
	.member_inquiry_box{
		font-family: 'Jua', sans-serif;
		color: white;
		display: flex;
	    flex-direction: column;
	    justify-content: center;
	    font-size: 1.5em;
	    margin-bottom: 50px;
	}
	
	.btn{
		background-color: black;
		color: white;
		font-family: 'Bungee Shade', cursive;
		font-size: 1.5em;
		cursor: pointer;
	}
	
	.btn:hover{
		color: gold;
	}
	
	.member_inquiry_reply_box {
		color: white;
		font-family: 'Jua', sans-serif;
		margin-bottom: 80px;
	}
	
	.inquiry_reply_boxes {
		margin: 20px 0px;
	}
	.reply_btn_box{
	
	}
	.rbtn{
		color: white;
		background-color: black;
		font-family: 'Bungee Shade', cursive;
		font-size: 1.3em;
		cursor: pointer
	}
	
	.rbtn:hover{
		color: gold;
	}
	
	.reply_titel{
		font-family: 'Jua', sans-serif;
		font-size: 1.6em;
		margin-top: 50px;
	}
</style>

</head>
<body>
<!-- 게시물 상세 정보 불러오기 -->
<c:set var="idto" value="${iCont }" />
<!-- 게시물 상세 정보 (이미지 불러오기) -->
<c:set var="imgslit" value="${imgsList }" />
<!-- 상품 번호 정보 불러오기-->
<c:set var="pcont" value="${pdto }" />
<!-- 주문번호 정보 불러오기 -->
<c:set var="ocont" value="${odto }" />
<!-- 상품 이미지 리스트 불러오기 -->
<c:set var="plist" value="${pimgsList }" />
<!-- 주문 이미지 리스트 불러오기 -->
<c:set var="olist" value="${oimgsList }" />
<!-- 같은 그룹 답변글 불러오기 [reply_list] -->	
<c:set var="glist" value="${gList }" />


	<div class="admin_member_inquiry_cont_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_member_include.jsp" />
	
		<div class="admin_member_inquiry_container">
		
		<div class="left_side">
		
			<div class="inquiry_images_box">
				<c:if test="${!empty imgsList }">
					<div class="inquiry_img">
						<c:forEach items="${imgsList }" var="imgs">
							<img alt="" src="./resources/upload/inquiry_board/${imgs }">
						</c:forEach>
						<span style="font-size: 1.3em">[문의 게시판 이미지]</span>
					</div> <!-- inquiry_img -->
				</c:if>
				<c:if test="${empty imgsList }">
					<div style="font-size: 1.3em">[첨부 파일이 없습니다].</div>
				</c:if>
<!-- 				주문 번호를 통한 이미지 불러오기 -->
<%-- 				<c:if test="${!empty ocont.order_no }"> --%>
<%-- 					<c:if test="${ocont.order_no == idto.order_no }"> --%>
<!-- 						<div class="member_order_imgageBox"> -->
<%-- 							<a href="<%=request.getContextPath()%>/admin_order_productCont.do?no=${idto.order_no}"> --%>
<%-- 								<img alt="" src="./resources/upload/product/${olist[0] }"> --%>
<!-- 							</a> -->
<!-- 							<span style="font-size: 1.3em">[주문 상품 이미지]</span> -->
<!-- 						</div> member_inquiry_order -->
<%-- 					</c:if><!-- member_order_productInfo --> --%>
<%-- 				</c:if> --%>
<%-- 				<c:if test="${empty ocont.order_no }"> --%>
<!-- 					<div style="font-size: 1.3em">[주문 상품 첨부 파일이 없습니다].</div> -->
<%-- 				</c:if> --%>
				
				
				<!-- 상품 넘버를 통한 상품 이미지 -->
				<c:if test="${!empty pcont.product_no }">
<!-- 					<div class="member_order_imgageBox"> -->
						<c:if test="${pcont.product_no == idto.product_no }">
							<div class="member_order_imgageBox">
								<a href="<%=request.getContextPath() %>/admin_product_content.do?no=${idto.product_no}">
									<img alt="" src="./resources/upload/product/${plist[0] }">
									<span style="font-size: 1.3em">[상품 이미지]</span>
								</a>
							</div>
						</c:if>
<!-- 					</div> -->
				</c:if>		
				<c:if test="${empty pcont.product_no }">
				<div style="font-size: 1.3em">[ 상품 첨부 파일이 없습니다].</div>
				</c:if>
			</div> inquiry_images_box
		</div> <!-- left_side -->
		
		<div class="right_side">
			<div class="member_inquiry_box">
			
				
				
				
				
			
				<div>
					NO. ${idto.inquiry_no }
				</div>
				<div>
					ID: ${idto.inquiry_userid }
				</div>
				<div>
					TITLE: ${idto.inquiry_title }
				</div>
				<div style="color: #ffd600">
					${idto.inquiry_cont }
				</div>
				<div>
					VIEWS: ${idto.inquiry_hit }
				</div>
<!-- 				<div> -->
<%-- 					<c:if test="${idto.inquiry_update == null}"> --%>
<%-- 						DATE: ${idto.inquiry_date.substring(0, 10) } --%>
<%-- 					</c:if> --%>
<%-- 					<c:if test="${idto.inquiry_update != null}"> --%>
<%-- 						UPDATE: ${idto.inquiry_update.substring(0, 10) } --%>
<%-- 					</c:if> --%>
<!-- 				</div> -->
				<div>
					PRODUCT No. ${idto.product_no }
				</div>
				<div>
					ORDER No. ${idto.order_no }
				</div>
				
					<c:if test="${idto.inquiry_status == '0' }">
						<div style="color: red">
							답변대기
						</div>
					</c:if>
					<c:if test="${idto.inquiry_status == '1' }">
						<div style="color: gold">
							답변완료 
						</div>
					</c:if>
				
				<div>
					GROUP No. ${idto.inquiry_group }
				</div>
<!-- 				<div> -->
<%-- 					STEP No. ${idto.inquiry_step } --%>
<!-- 				</div> -->
<!-- 				<div> -->
<%-- 					INDENT. ${idto.inquiry_indent } --%>
<!-- 				</div> -->
				<div>
					<c:if test="${!empty idto.inquiry_update }">
						UPDATE: ${idto.inquiry_update.substring(0, 10) }
					</c:if>
					<c:if test="${empty idto.inquiry_update }">
						DATE: ${idto.inquiry_date.substring(0, 10) }
					</c:if>
				</div>
				<div class="reply_btn">
					<input class="btn" type="button" value="REPLY"
					onclick="location.href='admin_inquiry_reply.do?no=${idto.inquiry_no}'">
				</div>
			</div> <!-- member_inquiry_box -->
				
				
			<div class="member_inquiry_reply_box">
				<c:forEach items="${glist }" var="gdto">
					<c:if test="${idto.inquiry_no != gdto.inquiry_no }">
					<div class="inquiry_reply_boxes">
					<div class="reply_titel" style="color:gold">[답변글]</div>
						<div>
							No. : ${gdto.inquiry_no }
						</div>
						<div>
							GROUP : ${gdto.inquiry_group }
						</div>
						<div>
							STEP : ${gdto.inquiry_step }
						</div>
						<div>
							ID : ${gdto.inquiry_userid }
						</div>
						<div>
							TITLE: ${gdto.inquiry_title }
						</div>
						<div>
							COTENT: ${gdto.inquiry_cont }
						</div>
							<c:if test="${gdto.inquiry_status == '0' }">
								<span style="color: red">답변대기 </span>
							</c:if>
							<c:if test="${gdto.inquiry_status == 1 }">
								답변완료 
							</c:if>
						<div>
							<c:if test="${!empty gdto.inquiry_update }">
								${gdto.inquiry_update.substring(0, 10) }
							</c:if>
							<c:if test="${empty gdto.inquiry_update }">
								${gdto.inquiry_date.substring(0, 10) }
							</c:if>
						</div>
						<div class="reply_btn_box">
						<input class="rbtn" type="button" value="REPLY"
							onclick="location.href='admin_inquiry_reply.do?no=${gdto.inquiry_no}&originNo=${idto.inquiry_no }'">
						
						<input class="rbtn" type="button" value="DOMIFY"
							onclick="location.href='admin_inquiry_modify.do?no=${gdto.inquiry_no}&originNo=${idto.inquiry_no }'">
						
						<input class="rbtn" type="button" value="DELETE"
							onclick="if(confirm('정말 레알 삭제 하시렵니까 ? :(')){
							location.href='admin_reply_delete.do?no=${gdto.inquiry_no}'
						}else {return; }">
						</div>
					</div> <!-- inquiry_reply_boxes -->
					</c:if>
				</c:forEach>
			</div> <!-- member_inquiry_reply_box -->
		</div>
		
		</div> <!-- admin_member_inquiry_container -->
		
	</div> <!-- admin_member_inquiry_cont_wrapper -->



</body>
</html>