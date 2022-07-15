<%@page import="java.util.StringTokenizer"%>
<%@page import="com.idol.model.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의게시글 - 상품 검색</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<style type="text/css">

	#top{
	
		margin: 30px 10px;
    padding: 20px 10px;
    border: 5px solid #2a3a52;
	}
	
	#search_btn{
	
    padding: 5px 15px;
    border-radius: 20px;
    background-color: white;
    border: 1px solid #2a3a52;
    color: #2a3a52;
    cursor: pointer;
	font-size: 0.89em;
	
	}
	
	#popup_img{
		height:130px;
	
	}
	
</style>
</head>
<body>
	<c:set var="search_field" value="${map.get('field') }"/>
	<c:set var="search_word" value="${map.get('word') }"/>
	<c:set var="paging" value="${map.get('page') }"/>
	<c:set var="pList" value="${pList}"/>
	
	<div id="popup_container" align="center">
		<div id="top">
			<form method="post" action="<%=request.getContextPath()%>/inquiry_productSearch.do">
			<select name="search_field">
				<option value="product_name">제품명</option>
				<option value="celeb_name">셀렙명</option>
			</select>
			<input type="text" name="search_word">
			<button id="search_btn" type="submit" class="btn btn-outline-dark">
					검색
			</button>
			</form>
		</div>
		
		<div id="middle">
			<span> </span>
		</div>
		<div id="bottom">
			<table class="table table-hover ">
				<thead>
					<tr class="table-secondary">
						<th scope="col">상품이미지</th>
						<th scope="col">상품정보</th>
						<th scope="col">선택</th>
					</tr>
				</thead>
				<tbody>
					
					<c:if test="${!empty  pList}">
					<%
						List<ProductDTO> list = (List<ProductDTO>)request.getAttribute("pList");
					
						for(int i=0; i<list.size(); i++){
							 ProductDTO product = list.get(i);
							 
							StringTokenizer st = null;
							String [] arrImg = null;
							
							st = new StringTokenizer(product.getProduct_image(),"|");

							arrImg= new String[st.countTokens()];

							for(int j =0; j<arrImg.length; j++){
								arrImg[j]=st.nextToken();	
							}
							
					%>
					<tr>
						<td id="popup_img">
						<img alt="arrImg[0]" src="./resources/upload/product/<%= arrImg[0] %> " width="100%" height="100%">
						</td>
						<td id="popup_info">
							<div>
							<%=product.getProduct_name() %><br>
							<%if(product.getProduct_size() != null){%>
								<span>SIZE: <%=product.getProduct_size() %> &nbsp;
							<% }%>
							<%if(product.getProduct_color() != null){%>
								COLOR: <%=product.getProduct_color() %></span>
							<% }%>
							<br>
							<span><%=product.getProduct_price() %></span>
							</div>		
						</td>
							<td id="popup_btn"> 
							<input type="button" onclick="parentscall(<%=product.getProduct_no() %>)" value="선택">
						</td>
					</tr>

						<script type="text/javascript">
	
							function parentscall(pno){
								
								window.opener.location.href="<%=request.getContextPath()%>/inquiry_write.do?pno="+pno;
								self.close();

							}
						</script>

						<%	} %>
					</c:if>
				</tbody>
					
			</table>
			<c:if test="${empty pList }">
					<script type="text/javascript">
						console.log("데이터없음");
					</script>
					</c:if>
		</div>
		
			<div class="qa_paging" align="center">
			
			<c:if test="${paging.getPage() > paging.getBlock() }"> <!-- 현재 페이지가 4인데 block사이즈는 3이라면 -->
			<a href="inquiry_productSearch.do?page=1&search_field=${search_field}&search_word=${search_word}">[맨 처음]</a>
			<a href="inquiry_productSearch.do?page=${paging.getStartBlock()-1 }&search_field=${search_field}&search_word=${search_word}">◀</a>
		</c:if>

		<c:forEach begin="${paging.getStartBlock() }" end="${paging.getEndBlock() }" var="i">
			
			<c:if test="${i == paging.getPage() }">
			<b><a href="inquiry_productSearch.do?page=${i }&search_field=${search_field}&search_word=${search_word}">[${i }]</a></b>
			</c:if>	
			
			<c:if test="${i != paging.getPage() }">
			<a href="inquiry_productSearch.do?page=${i }&search_field=${search_field}&search_word=${search_word}">[${i }]</a>
			</c:if>
				
		</c:forEach>


		<c:if test="${paging.getEndBlock() < paging.getAllPage() }"> <!-- endBlock이 6인데 allPage가 7이라면 -->
			<a href="inquiry_productSearch.do?page=${paging.getEndBlock()+1 }&search_field=${search_field}&search_word=${search_word}">▶</a>
			<a href="inquiry_productSearch.do?page=${paging.getAllPage()}&search_field=${search_field}&search_word=${search_word}">[마지막으로]</a>
		</c:if>
		
		
			
			
		</div><!-- class="qa_paging -->
	</div><!-- class="popup_container" -->

	<script type="text/javascript">
	
		$(function(){
			
			$("#search_Btn").on("click", function(){
				$(".qa_paging").show();
			});
			
		});
	
	</script>

</body>
</html>