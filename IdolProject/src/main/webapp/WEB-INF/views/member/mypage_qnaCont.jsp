<%@page import="com.idol.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	
	.qna_cont, .qna_reply{
		padding: 20px 30px;
	}
	
	.qnaCont_table .qnaCont_contTD{
		padding: 15px 20px;
		height:130px
	}
	
	.inquiry_img {
		display: flex;
	}
	
	.inquiry_img .img_item{
	
		width:100px;
		height:100px;
		margin: 5px;
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
	
	.qna_reply_title{
	
		padding:20px;
		font-size: 2em;
		font-weight: bold;
	}

</style>


<script type="text/javascript">



</script>
</head>
<body>
	<c:set var="dto" value="${loginInfo }"/> <!--로그인회원 정보 저장 -->
	<c:set var="cont" value="${Cont }"/>
	<c:set var="Img" value="${Img }"/> <!-- 문의글 첨부파일 배열 -->
	<c:set var="page" value="${page }"/>
	<c:set var="reply" value="${Reply }"/> <!-- 답변글 -->
	<c:set var="pCont" value="${pCont }"/> <!-- 제품 정보 -->
	
	<%@include file="../include/user_top.jsp" %>
	<div class="mypage_container">
		
		<!-- aisde inlcude 추가  -->
		<jsp:include page="../include/mypage_aside.jsp"/>
		
		<div class="mypage_main">
		<div class="manage_top">
		고객문의 내용
		</div>
		<br>
			<div class="qna_cont">
			<table class="qnaCont_table">
				<tr>
					<th>작성자</th>
					<td>${cont.getInquiry_userid()}</td>
				</tr>
				<tr>
					<c:if test="${empty cont.getInquiry_update()}">
					<th>등록일</th>
					<td>
						${cont.getInquiry_date().substring(0,10)}
					</td>
					</c:if>
					<c:if test="${!empty cont.getInquiry_update() }">
					<th>등록일<br>수정일</th>
					<td>
						${cont.getInquiry_date().substring(0,10)}<br>
						${cont.getInquiry_update().substring(0,10)}
					</td>
					
					</c:if>
				</tr>
				<tr>
					<th>상품 정보</th>
					<td>
					<c:if test="${cont.getProduct_no() != 0 }"> <!-- 제품 정보가 있는경우 -->
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
					<th>답변상태</th> <!-- 관리자 답변 달으면 답변대기 수정 필요!!! -->
					
					<c:if test="${cont.getInquiry_status() == 0 }">
						<td><span style="color:#ff5722;">답변대기</span></td>
						</c:if>
						<c:if test="${cont.getInquiry_status() == 1 }">
						<td>답변완료</td>
						</c:if>
					
				</tr>
				<tr>
					<th>제목</th>
					<td>${cont.getInquiry_title() }</td>
				</tr>
				<tr class="qnaCont_contTR">
					<!-- <th>내용</th> -->
					<td colspan="2" class="qnaCont_contTD">
					<% pageContext.setAttribute("replaceChar", "\n"); %>
						<p>
						<c:set var="content" value="${fn:replace(cont.getInquiry_cont(), replaceChar, '<br>') }"/>
				  		${content }
						</p>
					</td>
				</tr>
				<tr>
					<th>파일</th>
					<td>
					<div class="inquiry_img">
						<c:if test="${!empty Img }">
							<c:forEach items="${Img }" var="i">
							<div class="img_item"> 
								<img src="./resources/upload/inquiry_board/${i }" alt="inquiry_image" onclick="window.open(this.src)">						
							</div>
							</c:forEach>
						</c:if>
						<c:if test="${empty Img }">
							<span>첨부파일 없음</span>
						</c:if>
					</div>
					</td>
				</tr>
			</table>
			<div class="qna_table_bottom" align="right">
				<input class="btn" type="button" value="목록" onclick="location.href='inquiry_list.do?page=${page}'">
					<input class="btn" id="reviseBtn" type="button" value="수정" onclick="location.href='inquiry_update.do?no=${cont.getInquiry_no()}&page=${page}'">
					<input class="btn" type="button" value="삭제" onclick="if(confirm('정말로 삭제하시겠습니까?')){
							location.href='inquiry_delete.do?no=${cont.getInquiry_no()}';
					}else{ return; }">
			</div>
		</div><!-- class="qna_cont" -->
		
		<!-- 답변이 있는 경우 -->
		
		<c:if test="${!empty reply }">
		<div class="qna_reply">
		<div class="qna_reply_title">
		A.
		</div>
			<table class="qnaCont_table">
				<tr>
					<td>
						답변 날짜 : ${reply.getInquiry_date().substring(0,10) }
					</td>
				</tr>
				<tr>
					<td colspan="2" class="qnaCont_contTD">
					<c:set var="admin_reply" value="${fn:replace(reply.getInquiry_cont(), replaceChar, '<br>') }"/>
						<p>${admin_reply }</p>
					</td>
				</tr>
			</table>
		</div><!-- class="qna_reply" -->
		</c:if>
		
		<script type="text/javascript">
		
			var reply = "<c:out value='${Reply}'/>";
			
			console.log("reply:"+reply);
			console.log("typeof:" + typeof reply)
			if(reply != ""){
				
				$("#reviseBtn").hide();
			}
		
		</script>
		
		
		</div><!-- class="mypage_main" end  -->
	
	</div><!-- class="mypage_container" end -->
	<%@include file="../include/user_bottom.jsp" %>
</body>
</html>