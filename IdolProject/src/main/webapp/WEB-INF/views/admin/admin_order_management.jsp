<%@page import="java.util.StringTokenizer"%>
<%@page import="com.idol.model.OrderDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN ORDER MANAGEMENT</title>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">

<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
 
<style type="text/css">
	
	html, body {
		padding: 0px;
		margin: 0px;
		background-color: black;
		height: 100%;
	}
	a {
		text-decoration: none;
	}
	
	.products_order_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	}
	
	.products_order_container {
		display: flex;
		flex-direction: column;
		align-items: center;
		row-gap: 10px;
	}
	
	.order_boxes_tag {
		width: 147px;
    	height: 147px;
	}
	.order_boxes {
		border: 1px solid pink;
		width: 80%;
		height: 147px;
		display: flex;
		flex-direction: row;
		align-items: center;
		font-family: 'Press Start 2P', 'Jua', monospace;
	}
	
	.order_boxes a {
		color: white;
	}
	
	.order_img {
		flex: 10%;
		height: 100%;
		width: 100%;
		border-right: 1px solid pink;
	}
	.order_img img {
		width: 100%;
		height: 100%;
	}
	
	.order_img:hover{
		opacity: 0.5;
	}
	
	.order_detail {
		flex: 90%;
		color: white;
		display: flex;
	    flex-wrap: wrap;
	    flex-direction: row;	
	    justify-content: space-between;
	    align-items: center;
	    margin: 0px 20px;
	}
	
	.order_id:hover{
		color: gold;
	}
	
	.order_no:hover{
		color: skyblue;
	}
</style>

	
<script type="text/javascript">
	
	
	
</script>
	
</head>
<body>
	<c:set var="olist" value="${oList }" />
	<div class="products_order_wrapper"> 
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_products_include.jsp" />
	
	
		<div class="products_order_container">
		
			
		<%
		List<OrderDTO> oList = (List<OrderDTO>)request.getAttribute("oList");
		
		for(int i = 0; i < oList.size(); i++){
			
			OrderDTO dto = oList.get(i);
			
			String img = dto.getOrder_pimage();
			
			StringTokenizer tokenizer = new StringTokenizer(img, "|");
			
			String[] imgList = new String[tokenizer.countTokens()];
			
			for(int j = 0; j <imgList.length; j++){
				
				imgList[j] = tokenizer.nextToken();
			}
		
		%>
		
			
				<div data-aos="fade-in" class="order_boxes">	
					<a class="order_boxes_tag" href="<%=request.getContextPath() %>/admin_order_productCont.do?no=<%=dto.getOrder_no()%>">
						<div class="order_img">
							<img alt="" src="./resources/upload/product/<%=imgList[0]%>">
						</div><!-- order_img -->
					</a> <!-- order_boxes_tag -->	
					
					<div class="order_detail">
				
						<div>
							<a class="order_id" href="<%=request.getContextPath()%>/admin_memeber_purchaseInfo.do?name=<%=dto.getOrder_userid()%>">
								ID:<%=dto.getOrder_userid() %>
							</a>
						</div>
				
						<div>
							<a class="order_no" href="<%=request.getContextPath()%>/admin_order_groupCont.do?no=<%=dto.getOrder_group()%>">
								주문번호:<%=dto.getOrder_group() %>
							</a>
						</div>
						<div>
							수량:<%=dto.getOrder_qty() %>
						</div>
						
						<div>
							상품 가격 :<%=String.format("%,d", dto.getOrder_pprice()) %> 원
						</div>
						<div>
							총금액:<%=String.format("%,d", dto.getOrder_total()) %> 원
						</div>
						<div>
							수취인 :<%=dto.getOrder_receivername() %>
						</div>
<!-- 						<div> -->
<%-- 							수취인 연락처: <%=dto.getOrder_receiverphone() %> --%>
<!-- 						</div> -->
<!-- 						<div> -->
<%-- 							수취인 주소 : <%=dto.getOrder_receiveraddress() %> --%>
<!-- 						</div> -->
						<div>
							 <%=dto.getOrder_date().substring(0, 10) %>
						</div>
					
					
					</div> <!-- order_detail -->
				</div> <!-- order_boxes -->
			
			
		<%}%>
			
			
		</div> <!-- products_order_container -->
	</div> <!-- products_order_wrapper -->

<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
 <script>
   AOS.init();
 </script>

</body>
</html>