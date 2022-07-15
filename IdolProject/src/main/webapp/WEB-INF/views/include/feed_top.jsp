<%@page import="com.idol.model.MemberDTO"%>
<%@page import="com.idol.model.FollowDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="dto" value="${feedInfo.get('mInfo') }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<link rel="stylesheet" href="./resources/css/member.css?v=2022062314">
<style type="text/css">
	a{
		text-decoration: none;
		color:inherit;
	}

	.feed_top {
		position:relative;
		background-color:white;
		width:100%;
		height:360px;
		margin-bottom:80px
		
	}
	
	.feed_top .feed_headImg{
		height:60%;
		opacity: 85%;
	}
	
	.feed_headImg img{
		width:100%;
		height:250px;
		
	}
	
	
	.feed_headOverlay {
		position: absolute;
		top:100px;
	}
	
	.feed_headOverlay table{
		width:100%;
	}
	
	.feed_headOverlay img{
		width: 170px;
		height: 170px;
		border: 2px solid white;
		border-radius: 5px;
	}

	
 	.feed_headOverlay .feed_nickname{
		font-size: 1.5em;
		font-weight:bold;
		color:black	;
		
	}
	
	.feed_headOverlay .feed_id{
		font-weight:bold;
		color:gray;
	} */
	
 	.feed_nickname a{
		text-decoration: none;
		color:black;
	}
	
	.feed_sum {
		line-height: 1.6;
	}
	
	.feed_sum a{
		text-decoration:none;
		color:black;
		
	}
	
	.feed_sum a:hover {
	
		text-decoration: underline;
	}  
	
	/* ******드롭다운 css*********** */
	.dropbtn {
	  position : relative;
	  top:3px;
	  left:670px;
	  background-color: #a6b0a6;
	  color: white;
	  padding: 7px 12px;
	  font-size: 0.8em;
	  border: none;
	  cursor: pointer;
	  border-radius: 6px;
	  opacity:85%;
	}
	
	.dropdown {
	  position: relative;
	  display: inline-block;
	}
	
	.dropdown-content {
	  font-size: 0.8em;
	  display: none;
	  position: absolute;
	  left: 670px;
      top: 38px;
	  background-color: #f9f9f9;
	  min-width: 150px;
	  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
	  z-index: 1;
	  border-radius:5px;
	}
	
	.dropdown-content a {
	  color: black;
	  padding: 12px 16px;
	  text-decoration: none;
	  display: block;
	}
	
	.dropdown-content a:hover {background-color: #f1f1f1}
	
	.dropdown:hover .dropdown-content {
	  display: block;
	}
	
	.dropdown:hover .dropbtn {
	  background-color: #858f85;
	}
	
	
	/********* 레이어 팝업창 ***************/
	.editImg{
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
	
	.editImg p {
		text-align: left;
		font-weight: bold;
	}
	
	.editImg .editFile{
		border: 1px solid #8b8989;
   	    padding: 5px;
        border-radius: 5px;
        background-color: white;
        box-shadow: 1px 1px 3px #8b8989;
        margin-bottom: 15px;
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
	
/*  	.feed_headImag_box {  */
/* 		background-image: url('./resources/upload/member_image/${dto.getMember_no() }/${dto.getMember_cover() }');  */
/*  		width: 100%;  */
/*  		height: 100%;  */
/* 		background-size: cover;  */
/*  	}  */
</style>
<script type="text/javascript">

	
	
	
	
</script>
</head>
<body>
	<c:if test="${!empty login_id }">
	<c:set var="login" value="${login_id }"/>
	</c:if> 
	<c:set var="dto" value="${feedInfo.get('mInfo') }"/> <!-- 회원정보 -->
	<c:set var="commList" value="${feedInfo.get('commList') }"/> <!-- 게시글 총 개수 -->
	<c:set var="following" value="${feedInfo.get('following') }"/> <!-- 팔로우 -->
	<c:set var="follower" value="${feedInfo.get('follower') }"/> <!-- 팔로워 -->
	
	
		<div class="feed_top">
			<div class="feed_headImg">
				<c:if test="${!empty dto.getMember_cover() }">
					<img alt="" src="./resources/upload/member_image/${dto.getMember_no() }/${dto.getMember_cover() }">
<!-- 					<div class="feed_headImag_box"> -->
<!-- 					</div> -->
				</c:if>
				<c:if test="${empty dto.getMember_cover() }">
					<i class="bi bi-card-image" style="font-size: 5em;text-align: center;margin-left: 25px;"></i>
				</c:if>
			</div>
			<div class="feed_headOverlay">
			
				<table >
					<tr>
						<td rowspan="2" style="width:10%; padding:30px;">
						<c:if test="${!empty dto.getMember_image() }">
						<img src="./resources/upload/member_image/${dto.getMember_no() }/${dto.getMember_image() }" alt="member_image">
						</c:if>
						<c:if test="${empty dto.getMember_image() }">
						<img src="./resources/upload/celeb/프사없음.jpeg" alt="member_image">
						<!-- <i class="bi bi-card-image" style="font-size: 5em;text-align: center;margin-left: 25px;"></i> -->
						</c:if>
						
						</td>
						<td colspan="3">
							<div class="feed_nickId">
							<span class="feed_nickname">
							<a href="<%=request.getContextPath()%>/myfeed.do?id=${dto.getMember_id()}">${dto.getMember_nickname() }</a>
							</span> 
							&nbsp;&nbsp;&nbsp;
							<!-- ----------------팔로우 버튼 -------------------- -->
							<c:if test="${dto.getMember_id() != login && login != null }">
								<%
									HashMap map= (HashMap)session.getAttribute("feedInfo");
								
									//로그인한 회원의 팔로우 리스트
									List<FollowDTO> login_f = (List<FollowDTO>)map.get("login_follow");
									
									//피드회원 정보 
									MemberDTO mdto = (MemberDTO)map.get("mInfo");
									
									int check =0;
									
									if(login_f.size() > 0 ){
										
									
									for(int i=0; i<login_f.size(); i++){
										FollowDTO fDto = login_f.get(i);
										
										String feed = mdto.getMember_id();
										String loginF = fDto.getFollow_name();
										
										System.out.println("feed:"+feed);
										System.out.println("loginF:"+loginF);
										
										if(feed.equals(loginF)){
											check =1;
										}
									}
									}
									/* System.out.println("feed_top check:"+check); */
									if(check>0){//이미 팔로우중이라면
								%>	
										<input type="button" class="f_btn2" value="팔로잉" 
											onclick="location.href='unfollow.do?id=${dto.getMember_id()}&feed=${dto.getMember_id()}'">
											<!-- 로그인한 아이디의 팔로우리스트에서 현재 피드의 id를 삭제하기 -->
								<% 	}else{// 팔로우중이 아니라면 %>
										<input type="button" class="f_btn1" value="팔로우" 
											onclick="location.href='follow.do?id=${dto.getMember_id()}&feed=${dto.getMember_id()}'">
											<!-- 로그인한 아이디의 팔로우리스트에 현재 피드의 id를 추가하기  -->	
								<% }%>
								
							</c:if>
							<br>
							<span class="feed_id">@${dto.getMember_id() }</span>
							</div><!-- class="feed_nickId" -->
							
							<c:if test="${dto.getMember_id() == login }">
							<div class="dropdown">
							  <button class="dropbtn"><i class="bi bi-list" style="font-size:1.1em;"></i></button>
							  <div class="dropdown-content">
							  <a href="#editCover" class="cover_setting">커버이미지 수정</a>
							  <a href="#editProfile" class="profile_setting">프로필 수정</a>
							  <a href="<%=request.getContextPath() %>/mypage.do" class="mypage_btn">마이페이지</a>
							  </div>
							</div>
							</c:if>
							<!-- **************레이어 팝업창*********************              -->
							<!-- 프로필이미지 수정창 -->
							<div id="editProfile" class="editImg">
								<form class="frm1" method="post" action="<%=request.getContextPath() %>/editProfile.do" 
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
							
							<!-- 커버이미지 수정창 -->
							<div id="editCover" class="editImg">
								<form class="frm2" method="post" action="<%=request.getContextPath() %>/editCover.do" 
										enctype="multipart/form-data"> 
										
								<input type="hidden" name="member_no" value="${dto.getMember_no() }">
								<input type="hidden" name="member_id" value="${dto.getMember_id() }">
								<input type="hidden" name="old_img" value="${dto.getMember_cover() }">
								<p><i class="bi bi-check-circle"></i> Upload Cover</p>
								<div class="editFile" align="left">
								<input type="file" name="file2">
								</div>
								<input type="submit" class="edit_btn" value="확인">
								<input type="button" class="cancel_btn" value="취소" >
								</form>
							</div><!-- class="editProfile" -->
							<div class="edit_dim">
								
							</div>
							<!-- **************레이어 팝업창 script*********************-->
							<script type="text/javascript">
							
							$(".profile_setting").on("click",function(){
								$("#editProfile").show();
								$(".frm1").show();
								$(".edit_dim").show();
							});
							
							$("#editProfile .cancel_btn").on("click", function(){
								$(this).parent().hide();
								$(".edit_dim").hide();
								$("#editProfile").hide();
								
								}); 
							
							$(".cover_setting").on("click",function(){
								$("#editCover").show();
								$(".frm2").show();
								$(".edit_dim").show();
							});
							
							$("#editCover .cancel_btn").on("click", function(){
								$(this).parent().hide();
								$(".edit_dim").hide();
								$("#editCover").hide();
								
								}); 
							
							
							</script>
							<!-- **************레이어 팝업창 end*********************-->
							
							
						</td>
					</tr>
					<tr>
						<td colspan="3" style="display:flex; justify-content: space-around; text-align: center;">
							<div class="feed_sum" >게시물<br>
							<a href="<%=request.getContextPath() %>/feed_posting.do?id=${dto.getMember_id()}"> 
							<fmt:formatNumber value="${commList.size() }"/>   </a></div>
							
							<div class="feed_sum" >팔로워<br>
							<a href="<%=request.getContextPath()%>/feed_follower.do?id=${dto.getMember_id()}">
							<fmt:formatNumber value="${follower.size() }"/>	 </a></div>
							
							<div class="feed_sum" >팔로잉<br>
							<a href="<%=request.getContextPath()%>/feed_following.do?id=${dto.getMember_id()}">
							<fmt:formatNumber value="${following.size() }"/>
							</a></div>
						</td>
					</tr>
				
				</table>
			</div>
		</div><!-- class="feed_top" end -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" ></script>
</body>
</html>