<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	
	a{
		text-decoration:none;
		color: black;
	}
	
	.wrapper	{
		margin: -8px;
		background-color: #EEEEEE;
		font-family: NotoSans Kor;
	}
	
	.used_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
		width: 65%;
		text-align: left;
		font-size: 12px;
	}
	
	.used_notice{
		background-color: #FFFFFF;
		padding: 10px 20px;
		min-height: 100px;
		margin: 30px 0 30px 0;
		border: 1px solid #CCCCCC;
	}
	
	.used_flex_wrapper {
		flex: 1;
		margin: 20px 0 30px 0;
		border: 1px solid #CCCCCC;
		background-color: #FFFFFF;
	}
	
	.title {
		height: 130px;
		padding: 15px;
	}
	
	.used_cont {
		padding: 30px 20px;
	}
	
	.used_flex_row{
		display: flex;
		flex-direction: row;
	}
	
	.used_comment_icon{
		width: auto;
	}
	.icon{
		width: 30px;
		height: 30px;
		border-radius: 70%;
		overflow: hidden;
	}
	
	.used_comment{
		flex: 30;
	}
	
	.used_left{
		flex: 1;
		text-align: left;
	}
	
	.used_right{
		flex: 1;
		text-align: right;
	}
	
	.used_comment_head{
		background-color: #EEEEEE;
		padding: 10px;
	}
	
	.used_comment_flex_row{
		display: flex;
		flex-direction: row;
		padding: 10px;
	}
	
	.used_comment_cont{
		padding: 10px;
	}
	
	.used_comment_bottom{
		background-color: #EEEEEE;
		height: 30px;
	}
	
	.used_comment_write{
		border-bottom: 1px solid #CCCCCC;
	}
	
	button.gray{
		background-color: #EEEEEE;
		width: 40px;
		height: 50px;
		border: 0;
		font-weight: bold;
	}
	
	button.white{
		background-color: #FFFFFF;
		width: 100%;
		height: 102%;
		font-weight: bold;
		font-size: 12px;
		color: red;
		border: 1px solid #EEEEEE;
	}
	
	input.white{
		border: 0;
		outline: none;
		width: 99%;
		font-size: 12px;
	}
	
	textarea{
		border: 0;
		outline: none;
		padding: 15px 10px;
	}
	
	th {
		background-color: #2A3A52; 
		color: white; 
		text-align: center;
		height: 30px;
	}
	
	td {
		padding: 0 20px;
	}
	
	select.navy{
		background-color: #2A3A52;
		color: white;
		padding: 5px;
		font-size: 12px;
	}
	
	button.navy{
		background-color: #2A3A52;
		color: white;
		padding: 5px 15px;
		font-size: 12px;
	}
	
	textarea{
		border: 0;
		outline: none;
		padding: 15px 10px;
	}
	
	input.red{
		width: 45px;
		color: red;
		border: solid 1px red;
		border-radius: 5px;
		font-size: 8px;
		padding: 0 0 0 2px;
	}
	
</style>
</head>
<body>
	<%@ include file="../include/user_top.jsp" %>
	<!-- include top 영역 -->
	
	<div class="wrapper" align="center">
		<c:set var="dto" value="${dto }" />
		<c:set var="id" value="${id }" />
		<div class="used_wrapper">
		
			<div class="used_category">
				<button class="gray" style="color:red;"
				onclick="location.href='<%=request.getContextPath() %>/used_list.do?id=${id }'">판매</button>
				<button class="gray">구매</button>
				<button class="gray">교환</button>
				<hr>
			</div>
			
			<div class="used_notice">
				<br><h3>YOUR CELEB 중고장터는 거래 안전지대가 아닙니다.<br>
				판매/구매 행위에 관하여 최대한 신중히 하셔야 되시며 반드시 만약의 경우를 대비해주세요.</h3>
			</div>
			
			<div class="used_flex_wrapper">
				<div class="title">
				
					<span style="color: red;">
						<c:if test="${dto.used_saltatus == 0}">판매</c:if>
						<c:if test="${dto.used_saltatus == 1}">완료</c:if>
					</span>
					<br>
					<h2>${dto.used_title }</h2>
					<br>
					
					<div class="used_flex_row">
						<div style="width: 30px; height: 30px; border-radius: 70%; overflow: hidden;">
							
							<c:forEach items="${mdtoList }" var="j">
								<c:if test="${j.member_id == dto.used_userid }">
									<c:if test="${j.member_image != null }">
										<img src="./resources/upload/member_image/${j.member_no }/${j.member_image }"
											width="100%" height="100%">
									</c:if>
									<c:if test="${j.member_image == null }">
										<img src="resources\\upload\\used/프사없음.jpeg"
											width="100%" height="100%">
									</c:if>
								</c:if>
							</c:forEach>
						</div>
						<div style="padding: 10px;">
							<b>${dto.used_userid }</b>&nbsp;&nbsp;조회수&nbsp;<b>${dto.used_hit }</b>&nbsp;&nbsp;
							댓글&nbsp;&nbsp;
							<c:set var="a" value="0" />
							<c:forEach items="${allCommentList }" var="j">
								<c:if test="${j.used_nofk == dto.used_no }">
									<c:set var="a" value="${a+1}" />
								</c:if>
							</c:forEach>
							${a }&nbsp;&nbsp;&nbsp;
							${dto.used_date }
						</div>
					</div>
					
				</div>
				
				<div class="table">
				
					<table border="1" cellspacing="0" width="100%">
				    	<tr>
				   			<th>제품명</th>
				    		<td>${dto.used_product}</td>
				    	</tr>
				    	
				    	<tr>
				   			<th>사이즈</th>
				    		<td>${dto.used_size }</td>
				    	</tr>
				    	
				    	<tr>
				   			<th>제품 상태</th>
				    		<td> 
				    			<c:if test="${dto.used_status == 0 }">중고품</c:if>
				    			<c:if test="${dto.used_status == 1 }">새상품</c:if>
				    		</td>
				    	</tr>
				    	
				    	<tr>
				   			<th>판매 가격</th>
				    		<td><fmt:formatNumber value="${dto.used_price }" /> 원</td>
				    	</tr>    
				    </table>
				</div>
				
				<div class="used_cont">
				<% pageContext.setAttribute("replaceChar", "\n"); %>
				<c:set var="content" value="${fn:replace(dto.used_cont, replaceChar, '<br>') }"/>
				  	${content }
				
					<c:set var="images" value="${Images }" />
					<c:forEach items="${images }" var="img">
						<img src="resources\\upload\\used/${img}"
								width="100%" height="100%" />
					</c:forEach>
					
				</div>

			</div>
			
			<div class="used_flex_row">
			
				<div class="used_left">
					<button class="navy" onclick="location.href='<%=request.getContextPath() %>/used_list.do?id=${id }&page=${page }'">목록으로</button>
				</div>
				
				<div class="used_right">
				
					<!-- if문 자신의 작성글이면 수정과 삭제가 보이게끔 (session이 가능해져야 될 것 같다.) -->
					
				</div>
				
			</div>
			
			<div class="used_flex_wrapper">
				<div class="used_comment_head">
					댓글&nbsp;
					<c:set var="a" value="0" />
					<c:forEach items="${allCommentList }" var="i">
						<c:if test="${i.used_nofk == dto.used_no }">
							<c:set var="a" value="${a+1 }" />
						</c:if>
					</c:forEach>
					<span style="color: green;">${a }</span>
				</div>
				
				<div class="used_comment">
				
					<c:forEach items="${comment_list }" var="i">
					
						<div class="used_comment_flex_row">
							<div class="used_comment_icon">
								<div class="icon">
									<c:forEach items="${mdtoList }" var="j">
										<c:if test="${j.member_id == i.comment_writer }">
											<c:if test="${j.member_image != null }">
												<img src="./resources/upload/member_image/${j.member_no }/${j.member_image }"
													width="100%" height="100%">
											</c:if>
											<c:if test="${j.member_image == null }">
												<img src="resources\\upload\\used/프사없음.jpeg"
													width="100%" height="100%">
											</c:if>
										</c:if>
									</c:forEach>
								</div>
							</div>
							<div class="used_comment">
								<div class="used_comment_flex_row">
									<div class="used_left">
										${i.comment_writer } &nbsp;&nbsp; <span style="color:lightgray">${i.comment_date.substring(0,16) }</span>
										&nbsp;&nbsp; <c:if test="${i.comment_writer == dto.used_userid }"><input class="red" type="text" value="글 작성자"></c:if>
										
									</div>
									
									<div class="used_right">
										<a href="<%=request.getContextPath() %>/used_comment_comment.do?no=${i.comment_no }&id=${id}&page=${page }">답글</a>
										&nbsp;&nbsp;
										
										<c:if test="${i.comment_writer == id }">
											<a href="<%=request.getContextPath() %>/used_comment_modify.do?no=${i.comment_no }&page=${page }">수정</a>
											&nbsp;&nbsp;
											
											<a onclick="if(confirm('정말로 삭제하시겠습니까?')){
												location.href='<%=request.getContextPath() %>/used_comment_delete.do?no=${i.comment_no }&nofk=${i.used_nofk }&id=${id}&page=${page }'}
												else{ return; }">삭제</a>
										</c:if>
									</div>
									
								</div>
								
								<div class="used_comment_cont">
									${i.comment_cont }
								</div>
								
							</div>
						</div>
						
						<hr color="#EEEEEE">
					</c:forEach>
				</div>
				
				<div class="used_comment_bottom">
				
				</div>
			</div>
			
			<form class="used_flex_wrapper" method="post" action="<%=request.getContextPath() %>/used_comment_write.do">
				<input type="hidden" name="comment_writer" value="${login_id }">
				<input type="hidden" name="used_nofk" value="${dto.used_no }">
				<input type="hidden" name="category_unofk" value="${dto.category_unofk }">
				<input type="hidden" name="page" value="${page}">
				
				<div class="used_comment_write">
					<textarea rows="2" cols="140" name="comment_cont"></textarea>
				</div>
				<div style="text-align:right;">
					<button class="navy">댓글 달기</button>
				</div>
			</form>
		</div>
		
	</div>
	<%@include file="../include/user_bottom.jsp" %>
</body>
</html>