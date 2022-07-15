<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>


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
		margin: 30px 0 30px 0;
		border: 1px solid #CCCCCC;
	}
	
	.used_flex_row{
		display: flex;
		flex-direction: row;
	}
	
	.used_left{
		flex: 1;
		text-align: left;
	}
	
	.used_right{
		flex: 1;
		text-align: right;
	}
	
	.used_flex_wrapper {
		flex: 1;
		margin: 20px 0 30px 0;
	}
	
	.used_list {
		display: grid;
		grid-template-columns: 1fr 1fr 1fr 1fr;
		grid-gap: 10px;
	}
	
	.used_one {
		display: flex;
		flex-direction: column;
		background-color: #FFFFFF;
		border: 1px solid #CCCCCC;
	}
	
	.used_up {
		flex: 1;
		
	}
	
	.used_down {
		flex: 1;
		padding: 10px;
	
	}
	
	.used_member{
		display: flex;
		flex-direction: row;
		height: 30px;
	}
	.used_member_image {
		flex: 1;
		border-radius: 70%;
		overflow: hidden;
	}
	.used_member_id{
		flex: 6;
		padding: 5px 10px;
	}
	
	.used_comment_hit{
		text-align: right;
		color: gray;
	}
	
	button.gray{
		background-color: #EEEEEE;
		width: 40px;
		height: 50px;
		border: 0;
		font-weight: bold;
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
	
	input.keyword {
		height: 30px;
	}
	
</style>
</head>
<body>
	<%@ include file="../include/user_top.jsp" %>
	<!-- include top 영역 -->
	<div class="wrapper" align="center">
	
		<div class="used_wrapper">
		
			<div class="used_category">
				<button class="gray" style="color:red;"
				onclick="location.href='<%=request.getContextPath() %>/used_list.do">판매</button>
				<button class="gray">구매</button>
				<button class="gray">교환</button>
				<hr>
			</div>
		
			<div class="used_notice">
				<h3>플리마켓-판매</h3>
				동일 제품 중복 등록할 수 없습니다.<br><br>
			</div>
			
			<c:set var="list" value="${List }" />
	      	<c:set var="paging" value="${Paging }" />
	      	
			<div class="used_flex_row">
			
				<div class="used_left">
				
					<select class="navy">
						<option value="" selected>전체</option>
						<option value="">판매중</option>
						<option value="">완료</option>
					</select>
					&nbsp;
					<select class="navy">
						<option value="" selected>최신순</option>
						<option value="">조회순</option>
						<option value="">추천순</option>
						<option value="">댓글순</option>
					</select>
					
				</div>
				
				<script type="text/javascript">
				function loginAlert() {
				      alert("사용 권한이 없습니다. 로그인 해주세요");
				  } 
				</script>
				
				<div class="used_right">
					<c:if test="${login_id == null }">
					<button class="navy" onclick="loginAlert()">쓰기</button>&nbsp;&nbsp;
					</c:if>
					<c:if test="${!empty login_id }">
					<button class="navy" onclick="location.href='<%=request.getContextPath() %>/used_write.do?id=${loginInfo.member_id }'">쓰기</button>&nbsp;&nbsp;
					</c:if>
					<button class="navy" onclick="location.href='<%=request.getContextPath() %>/used_list.do?id=${loginInfo.member_id }'">목록</button><br><br>
					
					<form method="post" action="<%=request.getContextPath() %>/used_search.do">
				   	    <input type="hidden" name="page" value="${paging.getPage() }">
				   	  
					    <select class="navy" name="field">
						    <option value="title">제목</option>
						    <option value="cont">내용</option>
						    <option value="title_cont">제목+내용</option>
						    <option value="writer">작성자</option>
					    </select>
				      
				      	<input class="keyword" name="keyword">&nbsp;&nbsp;
				    	<button class="navy">검색</button>
					</form>
				</div>
				
			</div>
	      			
			<div class="used_flex_wrapper">
			
				<div class="used_list">
					
					<c:forEach items="${list }" var="i">
						<c:if test="${login_id == null }">
						  <a onclick="alert('읽기 권한이 없습니다.'); return false;">
						</c:if>
						<c:if test="${!empty login_id }">
						<a href="<%=request.getContextPath() %>/used_content.do?no=${i.used_no }&id=${loginInfo.member_id}&page=${paging.page }">
						</c:if>
						<div class="used_one" >
							
							<div class="used_up">
								<c:if test="${!empty i.used_image }">
								<img src="./resources/upload/used/${i.used_image }"
								width="100%" height="250px">
								</c:if>
								<c:if test="${empty i.used_image }">
								<img src="./resources/upload/used/noImage.png"
								width="100%" height="250px">
								</c:if>
							</div>
							
							<div class="used_down">
								
								<c:if test="${i.used_saltatus == 0 }">
									<c:if test="${i.category_unofk == 1}">
										<span style="color: blue;">판매,</span>
									</c:if>
									<c:if test="${i.category_unofk == 2}">
										<span style="color: blue;">구매,</span>
									</c:if>
									<c:if test="${i.category_unofk == 3}">
										<span style="color: blue;">교환,</span>
									</c:if>
								</c:if>
								<c:if test="${i.used_saltatus == 1}">
									<span style="color: blue;">완료,</span>
								</c:if>
								&nbsp;&nbsp;&nbsp;
								<span style="color: gray;">${i.used_date.substring(0, 10) }</span>
								<br><br>
								<b>${i.used_title }</b>
								<br><br>
								사이즈 : ${i.used_size }
								<br>
								제품 상태 : <c:if test="${i.used_status == 0}">중고품</c:if>
								<c:if test="${i.used_status == 1}">새상품</c:if>
								<br>
								판매 가격 : <fmt:formatNumber value="${i.used_price }"/>원
								<br><br>
								
								<div class="used_member">
									<div class="used_member_image">
										<c:forEach items="${mdtoList }" var="j">
											<c:if test="${j.member_id == i.used_userid }">
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
									
									<div class="used_member_id">
										${i.used_userid }
									</div>
								</div>
								
								<div class="used_comment_hit">
									<img src="./resources/upload/used/comment_icon.png"
													width="12" height="12">
													
									<c:set var="a" value="0" />
									<c:forEach items="${commentList }" var="j">
										<c:if test="${j.used_nofk == i.used_no }">
											<c:set var="a" value="${a+1}" />
										</c:if>
									</c:forEach>
									${a }
									
									<img src="./resources/upload/used/hit_icon.png"
													width="15" height="12">
									${i.used_hit }
								</div>
							</div>
							
						</div>
						</a>
			        </c:forEach>
					
					<!-- /foreach 문 -->
					
				</div>
				
			</div>
			
			<div class="used_flex_wrapper" style="text-align: center;">
				<%-- 페이징 처리 부분 --%>
			   <c:if test="${paging.getPage() > paging.getBlock() }">
			      <a href="used_list.do?page=1">[처음으로]</a>
			      <a href="used_list.do?page=${paging.getStartBlock() - 1 }">◀</a>
			   </c:if>
			   
			   <c:forEach begin="${paging.getStartBlock() }"
			          				end="${paging.getEndBlock() }" var="i">
			      <c:if test="${i == paging.getPage() }">
			         <b> <a href="used_list.do?page=${i }">[${i }]</a></b>
			      </c:if>
			   
			   	  <c:if test="${i != paging.getPage() }">
			         <a href="used_list.do?page=${i }">[${i }]</a>
			      </c:if>
			   </c:forEach>
		
			   <c:if test="${paging.getEndBlock() < paging.getAllPage() }">
			      <a href="used_list.do?page=${paging.getEndBlock() + 1 }">▶</a>
			      <a href="used_list.do?page=${paging.getAllPage() }">[마지막으로]</a>
			   </c:if>
			</div>
			
		</div>
		
	</div>
	<%@include file="../include/user_bottom.jsp" %>
</body>
</html>