<%@page import="com.idol.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지> 문의글 작성</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="./resources/js/member.js"></script>
<link rel="stylesheet" href="./resources/css/member.css?v=2022063010">
<style type="text/css">
	
	.qnaCont_table input{
		padding: 5px 8px;
		border:none;
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
	
	.search_btn{
	
		    margin-left: 10px;
    padding: 5px 10px;
    border-radius: 20px;
    background-color: white;
    border: 1px solid #2a3a52;
    color: #2a3a52;
    cursor: pointer;
	}

</style>


<script type="text/javascript">



</script>
</head>
<body>
	<c:set var="dto" value="${loginInfo }"/> <!--로그인회원 정보 저장 -->
	<c:set var="category" value="${cList }"/> <!-- 문의게시글 카테고리 리스트 -->
	<c:set var="pCont" value="${pCont }"/> <!-- 제품정보 -->
	<c:set var="ono" value="${ono }"/><!-- 주문번호  -->
	
	<script type="text/javascript">
	
		
	</script>
	
	<%@include file="../include/user_top.jsp" %>
	
	<div class="mypage_container">
		
		<!-- aisde inlcude 추가  -->
		<jsp:include page="../include/mypage_aside.jsp"/>
		
		<div class="mypage_main">
		<div class="manage_top">
		고객문의 글 작성
		</div>
		<br>
		
			<form method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/inquiry_write_ok.do">
			<c:if test="${!empty ono }"><input type="hidden" name="order_no" value="${ono }"></c:if>
			<table class="qnaCont_table">
				<tr>
					<th>작성자</th>
					<td><input name="inquiry_userid" value="${dto.getMember_id()}" readonly></td>
				</tr>
				<tr>
					<th>상품 정보</th>
					<td>
					
					<c:if test="${!empty pCont }">
					<input name="product_name" value="${pCont.getProduct_name() }" size="20"> <!-- 상품정보 있는 경우 상품 이름이 들어가기 -->
					<input type="hidden" name="product_no" value="${pCont.getProduct_no() }">
					</c:if>
					
					<c:if test="${empty pCont }">
					<input name="product_name" size="20"> <!-- 상품정보 있는 경우 상품 이름이 들어가기 -->
					</c:if>
					<c:if test="${!empty ono }">
					<button class="search_btn" type="button" class="product_search" disabled="disabled" style="background-color:#ececec; color:white; border:#ececec; cursor:auto;"
					onclick="window.open( '<%=request.getContextPath()%>/inquiry_product.do', '', 'width=500,height=400, scrollbars=yes,directories=no') ">
					상품 검색
					</button>
					</c:if>
					<c:if test="${empty ono }">
					<button class="search_btn" type="button" class="product_search" 
					onclick="window.open( '<%=request.getContextPath()%>/inquiry_product.do', '', 'width=500,height=400, scrollbars=yes,directories=no') ">
					상품 검색
					</button>
					</c:if>
					</td>
				</tr>
				<tr>
					<th>분류</th>
					<td>
					<c:if test="${!empty cList }">
					<select name="category_inofk">
						<c:forEach items="${category }" var="c">
						<option value=${c.getCategory_ino() }> ${c.getCategory_iname() }</option>
						</c:forEach>
					</select>
					</c:if>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input name="inquiry_title"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="10" cols="50" name="inquiry_cont"></textarea>
					</td>
				</tr>
				<tr>
					<th>파일</th>
					<td><input type="file" name="file1" multiple="multiple"></td>
				</tr>
			</table>
			<div class="qna_table_bottom" align="right">
				<input class="btn" type="submit" value="확인">
				<input class="btn" type="reset" value="새로고침">
			</div>
		</form>		
		
		
		</div><!-- class="mypage_main" end  -->
	
	</div><!-- class="mypage_container" end -->
	<%@include file="../include/user_bottom.jsp" %>
</body>
</html>