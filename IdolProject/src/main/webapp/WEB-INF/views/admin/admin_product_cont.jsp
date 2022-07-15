<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN PRODUCT CONTENT</title>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">


<style type="text/css">

	html, body {
		padding: 0px;
		margin: 0px;
		height: 100%;
		background-color: black;
	}
	
	.product_cont_wrapper {
		display: flex;
		flex-direction: column;
    	min-height: 100vh;
	}
	
	
	.product_cont_container {
		display: flex;
		flex-direction: row;
		justify-content: center;
		align-items: center;
	}
	
	.product_cont_box {
		margin-left: 10%;
		width: 30%;
	}
	
	
	.product_cont_detail {
		color: white;
		font-family: 'Press Start 2P', 'Gugi', cursive;
		font-size: 0.9em;
		line-height: 1.4;
	}
	
	/******************************/
	
	
	.product_cont_slider {
		/*width: 500px;*/
		/*height: 600px;*/
		width: 35%;
		height: 35%;
	}
	
	.product_cont_slider img{
		width: 100%;
		height: 100%;
		/*cursor: pointer;*/
		border-radius: 10% / 50%;
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
	
	
	
	
	/*************** 버튼 ***************/
	.celeb_btn {
		display: flex;
		flex-direction: row;
		justify-content: center;
		margin-right: 30%;
	}
	
	.celeb_btn input {
		color: white;
		background-color: black;
		font-family: 'Creepster', cursive;
		font-size: 1.9em;
		cursor: pointer;
	}
	
	
	.product_btn:hover {
		color: red;
	}
	
	
	
	
	
</style>


<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&display=swap" rel="stylesheet">


</head>
<body>
	<c:set var="dto" value="${productCont }" />
	<c:set var="imgs" value="${imgsList }" />
	
	<div class="product_cont_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_products_include.jsp" />
		
		
		<div class="product_cont_container">
			
			<div class="product_cont_slider"> 
				<c:forEach begin="0" end="0" items="${imgsList }" var="img2">
					<img alt="" src="./resources/upload/product/${img2}">
				</c:forEach>
			</div> <!-- product_imgs -->
		
		
			<div class="product_cont_box">
			
				<div class="product_cont_detail">
					<div>
						NO. ${dto.product_no }
					</div>
					<div>
						${dto.product_name }
					</div>
					<div>
						QUATITY: ${dto.product_qty }
					</div>
					<div> 
						PRICE: <fmt:formatNumber value="${dto.product_price }" />원
					</div>
					<c:if test="${dto.product_size != null }">
						SIZE : ${dto.product_size }
					</c:if>
					<c:if test="${dto.product_color != null }">
						COLOR: ${dto.product_color }
					</c:if>
					<div>
						INFO: ${dto.product_detail }
					</div>
					<div>
						MILEAGE: <fmt:formatNumber value="${dto.product_mileage }" /> POINT
						
					</div>
					<div>
						INPUT DATE: ${dto.product_input.substring(0, 10) }
					</div>
					
				
				</div> <!-- product_cont_detail -->
				
				<div class="celeb_btn">
					<input class="product_btn" type="button" value="MODIFY" class="inset_btn"
					onclick="location.href='admin_product_update.do?no=${dto.product_no}'">
					
					<input class="product_btn" type="button" value="DELETE" class="inset_btn"
					onclick="if(confirm('상품을 삭제하시겠습니까? :(')){
						location.href='admin_product_delete.do?no=${dto.product_no}&imgs=${dto.product_image }'
					}else{return; }">
					
					<input class="product_btn" type="button" value="BACK" class="inset_btn"
					onclick="location.href='admin_products_list.do'">
				</div>
				
			</div>	<!-- product_cont_wrapper -->
				
			
		</div> <!-- product_cont_container -->
		
	</div> <!-- product_cont_wrapper -->
	


<script type="text/javascript">

		$('.product_cont_slider').slick({
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