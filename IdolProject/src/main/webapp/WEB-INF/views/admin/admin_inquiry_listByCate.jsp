<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN INQUIRY ALL</title>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">

<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />

<style type="text/css">

	html, body {
		padding: 0px;
		margin: 0px;
		height: 100%;
		background-color: black;
		font-family: 'Press Start 2P', 'Jua', monospace;
	}
	
	a{
		text-decoration: none;
		color: white;
	}
	.admin_Inquiry_allList_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	}
	
	.admin_inquiry_allList_container{
		display: flex;
    	justify-content: center;
	}
	
	
	.inquiry_boxes {
		color: white;
		width: 80%;
    	display: flex;
	    flex-direction: column;
	    align-items: center;
	
	}
	
	.border_radius {
		margin: 20px 0px;
		width: 800px;
		background-color: #29434e;
    	border-radius: 30px;
	}
	
	.member_box_link{
		display: flex;
   	 	flex-direction: row;
   	 	width: 100%;
	}

	.content_left {
		display: flex;
    	flex-direction: row;
	}
	
	.member_img_box {
		width: 150px;
    	height: 130px;
	}
	.member_img {
		width: 100%;
		height: 100%;
		border-radius: 30px;
	}
	
	.member_communi_text {
		color: white;
		display: flex;
    	flex-direction: row;
    	width: 100%;
    	justify-content: space-around;
    	align-items: center;
	}
	.content_id {
		margin: 0px 9px;
		color: #819ca9;
	}
	
	.content_title {
	    font-size: 1.4em;
	    
	}
	
	.content_right {
		color: #819ca9;
		font-size: 0.8em;
	}
</style>

<script type="text/javascript">

</script>
</head>
<body>
<c:set var="oklist" value="${okList }" />
<c:set var="list" value="${categoryByNo }" />
<c:set var="mlist" value="${mList }" />

	<div class="admin_Inquiry_allList_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_member_include.jsp" />
	
		<div class="admin_inquiry_allList_container">
			
			<div class="inquiry_boxes">
			
				<c:if test="${!empty list }">
					<c:forEach items="${list }" var="dto">
						<c:forEach items="${mlist }" var="mdto">
							<c:if test="${mdto.member_id == dto.inquiry_userid }">
								<div data-aos="fade-in"  class="border_radius">
								<a class="member_box_link" href="<%=request.getContextPath()%>/admin_member_inquiryCont.do?no=${dto.inquiry_no}
									&pno=${dto.product_no}&ono=${dto.order_no}&gno=${dto.inquiry_group}">
										<div class="member_img_box">
											<img class="member_img" alt="" src="./resources/upload/member_image/${mdto.member_no }/${mdto.member_image}">
										</div>
										<div class="member_communi_text">
											
											<div class="content_id">
												${dto.inquiry_userid }
											</div>
											
											<!-- 대댓글 문의인 경우 -->
											<c:if test="${dto.inquiry_indent > 0 }">
												 <div class="content_title"> 
												 	(대댓글) ${dto.inquiry_title }
												 </div>
											<!-- 
												<c:forEach begin="1" end="${i.inquiry_indent }">
													
												</c:forEach>
												 -->
											</c:if>
											<!-- 원글인 경우 -->
											<c:if test="${dto.inquiry_indent == 0 }">
												<div class="content_title">
													${dto.inquiry_title }
												</div>	
											</c:if>
											
											<div class="content_right">
												<c:if test="${empty dto.inquiry_update }">
													${dto.inquiry_date.substring(0, 10) }
												</c:if>
												<c:if test="${!empty dto.inquiry_update }">
													${dto.inquiry_update.substring(0, 10) }
												</c:if>
											</div>
										
										<!--  	
										<div class="content_text">${i.inquiry_cont }</div>
										-->	
											
										
<!-- 											<div class="inquiry_cont"> -->
<%-- 												${dto.inquiry_cont } --%>
<!-- 											</div> -->
										
											
										</div>
									</a> <!-- member_box_link -->
								</div> <!-- border_radius -->
							</c:if>
						</c:forEach>
					</c:forEach>
				</c:if>
				<c:if test="${!empty oklist }">
					<c:forEach items="${oklist }" var="ok">
						<c:forEach items="${mlist }" var="mdto">
							<c:if test="${mdto.member_id == ok.inquiry_userid }">
								<div data-aos="fade-in" class="border_radius">
								<a class="member_box_link" href="<%=request.getContextPath()%>/admin_member_inquiryCont.do?no=${ok.inquiry_no}
									&pno=${ok.product_no}&ono=${ok.order_no}&gno=${ok.inquiry_group}">
										<div class="member_img_box">
											<img class="member_img" alt="" src="./resources/upload/member_image/${mdto.member_no }/${mdto.member_image}">
										</div>
										<div class="member_communi_text">
											<div class="content_id">
												${ok.inquiry_userid }
											</div>
											
											<!-- 대댓글 문의인 경우 -->
											<c:if test="${ok.inquiry_indent > 0 }">
												 <div class="content_title"> 
												 	(대댓글) ${ok.inquiry_title }
												 </div>
											<!-- 
												<c:forEach begin="1" end="${i.inquiry_indent }">
													
												</c:forEach>
												 -->
											</c:if>
											<!-- 원글인 경우 -->
											<c:if test="${ok.inquiry_indent == 0 }">
												<div class="content_title">
													${ok.inquiry_title }
												</div>	
											</c:if>
											
											<div class="content_right">
												<c:if test="${empty ok.inquiry_update }">
													${ok.inquiry_date.substring(0, 10) }
												</c:if>
												<c:if test="${!empty ok.inquiry_update }">
													${ok.inquiry_update.substring(0, 10) }
												</c:if>
											</div>
										
										<!--  	
										<div class="content_text">${i.inquiry_cont }</div>
										-->	
											
										
											<div class="inquiry_cont">
												${dto.inquiry_cont }
											</div>
											
										</div>
									</a> <!-- member_box_link -->
								</div> <!-- border_radius -->
							</c:if>
						</c:forEach>
					</c:forEach>
				</c:if>
				
			</div> <!-- inquiry_boxes -->
			
		</div> <!-- admin_inquiry_allList_container -->
	</div> <!-- admin_Inquiry_allList_wrapper -->

  <div
    data-aos="fade-up"
    data-aos-offset="200"
    data-aos-delay="50"
    data-aos-duration="1000"
    data-aos-easing="ease-in-out"
    data-aos-mirror="true"
    data-aos-once="false"
    data-aos-anchor-placement="top-center"
  >
  </div>
  
 <script src="https://unpkg.com/aos@next/dist/aos.js"></script>
  <script>
    AOS.init();
  </script>

</body>
</html>