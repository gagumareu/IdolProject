<%@page import="com.idol.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지> 문의글 수정</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="./resources/js/member.js"></script>
<link rel="stylesheet" href="./resources/css/member.css?v=2022063010">
<style type="text/css">
	
	/* ***********마이페이지 회원정보관리************* */
	
	.qna_cont, .qna_reply{
		padding: 20px 30px;
	}
	
	.qna_cont table, .qna_reply table{
		width: 100%;
	}
	
	.qnaCont_table input , .qnaCont_table textarea{
	
		padding: 5px;
		font-size:1em;
	}
	
	
	.inquiry_img {
		display: flex;
	}
	
	.inquiry_img .img_item{
	
		width:100px;
		height:100px;
	}
	
	.img_item img{
		width:100%;
		height:100%;
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
	


</style>


<script type="text/javascript">



</script>
</head>
<body>
	<c:set var="dto" value="${loginInfo }"/> <!--로그인회원 정보 저장 -->
	<c:set var="cont" value="${Cont }"/>
	<c:set var="page" value="${page }"/>
	<c:set var="pCont" value="${pCont }"/> <!-- 제품 정보 -->
	
	
	
	<%@include file="../include/user_top.jsp" %>
	<div class="mypage_container">
		
		<!-- aisde inlcude 추가  -->
		<jsp:include page="../include/mypage_aside.jsp"/>
		
		<div class="mypage_main">
		<div class="manage_top">
		고객문의 내용 수정
		</div>
		<br>
			<div class="qna_cont">
			<form method="post" action="<%=request.getContextPath() %>/inquiry_updateOk.do"
			  enctype="multipart/form-data">
			  <input type="hidden" name="inquiry_no" value="${cont.getInquiry_no() }"> 
			  <input type="hidden" name="inquiry_image" value="${cont.getInquiry_image() }"> 
			  <input type="hidden" name="inquiry_userid" value="${cont.getInquiry_userid() }"> 
			  <input type="hidden" name="page" value="${page}"> 
			
			<table class="qnaCont_table">
				<tr>
					<th>작성자</th>
					<td>${cont.getInquiry_userid()}</td>
				</tr>
				<tr>
					<th>상품 정보</th>
					<td>
					<c:if test="${cont.getProduct_no() != 0 }">
							${pCont.getProduct_name() }
					</c:if>
					</td>
				</tr>
				<tr>
					<th>분류</th>
					<td>
					<c:choose>
							<c:when test="${cont.getCategory_inofk() == 1 }">취소/환불</c:when>						
							<c:when test="${cont.getCategory_inofk() == 2 }">상품문의</c:when>						
							<c:when test="${cont.getCategory_inofk() == 3 }">배송</c:when>						
							<c:when test="${cont.getCategory_inofk() == 4 }">교환</c:when>						
							<c:when test="${cont.getCategory_inofk() == 5 }">기타</c:when>						
					</c:choose>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input name="inquiry_title" value="${cont.getInquiry_title() }" autofocus="autofocus"></td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea name="inquiry_cont" rows="10" cols="50"> ${cont.getInquiry_cont() }</textarea>
					</td>
				</tr>
				<tr>
					<th>파일</th>
					<td>
						<input type="file" name="file2" multiple="multiple" style="padding:0; font-size:0.9em;margin-top:5px;"><br>
						<span style="font-size:0.9em;"> 업로드된 파일 : ${cont.getInquiry_image() }</span> 
						
					</td>
				</tr>
			</table>
			<div class="qna_table_bottom" align="right">
				<input class="btn"  type="submit" value="수정" onclick="location.href='inquiry_update.do?no=${cont.getInquiry_no()}&page=${page}">
					<input  class="btn" type="button" value="뒤로가기" onclick="location.href='inquiry_cont.do?no=${cont.getInquiry_no()}&page=${page}'">
			</div>
			
			</form>
		</div><!-- class="qna_cont" -->
		
		
		
		
		</div><!-- class="mypage_main" end  -->
	
	</div><!-- class="mypage_container" end -->
	<%@include file="../include/user_bottom.jsp" %>
</body>
</html>