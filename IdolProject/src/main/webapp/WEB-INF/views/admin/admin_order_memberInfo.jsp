<%@page import="java.util.StringTokenizer"%>
<%@page import="org.springframework.core.annotation.Order"%>
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
<title>ADMIN ORDER MEMBER_INFO</title>

 <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />


<style type="text/css">

	html, body {
		margin: 0px;
		padding: 0xp;
		height: 100%;
		font-family: 'Press Start 2P', 'Jua', monospace;
		background-color: black;
	}
	
	.admin_memberInfo_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	}
	
	
	.admin_memberInfo_container {
		color: white;
		display: flex;
	    flex-direction: column;
	    align-items: center;
	    gap: 20px;
	    margin-bottom: 50px;
	}
	
	
	
	.member_purchase_list {
		border: 1px solid pink;
		display: grid;
		grid-template-columns: 200px 100%;
		height: 200px;
		width: 900px;
	}
	
	.image_box {
		width: 200px;
		height: 200px;
		border: 1px solid pink;
	}
	
	.image_box img {
		width: 100%;
		height: 100%;
	
	}
	
	
	.addr {
		display: flex;
   		flex-direction: row;
		flex-wrap: wrap;
	}
	
	.admin_member_purchase_detail {
		display: grid;
   		grid-template-columns: 28% 72%;
		width: 700px;
	}
	
	.right_side {
		display: flex;
	    flex-direction: column;
	    justify-content: center;
	    margin-left: 10%;
	}
	
	.left_side {
		display: flex;
	    flex-direction: column;
	    justify-content: center;
	    align-items: center;
	    line-height: 1.6;
		margin-left: 8%;
	}
	
	.date {
		font-size: 0.8em;
	}
	
	.member_personal_sales {
		display: flex;
		width: 530px;
	}
	
	.p_left {
		flex: 50%;
		max-width: 50%;
		justify-content: center;
	    display: flex;
	    align-items: center;
		
	}
	.p_right {
		flex: 50%;
		max-width: 50%;
		
	}
</style>
</head>
<body>
<!-- 구매내역 리스트 by user_id -->
<c:set var="list" value="${mList }" />

	<div class="admin_memberInfo_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_member_include.jsp" />
	
		<div class="admin_memberInfo_container">
		<c:set var="qty" value="0" />
		<c:set var="mile" value="0" />
		<c:set var="total" value="0" />
		<c:forEach items="${list }" var="dto">
			<c:set var="qty" value="${qty+dto.order_qty }" />
			<c:set var="mile" value="${mile+dto.order_mileage }" />
			<c:set var="total" value="${total+dto.order_total }" />
		</c:forEach>
		
		<div class="member_personal_sales">
					<div class="p_left">
						<c:forEach begin="0" end="0" items="${list }" var="p">
							ID: ${p.order_userid }
						</c:forEach>
					</div>
				
					<div class="p_right">
						<div>총 수량: <fmt:formatNumber value="${qty }" />개</div>
						<div>총 마일리지: <fmt:formatNumber value="${mile }" />원</div>
						<div>총 구매 금액: <fmt:formatNumber value="${total }" />원</div>
					</div>
			
		</div>
		
		
		<%
		
		List<OrderDTO> list = (List<OrderDTO>)request.getAttribute("mList");
		
		for(int i = 0; i < list.size(); i++){
			
			OrderDTO dto = list.get(i);
			
			String addr = dto.getOrder_receiveraddress();
			
			StringTokenizer addrToekn = new StringTokenizer(addr, "|");
			
			String[] addrArray = new String[addrToekn.countTokens()];
			
			for(int j = 0; j < addrArray.length; j++){
				
				addrArray[j] = addrToekn.nextToken();
				
			}
			
		
		
		%>
			
			<div data-aos="fade-in" class="member_purchase_list">
				
				<div class="image_box">
					<img alt="" src="./resources/upload/product/<%=dto.getOrder_pimage()%> ">
				
				</div>
		

				
				<div class="admin_member_purchase_detail">
				
					
					<div class="left_side"> 
						<div>
							No. <%=dto.getOrder_no() %>
						</div>
						<div>
							ID: <%=dto.getOrder_userid() %>
						</div>
						<div class="date">
							<%=dto.getOrder_date().substring(0, 10) %>
						</div>
					</div>
					
					<div class="right_side">
						
						<div>
							수량 : <%=String.format("%,d", dto.getOrder_qty()) %>개
						</div>
						<div>
							개당 구매 금액 : <%=String.format("%,d", dto.getOrder_pprice()) %>원
						</div>
						<div>	
							마일리지: <%=String.format("%,d", dto.getOrder_mileage()) %>
						</div>
						<div>
							총 구매금액 : <%=String.format("%,d", dto.getOrder_total()) %>원
						</div>
						<div>			
						수령인 : <%=dto.getOrder_receivername() %>
						</div>
						<div>
						수령인 연락처: 	
						<%=dto.getOrder_receiverphone().substring(0, 3) %>-
						<%=dto.getOrder_receiverphone().substring(3, 7) %>-
						<%=dto.getOrder_receiverphone().substring(7) %>
						
						</div>
						<div class="addr">
							<div>[<%=addrArray[0] %>]</div>
						<%
						for(int n = 1; n < addrArray.length; n++){
						%>								
							<div><%=addrArray[n] %></div>
						<%}%>
						</div>
					</div>
					
				</div> <!-- admin_member_purchase_detail -->
			</div> <!-- member_purchase_list -->
			<%}%>	
		</div> <!-- admin_memberInfo_container -->
				
	</div> <!-- admin_memberInfo_wrapper -->
	
	
 <script src="https://unpkg.com/aos@next/dist/aos.js"></script>
  <script>
    AOS.init();
  </script>
  
  
</body>
</html>