/**
 * 
 */
 
 /*
 	***********회원가입폼 join.jsp**************** 
 */
 let idcheckCount = "false";

	$(document).ready(function(){
		
		
		//중복체크버튼 마우스 올렸을 때 
		$("#idcheck_btn").mouseover(function(){
			
			$("#id_check").hide();
			
			idcheckCount = "true";
			
			let userId = $("#member_id").val();
			
			//입력길이 체크 4자 이하
			if($.trim($("#member_id").val()).length < 4){
				let warningTxt = '<font color="red">아이디는 4자 이상이어야 합니다.</font>'
				
				$("#id_check").text('');//span영역 빈칸 초기화
				$("#id_check").show();
				$("#id_check").append(warningTxt);
				$("#member_id").val().focus();
				return false;
				
			}
			
			//입력길이 체크 16자 이상
			if($.trim($("#member_id").val()).length >= 16){
				let warningTxt = '<font color="red">아이디는 16자 미만이어야 합니다.</font>'
				
				$("#id_check").text('');//span영역 빈칸 초기화
				$("#id_check").show();
				$("#id_check").append(warningTxt);
				$("#member_id").val().focus();
				return false;
				
			}
		});
		
		$("#idcheck_btn").mouseleave(function(){
			$("#id_check").text('');
			$("#id_check").hide();
		});
		
	});
	
	




		//회원가입 빈칸체크 
		function emptyCheck(){
			
			var id = $("member_id").val();
			var pwd = $("#member_pwd").val();
			var check = $("#member_pwd_check").val();
			var name = $("#member_name").val();
			var email = $("#member_email").val();
			var phone2 = $("#phone2").val();
			var phone3 = $("#phone3").val();
			var addr = $(".addr").val();
			var addr1 = $(".addr1").val();
			var addr3 = $(".addr3").val();
			
			if(id == ""){
				alert("아이디를 입력해주세요");
				$("#member_id").focus();
				return false;
			}
			if(pwd == ""){
				alert("비밀번호를 입력해주세요");
				$("#member_pwd").focus();
				return false;
			}
			if(check == ""){
				alert("비밀번호확인란을 확인해주세요");
				$("#member_pwd_check").focus();
				return false;
			}
			
			/* 비밀번호 확인 */
			if(pwd != check){
				alert("비밀번호가 틀립니다. 확인해주세요.");
				$("#member_pwd").focus();
				return false;
			}
			
			if(name == ""){
				alert("이름을 확인해주세요");
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
			
			if(idcheckCount == "false"){
				alert("아이디 중복체크 해주세요.");
				return false;
			}
			
			/* 약관동의 체크 여부 */
			let agree= false;
			
			if($("#agree_check1").prop("checked") && $("#agree_check2").prop("checked")){

				agree = true;

			}else{
				agree = false;
			}
			
			if(agree == false){
				alert("약관동의를 확인해주세요");
				return false;
			}
			
		
			
			
		}
/*
 	***********회원가입폼 join.jsp   END **************** 
 */
 
 
 