<%@page import="java.util.StringTokenizer"%>
<%@page import="com.idol.model.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   
    <c:set value="${plist }" var="pList" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN PRODUCTS LIST</title>

<style type="text/css">
	html, body {
		padding: 0px;
		margin: 0px;
		background-color: black;
		height: 100%;
	}
	
	a {
		text-decoration: none;
	}
	
	.products_list_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	
	}
	
	
	.product_list_container {
		height: 100vh;
	
	}
	
	.products_list_boxes {
		display: flex;
    	flex-direction: row;
    	flex-wrap: wrap;
   	 	gap: 30px;
   	 	justify-content: center;
	}
	.product_box {
		color: white;
		border:1px solid pink;
		width: 275px;
		height: 310px;
		/*display: grid;
		grid-template-rows: 75% 25%;*/
		font-family: 'Press Start 2P', 'Gugi', cursive;
		
	}
	
	.product_box a {
		text-decoration: none;
		color: white;
	}

	.product_img {
		height: 100%;
		width: 100%;
		overflow: hidden;
		/*grid-row: 1;*/
	
	}
	
	.product_img img {
		width: 100%;
		height: 100%;
		
	}
	.product_info {
		/*grid-row: 2;*/
    	font-size: 0.9em;
	}
	
	
	.product_name {
		opacity: 0;
    	left: -275px;
    	position: absolute;
    	display: block;
    	z-index: 1;
    	bottom:0;
    	background: rgba(0, 0, 0, 0.5);
    	text-align: left;
    	
    	
	}
	.product_box span{
		position: absolute;
    	display: block;
    	z-index: 0;
    	top: 0;
    	width: 275px;
    	height: 310px;
    	box-shadow: inset 0 0 50px rgba(50, 30, 0, 0.6),
    				inset 0 0 100px rgba(50, 30, 0, 0.3);
    	background: rgba(255, 155, 0, 0.2);
    	opacity: 0;
    	
	}
	.product_link {
		position: relative;
	}
</style>

 <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
 
 <link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&display=swap" rel="stylesheet">
 
 <script type="text/javascript">
 	
 
 </script>
 
</head>
<body>

	
	
	<div class="products_list_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_products_include.jsp" />
	
		<div class="product_list_container">
			
			<div class="products_list_boxes">
			
			
			<%
			List<ProductDTO> list = (List<ProductDTO>)request.getAttribute("plist");

			for(int i=0; i < list.size(); i++){
				
				ProductDTO dto = list.get(i);
				
				String imgs = dto.getProduct_image();
				
				StringTokenizer tokenizer = new StringTokenizer(imgs, "|");
				
				String[] arrayToekn = new String[tokenizer.countTokens()];
				
				for(int j =0; j < arrayToekn.length; j++ ) {
					arrayToekn[j] = tokenizer.nextToken();
					
				}
				%>
				<a class="product_link" href="<%=request.getContextPath()%>/admin_product_content.do?no=<%=dto.getProduct_no()%>">
				<div data-aos="fade-in" class="product_box">
							<img class="product_img" alt="" src="./resources/upload/product/<%=arrayToekn[0]%>"> 
						<strong class="product_name">
							<%=dto.getProduct_name() %>
						</strong><span></span>
				</div> <!-- product_box -->
				</a>
			<%}%>	
				
			</div> <!-- products_list_boxes -->
			<div
		    data-aos="fade-up"
		    data-aos-offset="200"
		    data-aos-delay="50"
		    data-aos-duration="1000"
		    data-aos-easing="ease-in-out"
		    data-aos-mirror="true"
		    data-aos-once="false"
		    data-aos-anchor-placement="top-center"
		  >
		  </div>
			
		</div> <!-- product_list_container -->
	
	</div> <!-- products_list_wrapper -->


<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
  <script>
    AOS.init();
  </script>
  
  
</body>
</html>