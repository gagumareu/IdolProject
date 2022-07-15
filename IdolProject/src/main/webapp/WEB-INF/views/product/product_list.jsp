<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 리스트 페이지</title>
    <link rel="stylesheet" href="css/product_list.css">
    <script src="https://kit.fontawesome.com/3de1cbcb05.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<%@include file="../include/user_top.jsp" %>
<div id="wrap">
        <div id="container">

            <!-- 상단 슬라이더container -->
            <div id="slider">
                <div class="slider-container">
                    <ul class="slider-innercontainer simple-list" id="slider">
                        <li class="slide">
                            <img src="slider/sample1.JPG" alt="slide1">
                        </li>

                        <li class="slide">
                            <img src="slider/sample2.JPG" alt="slide2">
                        </li>

                        <li class="slide">
                            <img src="slider/sample3.JPG" alt="slide3">
                        </li>

                        <li class="slide">
                            <img src="slider/sample4.JPG" alt="slide4">
                        </li>

                        <li class="slide">
                            <img src="slider/sample5.JPG" alt="slide5">
                        </li>
                    </ul> 
                </div> 
                <div class="slider-button">

                    <a href="#" id="prev"><i class="fa-solid fa-chevron-left"></i></a>
                    
                    <span class="slider-bullet">
                    </span>
                    <span class="slider-bullet">
                    </span>
                    <span class="slider-bullet">
                    </span>
                    <span class="slider-bullet">
                    </span>
                    <span class="slider-bullet">
                    </span>

                    <a href="#" id="next"><i class="fa-solid fa-chevron-right"></i></a>

                </div> 
            </div>

        <div id="contents">

            <!--Product페이지 좌측 사이드바-->           
                <div id="product_side">
                    <div class="product_side_title">PRODUCT
                    </div>

                    <div class="product_side_menu">
                         <ul>
                            <li class="product_main_category"><a href="<%=request.getContextPath()%>/product_list.do?cno=${100}">MUSIC</a>
                            	<i class="fa-solid fa-chevron-down"></i><i class="fa-solid fa-chevron-up"></i>
								<ul>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${110}"><li class="product_detail_category">CD</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${120}"><li class="product_detail_category">DVD</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${130}"><li class="product_detail_category">etc.</li></a>
								</ul>
							</li>
                            <li class="product_main_category"><a href="<%=request.getContextPath()%>/product_list.do?cno=${200}">PHOTO</a>
                            	<i class="fa-solid fa-chevron-down"></i><i class="fa-solid fa-chevron-up"></i>
								<ul>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${210}"><li class="product_detail_category">Printed</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${220}"><li class="product_detail_category">Photo Book</li></a>
								</ul>
							</li>
                            <li class="product_main_category"><a href="<%=request.getContextPath()%>/product_list.do?cno=${300}">CONCERT</a>
                            	<i class="fa-solid fa-chevron-down"></i><i class="fa-solid fa-chevron-up"></i>
								<ul>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${310}"><li class="product_detail_category">Official Fanlight</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${320}"><li class="product_detail_category">Concert Goods</li></a>
								</ul>
							</li>
                            <li class="product_main_category"><a href="<%=request.getContextPath()%>/product_list.do?cno=${400}">LIVING</a>
                            	<i class="fa-solid fa-chevron-down"></i><i class="fa-solid fa-chevron-up"></i>
								<ul>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${410}"><li class="product_detail_category">Home</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${420}"><li class="product_detail_category">Kitchen</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${430}"><li class="product_detail_category">F&B</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${440}"><li class="product_detail_category">Tech</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${450}"><li class="product_detail_category">Book</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${460}"><li class="product_detail_category">Pet</li></a>
								</ul>
							</li>
                            <li class="product_main_category"><a href="<%=request.getContextPath()%>/product_list.do?cno=${500}">BEAUTY</a>
                            	<i class="fa-solid fa-chevron-down"></i><i class="fa-solid fa-chevron-up"></i>
								<ul>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${510}"><li class="product_detail_category">Skin Care</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${520}"><li class="product_detail_category">Make Up</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${530}"><li class="product_detail_category">Cleansing</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${540}"><li class="product_detail_category">Body & Hair</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${550}"><li class="product_detail_category">Pack & Masks</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${560}"><li class="product_detail_category">Perfume</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${570}"><li class="product_detail_category">Tool</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${580}"><li class="product_detail_category">Men’s</li></a>

								</ul>
							</li>
                            <li class="product_main_category"><a href="<%=request.getContextPath()%>/product_list.do?cno=${600}">STATIONERY</a>
                            	<i class="fa-solid fa-chevron-down"></i><i class="fa-solid fa-chevron-up"></i>
								<ul>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${610}"><li class="product_detail_category">Note</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${620}"><li class="product_detail_category">Office</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${630}"><li class="product_detail_category">Pen</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${640}"><li class="product_detail_category">Deco</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${650}"><li class="product_detail_category">Binder</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${660}"><li class="product_detail_category">Toy</li></a>
								</ul>
							</li>
                            <li class="product_main_category"><a href="<%=request.getContextPath()%>/product_list.do?cno=${700}">FASTION</a>
                            	<i class="fa-solid fa-chevron-down"></i><i class="fa-solid fa-chevron-up"></i>
								<ul>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${710}"><li class="product_detail_category">Clothing</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${720}"><li class="product_detail_category">Acc</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${730}"><li class="product_detail_category">Jewelry</li></a>
								</ul>
							</li>
                            <li class="product_main_category"><a href="<%=request.getContextPath()%>/product_list.do?cno=${800}">CUSTOMIZING</a>
                            	<i class="fa-solid fa-chevron-down"></i><i class="fa-solid fa-chevron-up"></i>
								<ul>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${810}"><li class="product_detail_category">Phone Case</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${820}"><li class="product_detail_category">Fashion</li></a>
									<a href="<%=request.getContextPath()%>/product_list.do?cno=${830}"><li class="product_detail_category">Acc</li></a>
								</ul>
							</li>
                        </ul>
                    </div><!-- //product_side_menu -->
                </div>


             <!--Product container-->
            <div id="product_container">
                <!--Product kind-->
                <div class="list_function">
                    <select id="list_kind" name="list_kind" 
                    onchange="if(this.value=='new'){location.href='product_list.do?cno=${ListCate }&list_kind=new'}
                    else if(this.value=='name'){location.href='product_list.do?cno=${ListCate }&list_kind=name'}
                    else if(this.value=='row'){location.href='product_list.do?cno=${ListCate }&list_kind=row'}
                    else if(this.value=='high'){location.href='product_list.do?cno=${ListCate }&list_kind=high'}
                    "> 
                    <option value="new" <c:if test="${ListKind == 'new'}">selected</c:if> >최신순</option>
                    <option value="name" <c:if test="${ListKind == 'name'}">selected</c:if> >상품명</option>
                    <option value="row" <c:if test="${ListKind == 'row'}">selected</c:if> >낮은가격</option>
                    <option value="high" <c:if test="${ListKind == 'high'}">selected</c:if> >높은가격</option>
                    </select>        	
                </div>

                <!--Product페이지 리스트-->
                <c:set var="plist" value="${PList }"/>
                <!--Celeb 리스트-->
                <c:set var="clist" value="${CList }"/>
                <div id="product_list">
					<c:if test="${!empty plist }">
						<!-- 제품리스트를 dto값으로 나열한다. -->
						<c:forEach items="${plist }" var="dto">
							<div class="prd-box">
							
							<!-- 제품의 수량을 확인하여 이미지를 흐리게 처리하기 위한 태그 -->
							<input type="hidden" class="prd-qty" value="${dto.product_qty}">
		                        <div class="prd-img-box">
		                        	<a href="<%=request.getContextPath()%>/product_detail.do?pno=${dto.product_no}">
		                            <img class="prd-img" src="product/${dto.product_image}" alt="제품이미지">
		                            </a>
		                        </div>
		                        <div class="prd-description">

		                        	<a href="<%=request.getContextPath()%>/product_detail.do?pno=${dto.product_no}">
		                            <div class="prd-celeb"> 
		                            <!-- 셀럽 리스트에서 제품리스트에 맞는 셀럽번호가 있으면 해당 셀럽 그룹명을 호출 -->
		                            <c:if test="${!empty clist }">
			                        <c:forEach items="${clist }" var="cdto">
		                            <c:if test="${dto.celeb_no == cdto.celeb_no }">   
		                            
		                            <!-- 셀럽그룹이 있으면 해당 셀럽 그룹명을 호출 하되 그룹명이 없으면 셀럽네임을 호출한다. -->
		                            <c:if test="${cdto.celeb_group ne 'solo' }">   
		                            ${cdto.celeb_group }
		                            </c:if>
		                            <c:if test="${cdto.celeb_group eq 'solo'}">   
		                            ${cdto.celeb_name }
		                            </c:if>
		                            
		                            </c:if>
		                            </c:forEach>
		                            </c:if>
		                            </div>
		                            </a>
		                            
		                            <div class="prd-name-cart"> 
		                            <a href="<%=request.getContextPath()%>/product_detail.do?pno=${dto.product_no}">
		                            <span class="prd-name">${dto.product_name }</span>
		                            </a>
		                            <span class="prd-cart">  
		                            
		                            <img class="prd-cart-img" alt="basket" src="product/basket.png">
		                            <!-- 장바구니 추가시 ajax컨트롤러에 할달될 파라미터 값 -->
		                            <input type="hidden" class="pno" value="${dto.product_no}">
		                        	<input type="hidden" class="pimage" value="${dto.product_image}">
		                        	<input type="hidden" id="memno" value="${loginInfo.member_no}">
		                            
		                            </span>
		                            </div>
		                            <div class="prd-price">₩ <fmt:formatNumber value="${dto.product_price}"/> &nbsp;
		                            <!-- <span class="origical-price">₩ <fmt:formatNumber value="${dto.product_price}"/> </span> -->
		                            </div>
		                        </div>
	                   		</div>
						
						</c:forEach>
					
					</c:if>
					
					<c:if test="${empty plist }">
						<h2>상품을 준비중에 있습니다.</h2>
					</c:if>
					</div>
                	<div class="main_product_more move">더보기 +</div>
                </div>
            </div>

        </div>

    </div>
	<a id="back-to-top" href="#">Top</a>
    <a id="back-to-bottom" href="#">Bot</a>
    
    
    <!-- 장바구니 버튼을 클릭하면 보여질 장바구니 actionScreen -->
    <div id="basketaddContainer">
    <div id="bheader">
        <h3>장바구니 담기</h3>
    </div>
    <div id="bcontent">
        <img class="prd-cart-img" alt="basket" src="product/basket.png" width="60" height="60">
            <p>장바구니에 상품이 정상적으로 담겼습니다.</p>
    </div>

    <div id="bmove_action">
        <a href="#" id="bcancle">쇼핑 계속하기</a>
        <a href="#" id="bmove" onclick="location.href='product_cartList.do?memno=${loginInfo.member_no}'">장바구니 이동</a>
    </div>
        <a id="bclose"><i class="fa-solid fa-xmark fa-2x"></i></a>
    </div>


<%@include file="../include/user_bottom.jsp" %>
<script src="js/product_list.js"></script>
</body>
</html>