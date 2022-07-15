<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디, 비밀번호 찾기 결과</title>
<link rel="stylesheet" href="./resources/css/member.css?v=2022062113">
<style type="text/css">
	body{
 		background-color: #f2f2f2;
 	}
 	
 	.result_cont{
 	
 		margin:30px 0;
 		font-size: 1.2em;
 	}
 	
 	.result_cont span{
 		color:#3f51b5;
 		text-decoration: underline;
 	}
 	
 	.find_bottom{
 		margin-top:30px
		margin-bottom:40px;
		width:60%
	}
	
	.find_bottom table{
		width: 100%;
		font-size : 1.1em;
		text-align: center;
		
	}
	
	.find_bottom table td{
		padding: 0 15px;
	}
 	
</style>
</head>
<body>

	<%
		String find = (String)request.getAttribute("find");
		String result = (String)request.getAttribute("result");
		
	%>
	
	<c:if test="${find == 'id' }">
		<c:set var="word" value="아이디"/>
	</c:if>
	<c:if test="${find == 'pwd' }">
		<c:set var="word" value="비밀번호"/>
	</c:if>
	
<%@include file="../include/user_top.jsp" %>	
	<div class="login_wrapper" align="center">
	<div class="lojo_container">
	<div class="lojo_title">
		<span>ID/PWD 찾기 결과</span>
		</div>
	
		<div class="lojo_body">
		
		<div class="result_cont">
			회원님의 ${word }는 <span>${result }</span> 입니다.
		</div>
		
		<div class="find_bottom">
			<table>
				<tr>
					<td style="border-right: 1px solid #e0dfdf;">
					<a href="<%=request.getContextPath()%>/login.do">로그인</a>
					</td>
					<td>
					<c:if test="${find == 'id' }">
					<a href="<%=request.getContextPath()%>/findIdPwd.do">비밀번호찾기</a>
					</c:if>
					<c:if test="${find == 'pwd' }">
					<a href="<%=request.getContextPath()%>/">메인화면</a>
					</c:if>
					</td>
				</tr>
			</table>
		</div>
		
		
		
		</div><!--  class="lojo_body" end-->
		
	</div><!-- class="lojo_container" end -->
	</div>
<%@include file="../include/user_bottom.jsp" %>
</body>
</html>