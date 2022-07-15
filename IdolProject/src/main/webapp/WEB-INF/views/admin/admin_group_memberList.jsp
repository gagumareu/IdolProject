<%@page import="com.idol.model.CelebDTO"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="com.idol.model.NoticeDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN GROUP MEMBER LIST</title>

<script src="http://code.jquery.com/jquery-3.6.0.js"></script>

<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js" integrity="sha256-xH4q8N0pEzrZMaRmd7gQVcTZiFei+HfRTBPJ1OGXC0k=" crossorigin="anonymous"></script>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">

<style type="text/css">
	html, body {
		padding: 0px;
		margin: 0px;
		height: 100%;
		background-color: black;
	}
	
	
	li {
		list-style-type: none;
		
	}
	a {
		text-decoration: none;
	}
	
	
	
	.admin_member_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	
	}
	
	.group_member_container {
		display: flex;
		margin: 50px 0px;
		height: 700px;
	}
	
	
	.group_info {
		color: white;
		width: 60%;
	    display: flex;
	    flex-direction: column;
	    /* justify-content: center; */
	    align-items: center;
	}
	

	.admin_memberBoxes_container {
		display: flex;
	    flex-direction: row;
	    flex-wrap: wrap;
	    gap: 10px;
	    color: white;
	    flex: 50%;
    	max-width: 50%;
    	justify-content: center;
    	align-items: center;
	}
	
	.admin_member_box{
		width: 200px;
		height: 200px;
		color: white;
		border-radius: 100px;
		
	}
	
	
	

	.admin_group_imageBox {
		justify-content: center;
    	align-items: center;
   	 	display: flex;
		flex: 50%;
   	 	max-width: 50%;
	}
	.img_box {
		width: 70%;
		height: 70%;
		
	}
	
	
	.admin_group_imageBox img {
		width: 100%;
		height: 100%;
		border-radius: 20px;
	}
	
	.celeb_noticeNevent {
		color: white;
		font-family: 'Press Start 2P', 'Jua', monospace;
		margin: 25px;
		width: 60%;
	}
	
	.celeb_noticeNevent a{
		color: white;
	}
	.celeb_notice_boexs {
		margin-bottom: 20px;	
		display: flex;
	    flex-direction: column;
	    align-items: center;
	
	}
	
	
	
	.slick-track {
		width: 100%;
		height: 100%;
		
	}
	
	.slick-list draggable {
		height: 100%;
		width: 100%;
		
	}
	
	
	.group_info_container {
		display: flex;
	    flex-direction: column;
	    justify-content: center;
	    align-items: center;
	    margin-bottom: 20px;
	}
	
	
	.group_info_text{
		font-family: 'Press Start 2P', 'Jua', monospace;
		margin-bottom: 20px;
	
	}
	
	.group_name {
		font-family: 'Bungee Shade','Jua', cursive;
		font-size: 1.9em;
	}
	
	.btn{
		background-color: black;
		color: white;
		font-family: 'Creepster', cursive;
		font-size: 1.9em;
		cursor: pointer;
		
	}
	
	.btn:hover {
		color: red;
	}
	
	.notice_title {
		font-size: 1.2em;
	}
	
	.notice_text {
		display: none;
	}
	
	.celeb_img {
		width: 100%;
		height: 100%;
	
	}
	
	.celeb_img img {
		width: 100%;
		height: 100%;
		overflow: hidden;
		border-radius: 100px;
	}
	.celeb_img img:hover {
		opacity: 0.6;
	}
</style>

<script type="text/javascript">

 	$(function(){
 		$('.notice_title').click(function(){
 			$('.notice_text').slideToggle();
 		});
 	});
	
	

</script>


</head>
<body>
	<c:set var="mList" value="${gmList }" />
	<c:set var="cont" value="${gCont }" />
	<c:set var="gimgs" value="${arrGourpImg }" />
	<c:set var="nlist" value="${nList }" />
	
	<div class="admin_member_wrapper">
		
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_group_include.jsp" />	
	
		<div class="group_member_container">
		
				<div class="admin_group_imageBox">
					<c:forEach begin="1" items="${arrGourpImg }" var="gimgs">
						<div class="img_box">
							<img style="box-shadow: 2px 3px 20px 19px #d1b6b6;" alt="" src="./resources/upload/group/${gimgs }">
						</div>
					</c:forEach>
				</div>
			
			<div class="admin_memberBoxes_container">
			
			
			<%
			List<CelebDTO> list = (List<CelebDTO>)request.getAttribute("gmList");
			
			for(int i = 0; i < list.size(); i++){
				
				CelebDTO dto = list.get(i);
				
				String imgs = dto.getCeleb_pimage();
				
				StringTokenizer imgsToken = new StringTokenizer(imgs, "|");
				
				String[] imgsArray = new String[imgsToken.countTokens()];
				
				for(int j = 0; j < imgsArray.length; j++){
					
					imgsArray[j]=imgsToken.nextToken();
				}
				%>
					
						<a href="<%=request.getContextPath()%>/admin_celeb_content.do?no=<%=dto.getCeleb_no()%>">
							<div class="admin_member_box">
								
 								<div class="celeb_img"> 
 									<img alt="" src="./resources/upload/celeb/<%=imgsArray[0]%>"> 
 								</div> 
								
<!-- 								<div> -->
<!-- 									<div> -->
<%-- 										가수 명 : <%=dto.getCeleb_name() %> --%>
<!-- 									</div> -->
<!-- 									<div> -->
<%-- 										본명 : <%=dto.getCeleb_realname() %> --%>
<!-- 									</div> -->
<!-- 								</div>				 -->
							</div> <!-- admin_member_box -->
						</a>
				<%}%>

				
			</div> <!-- admin_memberBoxes_container -->
			
		</div> <!-- group_member_container -->
		
		
		<div class="group_info_container">
			
			<div class="group_info">
				<div class="group_name">
					${cont.group_name }
				</div>
				<div class="group_info_text">
					${cont.group_info }
				</div>
				<div class="group_btns">
					<input class="btn" type="button" value="MODIFY"
					onclick="location.href='admin_group_modify?no=${cont.group_no}'">
					
					<input class="btn" type="button" value="DELETE"
					onclick="if(confirm('그룹을 삭제 하시렵니까? :(')){
						 location.href='admin_group_delete.do?no=${cont.group_no}&&imgs=${cont.group_image}'
					}else {return; }">
				</div>
			</div> <!-- group_info -->
		
		
			
			
			<div class="celeb_noticeNevent">
				<c:forEach items="${nlist }" var="ndto">
					<c:if test="${!empty ndto.group_name}">
						<div class="celeb_notice_boexs">
							<div class="notice_title">
								[${ndto.notice_title }]
							</div>
							
							<div class="notice_text">
								${ndto.notice_cont } 
								<a href="<%=request.getContextPath()%>/admin_notice_content.do?no=${ndto.notice_no}">
								<span style="color: gold">[LINK]</span>
								</a>
							</div> 
						</div><!-- celeb_notice_boexs -->
					</c:if>
				</c:forEach>
			</div> <!-- celeb_noticeNevent -->
			
		</div>	
		
	</div><!-- admin_member_wrapper -->
<script type="text/javascript">

// 	$('.admin_group_imageBox').slick({
// 	  dots: false,
// 	  infinite: true,
// 	  speed: 500,
// 	  fade: true,
// 	  cssEase: 'linear',
// 	  autoplay: true,
// 	  autoplaySpeed: 5000,
// 	  arrows: false
// 	});


</script>

		
	
</body>
</html>