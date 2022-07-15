<%@page import="java.text.DecimalFormat"%>
<%@page import="com.idol.model.ProductDTO"%>
<%@page import="com.idol.model.OrderDTO"%>
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
<title>마이페이지> 문의글 내용</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="./resources/js/member.js"></script>
<link rel="stylesheet" href="./resources/css/member.css?v=2022063010">
<style type="text/css">
	
	/* ***********마이페이지 회원정보관리************* */
	
	.order_cont{
		padding: 20px 30px;
		margin-left:50px;
	}
	.orderCont_container{
		width:80%;
		padding:10px;
		background-color: #ececec;
		border:1px solid #ececec;
		border-radius: 8px;
	
	}
	
	.orderCont_date{
	
		margin-left: 4px;
    margin-bottom: 12px;
    font-weight: bold;
	}
	
	.orderCont_detail{
		width: 100%;
    border: 1px solid #e0dfdf;
    border-radius: 8px;
    padding: 20px;
    margin-bottom: 20px;
    background-color:white;
	}
	
	.orderCont_detail .orderContInfo_title{
		font-weight: bold;
		margin-bottom:10px;
	}
	.orderCont_detail div{
	
		margin: 2px 0;
	}
	
	.orderContInfo{
	
		display:flex;
		width:100%;
		justify-content: space-between;
		font-size: 0.95em;
	}
	
	
	
	.orderCont_item{
		width:100%;
		display: flex;
		padding:10px;
		margin:20px 0;
		border:1px solid #ececec;
		border-radius: 8px;
		background-color:white;
	}
	
	.orderCont_item .order_photo {
		width:100px;
		height:100px;
		border-radius: 10px;
		margin-right:20px;
	}
	
	.order_photo img{
		width:100%;
		height:100%;
		border: 1px solid #8b8989;
	}
	
	.orderCont_item .order_info{
		line-height: 1.5;
		width: 70%;
	}
	
	.order_info a:hover{
		text-decoration: underline;
	}

	.btn{
	background-color: white;
    border: 1px solid #233044;
    padding: 8px 20px;
    border-radius: 21px;
    cursor: pointer;
    margin: 30px 2px;
	
	}
	
	.btn:hover {
		background-color: #2a3a52;
		color:white;
	}
	
	.order_btns{
		display:flex;
		margin-top:15px;
	}
	
	.order_btns input{
	margin-right: 4px;
    width: 70px;
    height: 26px;
    border-radius: 5px;
    background-color: white;
    border: 1px solid #2a3a52;
    cursor: pointer;
    font-size: 0.8em;
	}

</style>


<script type="text/javascript">



</script>
</head>
<body>
	<c:set var="dto" value="${loginInfo }"/> <!--로그인회원 정보 저장 -->
	<c:set var="Group" value="${orderGroup }"/> <!-- 구매그룹 리스트-->
	<c:set var="pList" value="${pList }"/> <!-- 제품 정보 리스트 -->
	<c:set var="pay" value="${pay }"/> <!--실제 결제한 금액 -->
	<c:set var="totalPrice" value="${totalPrice }"/> <!-- 구매 가격 -->
	<c:set var="trans" value="${trans }"/> <!-- 배송비 -->
	<c:set var="date" value="${payDate }"/> <!-- 구매날짜-->
	<c:set var="name" value="${name }"/> <!-- 수취인 -->
	<c:set var="phone" value="${phone }"/> <!-- 수취인 번호 -->
	<c:set var="addr" value="${Addr }"/> <!-- 배송주소-->
	
	<%@include file="../include/user_top.jsp" %>
	<div class="mypage_container">
		
		<!-- aisde inlcude 추가  -->
		<jsp:include page="../include/mypage_aside.jsp"/>
		
		<div class="mypage_main">
		<div class="manage_top">
		주문 상세 내역
		</div>
			<div class="order_cont">
				<div class="orderCont_date">
					${date } 주문
				</div>
				<div class="orderCont_container">
				<div class="orderCont_detail">
					<div class="orderContInfo_title">결제 정보</div>
					<div class="orderContInfo"> 
						<div >상품가격</div>
						<div>
						<fmt:formatNumber value="${totalPrice }"/> 원
						</div>
					</div>
					<div class="orderContInfo">
						<div>배송비</div>
						<div><fmt:formatNumber value="${trans}"/> 원</div>
					</div>
					<c:if test="${totalPrice != (pay-trans) }"> <!-- 마일리지 차감했다면 구매금액과 결제금액(배송비제외)이 다를 것 -->
					<div class="orderContInfo">
						<c:set var="mileage" value="${totalPrice-(pay-trans) }"/>
						<div>마일리지 </div>
						<div> - <fmt:formatNumber value="${mileage}"/> 원 </div>
					</div>
					</c:if>
					<hr style="margin:12px 0;">
					<div class="orderContInfo">
						<div style="font-weight:bold;">총 결제금액</div>
						<div><fmt:formatNumber value="${pay }"/> 원</div>
					</div>
				</div> <!--class ="orderCont_detail"  -->	
				
				<!-- 배송 정보  -->
				<div class="orderCont_detail">
					<div class="orderContInfo_title">${name }</div>
					<div style="font-size:0.9em;">
						<c:forEach  items="${addr }" var="a">
							${a }&nbsp;
						</c:forEach> <br>
						${phone.substring(0,3) }-${phone.substring(3,7) }-${phone.substring(7) }
					 </div>
				</div> <!--class ="orderCont_detail"  -->
				
				<br>
				<%
					List<OrderDTO> orderCont = (List<OrderDTO>)request.getAttribute("orderGroup");
					List<ProductDTO> pCont = (List<ProductDTO>)request.getAttribute("pList");
					
					int ogno =0;
					
					for(int i=0; i<orderCont.size(); i++){
						
						OrderDTO odto = orderCont.get(i);
						ProductDTO pdto = pCont.get(i);
						
						if(ogno == 0){
							ogno = odto.getOrder_group();
						}
						
						DecimalFormat format = new DecimalFormat("###,###");
						String pprice = format.format(odto.getOrder_pprice());//제품가격
						
				%>
					<div class="orderCont_item">
						<div class="order_photo">
						<img src="./resources/upload/product/<%=odto.getOrder_pimage()%>">
						</div>
						<div class="order_info">
							<a href="<%=request.getContextPath() %>/product_detail.do?pno=<%=pdto.getProduct_no()%>" style="font-weight:bold;">
							<%=odto.getOrder_pname() %></a> 
							<br>
							<span style="font-size:0.9em;"> <%=pprice %> 원  |  <%=odto.getOrder_qty() %> 개 </span><br>
							<div class="order_btns">
								<input type="button" value="문의하기" onclick="location.href='inquiry_write.do?ono=<%=odto.getOrder_no()%>'"><br>
								<input type="button" value="리뷰쓰기">
							</div>
						</div>
					</div>
				<% }%>	
			
			</div>
				
			
			<div class="qna_table_bottom" align="right">
				<input class="btn" type="button" value="목록" onclick="location.href='order_list.do'">
					<input class="btn" type="button" value="삭제" onclick="if(confirm('정말로 삭제하시겠습니까?')){
							location.href='order_delete.do?ogno=<%=ogno %>';
					}else{ return; }">
			</div>
		</div><!-- class="order_cont" -->
		
		
		
		
		</div><!-- class="mypage_main" end  -->
	
	</div><!-- class="mypage_container" end -->
	<%@include file="../include/user_bottom.jsp" %>
</body>
</html>