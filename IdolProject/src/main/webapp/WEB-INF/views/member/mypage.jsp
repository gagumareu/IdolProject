<%@page import="java.text.DecimalFormat"%>
<%@page import="com.idol.model.OrderDTO"%>
<%@page import="com.idol.model.InquiryDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.idol.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<link rel="stylesheet" href="./resources/css/member.css?v=2022063010">
<style type="text/css">
	
	
	
	.mypage_main_top {
	
		margin-bottom:50px;
		display: flex;
		justify-content: space-between;
		
		background-color: #f7f8f8;
	}
	
	.mypage_main_top a{
		text-decoration: none;
		color:black;
		font-weight:bold;
	}
	
	.mypage_main_top span{
		font-size:2em;
		font-weight: 400;	
		
	}
	
	
	.main_top_icon{
		display:block;
		overflow:hidden;
		border-radius: 50%;
		width:60px;
		height:60px;
		margin-bottom: 10px;
	}
	
	.main_top_icon label{
		display:block;
		margin-left:auto;
		font-size: 35px;
		color:white;
		cursor: pointer;
	}
	
	.top_item {
		padding:20px;
		width:34%;
		
		border:1px solid #ececec;
	
	}
	.icon_point{
		background-color:#ffc1cc;
	}
	
	.icon_delivery{
		background-color:#ae84cd;
	}
	
	.icon_qna{
		background-color:#a3d9ef;
	}


	.recent_order, .recent_qna{
		/* margin-left:35px;
		margin-bottom: 50px; */
		
		padding: 40px;
	}
	.recent_qna i , .recent_order i{
		font-size:2em;
	}
	
	.recent_qna a , .recent_order a{
		text-decoration: none;
		color:black;
	}
	
	.recent_title{
		font-size: 1.3em;
		font-weight: bold;
	}
	
	.recent_qna_content a {
		text-decoration: none;
		color: black;
	}
	
	.order_item{
		display: flex;
		margin:20px 10px;
	}
	
	.order_item .order_photo {
		width:100px;
		height:100px;
		border-radius: 10px;
		margin-right:20px;
	}
	
	.order_photo img{
		width:100%;
		height:100%;
		}
	
	.order_item .order_info{
		line-height: 1.5;
	}
	
	.qna_item{
		margin: 10px;
		padding: 10px 0;
		line-height: 1.5;
	}
	.qna_item:hover, .order_item:hover {
		background-color:rgba(236,236,236,0.5);
		opaciy: 50%
	}
	
	.qna_item span{
		font-size: 1em;
	}

</style>
</head>
<body>
	
	<c:set var="mileage" value="${mileage }"/>	
	

	<%@include file="../include/user_top.jsp" %>
	<div class="mypage_container" >
		
		<!-- aisde inlcude 추가  -->
		<jsp:include page="../include/mypage_aside.jsp"/>
		
		<div class="mypage">
			<div class="mypage_main_top" algin="center">
			
				<div class="top_item" align="center">
				 <a href="<%=request.getContextPath()%>/mileage_list.do">
					<div class="main_top_icon icon_point">
						<label for="icon_point" class="bi bi-wallet2"></label>
					</div>
				마일리지
				<br>
				
				<span>
					<fmt:formatNumber value="${mileage}" /> 
				</span>
				</a>
				</div>
				
				<div class="top_item" align="center">
				<a href="<%=request.getContextPath()%>/order_list.do">
					<div class="main_top_icon icon_delivery">
						<label for="icon_delivery" class="bi bi-truck"></label>
					</div>
				주문/배송
				<br>
				<span>
					<fmt:formatNumber value="${threedays}" /> 
				</span>
				</a>
				</div>
				
				<div class="top_item" align="center">
				<a href="<%=request.getContextPath()%>/inquiry_list.do">
					<div class="main_top_icon icon_qna">
						<label for="icon_qna" class="bi bi-chat-left-dots"></label>
					</div>
				온라인문의
				<br>
				<span>
					<c:if test="${empty waiting }">0</c:if> 
					<c:if test="${!empty waiting }">
					<fmt:formatNumber value="${waiting }" /> 
					</c:if>
				</span>
				</a>
				</div>
				
			
			</div> <!-- class="mypage_main_top" end -->
		
			<div class="recent_order">
			<a href="<%=request.getContextPath()%>/order_list.do"> <span class="recent_title">최근 주문내역</span>&nbsp;<i class="bi bi-plus"></i></a> 
			<hr align="left" width="100%" color="lightgray">
			<!-- 최근 구매내역 3개까지 -->
			<div class="recent_order_content">
			<!-- 구매내역 없음  -->
			<c:if test="${empty oList }">
			<span>구매내역 없음</span>
			</c:if>
			
			<!-- 구매내역 있으면 for문돌려 3개까지 보이기(order_item) -->
			<c:if test="${!empty oList }">
			
			<% 
				List<OrderDTO> oList = (List<OrderDTO>)request.getAttribute("oList");
			
				int size =0;
				
				if(oList.size()<=3){ size = oList.size();}
				else{size = 3 ;}
			
				for(int i=0; i<size; i++){
					OrderDTO odto = oList.get(i);
					
					DecimalFormat format = new DecimalFormat("###,###");
					String price = format.format(odto.getOrder_total());
			%>		
				
					<a href="<%=request.getContextPath()%>/orderlist_cont.do?ogno=<%=odto.getOrder_group() %>">
					<div class="order_item">
					
					<div class="order_photo">
					<img src="./resources/upload/product/<%=odto.getOrder_pimage() %>" >
					</div>
					<div class="order_info">
						<span style="font-size:15px; color: gray;">
						<%=odto.getOrder_date().substring(0,10) %>
						</span> <br>
						<span style="font-size:1.2em; font-weight:bold;">
						<%=odto.getOrder_pname() %></span><br>
						<span style="font-size:0.9em;"><%=odto.getOrder_qty() %>개 </span>|
						<span style="font-size:0.9em;"> <%=price %>원 </span>
					</div> 
					
					</div> <!-- class="order_item" -->
					</a>
				
			<% 	}//for문 %>
			</c:if>
			</div><!-- class="recent_order_content" end -->
			
			</div> <!-- class="recent_order" end -->
		
			<div class="recent_qna">
			<a href="<%=request.getContextPath()%>/inquiry_list.do"> <span class="recent_title">최근 문의내역</span>&nbsp; <i class="bi bi-plus"></i></a>
			<hr align="left"  width="100%" color="lightgray">
			<div class="recent_qna_content"> 
			<c:if test="${!empty iList }">
			<!-- 문의내역 최신 3개만 보이기 -->
			<%
				List<InquiryDTO> inquiry = (List<InquiryDTO>)request.getAttribute("iList");
				
				int isize = 0;
				
				if(inquiry.size()<=3){ isize = inquiry.size();}
				else{isize = 3 ;}
				
				for(int i=0; i<isize; i++){
					
					InquiryDTO idto = inquiry.get(i);
					
					//카테고리구분
					String icategory ="";
					switch(idto.getCategory_inofk()){
					case 1: 
						icategory ="취소/환불";
						break;
					case 2: 
						icategory ="상품문의";
						break;
					case 3: 
						icategory ="배송";
						break;
					case 4: 
						icategory ="교환";
						break;
					case 5: 
						icategory ="기타";
						break;
				
					}
					//답변상태
					String status = "";
					String color ="";
					if(idto.getInquiry_status() == 0){
						status ="답변대기";
						color = "#ff5722";
					}else{
						status="답변완료";
						color="black";
					}
			%>
				<a href="<%=request.getContextPath()%>/inquiry_cont.do?no=<%=idto.getInquiry_no()%>&page=1">
				<div class="qna_item">
					<span style="color: #1f3093;font-size: 0.9em;"> [<%=icategory %>]</span>
					&nbsp;<span><%=idto.getInquiry_title() %></span><br>
					<span style="color: #858080;font-size: 0.9em; font-weight:normal;">
					<%=idto.getInquiry_date().substring(0, 10) %></span>│ 
					<span style="color:<%=color %>;font-size: 0.9em;"><%=status %> </span>
				</div><!-- class="qna_item" end -->
				</a>
			<%	}
			%>
			</c:if>
			<c:if test="${empty iList }">
			<span>문의내역 없음</span>
			</c:if>
			</div><!-- class="recent_qna_content" end -->
			
			</div>
			
		</div><!-- class="mypage_main" end -->
	
	</div><!-- class="mypage_container" end -->
	<%@include file="../include/user_bottom.jsp" %>
</body>
</html>