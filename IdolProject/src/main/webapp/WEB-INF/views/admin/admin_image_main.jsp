<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN IMAGES MAIN</title>


<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">

<style type="text/css">
	
	
	html, body {
		padding: 0px;
		margin: 0px;
		height: 100%;
		background-color: black;
	}
	
	a {
		text-decoration: none;
		color: white;
	}
	
	
	
	.admin_images_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	
	}
	


	.admin_images_container {
		display: flex;
		
		/*align-self: center;*/
	    
	}
	
	/****************************************/
	
	#rigth_side{
		flex: 50%;
		max-width: 100%;
		margin-top: 138px;
   		display: flex;
	    flex-direction: column;
	    align-items: center;

	}
	
	.admin_images_content_right{
		
		display: flex;
		flex-direction: column;
		height: 600px;
		margin-bottom: 170px;
		margin-right: 155px;
	}
	
	.images_right_no {
		width: 30px;
		height: 50px;
		color: white;
		font-family: 'Press Start 2P', cursive;
		font-size: 1.9em;
		
    	
	}
	
	
	.images_content__detail {
		height: 100%;
		
	}
	
	.rignt_link {
		width: 100%;
	}
	
	
	
/*************************************/	
	#left_side {
		flex: 50%;
		max-width: 100%;
		display: flex;
	    flex-direction: column;
	    align-items: center;
		
	}
	
	.admin_images_content_left{
		
		display: flex;
		flex-direction: column;
		height: 600px;
		margin-bottom: 170px;
		margin-left: 155px;
		
	}
	
	.images_left_no {
		width: 30px;
		height: 50px;
		color: white;
		font-family: 'Press Start 2P', cursive;
		font-size: 2.1em;
		display: flex;
		align-self: end;
	}
	
	
	
	
	
	.images_content_left_detail {
		height: 100%;
	}
	
	.rignt_link {
		width: 100%;
	}
	
	
	
	
	
/***********************************/	
	.images_text {
		width: 100%;
		font-family: 'Press Start 2P', Gamja Flower, cursive;
		font-size: 0.7em;
		width: 450px;
    	line-height: 1.5;
    	margin-top: 20px;
    	margin-left: 10px;
    	
	}
	

	.images_content_box {
		width: 520px;
   		height: 460px;
		
	
	}
	
	
	
	
	.slider-nav {
		margin-left: 3%;
		margin-bottom: 50px;	
		
	}
	
	.slider-nav img{
		width: 88%;
	}
	
	.image_link {
		width: 800px;
		height: 1000px;
		align-content: cenber;
		
	}
	
	.images_img {
		width: 100%;
		height: 100%;
	}
	.images_box_img {
		width: 100%;
		height: 100%;
		border-radius: 30px;
	}
	
	
	.slider_numbering {
		font-family: 'Press Start 2P', cursive;
		color: gold;
		font-size: 1.3em;
		
	}
</style>


</head>
<body>
	<c:set var="ilist" value="${imagesList }" />
	
	<div class="admin_images_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_images_include.jsp" />
	
		<div class="slider-nav">
			<c:forEach items="${ilist }" var="dto" varStatus="num">
				<c:if test="${dto.image_visible == '1' }">
					<a class="image_link" href="admin_images_content.do?no=${dto.image_no}">
						<span class="slider_numbering">${num.count }</span><img alt="" src="./resources/upload/images/${dto.image_path }">
					</a>
				</c:if>
			</c:forEach>
		</div> <!-- slider-nav -->
	
	
		<div class="admin_images_container">
		
			<c:if test="${!empty ilist }">
			
			<div id="left_side">
				<c:forEach items="${ilist }" var="dto">
					<c:if test="${dto.image_priority % 2 != 0 }">
						<div class="admin_images_content_left">
							<div class="images_left_no">
								 ${dto.image_priority }
							</div>
							
							<div class="images_content_box">
								<a class="rignt_link" href="<%=request.getContextPath()%>/admin_images_content.do?no=${dto.image_no}">
									
									<div class="images_content_left_detail">
										<div class="images_img">
											<img class="images_box_img" alt="" src="./resources/upload/images/${dto.image_path }">
										</div>
										<div class="images_text">
											<c:if test="${dto.image_visible == '1' }">
												<div style="color:gold">
													VISIBLE = ON
												</div>
											</c:if>
											<c:if test="${dto.image_visible == '0' }">
												<div style="color:red">
													VISIBLE = OFF
												</div>
											</c:if>			
											<div>
												IMAGE PATH = ${dto.image_path }
											</div>
											<div>
												IMAGE LINK = <span style="color:gold">${dto.image_link }</span>
											</div>
										</div><!-- images_text -->
									</div> <!-- images_content__detail -->
								</a>
								
							</div><!-- images_content_box -->
						</div> <!-- admin_images_content_ -->
					
					</c:if>
				</c:forEach>
			</div>
				
			<div id="rigth_side">
				<c:forEach items="${ilist }" var="dto">
					<c:if test="${dto.image_priority % 2 == 0 }">
					
						<div class="admin_images_content_right">
							
							<div class="images_right_no">
								 ${dto.image_priority }
							</div>
							
							<div class="images_content_box">
							<a class="rignt_link" href="<%=request.getContextPath()%>/admin_images_content.do?no=${dto.image_no}">
								
								<div class="images_content__detail">
									<div class="images_img">
										<img class="images_box_img" alt="" src="./resources/upload/images/${dto.image_path }">
									</div>
									<div class="images_text">
										<div>
											<c:if test="${dto.image_visible == '1' }">
												<div style="color:gold">
													VISIBLE = ON
												</div>
											</c:if>
											<c:if test="${dto.image_visible == '0' }">
												<div style="color:red">
													VISIBLE = OFF
												</div>
											</c:if>
										</div>				
										<div>
											IMAGE PATH = ${dto.image_path }
										</div>
										<div>
											IMAGE LINK = <span style="color:gold">${dto.image_link }</span>
										</div>
									</div>
								</div> <!-- images_content__detail -->
							</a>
								
							</div><!-- images_content_box -->
						</div> <!-- admin_images_content_ -->
					
					</c:if>
					
				</c:forEach>
			</div>
				
				
			</c:if>	
			
		</div> <!-- admin_images_container end  -->
		
	</div> <!-- admin_images_wrapper end -->
	
<script type="text/javascript">


	$('.slider-nav').slick({
	  slidesToShow: 3,
	  slidesToScroll: 1,
	  autoplay: true,
	  autoplaySpeed: 2000,
	  arrows: false,
	  pauseOnFocus: true
	});			


	

</script>
	
	
</body>
</html>