<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN ORDER CONTENT</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>

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
	
	}
	
	.order_cont_boxing {
		display: flex;
		flex-direction: row;
		margin-top: 50px;
	}
	
	
	
	
	
	.order_cont_img {
		flex: 50%;
		max-width: 50%;
		display: flex;
   	 	justify-content: center;
	}
	
	.order_img {
		width: 500px;
		height: 500px;
	}
	
	
	.order_cont_info_box {
		flex: 50%;
		max-width: 50%;
		/*border: 1px solid pink;*/
		color: white;
		display: flex;
	    flex-direction: column;
	    justify-content: center;
	   /* align-items: center;*/
	    line-height: 1.4;
	    
	}
	
	
	.addr_box {
		display: flex;
	    flex-direction: row;
	}
	
	
</style>



<script type="text/javascript">
	
</script>

</head>
<body>
<!-- 주문 상세 내역 -->
<c:set var="odto" value="${orderCont }" />
<!-- 토크나이져로 조진 주소 -->
<c:set var="addr" value="${address }" />


	<div class="admin_order_cont_wrapper"> 
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_products_include.jsp" />
	
		<div class="order_container">
		
			 <div class="order_cont_boxing">
			 
			 	<div class="order_cont_img">
			 		<img class="order_img" alt="" src="./resources/upload/product/${odto.order_pimage }">
			 	</div>
			 
			 
				<div class="order_cont_info_box">
					<div>
						주문 번호: ${odto.order_no }
					</div>
					<div>
						그룹 번호:  ${odto.order_group }
					</div>
					<div>
						ID: ${odto.order_userid }
					</div>
					<div>
						${odto.order_pname }
					</div>
					<div>
						수량: <fmt:formatNumber value="${odto.order_qty }" />개
					</div>
					<div> 
						가격: <fmt:formatNumber value="${odto.order_pprice }" />원
					</div>
					<div>
						운송비: <fmt:formatNumber value="${odto.order_tcost }" />원
					</div>
					<div>
						총 금액: <fmt:formatNumber value="${odto.order_total }" />원
					</div>
					<div>
						마일리지: <fmt:formatNumber value="${odto.order_mileage }" />
					</div>
					<div>
						<c:if test="${odto.order_type == '1' }">
							카드결제
						</c:if>
						<c:if test="${odto.order_type == '0' }">
							계좌이체
						</c:if>
					</div>
					<div>
						주문날짜: ${odto.order_date.substring(0, 10) }
					</div>
					
					<div class="order_address">
						
						<div>
							수취인: ${odto.order_receivername }
						</div>
						<div>
							
						<c:set var="first" value="${odto.order_receiverphone.substring(0, 3) }" />
						<c:set var="second" value="${odto.order_receiverphone.substring(3, 7) }" />
						<c:set var="third" value="${odto.order_receiverphone.substring(7) }" />
						연락처: ${first }-${second }-${third }
						</div>
						주소:
						<div class="addr_box">
							<c:forEach begin="0" end="0" items="${address }" var="addr">
								<div>[${addr }]</div>
							</c:forEach>
							<c:forEach begin="1" items="${address }" var="addr">
								<div>${addr }</div>
							</c:forEach>
						</div>
					</div><!-- order_address -->
				</div> <!-- order_cont_info_box -->
				
			</div><!-- order_cont_wrapper -->
			

			
		</div> <!-- order_container -->
		
		
	
	</div> <!-- admin_order_cont_wrapper -->
	
	
	
</body>
</html>