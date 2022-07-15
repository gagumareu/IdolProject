<%@page import="java.text.DecimalFormat"%>
<%@page import="com.idol.model.OrderDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.idol.model.ProductDTO"%>
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
<title>마이페이지> 주문내역 날짜조회 결과</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="./resources/js/member.js"></script>
<link rel="stylesheet" href="./resources/css/member.css?v=2022063010">
<style type="text/css">
	
	
	
	.order_list{
	   margin-top:50px;
	   margin-bottom:10px;
       border: 1px solid #e0dfdf;
       border-radius: 10px;
       padding: 20px;
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
		border: 1px solid #8b8989;
	}
	
	.order_item .order_info{
		line-height: 1.5;
		width: 70%;
	}
	
	.order_btns input{
		margin: 2px;
    width: 100px;
    height: 33px;
    border-radius: 5px;
    background-color: white;
    border: 1px solid #2a3a52;
    cursor: pointer;
	}
	
	#load{
		display:none;
		
		margin: 30px auto 0;
    width: 100%;
    text-align: center;
    cursor: pointer;
    height: 60px;
    line-height: 60px;
    text-align: center;
    color: #2f2d43;
    font-size: 16px;
    border-top: 1.5px solid #d9d8de;
	}


</style>


<script type="text/javascript">



</script>
</head>
<body>
	<c:set var="dto" value="${loginInfo }"/> <!--로그인회원 정보 저장 -->
	<c:set var="list" value="${dateMap }"/>
	
	<%@include file="../include/user_top.jsp" %>
	<div class="mypage_container">
		
		<!-- aisde inlcude 추가  -->
		<jsp:include page="../include/mypage_aside.jsp"/>
		
		<div class="mypage_main" >
		<div class="manage_top">
		 주문내역 날짜조회
		</div>

 		<form method="post" action="<%=request.getContextPath() %>/order_date.do">
		<div class="qna_month" align="center">
			<table>
				<tr>
					<td>
						<div class="month_area">
							<ul>
								<li class="quick_search" id="0"><label for="MONTH0"><input id="MONTH0" type="radio" name="search_date" value="0" >오늘</label></li>
								<li class="quick_search" id="7"><label for="MONTH0.25"><input id="MONTH0.25" type="radio" name="search_date" value="7">1주일</label></li>
								<li class="quick_search" id="1"><label for="MONTH1"><input id="MONTH1" type="radio" name="search_date" value="1">1개월</label></li>
								<li class="quick_search" id="3"><label for="MONTH3"><input id="MONTH3" type="radio" name="search_date" value="3">3개월</label></li>
								<li class="quick_search" id="6"><label for="MONTH6"><input id="MONTH6" type="radio" name="search_date" value="6">6개월</label></li>
								<li class="quick_search" id="12"><label for="MONTH12"><input id="MONTH12" type="radio" name="search_date" value="12">1년</label></li>
							</ul>
						</div>
					</td>
					<td><input type="submit" value="조회"></td>
				</tr>
			</table>
		</div>
		</form>
		<script type="text/javascript">
			
		$(document).ready(function(){
			
			
			
			var preValue='<c:out value='${search_date}'/>';
			var count =0;
			
			console.log(preValue);
			console.log(typeof preValue);
			
			if(preValue != null){
				
				$("#"+preValue).css('background-color','#e9e3e1');
				count = 1;
			}
			
			$("input[name='search_date']").click(function(){
				
				var check = String($(this).val());
				
				
					$("#"+check).css('background-color','#e9e3e1');
					$("#"+preValue).css('background-color', 'white');
					preValue = String($(this).val());
				
				
			
			});
			
			
		});
		
		</script>
		
		<form id="frm">
		<div class="order_main">

			<c:if test="${!empty dateMap }">
		<%
			HashMap<String, List> map = (HashMap<String, List>)request.getAttribute("dateMap");
			List<String> dates = (List<String>)request.getAttribute("dates");
			
			for(int i=0; i<dates.size(); i++){//map과 date 사이즈 같음
				
				String date = dates.get(i);//날짜
				List list = map.get(i);//날짜에 해당하는 구매리스트를 담은 리스트 (ex. 0916구매 총 6건 )
		%>		
			<div class="order_list">
				<h3><%=date %></h3>
				
				<% 		//구매리스트 for문
						int group =0;//구매 group 구분지을 변수
						
				for(int j=0; j< list.size(); j++){
					
					OrderDTO dto = (OrderDTO)list.get(j);
					
					DecimalFormat format = new DecimalFormat("###,###");
					int order_price = dto.getOrder_qty()*dto.getOrder_pprice();
					String price = format.format(order_price);//실제 구매한 가격 (제품가격*구매수량)
					
					if(j == 0){
						group = dto.getOrder_group();
					}
					
					System.out.println("dto group:"+dto.getOrder_group());
					System.out.println("group:"+group);
					System.out.println("no"+dto.getOrder_no());
					
					if(dto.getOrder_group() == group ){ %>
				<div class="order_item">

					<div class="order_photo">
						<img src="./resources/upload/product/<%=dto.getOrder_pimage()%>">
					</div>
					<div class="order_info">
						<!-- 주문 날짜 -->
						<span style="font-size: 13px; color: gray;"> <%=dto.getOrder_date().substring(0, 10)%>
						</span> <br> 
						<!-- 주문 제품 <br> 주문수량 | 주문가격 -->
						<a href="<%=request.getContextPath()%>/orderlist_cont.do?ogno=<%=dto.getOrder_group()%>">
						<span style="font-weight: bold;">
							<%=dto.getOrder_pname()%>
						</span>
						</a>
						<br> 
						
						<span style="font-size: 0.9em;"><%=dto.getOrder_qty()%>개 </span>| 
						<span style="font-size: 0.9em;"> <%=price%>원 </span>
					</div>
					
					<div class="order_btns">
					   <input type="button" value="문의하기" onclick="location.href='inquiry_write.do?ono=<%=dto.getOrder_no()%>'"><br>
					   <input type="button" value="리뷰쓰기">
					</div>
				</div> <!-- class="order_item" -->


				<% 			}else{
				%>
						<hr color="#e0dfdf">	
						<div class="order_item">

							<div class="order_photo">
								<img
									src="./resources/upload/product/<%=dto.getOrder_pimage()%>">
							</div>
							<div class="order_info">
								<span style="font-size: 13px; color: gray;"> <%=dto.getOrder_date().substring(0, 10)%>
								</span> <br> 
								<a href="<%=request.getContextPath()%>/orderlist_cont.do?ogno=<%=dto.getOrder_group()%>">
								<span style="font-weight: bold;">
									<%=dto.getOrder_pname()%></span></a>
								<br> 
								<span
									style="font-size: 0.9em;"><%=dto.getOrder_qty()%>개 </span>| <span
									style="font-size: 0.9em;"> <%=price%>원
								</span>
							</div>
							<div class="order_btns">
								<input type="button" value="문의하기" onclick="location.href='inquiry_write.do?ono=<%=dto.getOrder_no()%>'"><br>
								<input type="button" value="리뷰쓰기">
							</div>
							</div> <!-- class="order_item" -->

				<%
						group++;
				}//if - else%>
							
							
				<%		}//날짜별 구매리스트 for문
				%>		
				</div> <!-- class=" "order_list" -->
			<% 		}//바깥 map.size  for문%>
					
			</c:if>
		</div>	<!-- class="order_main"  -->
		<br><br>
		<div id="load">더 보기 +</div>
 	 		<!-- <a href="#" id="load">더 보기 +</a>  -->
		<!-- <div id="more_btn_div" align="center">
			
			<a id="more_btn_a" href="javascript:moreContent('order_item', 6)"> 더보기(more)</a>
		</div> -->
		</form>
	
		
		
		
 	<script type="text/javascript">
			
 	$(function(){
 		let count =0;
 		let point =0;
 		let order_list  = document.getElementsByClassName('order_list');
 		let length = order_list.length;
 		
 		for(let i=1; i<length; i++){//맨처음리스트 빼고 다 숨김
 			
 			order_list[i].style.display='none';
 			count++;
 		}
 		
 		if(length >1){

 			$("#load").show();
 			
 			 $("#load").click(function(e){
 				 e.preventDefault();
 				 point +=1 ;
 				 
 				 order_list[point].style.display='block';
 				 count--;
 				 
 				if(count == 0){
					 
					 alert('마지막 내역입니다.');
					 $("#load").hide();
				 }
 	 			
 				 
 			 });
 		}
 		
 	});
 	
 	
 	
 	
			/* let order_list  = document.getElementsByClassName('order_list');
			let length = order_list.length;
			
				
				order_list[0].style.display ='none';
				console.log('display none'); */
			
		</script> 
		
	
		
		
		</div><!-- class="mypage_main" end -->
	
	</div><!-- class="mypage_container" end -->
	<%@include file="../include/user_bottom.jsp" %>
</body>
</html>