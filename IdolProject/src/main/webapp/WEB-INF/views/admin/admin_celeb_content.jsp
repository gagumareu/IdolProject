<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN CELEB CONTENT</title>

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>


<style type="text/css">
	
	html, body {
		margin: 0px;
		padding: 0px;
		height: 100%;
		background-color: black;
		
	}
	
	a {
		text-decoration: none;
	}
	.admin_content_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100%;
		
	}
	
	ul {
		list-style-type: none;
	}
	
	
	
	.admin_content_container {
		display: flex;
   		flex-direction: row;
		align-items: center;
		justify-content: center;
		
	}
	
	
	
	
	.admin_content_box {
		color: white;
		font-family: 'VT323', 'Jua', monospace;
		font-size: 1.6em;
		margin-left: 10%;
	}
	
	
	.celeb_detail_box {
		display: flex;
	    flex-direction: column;
	    align-items: center;
	
	}
	
	
	.content_btns {
		margin: 13px 0px;
	    display: flex;
	    justify-content: center;
	
	}
	
	.content_btns input{
		font-family: 'Creepster', cursive;
		color: white;
		background-color: black;
		cursor: pointer;
		font-size: 1.3em;
	}
	
	.content_btns input:hover {
		color: red;
	}
	
	.celeb_noticeNevent_box {
		width: 600px;
		/*height: 400px;*/
	
	}
	
	.celeb_noticeNevent_box {
		color: white;
		justify-content: center;
	    display: flex;
	    flex-direction: column;
		margin-bottom: 23px;
	}
	
	
	.notice_title {
		align-self: center;
		display: flex;
		flex-direction: row;
	}
	
	
	
	/********* slider ********/
	.celeb_slider {
		/*width: 500px;*/
		/*height: 600px;*/
		width: 40%;
		height: 40%;
		position: sticky;
		top: 50px;
	}
	
	.celeb_slider img{
		width: 100%;
		height: 100%;
		cursor: pointer;
	}
	
	
	.draggable {
   		height: 100%;
		width: 100%;
	}
	
	.slick-track {
		height: 100%;
		width: 100%;
	}
	
	.notice_cont {
		display: none;
	}
	
	.notice_title {
		color: gold;
	}
	
	.click_this_img {
		color: red;
		background-color: red;
		font-size:
	}
	
	
</style>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&display=swap" rel="stylesheet">

<script type="text/javascript">

	$(function(){
		$('.notice_title').click(function(){
			$(this).next().slideToggle().siblings('.notice_cont').slideUp();
		});
		
	});

</script>
</head>
<body>
	
	<!-- 셀럽 개인 정보 불러고익 by no -->
	<c:set var="cont" value="${celebContByNo }" />
	<!-- 개인 이미지 배열 불러오기 -->
	<c:set var="imgs" value="${arrtokened }" />
	<!-- 셀럽에 관련된 공지 & 이벤트 정보 리스트 -->
	<c:set var="clist" value="${cList }" />
	<!-- 그룹에 관련된 공지 & 이벤트 정보 리스트 -->
	<c:set var="glist" value="${gList }" />
	
	<div class="admin_content_wrapper">
	
		<jsp:include page="../include/admin_top_include.jsp" />
		<jsp:include page="../include/admin_link_include.jsp" />
	
		<div class="admin_content_container">
		
			<div class="celeb_slider">
				<c:forEach items="${arrtokened }" var="imgs">
						<img alt="" src="./resources/upload/celeb/${imgs }">
				</c:forEach>
			</div>
			
			<div class="admin_content_box">
				<div class="celeb_detail_box">
					<div>
						<c:if test="${cont.celeb_group != 'solo' }">
							${cont.celeb_group }
						</c:if>
						<c:if test="${cont.celeb_group == 'solo' }">
						</c:if>
					</div>
					<div>
						${cont.celeb_name } (${cont.celeb_realname })
					</div>
					<div>
						AGENT : ${cont.celeb_agency }
					</div>
					<div>
						BORN : ${cont.celeb_dateofbirth.substring(0, 10) }
					</div>
					<div>
						YEARS ACTIVE : ${cont.celeb_debutdate.substring(0, 10) }
					</div>
				</div>	<!-- celeb_detail_box -->
				
				<div class="content_btns">
					<input type="button" value="MODIFY"
						onclick="location.href='admin_celeb_modify.do?no=${cont.celeb_no}'">
					<input type="button" value="DELETE"
						onclick="if(confirm('삭제 하시겠습니까 ?? :(')){
							location.href='<%=request.getContextPath()%>/celeb_delete.do?no=${cont.celeb_no }&img=${cont.celeb_pimage }'
								}else {return}">
					<input type="button" value="BACK"
						onclick = "location.href='admin_celeb_list.do'">
				</div>
				
				<c:forEach items="${clist }" var="cNdto">
					<c:if test="${!empty cNdto.celeb_name }">
						<div class="celeb_noticeNevent_box">
							<div class="notice_title">
								[${cNdto.notice_title }]
							</div>
							<div class="notice_cont">
								${cNdto.notice_cont }
							</div>
						</div>
					</c:if>
				</c:forEach>
				<c:forEach items="${glist }" var="gNdto">
					<c:if test="${cont.celeb_group == gNdto.group_name }">
						<div class="celeb_noticeNevent_box">
							<div class="notice_title">
								[${gNdto.notice_title }]
							</div>
							<div class="notice_cont">
								${gNdto.notice_cont }
							</div>
						</div>
					</c:if>
				</c:forEach>
						
			</div> <!-- admin_content_box -->
			

			
			
		</div> <!-- the end of admin_content_container -->
	</div> <!-- the end of admin_content_wrapper -->
	
<script type="text/javascript">

	$('.celeb_slider').slick({
		  dots: false,
		  infinite: true,
		  speed: 250,
		  fade: true,
		  cssEase: 'linear',
		  autoplay: true,
		  adaptiveHeight: true,
		  arrows: false,
		 
		  
		});
							

</script>		
	
	
	
	
	
	
</body>
</html>