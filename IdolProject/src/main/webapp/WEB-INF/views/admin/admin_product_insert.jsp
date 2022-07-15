<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">


	<style type="text/css">
		html, body {
			padding: 0px;
			margin: 0px;
			height: 100%;
			background-color: black;
		}
		
		.admin_product_insert_container {
			display: flex;
			flex-direction: row;
			justify-content: center;
		
		}
		
		.insert_category_form {
			color: white;
		}
		.insert_category {
			color: white;
		}
		
	
		.insert_product_form{
			color: white;
			
			font-family: 'Jua', sans-serif;
			
		}
	
		.product_category_list a{
			text-decoration: none;
			color: white;
		}
		.product_category_list a:hover {
			color: gold;
		}
		
		.product_category_list input {
			width: 73px;
		}
		
		.product_category_list span {
			cursor: pointer;
		}
		
		.product_category_list span:hover {
			color: red;
		}
		
		.product_insert_btn {
		
		}
		
		.btn {
			background-color: black;
			color: white;
			font-family: 'Creepster', cursive;
			font-size: 1.9em;
			cursor: pointer;
		}
		
		.btn:hover {
			color: red;
		}
</style>
	

</head>
<body>

	<c:set var="clist" value="${cList }" />
	<c:set var="pclist" value="${pcList }" />

	<div class="admin_product_insert_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_products_include.jsp" />
	
		<div class="admin_product_insert_container">
			
<!-- 			<div class="insert_category_form"> -->
<%-- 				<form method="post" action="<%=request.getContextPath()%>/admin_productCategory_insert_ok.do"> --%>
<!-- 						<h4>카테고리 추가 하기 [임시]</h4> -->
<!-- 					<div class="insert_category_no"> -->
<!-- 						번호 : <input name="category_pno"> -->
<!-- 					</div> -->
<!-- 					<div class="insert_category_name"> -->
<!-- 						카테고리 네임<input name="category_name"> -->
<!-- 					</div> -->
<!-- 					<div> -->
<!-- 						<input type="submit" value="GO!!"> -->
<!-- 						<input type="reset" value="RESET"> -->
<!-- 					</div> -->
<!-- 				</form> -->
<%-- 				<c:if test="${!empty pclist}"> --%>
<!-- 					<div class="product_category_list"> -->
<!-- 						<div> -->
<!-- 							<ul> -->
<%-- 								<c:forEach items="${pclist }" var="pcdto"> --%>
<!-- 									<li> -->
<%-- 										<a href="<%=request.getContextPath()%>/admin_product_categotry.do?no=${pcdto.category_pno}"> --%>
<%-- 											${pcdto.category_name }</a> <input name="category_name"> <span>수정</span> <span>X</span> --%>
										
<!-- 									</li> -->
<%-- 								</c:forEach> --%>
<!-- 							</ul> -->
<!-- 						</div> -->
<!-- 					</div> product_category_list -->
<%-- 				</c:if> --%>
<%-- 				<c:if test="${empty pclist}"> --%>
<!-- 					<h3>THERE ARE NO AVAILABLE ..</h3> -->
<%-- 				</c:if> --%>
				
<!-- 			</div> insert_category_form -->
			
			
			
			
			
			<div class="insert_product_form">
			
				<form method="post" enctype="multipart/form-data" 
					action="<%=request.getContextPath()%>/admin_product_insert_ok.do">
					
					<span>상품명</span>
					<div>
						<input name="product_name">
					</div>
					<span>CELEB NO</span>
					<div>
						<select name="celeb_no">	
							<option value="0">
								NONE
							</option>
							<c:forEach items="${clist }" var="c"> 
								<option value="${c.celeb_no }">
									 ${c.celeb_no }. ${c.celeb_name }
								</option>
							</c:forEach>
						</select>
					</div>
					<span>수량</span>
					<div>
						<input name="product_qty" type="number" min="1" max="100">
					</div>
					<span>가격</span>
					<div>
						<input name="product_price">
					</div>
					<span>사이즈</span>
					<div>
						<input name="product_size">
					</div>
					<span>컬러</span>
					<div>
						<input name="product_color">
					</div>
					<span>상세내용</span>
					<div>
						<textarea name="product_detail" rows="20" cols="30"></textarea>
					</div>
					<span>마일리지</span>
					<div>
						<input name="product_mileage">
					</div>
					<span>입고일 </span>
					<div>
						<input name="product_input" type="date">
					</div>
					<span>카테고리 </span>
					<div>
						
						<select name="category_pnofk">
							<c:forEach items="${pclist }" var="pcdto">
								<option value="${pcdto.category_pno }">
									${pcdto.category_pno } [${pcdto.category_name }]
								</option>
							</c:forEach>
						</select>
					</div>
					<div>
						<input style="margin: 5px 0px" type="file" multiple="multiple" name="file">
					</div>
					
					<div class="product_insert_btn">
						<input class="btn" type="submit" value="GO!!">
						<input class="btn" type="reset" value="RESET">
					
					</div>
					
				</form>
			</div> <!-- insert_product_form -->
			
			
		</div> <!-- admin_product_insert_container -->
	
	
	
	
	
	
	
	
	</div> <!-- admin_product_insert_wrapper -->





 





</body>
</html>