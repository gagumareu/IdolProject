<%@page import="com.idol.model.MemberDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="./resources/css/member.css?v=2022063010">
<style type="text/css">

	.profile_image_wrap{
		position:relative;
	}

	#image_setting{
		/* display:none; */
	}
	
	.profile_image_wrap label{
		font-size:1.7em;
		top: 160px;
    	left: 200px;
		
	}
	
	.image_setting{
	    position: absolute;
   		 top: 90px;
   		 left: 120px;
	
	}
	
	.image_setting i{
		font-size: 2em;
  		  color: #bebdbd;
   	 text-shadow: 2px 1px 2px black;
	}
	
	
	/********* 레이어 팝업창 ***************/
	.editProfile{
		display: none;
		
		position:fixed;
		left: 35%;
		top:20%;
		translate: (-50%, -50%);
		
		width:600px;
		height:170px;
		border: 2px solid #cdc7c7;
        box-shadow: 2px 0px 12px #888888;
		background-color:#efefef;
		border-radius: 6px;
		box-sizing:border-box;
		text-align: center;
		padding:20px;
		z-index:100;
	}
	
	.editProfile p {
		text-align: left;
		font-weight: bold;
	}
	
	.editProfile .editFile{
		border: 1px solid #8b8989;
   	    padding: 8px;
        border-radius: 5px;
        background-color: white;
        box-shadow: 1px 1px 3px #8b8989;
        margin: 15px;
	}
	
	.editFile{
		font-size: 0.9em;
	}
	
	
	.edit_dim {
		display:none;
		position:fixed;
		left:0; 
		top:0;
		width:100%;
		height:100%;
		background-color: rgb(0,0,0,0.5);
		z-index:99;
	}
	
	.edit_btn{
		
		width: 110px;
	    height: 35px;
	  	border-radius: 6px;
        background-color: #2a3a52;
        border: 1px solid #2a3a52;
        box-shadow: 1px 1px 2px #2a3a52;
	  	color: white;
	 	font-size: 0.8em;
		}
	
	.edit_btn:hover{
	
		 background-color: #15233a;
	}
	.cancel_btn{
		
		width: 110px;
	    height: 35px;
	  	border-radius: 6px;
	 	background-color: white;
	 	border: 1px solid #ece7e7;
        box-shadow: 1px 1px 3px #d7d7d7;
	  	color: black;
	 	font-size: 0.8em;
		}
	.cancel_btn:hover{
		background-color:#f7f5f5;
	}
	
</style>
</head>
<body>
	<c:set var="dto" value="${loginInfo }"/>
	<%-- <c:set var="dto" value="${memInfo }"/>	 --%>
	<aside class="mypage_aside">
			<div class="profile_box">
				<div class="profile_image_wrap">
				<div class="profile_image">
					<c:if test="${!empty dto.getMember_image() }">
					<img src="./resources/upload/member_image/${dto.getMember_no() }/${dto.getMember_image() }" alt="member_image">
					</c:if>
					<c:if test="${empty dto.getMember_image() }">
						<img src="./resources/upload/celeb/프사없음.jpeg" alt="member_image">
					</c:if>
				</div>
				<a href="#editProfile" class="image_setting"><i class="bi bi-gear-fill"></i></a>
				</div>
				
				<!-- **************레이어 팝업창*********************              -->
				<div id="editProfile" class="editProfile">
					<form class="frm" method="post" action="<%=request.getContextPath() %>/editProfile.do" 
							enctype="multipart/form-data"> 
							
					<input type="hidden" name="member_no" value="${dto.getMember_no() }">
					<input type="hidden" name="member_id" value="${dto.getMember_id() }">
					<input type="hidden" name="old_img" value="${dto.getMember_image() }">
					<input type="hidden" name="uri" value="<%=request.getRequestURI()%>">
					
					<p><i class="bi bi-check-circle"></i> Upload Profile</p>	
					<div class="editFile" align="left">
					<input type="file" name="file1">
					</div>
					<input type="submit" class="edit_btn" value="확인">
					<input type="button" class="cancel_btn" value="취소" >
					</form>
				</div><!-- class="editProfile" -->
				<div class="edit_dim">
					
				</div>
				<!-- **************레이어 팝업창 script*********************-->
				<script type="text/javascript">
				
				$(".image_setting").on("click",function(){
					$(".editProfile").show();
					$(".frm").show();
					$(".edit_dim").show();
				});
				
				$(".editProfile .cancel_btn").on("click", function(){
					$(this).parent().hide();
					$(".edit_dim").hide();
					$(".editProfile").hide();
					
					}); 
				
				
				</script>
				<!-- **************레이어 팝업창*********************-->
				
				
				<div class="info">
					<div class="info_cont">
					<span class="nickname">${dto.getMember_nickname() }님</span><br> <!-- 닉네임 -->
					<span style="font-size:0.9em;">	<!-- 아이디 -->
						<c:if test="${dto.getMember_id().length() <= 4 }">
							${dto.getMember_id().substring(0,2) }
							<c:forEach begin="1" end="${dto.getMember_id().substring(2).length() }">
								*
							</c:forEach>
						</c:if>
						<c:if test="${dto.getMember_id().length() > 4 }">
						${dto.getMember_id().substring(0,(dto.getMember_id().length()-2)) }**
						</c:if>
					</span>
					</div>
				</div>
			
			</div><!-- class="profile_box" end -->
			
			<div class="mypage_menu">
					<ul>
						<li><a href="<%=request.getContextPath()%>/mypage.do">마이페이지</a></li>
						<li><a href="<%=request.getContextPath()%>/mySettings.do">회원정보관리</a></li>
						<li><a href="<%=request.getContextPath()%>/mileage_list.do">마일리지 내역</a></li>
						<li><a href="<%=request.getContextPath()%>/order_list.do">주문 내역</a></li>
						<li><a href="<%=request.getContextPath()%>/inquiry_list.do">문의 내역</a></li>
						<li><a href="<%=request.getContextPath()%>/logout.do">로그아웃</a></li>
					</ul>
			
			</div> <!-- class="mypage_menu" end -->
		
		</aside><!-- class="mypage_aside" end -->

</body>
</html>