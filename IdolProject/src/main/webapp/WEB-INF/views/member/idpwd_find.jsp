<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디, 비밀번호 찾기</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="./resources/css/member.css?v=2022062113">
<script type="text/javascript">

	//아이디찾기, 비밀번호찾기 탭 메서드 
	function findTab( idpwd ){
		
		document.getElementById('findId').style.display='none';
	    document.getElementById('findPw').style.display='none';
	    document.getElementById( idpwd).style.display='block';
		$(".check_email").prop("checked",true);
		$('.phone_find').hide();
		$('.phone_input').hide();
		$('.email_find').show();
		$('.email_input').show();
	}
	
	//라디오 버튼에 따른 화면 변경
	$(document).ready(function(){
		
		$('input[name=verification]').on('change',function(){
			var v = $(this).val();
			
			switch(v){
			case 'email':
				$('.phone_find').hide();
				$('.phone_input').hide();
				$('.email_find').show();
				$('.email_input').show();
				break;
			case 'phone':
				$('.phone_find').show();
				$('.phone_input').show();
				$('.email_find').hide();
				$('.email_input').hide();
				
			}
			
		});
	});
	
	$(document).ready(function(){
		
		let result = '<c:out value="${find_result}"/>';
		
		console.log(result);
		
		if(result =="null"){
			alert("회원정보를 다시 확인해주세요.");
		}
		
	});

</script>
<style type="text/css">
	body{
 		background-color: #f2f2f2;
 	}
 	
	.find_tab{
		display:flex;
		width:85%;
		margin-bottom:20px;
		cursor: pointer;
	}
	
	.find_tab .tab_title{
		width:100%;
		padding: 10px;
		border-bottom: 1px solid #e0dfdf;
	}
	
	.find_tab .selected{
		border-bottom:2px solid #2a3a52;
	}
	
	.content table{
		width:85%;
	}
	
	.content table th{
		width: 30%;
		text-align: left;
		padding: 10px 5px;
		
		font-size: 0.9em;
	}
	
	.content table td{
		padding: 10px 5px;
		font-size: 0.9em;
	}
	
	.content input{
		padding: 8px 0;
		border:none;
		border-bottom: 1px solid #e0dfdf;
	}


	#findPw{
		display:none;
	}
	
	.phone_find {
		display:none;
	}
	
	.phone_input{
		display:none;
	}
	
	.content .idpwdSubmit{
	
		margin-top:30px;
		width:90%;
 		font-size: 1.1em;
        border-radius: 30px;
        background-color: #2a3a52;
        border: 1px solid #233044;
        color: white;
        font-weight: 500;
        letter-spacing: 1.3px;
        padding: 15px;
	}
	
	.extra_btn{
		width:85%;
		border-top: 1px solid #e0dfdf
	}
	
	.find_bottom{
		margin-bottom:40px;
		width:85%
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
<%@include file="../include/user_top.jsp" %>
	<div class="login_wrapper" align="center">
	<div class="lojo_container">
		<div class="lojo_title">
		<span>ID/PWD 찾기</span>
		</div>
	
		<div class="lojo_body">
			<div id="findId">
				<form method="post" class="find_form" action="findIdPwd_ok.do">
					<input type="hidden" name="find_word" value="id">
					<div class="content">
						<div class="find_tab" align="center">
							<div class="tab_title selected" onclick="findTab('findId')">아이디 찾기</div>
							<div class="tab_title" onclick="findTab('findPw')">비밀번호 찾기</div>
						</div>	
						<br>
						<table >
							<tr>
								<th>인증방법</th>
								<td>
								<input type="radio" class="check_email" name="verification" value="email" checked="checked"> 이메일
								&nbsp;&nbsp;&nbsp;
								<input type="radio" class="check_phone" name="verification" value="phone"> 휴대폰번호
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input name="member_name"></td>
							</tr>
							
							<tr>
								<th><span class="email_find">이메일로 찾기</span> <span class="phone_find">휴대번호로 찾기</span></th>
								<td>
									<div class="email_input"><input name="member_email"></div>
									<div class="phone_input"><input name="phone1" maxlength="4" size="7"> - 
									                         <input name="phone2" maxlength="4" size="7"> - 
									                         <input name="phone3" maxlength="4" size="7">
									 </div>
								</td>
							</tr>
							
							<tr>
								<td colspan="2" align="center">
								<input class="idpwdSubmit" type="submit" value="아이디찾기">
							</tr>
						</table>	
						<br>

						<div class="find_bottom">
							<table>
								<tr>
									<td style="border-right: 1px solid #e0dfdf;"><a
										href="<%=request.getContextPath()%>/login.do">로그인</a></td>
									<td><a href="<%=request.getContextPath()%>/join.do">회원가입</a>
									</td>
								</tr>
							</table>
						</div>

					</div><!-- class="content" end -->
				</form>			
			</div><!-- id="findId" end  -->
			
			<div id="findPw">
				<form method="post" class="find_form" action="findIdPwd_ok.do">
					<input type="hidden" name="find_word" value="pwd">
					<div class="content">
						<div class="find_tab">
							<div class="tab_title" onclick="findTab('findId')">아이디 찾기</div>
							<div class="tab_title selected" onclick="findTab('findPw')">비밀번호 찾기</div>
						</div>	
						<br>
						<table>
							<tr>
								<th>인증방법</th>
								<td>
								<input type="radio" class="check_email" name="verification" value="email" checked="checked"> 이메일
								&nbsp;&nbsp;&nbsp;
								<input type="radio" class="check_phone" name="verification" value="phone"> 휴대폰번호
								</td>
							</tr>
							<tr>
								<th>아이디</th>
								<td><input name="member_id"></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input name="member_name"></td>
							</tr>
							<tr>
								<th><span class="email_find">이메일로 찾기</span> <span class="phone_find">휴대번호로 찾기</span></th>
								<td>
								<div class="email_input"><input name="member_email"></div>
								<div class="phone_input"><input name="phone1" maxlength="4" size="7"> - 
														<input name="phone2" maxlength="4" size="7"> - 
														<input name="phone3" maxlength="4" size="7"></div>
								</td>
							</tr>
							
							<tr>
								<td colspan="2" align="center">
								<input class="idpwdSubmit" type="submit" value="비밀번호 찾기">
							</tr>
						</table>	
						<br>
						<div class="find_bottom">
							<table>
								<tr>
									<td style="border-right: 1px solid #e0dfdf;"><a
										href="<%=request.getContextPath()%>/login.do">로그인</a></td>
									<td><a href="<%=request.getContextPath()%>/join.do">회원가입</a>
									</td>
								</tr>
							</table>
						</div>						
					</div>
				</form>			
			</div><!-- id="findPw" end  -->
			
			
		</div><!-- class="find_form" end  -->
	
	</div><!-- class="find_container" -->
	</div><!-- class="login_wrapper" -->
<%@include file="../include/user_bottom.jsp" %>

</body> 
</html>