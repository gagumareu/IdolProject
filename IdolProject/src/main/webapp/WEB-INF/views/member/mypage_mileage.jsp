<%@page import="com.idol.model.MileageDTO"%>
<%@page import="java.text.DecimalFormat"%>
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
<title>마이페이지> 마일리지 내역</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="./resources/js/member.js"></script>
<link rel="stylesheet" href="./resources/css/member.css?v=2022063010">


<style type="text/css">
	
	.mileage_list{
	   margin-top:50px;
	   margin-bottom:10px;
       border: 1px solid #e0dfdf;
       border-radius: 10px;
       padding: 20px;
	}
	
	.mileage_item{
		display: flex;
		padding:20px 10px;
	}
	
	.mileage_circle{
		border-radius: 50%;
		width:90px;
		height:90px;
		text-align: center;
		margin-right: 30px;
		
	}
	
	.deduct{
		border:2px solid #d95555;
		color:#d95555;
	}
	
	.add{
		border:2px solid #39c934;
		color:#39c934;
	}
	
	.deduct span, .add span{
		display: block;
	    font-size: 1.1em;
 	  font-weight: bold;
  	  margin-top: 28px;
	}
	
	.mileage_info>span:first-of-type{
		font-size:0.9em;
		color:#868484;
	}
	
	.mileage_amount{
		width:70px;
		margin-top:20px;
		text-align: right;
	}
	
	.deduct_state{
		color:#d95555;
	}
	
	.add_state{
		color:#39c934;
	}
	
	.mileage_amount>span:last-of-type{
		font-size:0.85em;
		color:rgba(132,132,132,0.5);
	}
	
	.mileage_amount input{
		margin-top:5px;
		color: #a5a5a5;
		border: 1px solid #d5d8dc;
		background-color:white;
		padding:1px 4px;
		
		cursor: pointer;
	}
	
	
	.mileage_item a:hover{
		text-decoration: underline;
	}
	
	.mileage_item .mileage_info{
		line-height: 1.5;
		width: 70%;
		margin-top:20px;
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
	<c:set var="list" value="${mileage }"/>
	
	<%@include file="../include/user_top.jsp" %>
	<div class="mypage_container">
		
		<!-- aisde inlcude 추가  -->
		<jsp:include page="../include/mypage_aside.jsp"/>
		
		<div class="mypage_main" >
		<div class="manage_top">
		마일리지 내역
		</div>

 		<%-- <form method="post" action="<%=request.getContextPath() %>/mileage_date.do">
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
				
				var preValue=0;
				var count =0;
				
				$("input[name='search_date']").click(function(){
					
					if(count >=1){
						$("#"+check).css('background-color','#e9e3e1');
						$("#"+preValue).css('background-color', 'white');
						preValue = String($(this).val());
					}
					
					var check = String($(this).val());
					preValue = String($(this).val());
					
					console.log("preValue:"+preValue);
					
					$("#"+check).css('background-color','#e9e3e1');
					
					count ++;
				
				});
				
				
			});
		
		</script> --%>
		
		<form id="frm">
		<div class="order_main">

			<c:if test="${!empty list }">
			<div class="mileage_list" >
		<%
			List<MileageDTO> mileage = (List<MileageDTO>)request.getAttribute("mileage");
		
			int amount =0; //마일리지 금액
			String amountF = ""; //마일리지 금액 포맷
			String state="";
			
			DecimalFormat format = new DecimalFormat("###,###");
			
			for(int i=0; i<mileage.size(); i++){
				
				MileageDTO dto = mileage.get(i);
				
				//남은 마일리지금액
				String remain = format.format(dto.getMileage_remaining());
				
		%>			
				
				<div class="mileage_item" >
		<% 
					if(dto.getMileage_earn() > 0){ //얻은 마일리지 내역이 있다면 
						amount = dto.getMileage_earn();
						amountF ="+"+format.format(amount);
						state="add_state";
		%>
					<div class="mileage_circle add state">
						<span class="add_mileage">적립</span>
					</div>
		<%			}else if(dto.getMileage_deduction() >0){//차감된 마일리지가 있다면 
						amount = dto.getMileage_deduction();
						amountF ="-"+format.format(amount);
						state="deduct_state";
		%>
					<div class="mileage_circle deduct">
						<span>사용</span>
					</div>
		<%		} %>
					
					<div class="mileage_info">
						<span><%=dto.getMileage_date().substring(0,10) %></span><br>
						<span><%=dto.getMileage_type() %></span>
					</div>
					
					<div class="mileage_amount">
						<span class="<%=state%>"><%=amountF%>원</span> <br>
						<span ><%=remain%>원</span>
					<!-- 	<input type="button" value="내역삭제"> -->
					</div>
				</div><!-- class="mileage_item" -->
				
				
				
		<% 	} //for문 %>		
		
			</div><!-- class="mileage_list" -->		
			</c:if>
		</div>	<!-- class="order_main"  -->
		<br><br>
		<div id="load">더 보기 +</div>
		</form>
	
		
		
		
 	<script type="text/javascript">
			
 	$(function(){
 		let count =0;
 		let point =0;
 		let item  = document.getElementsByClassName('mileage_item');
 		let length = item.length;
 		
 		for(let i=1; i<length; i++){//맨처음리스트 빼고 다 숨김
 			
 			item[i].style.display='none';
 			count++;
 		}
 		
 		if(length >1){

 			$("#load").show();
 			
 			 $("#load").click(function(e){
 				 e.preventDefault();
 				 point +=1 ;
 				 
 				 item[point].style.display='flex';
 				 count--;
 				 
 				if(count == 0){
					 
					 alert('마지막 내역입니다.');
					 $("#load").hide();
				 }
 	 			
 				 
 			 });
 		}
 		
 	});
 	
		</script> 
		</div><!-- class="mypage_main" end -->
	</div><!-- class="mypage_container" end -->
	<%@include file="../include/user_bottom.jsp" %>
</body>
</html>