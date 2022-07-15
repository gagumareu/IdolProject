<%@page import="com.idol.model.BoardCategoryDTO"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.idol.model.CommunityDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="com.idol.model.MusicDTO"%>
<%@page import="com.idol.model.FollowDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${id }님의 피드 - Like</title>
<link href="https://fonts.googleapis.com/css2?family=Material+Icons"
      rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols"
      rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="./resources/css/member.css?v=2022063010">

<style type="text/css">

.posting_cards{
	background-color:white;
	padding:30px;
	
	margin:0 auto;
	max-width: 1000px;
	display:grid;
    grid-template-columns:repeat(auto-fill,minmax(220px,1fr));
	gap:20px;
	
}
	
 .card{
	box-shadow: 0 0 3px rgba(0,0,0, 0.1);
	heihgt:100%;
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
	<c:set var="dto" value="${feedInfo.get('mInfo') }"/> <!-- 피드회원정보 -->
	<c:set var="comm" value="${feedInfo.get('commList') }"/> <!--피드 회원의 커뮤니티게시글 리스트 -->
	<c:set var="cList" value="${cList }"/> <!-- 커뮤니티 카테고리 리스트 -->
	<%@include file="../include/user_top.jsp" %>
	
	<div class="feed_wrapper" align="center">
	<div class="myfeed_container" align="center">
		<!-- myfeed_top include 추가  -->
		<jsp:include page="../include/feed_top.jsp"/>
		
		<div class="feed_main">
			<div class="feed_title">
				<table>
					<tr>
						<td>
							<a href="<%=request.getContextPath() %>/myfeed.do?id=${dto.getMember_id()}" style="color: gray; ">
							ABOUT
							</a>
						</td>
						<td style="border-bottom:1px solid #2a3a52">
							<a href="#" style="color: black;">POSTING</a>
						</td >
						<td >
							<a href="<%=request.getContextPath() %>/feed_like.do?id=${dto.getMember_id()}" style="color: gray;">LIKE♥</a>
						</td>
					</tr>
				</table>
			</div><!-- class="feed_title"  end -->
			
			
			
			
			<div class="posting_cards" >
			<c:if test="${empty comm }">
			<p> 작성한 게시글이 없습니다.</p>
			</c:if>
			<c:if test="${!empty comm }">
			
			<%
			HashMap<String, Object> map = (HashMap<String, Object>)session.getAttribute("feedInfo");
			List<CommunityDTO> list = (List<CommunityDTO>)map.get("commList");
			
			for(int i=0; i<list.size(); i++){
				
				CommunityDTO cdto = list.get(i);
				
				String[] img = null;
				
				//이미지가 있는경우, 대표이미지 하나만 뽑아내기 
				if(cdto.getCommunity_image() != null ){
					img = cdto.getCommunity_image().split("\\|");
					System.out.println(img[0]);
				}
				/* String upload = "Aespa earing.jpg"; */
				
		%>
				<div class="card" >
				<!-- 이미지 값을 넣으면 java.lang.NullPointerException + checked_encoding 에러
					 net::ERR_INCOMPLETE_CHUNKED_ENCODING ===> 파일명 길이를 수정하니까 오류 해결
				 -->
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
					 <span><%=categoryName %></span> | 
					 <span><%=cdto.getCommunity_date().substring(0, 10) %></span>
				</div> <!-- class="card_category" -->
				
				<div class="card_content">
				<p>
			<%
					if(cdto.getCommunity_cont().length()>30){ //내용이 30자 이상일 경우 30자 까지만 보이기
						
			%>			
						<%=cdto.getCommunity_cont().substring(0, 30) %> ...	
						
			<% 		}else{  %>
						<%=cdto.getCommunity_cont() %>
						
			<%} %>	
				</p>
			</div><!-- class="card_content" -->
			<div class="card_userid">
					<div class="userid_img">
						<img src="./resources/upload/member_image/${dto.getMember_no() }/${dto.getMember_image() }" alt="member_image">
					</div>
					<div>
						<%=cdto.getCommunity_userid() %>
					</div>
				</div><!-- class="card_userid" end -->		
			<div class="card_info">
					<div>
						<i class="material-symbols-outlined">thumb_up</i><%=cdto.getCommunity_recommend() %>
						&nbsp;&nbsp;<i class="material-symbols-outlined">visibility</i><%=cdto.getCommunity_hit() %>
					</div>
						<div>
						<a href="<%=request.getContextPath()%>/community_boardContent.do?bno=<%=cdto.getCommunity_no() %>" class="card_link">Read More</a>
					</div>
				</div><!-- class="card_info" end -->	
				
				</div><!-- class="card" end  -->
	 <% }//for문 %>
			
			</c:if>
			</div><!-- class="posting_cards" -->
			
			
			
			
		
		</div><!-- class="feed_main" end -->
	
	</div><!-- class="myfeed_container" end -->
	</div>

	
	<%@include file="../include/user_bottom.jsp" %>
</body>
</html>