<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.rankWrapper{
	width: 980px;
	min-height: 80%;
	margin: 0 auto;
	margin-top: 40px;
	display: flex;
}
.sidenav {
  height: 100%;
  width: 240px;
  z-index: 1;
  top: 100px;
  left: 250px;
  background-color: white;
  overflow-x: hidden;
  padding-top: 20px;
  
}


.sidenav_menu{
padding-bottom: 16px;
}
.sidenav a {
  padding: 6px 6px 6px 6px;
  text-decoration: none;
  font-size: 20px;
  color: #242424;
  display: block;
  padding-bottom:
}
.sidenav a:hover {
  color: red;
}
.main {
  margin-left: 200px; /* Same as the width of the sidenav */
}

.w_ranking_title_value{
margin: 24px 0;

}

.overview_blocks{
padding: 8px;
}

.member_block{
display: flex;
text-align: center;
}

.member_block img{
align-items: center;
width: 32px;
height: 32px;
}
#member_nickname_div{
flex: 1;
min-width: 0;
vertical-align: top;
padding-left: 16px;
text-align: left;
}

#member_score_div{
padding-left: 16px;
padding-right: 16px;
}

#w_ranking_cate_value{
margin-bottom: 24px;
color: #7082A7
}

.overview_blocks{
display: flex;
flex-wrap: wrap;
margin-bottom: 40px;

}

.overview_block{
	width: 33.33%;
	padding: 16px;
}

.overview_block img{
	width:24px;
	height:24px;
}

.overview_block .overview_title {
	font-size: 18px;
	font-weight: 600;
	display: block;
}

.overview_block ul {
	padding: 14px 0;
}

.overview_block .overview_item {
	display: flex;
	align-items: center;
	height: 36px;
}

.overview_block .overview_item .overview_img_wrap {
	width: 36px;
	height: 36px;
	border-radius: 50%;
	overflow: hidden;
}

.overview_block .overview_item .overview_img_wrap img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.overview_block .overview_item .member_nickname {
	flex: 1;
	margin-left: 10px;
}

.overview_block .overview_item + .overview_item {
	margin-top: 10px;
}

.overview_block .overview_block_seemore {
	text-align: center;
	font-size: 14px;
	padding: 4px 0;
	background-color: #E1F6FF;
 	color: #0984C1;
 	-webkit-border-radius: 3px;
 	cursor:pointer;
}

.overview_block .overview_block_seemore:hover{
	background: #0984C1;
	color: #E1F6FF;
	cursor:pointer;
}

.w_rank_cont_wrap{
	width: 100%;
}


</style>
</head>
<body>
<%@include file="../include/user_top.jsp" %>
	
	<div class="rankWrapper">	
<%@include file="../include/ranking_sidebar.jsp" %>
		<c:set var="milist" value="${miList }"/>
		<c:set var="plist" value="${puList }"/>
		<c:set var="melist" value="${meList }"/>
		<c:set var="bilist" value="${birthList }"/>
		<c:set var="relist" value="${reList }"/>
		<c:set var="colist" value="${coList }"/>
		
		<div class="w_rank_cont_wrap">
			<div class="w_ranking_title">
				<h1 class="w_ranking_title_value">Notable members</h1>
			</div>
			
			
			<div class="overview_blocks">
				<div class="overview_block">
					<a class="overview_title" href="<%=request.getContextPath()%>/detail_ranking.do?key=point">Most point</a>
					<ul>
						<c:forEach items="${milist }" var="midto">
							<li class="overview_item">
							
							
								<div class="overview_img_wrap">
								<c:if test="${!empty midto.member_image }">
									<img src="./resources/upload/member_image/${midto.member_no }/${midto.member_image }">
								</c:if>
								<c:if test="${empty midto.member_image }">
									<img src="./resources/upload/celeb/프사없음.jpeg">
								</c:if>
								</div>
								<span class="member_nickname">
									<a href="<%=request.getContextPath()%>/myfeed.do?id=${midto.member_id}">${midto.member_nickname }</a>
								</span>
								<span class="member_score">
									<fmt:formatNumber value="${midto.score }" />
								</span>
							</li>
						</c:forEach>
					</ul>
					<div class="overview_block_seemore">
						<a href="<%=request.getContextPath()%>/detail_ranking.do?key=point">See more</a>
					</div>
				</div>
				
				<div class="overview_block">
					<a class="overview_title" href="<%=request.getContextPath()%>/detail_ranking.do?key=purchase">Most purchase</a>
					<ul>
						<c:forEach items="${plist }" var="pdto">
							<li class="overview_item">
								<div class="overview_img_wrap">
								<c:if test="${!empty pdto.member_image }">
									<img src="./resources/upload/member_image/${pdto.member_no }/${pdto.member_image }">
								</c:if>
								<c:if test="${empty pdto.member_image }">
									<img src="./resources/upload/celeb/프사없음.jpeg">
								</c:if>
								</div>
								<span class="member_nickname">
									<a href="<%=request.getContextPath()%>/myfeed.do?id=${pdto.member_id}">${pdto.member_nickname }</a>
								</span>
								<span class="member_score">
									<fmt:formatNumber value="${pdto.score }" />
								</span>
							</li>
						</c:forEach>
					</ul>
					<div class="overview_block_seemore">
						<a href="<%=request.getContextPath()%>/detail_ranking.do?key=purchase">See more</a>
					</div>
				</div>
				
				<div class="overview_block">
					<a class="overview_title" href="<%=request.getContextPath()%>/detail_ranking.do?key=message">Most message</a>
					<ul>
						<c:forEach items="${melist }" var="medto">
							<li class="overview_item">
								<div class="overview_img_wrap">
								<c:if test="${!empty medto.member_image }">
									<img src="./resources/upload/member_image/${medto.member_no }/${medto.member_image }">
								</c:if>
								<c:if test="${empty medto.member_image }">
									<img src="./resources/upload/celeb/프사없음.jpeg">
								</c:if>
								</div>
								<span class="member_nickname">
									<a href="<%=request.getContextPath()%>/myfeed.do?id=${medto.member_id}">${medto.member_nickname }</a>
								</span>
								<span class="member_score">
									<fmt:formatNumber value="${medto.score }" />
								</span>
							</li>
						</c:forEach>
					</ul>
					<div class="overview_block_seemore">
						<a href="<%=request.getContextPath()%>/detail_ranking.do?key=message">See more</a>
					</div>
				</div>
				
				
				
				<div class="overview_block">
					<a class="overview_title"href="<%=request.getContextPath()%>/detail_ranking.do?key=referrals">Most referrals</a>
					<ul>
						<c:forEach items="${relist }" var="rdto">
							<li class="overview_item">
								<div class="overview_img_wrap">
								<c:if test="${!empty rdto.member_image }">
									<img src="./resources/upload/member_image/${rdto.member_no }/${rdto.member_image }">
								</c:if>
								<c:if test="${empty rdto.member_image }">
									<img src="./resources/upload/celeb/프사없음.jpeg">
								</c:if>
								</div>
								<span class="member_nickname">
									<a href="<%=request.getContextPath()%>/myfeed.do?id=${rdto.member_id}">${rdto.member_nickname }</a>
								</span>
								<span class="member_score">
									<fmt:formatNumber value="${rdto.score }" />
								</span>
							</li>
						</c:forEach>
					</ul>
					<div class="overview_block_seemore">
						<a href="<%=request.getContextPath()%>/detail_ranking.do?key=referrals">See more</a>
					</div>
				</div>
				
				<div class="overview_block">
					<a class="overview_title" href="<%=request.getContextPath()%>/detail_ranking.do?key=comment">Most comment</a>
					<ul>
						<c:forEach items="${colist }" var="cdto">
							<li class="overview_item">
								<div class="overview_img_wrap">
								<c:if test="${!empty cdto.member_image }">
									<img src="./resources/upload/member_image/${cdto.member_no }/${cdto.member_image }">
								</c:if>
								<c:if test="${empty cdto.member_image }">
									<img src="./resources/upload/celeb/프사없음.jpeg">
								</c:if>
								</div>
								<span class="member_nickname">
									<a href="<%=request.getContextPath()%>/myfeed.do?id=${cdto.member_id}">${cdto.member_nickname }</a>
								</span>
								<span class="member_score">
									<fmt:formatNumber value="${cdto.score }" />
								</span>
							</li>
						</c:forEach>
					</ul>
					<div class="overview_block_seemore">
						<a href="<%=request.getContextPath()%>/detail_ranking.do?key=comment">See more</a>
					</div>
				</div>
				
				<div class="overview_block">
					<a class="overview_title" href="<%=request.getContextPath()%>/detail_ranking.do?key=birth">Today's birthdays</a>
					<ul>
						<c:forEach items="${bilist }" var="bdto">
						<c:if test="${biList.size() <=0}">
							<div>
							
							</div>
						</c:if>
						<c:if test="${biList.size() > 0 }">
							<li class="overview_item">
								<div class="overview_img_wrap">
								<c:if test="${!empty bdto.member_image }">
									<img src="./resources/upload/member_image/${bdto.member_no }/${bdto.member_image }">
								</c:if>
								<c:if test="${empty bdto.member_image }">
									<img src="./resources/upload/celeb/프사없음.jpeg">
								</c:if>
								</div>
								<span class="member_nickname">
									<a href="<%=request.getContextPath()%>/myfeed.do?id=${bdto.member_id}">${bdto.member_nickname }</a>
								</span>
								
								<c:if test="${bdto.score <= 0 }">
									<span>
										
									</span>
								</c:if>
								<c:if test="${bdto.score > 0 }">
								<span class="member_score">
									<fmt:formatNumber value="${bdto.score }" />
								</span>
								</c:if>
							</li>
						</c:if>
						</c:forEach>
					</ul>
					<c:if test="${biList.size() <=0}">
							<div>
							
							</div>
					</c:if>
					<c:if test="${biList.size() > 0 }">
					<div class="overview_block_seemore">
						<a href="<%=request.getContextPath()%>/detail_ranking.do?key=birth">See more</a>
					</div>
					</c:if>
				</div>
			</div>
		</div>
		
		
		
	</div>	
		
	
	<%@include file="../include/user_bottom.jsp" %>
</body>
</html>