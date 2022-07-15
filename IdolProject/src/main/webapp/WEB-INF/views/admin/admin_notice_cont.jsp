<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN NOTICE CONTENT</title>


<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">

<style type="text/css">
	
	html, body {
		margin: 0px;
		padding: 0px;
		height: 100%;
		background-color: black;
	}
	
	.admin_notice_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	}
	
	ul {
		list-style-type: none;
	}
	


	
	.admin_notice_container {
		display: flex;
   		flex-direction: row;
		align-items: center;
		justify-content: center;
	}
	
	.notice_cont_slider {
		/*width: 500px;*/
		/*height: 600px;*/
		width: 40%;
		height: 40%;
	}
	
	.notice_cont_slider img{
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
	
	.slick-dots {
		display: flex;
		color: white;
		background-color: black;
		font-family: 'Press Start 2P', cursive;
		
	}
	
	
	.admin_notice_box {
		color: white;
		width: 30%;
		margin-left: 10%;
		font-family: 'Press Start 2P', 'Gugi', 'VT323', cursive;
	}
	
	
	.notice_cont_btn {
		display: flex;
   		justify-content: center;
   		margin-top: 13px;
   		
	
	}
	
	.btn {
		background-color: black;
		color: white;
		font-family: 'Creepster', cursive;
		font-size: 1.88em;
		cursor: pointer;
	}
	
	.btn:hover {
		color: red;
	
	}
	.celeb_name {
		margin-top: 10px;
		color: gold;
	
	}
	
	.title {
		/*color: red;*/
		line-height: 1.2;
	}
</style>
</head>
<body>

	<c:set var="cont" value="${noticeCont }" />
	<c:set var="imgs" value="${arrToken }" />
	
	<div class="admin_notice_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_notice_include.jsp" />
	
		
	
	
	
		<div class="admin_notice_container">
		
			<div class="notice_cont_slider">
				<c:forEach items="${arrToken }" var="imgs">
			    	<img alt="" src="./resources/upload/notice/${imgs }">
			    </c:forEach>
			 </div> <!-- notice_cont_slider -->
		 
			<div class="admin_notice_box">
				
					<div class="title">
						${cont.notice_title }
					</div>
					<c:if test="${cont.group_name != null }">
						<div class="celeb_name"> ${cont.group_name }</div>
					</c:if>
					<c:if test="${cont.group_name == null }">
						
					</c:if>
				
					<c:if test="${cont.celeb_name != null }">
						<div class="celeb_name"> ${cont.celeb_name }</div>
					</c:if>
					<c:if test="${cont.celeb_name == null }">
						
					</c:if>
					
					<div>
						<p style="line-height: 1.35">${cont.notice_cont }</p>
						
					</div>
					
					
					<div style="line-height: 1.17">
						<div>
							ABOUT: ${cont.notice_type}
						</div>
						<div>
							VIEWS: ${cont.notice_hit}
						</div>
						<div>
							<c:if test="${cont.notice_update == null }">
								DATE: ${cont.notice_date.substring(0, 10) }
							</c:if>
							<c:if test="${cont.notice_update != null }">
								UPDATE : ${cont.notice_update.substring(0, 10) }
							</c:if>
						</div>
						<div style="color: gold">
							<c:if test="${cont.notice_enddate == null }">
								
							</c:if>
							<c:if test="${cont.notice_enddate != null }">
								END DATE: ${cont.notice_enddate.substring(0, 10) }
							</c:if>
							
						</div>
					</div>
				<div class="notice_cont_btn">
					<input class="btn" type="button" value="MODIFY"
						onclick="location.href='<%=request.getContextPath()%>/admin_notice_modify.do?no=${cont.notice_no }&imgs=${cont.notice_image }'">
					<input class="btn" type="button" value="DELETE"
						onclick="if(confirm('삭제 하시겠습니까 ?? :(')){
							location.href='<%=request.getContextPath()%>/admin_notice_delete.do?no=${cont.notice_no }&imgs=${cont.notice_image }'
								}else {return}">
					<input class="btn" type="button" value="BACK"
						onclick="location.href='admin_notice_list.do'">
				</div>
			</div><!-- admin_notice_box -->
			
		</div> <!-- the end of admin_notice_container -->
		
	</div> <!-- the end of admin_notice_wrapper -->
	
	

	

<script type="text/javascript">

	$('.notice_cont_slider').slick({
		  dots: false,
		  infinite: true,
		  speed: 500,
		  fade: true,
		  cssEase: 'linear',
		  autoplay: true,
		  adaptiveHeight: true,
		  arrows: false,
		  pauseOnFocus: true
		 
		  
		});
							

</script>
	
	
	
</body>
</html>