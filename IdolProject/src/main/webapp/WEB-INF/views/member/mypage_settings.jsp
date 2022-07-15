<%@page import="com.idol.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지> 회원정보관리</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="./resources/js/member.js"></script>
<link rel="stylesheet" href="./resources/css/member.css?v=2022063010">
<style type="text/css">
	
	/* ***********마이페이지 회원정보관리************* */
	.manage_top {
		text-align: left;
 		font-size:1.8em;
 		font-weight:bold;
        padding: 10px 0;
        margin-bottom:20px;
	}
	
	.setting_title{
		text-align: left;
 		font-size:1.1em;
 		border-bottom: 2px solid #c2c0c0;
        padding: 10px 0;
        margin-bottom:20px;
	
	}
	
	 .manage_cont{
		width: 80%;
	} 
	
	.manage_basic, .manage_extr {
		margin:40px 0;
	}
	
	.manage_basic table{
		width:90%;
 		margin-bottom:40px;
 		font-weight: normal;
 		font-size: 1em;
	}
	
	.manage_basic table th{
		width: 25%;
		text-align: left;
		padding: 8px 10px;
	}
	.manage_basic table td{
		padding: 8px 5px;
		line-height: 2;
	}
	
	.manage_basic table input {
		padding: 5px 0;
		border:none;
		border-bottom: 1px solid #e0dfdf;
	}
	
	.manage_bottom{
		display:flex;
		margin-top:100px;
		margin-bottom:50px;
		
	}
	
	 #addr_btn{
 		font-size: 0.8em;
       	
        border-radius: 30px ;
       	border:1px solid #c2c0c0;
       	background-color:white;
       	padding: 8px 10px;
       	margin-left: 10px;
       	cursor: pointer;
        
 	
 	}

</style>


<script type="text/javascript">


	function checkUpdate(){
		
		var pwd = $("#member_pwd").val();
		var check = $("#member_pwd_check").val();
		var email = $("#member_email").val();
		var phone1 = $("#phone1").val();
		var phone2 = $("#phone2").val();
		var phone3 = $("#phone3").val();
		var addr = $(".addr").val();
		var addr1 = $(".addr1").val();
		var addr3 = $(".addr3").val();
		
		if(pwd == ""){
			alert("비밀번호를 입력해주세요");
			$("#member_pwd").focus();
			return false;
		}
		if(check == ""){
			alert("비밀번호를 확인해주세요");
			$("#member_pwd_check").focus();
			return false;
		}
		if(phone2 == "" || phone3 ==""){
			alert("핸드폰번호를 확인해주세요");
			$("phone2").focus();
			return false;
		}
		
		if(email ==""){
			alert("이메일을 입력해주세요");
			$("#member_email").focus();
			return false;
		}
		if(addr =="" || addr1 ==""  || addr3 ==""){
			alert("주소를 입력해주세요");
			$("addr").focus();
			return false;
		}
		
		if(pwd.length != 0 && check.length != 0){
			if(pwd != check){
				alert("비밀번호를 다시 확인해주세요.");
				$("#member_pwd").focus;
				return false
			}
		}
		
	}

</script>
</head>
<body>
	<c:set var="dto" value="${memInfo }"/> 
	<c:set var="fav" value="${mem_fav }"/>
	<script type="text/javascript">
	
		
	</script>
	<%@include file="../include/user_top.jsp" %>
	
	<div class="mypage_container" algin="center">
		
		<!-- aisde inlcude 추가  -->
		<jsp:include page="../include/mypage_aside.jsp"/>
		
		<div class="mypage_main">
		<div class="manage_top">
		회원정보 수정
		</div>
		<div class="manage_cont">
		<form method="post" action="<%=request.getContextPath() %>/member_update.do" onsubmit="return checkUpdate()">
				<input type="hidden" name="checked_celeb" id="hidden_chcked" value="">
				<input type="hidden" name="member_no"  value="${dto.getMember_no() }">
			
			<div class="manage_basic">
			<div class="setting_title">기본 정보 수정</div>
			
			<table>
				<tr>
					<th>이름</th>
					<td><input name="member_name" value="${dto.getMember_name() }" readonly></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="member_pwd" id="member_pwd"></td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" name="member_pwd_check" id="member_pwd_check"></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td><input name="member_nickname" value="${dto.getMember_nickname() }" ></td>
				</tr>
				<tr>
					<th>자기소개</th>
					<td><textarea rows="7" cols="50"  name="member_introduction">${dto.getMember_introduction() }</textarea> </td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input name="phone1" value="${dto.getMember_phone().substring(0,3)}" id="phone1" maxlength="4" size="7">
						-<input name="phone2" value="${dto.getMember_phone().substring(3,7) }" id="phone2" maxlength="4" size="7">
						-<input name="phone3" value="${dto.getMember_phone().substring(7) }" id="phone3" maxlength="4" size="7"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input name="member_email" id="member_email" value="${dto.getMember_email() }"></td>
				</tr>
				<tr>
					<th>주소</th>
				<td>
				<!-- 다음 api 사용  -->
				<input class="addr" type="text" name="postnum" id="sample6_postcode" placeholder="우편번호" value="${mem_addr[0] }">
				<input id="addr_btn" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" name="addr1" class="addr1" id="sample6_address" placeholder="주소" value="${mem_addr[1] }"><br>
				<input type="text" name="addr2" class="addr2" id="sample6_detailAddress" placeholder="상세주소" value="${mem_addr[2] }">
				<input type="text" name="addr3" class="addr3" id="sample6_extraAddress" placeholder="참고항목" value="${mem_addr[3] }">
				
				<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				<script>
				    function sample6_execDaumPostcode() {
				        new daum.Postcode({
				            oncomplete: function(data) {
				                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				
				                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
				                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				                var addr = ''; // 주소 변수
				                var extraAddr = ''; // 참고항목 변수
				
				                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
				                    addr = data.roadAddress;
				                } else { // 사용자가 지번 주소를 선택했을 경우(J)
				                    addr = data.jibunAddress;
				                }
				
				                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				                if(data.userSelectedType === 'R'){
				                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
				                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
				                        extraAddr += data.bname;
				                    }
				                    // 건물명이 있고, 공동주택일 경우 추가한다.
				                    if(data.buildingName !== '' && data.apartment === 'Y'){
				                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				                    }
				                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				                    if(extraAddr !== ''){
				                        extraAddr = ' (' + extraAddr + ')';
				                    }
				                    // 조합된 참고항목을 해당 필드에 넣는다.
				                    document.getElementById("sample6_extraAddress").value = extraAddr;
				                
				                } else {
				                    document.getElementById("sample6_extraAddress").value = '';
				                }
				
				                // 우편번호와 주소 정보를 해당 필드에 넣는다.
				                document.getElementById('sample6_postcode').value = data.zonecode;
				                document.getElementById("sample6_address").value = addr;
				                // 커서를 상세주소 필드로 이동한다.
				                document.getElementById("sample6_detailAddress").focus();
				            }
				        }).open();
				    }
				</script>
				</td>
				</tr>
			</table>
			</div><!-- class="manage_basic" end  -->
			<div class="manage_extr">
			<div class="setting_title">좋아하는 가수 변경</div>
			
			<c:if test="${empty totalList  }">
			<h2>셀럽 정보가 없습니다.</h2>
			</c:if>
			
			<c:if test="${!empty totalList }">
			
			<div class="celeb_container" style="width:80%;"> 
			<c:set var="list" value="${totalList }"/>
			<c:forEach items="${list }" var="dto">
			<c:if test="${dto.getCeleb_group() != 'solo' }"> <!-- totalList 그룹가수인 경우 -->
			<div class="celeb_item">
			<input type="checkbox" name="fav_celeb[]" id="celeb_${dto.getCeleb_no() }" value="${dto.getCeleb_no() }" onchange="check_celeb(${dto.getCeleb_no()})" > 
			<label for="celeb_${dto.getCeleb_no() }" >
	       <span class="celeb_span"> ${dto.getCeleb_group() } </span>
	       	</label>
			</div>
			</c:if>
			<c:if test="${dto.getCeleb_group() == 'solo' }"> <!-- totalList 솔로 가수인 경우 -->
			<div class="celeb_item">
			<input type="checkbox" name="fav_celeb[]" id="celeb_${dto.getCeleb_no() }" value="${dto.getCeleb_no() }" onchange="check_celeb(${dto.getCeleb_no()})" > 
			<label for="celeb_${dto.getCeleb_no() }" >
	       <span class="celeb_span"> ${dto.getCeleb_name() } </span>
	       	</label>
			</div>
			</c:if>
			
			</c:forEach>
				
			</div><!-- class="celeb_container" end -->
			</c:if>
			
			<%-- <%
				String[] mem_fav = request.getParameterValues("mem_fav");
			
			%> --%>
			
			<script type="text/javascript">
			
			
			let checked = new Array();
			var count =0;
			
			$(document).ready(function(){

				/* 회원가입시 선택했던 가수를 수정폼에서 선택된 상태로 보여줌  */
				checked.push('<c:out value="${fav[0]}"/>');
				checked.push('<c:out value="${fav[1]}"/>');
				checked.push('<c:out value="${fav[2]}"/>');
				
				console.log(checked);
				
				for(let i =0 ; i< checked.length; i++){
				
					if(checked[i] === ''){
						checked.splice(i);
						
					}else{
					
					$("#celeb_"+checked[i]).prop("checked",true);
					++count; }
					
				}
				
				console.log("Result:"+checked)
				
			});
		
			
			function check_celeb(no){
				
				console.log(no);
				
				if($("#celeb_"+no).prop("checked")){//체크되면 배열에 저장
					
					++count; 
					
					if(count < 4){
						
					checked.push($("#celeb_"+no).val());
					console.log(count);
					
					}else {//3명이상 선택했을 경우 취소 및 삭제
					
						alert("최대 3명까지 선택 가능합니다.");
						$("#celeb_"+no).prop("checked",false);
						count --;
					}
					
				}else {
					var findNO = String(no);
					const index = checked.indexOf(findNO);
					console.log("index:"+index)
					
					checked.splice(index,1);

					--count;
				}
			
				console.log(checked);
				$("#hidden_chcked").val(checked);
				console.log($("#hidden_chcked").val());
				
			}
		
			
		
		</script>
			
			</div>
			<div class="manage_bottom" align="center">
				<input class="manage_submit" type="submit" value="수정">
				<input class="manage_cancel" type="button" value="취소" onclick="location.href='mypage.do'">
			</div>
			</form>	
			</div> <!-- class="manage_cont" -->
		</div><!-- class="mypage_main" end -->
	
	</div><!-- class="mypage_container" end -->
	
<%@include file="../include/user_bottom.jsp" %>
</body>
</html>