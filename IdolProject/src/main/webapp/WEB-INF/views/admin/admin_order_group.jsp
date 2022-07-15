<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN MEMBER ORDER GROUP LIST</title>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">

<style type="text/css">
	
	html, body {
		margin: 0px;
		padding: 0px;
		background-color: black;
		font-family: 'Press Start 2P', 'Jua', monospace;
	}
	
	.admin_order_cont_wrapper {
		min-height: 100vh;
		display: flex;
		flex-direction: column;
	}
	
	.order_container {
		display: flex;
	    flex-direction: column;
	    align-items: center;
	    margin-bottom: 60px;
	}
	
	
	.order_cont_info {
		color: white;
	
	}
	
	.order_cont_wrapper {
		display: flex;
		flex-direction: column;
		width: 850px;
	}
	

	.order_cont_info_box {
		border: 1px solid pink;
		color: white;
		display: grid;
		grid-template-columns: 200px 100%;
		height: 200px;
	}


	.order_img {
		grid-column: 1;
		width: 200px;
    	height: 200px;
	}
	.order_img img{
		width: 100%;
		height: 100%;
	}
	
	.order_right_box {
		grid-column: 2;
		width: 640px; 
		display: flex;
	}
	
	.left_side{
		width: 250px;
		justify-content: center;
		display: flex;
	    flex-direction: column;
	    line-height: 1.5;
	    margin-left: 5%;
	}
	
	.right_side {
		display: flex;
	    flex-direction: column;
	    width: 100%;
	    justify-content: center;
	    margin-left: 10%;
	    line-height: 1.3;
	}
	
	.member_order_address {
		color: white;
	
	}
	
	.order_date {
		font-size: 0.9em;
	}
	
	
	.address_box{
		display: flex;
    	flex-direction: row;
   		flex-wrap: wrap;
}
	
	}
</style>
</head>
<body>


<c:set var="olist" value="${oList }" />
<c:set var="arrd" value="${addrArray }" />

	<div class="admin_order_cont_wrapper"> 
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_products_include.jsp" />
	
		<div class="order_container">
			
			 
			<div class="order_cont_wrapper">
			 
			 <c:set var="sumQty" value="0" />
			 <c:set var="sumTotal" value="0" />
			 <c:set var="sumMileage" value="0" />
			 <c:forEach items="${olist }" var="odto" varStatus="i1">
			<!-- 
				 <div class="order_cont_img">
						<img alt="" src="./resources/upload/product/${oimgsList[i1.index] }">
					</div> <!-- order_cont_img -->
			 -->		
				<div class="order_cont_info_box">
					<div class="order_img">
						<img alt="" src="./resources/upload/product/${odto.order_pimage }">
					</div>
					<div class="order_right_box">
					
						<div class="left_side">
							<div>
								주문 번호: ${odto.order_no }
							</div>
							<div>
								그룹 번호:  ${odto.order_group }
							</div>
							<div>
								ID: ${odto.order_userid }
							</div>
							<div class="order_date">
								${odto.order_date.substring(0, 10) }
							</div>
						</div>
						
						<div class="right_side">
							<div>
								${odto.order_pname }
							</div>
							<div>
								수량: ${odto.order_qty }
							</div>
							<div>
								가격: <fmt:formatNumber value="${odto.order_pprice }" />원
							</div>
							<div>
								총 금액: <fmt:formatNumber value="${odto.order_total }" />원
							</div>
							<div>
								운송비: <fmt:formatNumber value="${odto.order_tcost }" />원
							</div>
							
							<div>
								마일리지: <fmt:formatNumber value="${odto.order_mileage }" /> 마일리지
							</div>
							<div>
								<c:if test="${odto.order_type == '1' }">
									카드결제
								</c:if>
								<c:if test="${odto.order_type == '0' }">
									계좌이체
								</c:if>
							</div>
						</div>
						
						
						
						
					</div> <!-- order_right_box -->
					
				</div> <!-- order_cont_info_box -->
				<c:set var="sumQty" value="${sumQty + odto.order_qty }" />
				<c:set var="sumTotal" value="${sumTotal + odto.order_total }" />
				<c:set var="sumMileage" value="${sumMileage + odto.order_mileage }" />
			</c:forEach>
			</div><!-- order_cont_wrapper -->
			
			<div class="counting" style="color: white">
				<ul>
					<li>
						총 수량: <fmt:formatNumber value="${sumQty }" /> 개
						
					</li>
					<li>
						총 마일리지: <fmt:formatNumber value="${sumMileage }" /> 원
					</li>
					<li>
						총 구매 금액: <fmt:formatNumber value="${sumTotal }" /> 원
					</li>
					
				</ul> 
				
			</div>
			<div class="member_order_address">
				<div>
				[주소]
				</div>
				<c:forEach begin="0" end="0" items="${olist }" var="addr">
					<div>			
						수령인 : ${addr.order_receivername }
					</div>
					<div>
						 
						<c:set var="first" value="${addr.order_receiverphone.substring(0, 3) }" />
						<c:set var="second" value="${addr.order_receiverphone.substring(3, 7) }" />
						<c:set var="third" value="${addr.order_receiverphone.substring(7) }" />
						수령인 연락처: ${first }-${second }-${third }
					</div>
					<div>
						<span>수령인 주소:</span>
						<div class="address_box">
							<c:forEach begin="0" end="0" items="${addrArray }" var="addr">
								<div>
									<span>[${addr }]</span>
								</div>
							</c:forEach> 
							<c:forEach begin="1" items="${addrArray }" var="addr">
								<div>
									<span>${addr }</span>
								</div>
							</c:forEach>
						</div>
					</div>
				</c:forEach>
			</div>
			
			
		</div> <!-- order_container -->
	
	</div> <!-- admin_order_cont_wrapper -->
</body>
</html>