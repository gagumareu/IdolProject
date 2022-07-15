<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	
<style type="text/css">

	html, body {
		padding: 0px;
		margin: 0px;
		height: 100%;
		background-color: black;
	}
	.admin_product_update_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	}
	
	.admin_product_container {
		display: flex;
    	justify-content: center;
	
	}

	.product_imgs {
		width: 220px;
		height: 220px;
		display: flex;
		flex-direction: row;
		justify-content: center;
	}
	
	.product_imgs img {
		width: 100%;
		height: 100%;
	}
	
	.product_modify_textForm {
		color: white;
		
	}


</style>

</head>
<body>
	<c:set var="dto" value="${productCont }" />
	<c:set var="imgs" value="${imgsList }" />
	<c:set var="clist" value="${cList }" />
	<c:set var="cplist" value="${cpList }" />
	
	<div class="admin_product_update_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_products_include.jsp" />
	
		<div class="admin_product_container">
			<form class="product_update_form" method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/admin_product_update_ok.do">
			
				<input type="hidden" name="oldImgs" value="${dto.product_image }">
				<input type="hidden" name="product_no" value="${dto.product_no }">
				
				<div class="product_imgs">
					<c:forEach items="${imgsList }" var="imgs2">
						<img alt="" src="./resources/upload/product/${imgs2 }">
					</c:forEach>
				</div>
				<div class="product_modify_textForm">
					<div>
						상품 명:<input name="product_name" value="${dto.product_name }">
					</div>
					<div>
						셀럽
						<select name=celeb_no>
							<option value="0">
								NONE
							</option>
							<c:forEach items="${clist }" var="c">
								<c:if test="${c.celeb_no == dto.celeb_no }">
									<option value="${c.celeb_no }" selected>
										[${c.celeb_no }] ${c.celeb_name }
									</option>
								</c:if>
								<c:if test="${c.celeb_no != dto.celeb_no }">
									<option value="${c.celeb_no }">
										[${c.celeb_no }] ${c.celeb_name }
									</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					<div>
						카테고리
						<select name="category_pnofk">
							<c:forEach items="${cplist }" var="cpdto">
								<c:if test="${cpdto.category_pno == dto.category_pnofk }">
									<option value="${cpdto.category_pno }" selected>
										${cpdto.category_pno } [${cpdto.category_name }]
									</option>
								</c:if>
								<c:if test="${cpdto.category_pno != dto.category_pnofk }">
									<option value="${cpdto.category_pno }">
										${cpdto.category_pno } [${cpdto.category_name }]
									</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
					
					<div>
						수량: <input type="number" min="1" max="100" name="product_qty" value="${dto.product_qty }">
					</div>
					<div>
						가격: <input name="product_price" value="${dto.product_price }">
					</div>
					<div>
						<c:if test="${dto.product_size == null }">
							사이즈: <input name="product_size">
						</c:if>
						<c:if test="${dto.product_size != null }">
							사이즈: <input name="product_size" value="${dto.product_size }">
						</c:if>
					</div>
					<div>
						<c:if test="${dto.product_color == null }">
							색상: <input name="product_color">
						</c:if>
						<c:if test="${dto.product_color != null }">
							색상: <input name="product_color" value="${dto.product_color }">
						</c:if>
					</div>
					<div>
						<textarea name="product_detail" rows="20" cols="40">${dto.product_detail }</textarea>
					</div>
					<div>
						마일리지: <input type="number" name="product_mileage" value="${dto.product_mileage }">
					</div>
					<div>
						입고일: <input type="date" name="product_input" value="${dto.product_input.substring(0, 10) }">
					</div>
					
					
					<div>
						<input type="file" multiple="multiple" name="file">
					</div>
				</div> <!-- product_modify_textForm -->
				
				<div class="product_update_btn">
					<input type="submit" value="GO!!!">
					<input type="reset" value="RESET">
				</div> <!-- product_update_btn -->
			
			</form> <!-- product_update_form -->
		
		</div> <!-- admin_product_container -->
		
		
	</div> <!-- admin_product_update_wrapper -->



</body>
</html>