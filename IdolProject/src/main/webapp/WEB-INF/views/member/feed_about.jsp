<%@page import="com.idol.model.BoardCategoryDTO"%>
<%@page import="com.idol.model.CommunityDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${id }님의 피드 - about</title>
<link href="https://fonts.googleapis.com/css2?family=Material+Icons"
      rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols"
      rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" ></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="./resources/css/member.css?v=2022062212">



<style type="text/css">
	
	
	
	.feed_introduction{
		background-color:white;
		padding:20px;
		font-size:0.95em;
	}
	
	
	.feed_introduction table td{
		padding : 6px
	}
	
	.feed_introduction table tr{
		height: 80px;
	}
	
	.fav_list{
		display:flex;
	}
	
	.fav_img{
		display:block;
		overflow:hidden;
		border-radius: 50%;
		width:50px;
		height:50px;
	}
	
	.fav_img >img{
		display:block;
		width:120%;
		height:100%;
		margin-left: -5px;
	}
	
	.fav_item{
	
		margin:0 10px;
		text-align:center;
	}
	
	.fav_item a{
		text-decoration: none;
		color: black;
	}
	
	.fav_name{
		font-size:0.8em;
		
	}
	
	.feed_posting{
		background-color:white;
		padding:20px;
		
		margin:0 auto;
		max-width: 1000px;
		display:grid;
		grid-template-columns:repeat(auto-fill,minmax(220px,1fr));
		gap:20px;
		
	}
	
	.card_image {
	width:100%;
	height:269px;
	display:block;
}

.card_category{
	font-size:0.8em;
	padding:10px;
	background:#fafafa;
	text-align: left;
}

.card_content{
	line-height: 1.5;
	font-size:0.9em;
	padding:10px;
	background:#fafafa;
	text-align: left;
}

.card_content >p:first-of-type{
	margin-top:0;
	margin-bottom:0;
	height:43px;
}

.card_userid{
	display:flex;
	margin:10px;
	font-size:0.9em;
}

.card_userid>div:last-of-type{
	margin-left:8px;
}

.userid_img{

	display:block;
		overflow:hidden;
		border-radius: 50%;
		width:20px;
		height:20px;
}

.userid_img >img{
		display:block;
		width:auto;
		height:100%
	}


.card_info{
	padding:10px;
	display:flex;
	justify-content: space-between;
	align-items:center;
	background:#eeeeee;
	font-size:0.8em;
	border-bottom:2px solid #cccccc;
	color:#555555;
}

.material-symbols-outlined {
  font-variation-settings:
  'FILL' 100,
  'wght' 400,
  'GRAD' 0,
  'opsz' 48
}


.card_info i{
	font-size:0.95em;
	margin-right :5px;
	
}

.card_link {
	color:#626262;
	text-decoration: none;
}

.card_link:hover {
	text-decoration: underline;
}

</style>
</head>
<body>
	<c:set var="dto" value="${feedInfo.get('mInfo') }"/> <!-- 회원정보 -->
	<c:set var="fav" value="${favList }"/> <!-- 좋아하는 가수 정보가 들은 리스트  -->
	<c:set var="comm" value="${community }"/> <!--피드 회원의 커뮤니티게시글 리스트 -->
	<%@include file="../include/user_top.jsp" %>
	
	<div class="feed_wrapper" align="center">
	<div class="myfeed_container" align="center">
		<!-- myfeed_top include 추가  -->
		<jsp:include page="../include/feed_top.jsp"/>
		
		<div class="feed_main" >
			<div class="feed_title">
				<table>
					<tr>
						<td style="border-bottom:1px solid #2a3a52">
							<a href="<%=request.getContextPath() %>/myfeed.do?id=${dto.getMember_id()}" style="color: black; ">
							ABOUT
							</a>
						</td>
						<td >
							<a href="<%=request.getContextPath() %>/feed_posting.do?id=${dto.getMember_id()}" style="color: gray;">POSTING</a>
						</td >
						<td >
							<a href="<%=request.getContextPath() %>/feed_like.do?id=${dto.getMember_id()}" style="color: gray;">LIKE♥</a>
						</td>
					</tr>
				</table>
			</div><!-- class="feed_title"  end -->
			<div class="feed_introduction" align="left">
				<div class="introduction_cont">
				<% pageContext.setAttribute("replaceChar", "\n"); %>
				<p>
				  	<c:set var="content" value="${fn:replace(dto.getMember_introduction(), replaceChar, '<br>') }"/>
				  	${content }
				</p>
				</div>
				<hr>
				<table>
					<tr>
						<td>
							gender:
						</td>
						<td colspan="4">
						 <c:if test="${dto.getMember_gender() == 'M' }">
						  &nbsp;MALE
						 </c:if>
						 <c:if test="${dto.getMember_gender() == 'F' }">
						   &nbsp; FEMALE
						 </c:if>
						</td>
					</tr>
					<tr>
						<td>
						Favorite Celeb:
						</td>
						<td colspan="4">
						<c:if test="${!empty fav }">
						<div class="fav_list" >
						<c:forEach items="${fav }" var="list">
						<c:if test="${list[3] == 'solo' }"> <!-- 솔로 가수인 경우 -->
						
							<div class="fav_item" >
							<a href="#">
							<div class="fav_img" >
								<img src="./resources/upload/celeb/${list[2] }" alt="celeb_image">
							</div>
							<div class="fav_name">
								${list[1] } <!-- 가수정보로 넘어가는 a태그 번호 list[0] -->
							</div>
							</a>
							</div><!-- class="fav_item" -->
						
						</c:if>
						<c:if test="${list[3] != 'solo' }"> <!-- 그룹가수인 경우 -->
							<div class="fav_item">
							<a href="#">
							<div class="fav_img">
								<img src="./resources/upload/group/${list[2] }" alt="group_image">
							</div>
							<div class="fav_name">
								${list[1] } <!-- 가수정보로 넘어가는 a태그 번호 list[0] -->
							</div>
							</a>
							</div>
						</c:if>
						</c:forEach>
						</div><!-- class="fav_list" -->
						</c:if>
						<c:if test="${empty fav }">
						<div class="fav_list" >
							<p>선택한 가수가 없습니다.</p>
						</div>
						</c:if>
						
						</td>
					</tr>
				</table>
				<hr>
			</div><!-- class="feed_introduction" -->
			<c:if test="${!empty comm }">
			<div class="feed_posting">
				<%
					List<CommunityDTO> list = (List<CommunityDTO>)request.getAttribute("community");
					
					int count =3;//리스트 최신 3개까지 보여주기 
					
					if(list.size()<3){
						count = list.size();
					}
				
					for(int i=0; i<count; i++){ 
						
						CommunityDTO cdto = list.get(i);
						
						String[] img = null;
						
						//이미지가 있는경우, 대표이미지 하나만 뽑아내기 
						if(cdto.getCommunity_image() != null ){
							img = cdto.getCommunity_image().split("\\|");
							//대표이미지는 맨처음 이미지 img[0]
									
							/* String str = "Aespa LOVE LETTER EARRINGSdetail1.jpg";
							if(str.equals(img[0])){
								System.out.println("동일");
							} */
							System.out.println("img[0]:"+img[0]);
						}
						
				%>		
					<div class="card">
					<%if(cdto.getCommunity_image() != null ){
				%>
					<img alt="" src="./resources/upload/community/<%=img[0] %>" class="card_image"> 
					<% }else{//올린 이미지가 없을 경우 %>
					
					 <img alt="" src="./resources/upload/logo.png" class="card_image">
					<% }%>
				
				
				<%
					List<BoardCategoryDTO> cList = (List<BoardCategoryDTO>)request.getAttribute("cList");
					String categoryName = "";
					for(int j=0; j<cList.size(); j++){
						
						BoardCategoryDTO category = cList.get(j);
						
						if(category.getCategory_cno() == cdto.getCategory_cnofk()){
							
							categoryName = category.getCategory_cname();
					}
							}//카테고리 for문 
					
				%>	
				<div class="card_category">
				 <span><%=categoryName %></span> | <span><%=cdto.getCommunity_date().substring(0,10) %></span>
				</div>
				<div class="card_content">
				<p>
					<%
						if(cdto.getCommunity_cont().length() > 30){ //30자이상일 경우
					%>
						<%=cdto.getCommunity_cont().substring(0,30) %>...
					<% 	}else{ %>
						<%=cdto.getCommunity_cont() %>	
							
					<%} %>
					
				</p>
				</div>
				<div class="card_userid">
					<div class="userid_img">
						<img src="./resources/upload/member_image/${dto.getMember_no() }/${dto.getMember_image() }" alt="member_image">
					</div>
					<div>
						<%=cdto.getCommunity_userid() %>
					</div>
				</div>
				<div class="card_info">
					<div>
						<i class="material-symbols-outlined">thumb_up</i><%=cdto.getCommunity_recommend() %>
						&nbsp;&nbsp;<i class="material-symbols-outlined">visibility</i><%=cdto.getCommunity_hit() %>
					</div>
						<div>
						<a href="<%=request.getContextPath()%>/community_boardContent.do?bno=<%=cdto.getCommunity_no() %>" class="card_link">Read More</a>
					</div>
				</div>
			</div> <!-- class="card" end  -->
					
				<%} %>
			
			</div>
			</c:if>
		</div><!-- class="feed_main" end -->
	
	</div><!-- class="myfeed_container" end -->
	</div>
	<%@include file="../include/user_bottom.jsp" %>

	
	
</body>
</html>