<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
<link rel="stylesheet" href="./resources/css/member.css?v=2022062117">
<style type="text/css">
 	body{
 		background-color: #f2f2f2;
 	}
 	
</style>
</head>
<body>
	<%@include file="../include/user_top.jsp" %>
	<div class="login_wrapper" align="center">
		
		<div class="lojo_container">
		<div class="lojo_title">
		<span>LOGIN</span>
		</div>
		
		<div class="lojo_body">
		<form method="post" action="<%=request.getContextPath() %>/login_ok.do">
		<table class="login_table">
			<tr>
				<th>ID</th>
				<td><input name="member_id" autofocus="autofocus"></td>
			</tr>
			<tr>
				<th>PASSWORD</th>
				<td><input type="password" name="member_pwd"></td>
			</tr>
			<!-- <tr>
				<td colspan="2">
					<input type="submit" value="LOGIN">
				</td>
			</tr> -->
		</table>
		<div class="login_btn">
			<input type="submit" value="LOGIN">
		</div>
		</form>
		
		<div class="login_bottom">
			<table>
				<tr>
					<td style="border-right: 1px solid #e0dfdf;">
					<a href="<%=request.getContextPath() %>/findIdPwd.do">아이디/비밀번호 찾기</a>
					</td>
					<td>
					<a href="<%=request.getContextPath() %>/join.do">회원가입</a>
					</td>
				</tr>
				</table>
		</div>
		
		</div><!-- class= "login_body" -->
		
		
		</div><!-- class="lojo_container" -->
	</div> <!-- class="login_wrapper" -->
<%@include file="../include/user_bottom.jsp" %>
</body>
</html>