<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">

		
	.admin_navbar {
		display: flex;
		flex-direction: row;
		background-color: black;
		width: 100%;
		/* 스크롤 다운 시 메뉴바 적용 후 사용
		position: sticky;
		top:0px;
		z-index: 99;
		*/
	}	
	.admin_link {
		display: flex;
		flex-direction: row;
		width: 100%;
		flex-wrap: wrap;
		justify-content: space-evenly;
    	padding-right: 10px;
		align-items: center;
	}
	
	
	.admin_link a {
		
		text-decoration: none;
		font-family: 'Press Start 2P', cursive;
		color: white;
	}
	
	
	
	.include_top_title {
		/*font-family: 'Bungee Shade', cursive;*/
		font-family: 'Press Start 2P', cursive;
		color: white;
		width: 130px;
	}
	
	li {
		list-style-type: none;
	}
	
	.include_top_title {
		cursor: pointer;
		margin-left: 100px;
	}
	
	.admin_id_session {
		width: 130px;
		color: white;
		font-family: 'Creepster', cursive;
		font-size: 1.3em;
		padding: 13px 0px 13px 13px;
	}
	
	
	
	
	
	.celeb a:hover {
		color: gold;
	}
	
	
	.upBox_icon {
		
		font-size: 40px;
		position: fixed;
		right: 16px;
		bottom: 50px;
		display: none;
		color: white;
		cursor: pointer;
		z-index: 3;
	}
	
	.upBox_icon img:hover {
		color: red;
	}
	
	.upBox_icon img {
		width: 50px;
		height: 50px;
	}
</style>



<script src="https://kit.fontawesome.com/a705bacd4a.js" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />


<script src="http://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js" integrity="sha256-xH4q8N0pEzrZMaRmd7gQVcTZiFei+HfRTBPJ1OGXC0k=" crossorigin="anonymous"></script>

<script type="text/javascript">

	$(function(){
		$('.include_top_title').click(function(){
			location.href='<%=request.getContextPath()%>/admin_main.do'
		});	
	});

	// welcome 마우스 오버시 로그아웃 애니매이션
	$(function(){
		$('.admin_id_session').stop().mouseover(function(){
			$(this).animate({color:'red' }, 200, function(){
				$(this).text("LOGOUT");
			});
		})
		.mouseout(function(){
			$(this).stop().animate({color:'white'}, 200, function(){
				$(this).text("WELLCOME ${admin_id } :D");
			});
		})
		.click(function(){
			location.href='<%=request.getContextPath()%>/admin_logout.do';
		});
	});
	
	
	// 마우스 스크롤 애니메이션 탑 버튼 생성
	$(function(){
		$(window).scroll(function(){
			if($(this).scrollTop() >= 300){
				$('.upBox_icon').fadeIn();
			}else {
				$('.upBox_icon').fadeOut();
			}
		});
		
		$('.upBox_icon').click(function(){
			
			$('html, body').stop().animate({scrollTop:0},500);
		});
	});
	
</script>

</head>
<body>
	
	
		<!-- include  -->
		<div class="admin_navbar">
		
			<div class="include_top_title">
				<h2>YOUR CELEB</h2>
			</div>
			<div class="admin_link">
				<div class="celeb">
					<a href="<%=request.getContextPath() %>/admin_celeb_list.do">
						CELEB
					</a>
				</div>
				
				<div>
					<a href="<%=request.getContextPath() %>/admin_group_list.do">
						GROUP
					</a>
				</div>
				
				<div>
					<a href="<%=request.getContextPath() %>/admin_music_list.do">
						MUSIC
					</a>
				</div>
						
				<div>
					<a href="<%=request.getContextPath() %>/admin_images_list.do">
						IMAGES
					</a>
				</div>
					
				<div>
					<a href="<%=request.getContextPath() %>/admin_notice_list.do">
						NOTICE
					</a>
				</div>
				
				<div>
					<a href="<%=request.getContextPath() %>/admin_products_list.do">
						PRODUCTS
					</a>
				</div>
				<div>
					<a href="<%=request.getContextPath() %>/admin_member_main.do">
						MEMBER						
					</a>
				</div>
				
				<div class="admin_id_session" style="cursor: pointer">
					WELLCOME ${admin_id } :D
				</div>
			
			</div> <!-- admin_link -->
			
		</div> <!-- admin_navbar end -->
			
	
	<div class="upBox_icon">
	 <!--  <i class="fa-solid fa-arrow-up-long"></i> -->
	<img alt="" src="./resources/icon/ghost.gif">
</div>
	
</body>
</html>