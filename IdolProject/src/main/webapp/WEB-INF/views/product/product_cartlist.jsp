<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 리스트 페이지</title>
    <script src="https://kit.fontawesome.com/3de1cbcb05.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="css/product_cartlist.css">
</head>
<body>
<%@include file="../include/user_top.jsp" %>
	<div id="wrap">
        <div id="container">
        <div id="content">
        		<c:set var="clist" value="${cartList }"/>
            	<c:set var="celeblist" value="${celebList }"/>
            	<c:set var="prdlist" value="${prdList }"/>
                <input type="hidden" id="memNo" value="${loginInfo.member_no }">
            <div class="cart-title">
                <h2>Cart</h2>
            </div>
            	
                <c:if test="${!empty clist}">
                <form method ="post"  id="frm" action="<%=request.getContextPath()%>/product_orderFromCart.do">
	                <div class="cart-table">
	                    <table cellspacing="0">
	                        <tr>
	                            <th><input id="cart_all_check" type="checkbox"></th>
	                            <th colspan="2">상품정보</th>
	                            <th>수량</th>
	                            <th>배송비</th>
	                            <th>주문금액</th>
	                            <th>선택</th>
	                        </tr>
	                        
	                        
	                        <c:forEach items="${clist}" var="cdto">
		                        <tr>
		                            <td>
		                                <input type="checkbox" class="check_medium">
		                            </td>
		
		                            <td class="cart-image">
		                                <a href="#">
		                                    <img src="product/${cdto.cart_pimage }" alt="제품이미지">
		                                </a>
		                            </td>
		
		                            <td class="cart-prdInfo">
		                                <div class="cart-prdGroup">
		                                    <!-- 카테고리에 저장된 제품의 셀럽그룹을 가져오기 위한 로직 -->
	                            	
	                            	<!-- 카트에 저장되 있는 제품번호와 제품에 저장되있는 제품번호가 일치하는 경우 
	                            		   제품에 저장되 있는 셀럽번호를 톨해 셀럽그룹명을 가져온다. -->
	                            	<c:if test="${!empty prdlist}">
	                            	<c:forEach items="${prdlist }" var="pdto">
	                            	<c:if test="${pdto.product_no == cdto.cart_pno }">
	                            	<c:if test="${!empty celeblist}">
	                            	<c:forEach items="${celeblist}" var="celdto">
	                            	<c:if test="${pdto.celeb_no == celdto.celeb_no }">
	                                
	                                 <!-- 셀럽그룹이 있으면 해당 셀럽 그룹명을 호출 하되 그룹명이 없으면 셀럽네임을 호출한다. -->
	                                <c:if test="${celdto.celeb_group ne 'solo'}">
	                                	${celdto.celeb_group }
	                                </c:if>
	                                <c:if test="${celdto.celeb_group eq 'solo'}">
	                                	${celdto.celeb_name } 
	                                </c:if>
	
	                                </c:if>
	                                </c:forEach>
	                                </c:if>
	                                </c:if>
	                                </c:forEach>
	                                </c:if>
		                                </div>
		                                <div class="cart-prdName">
		                                     ${cdto.cart_pname}
		                                </div>
		                            </td>
		                                                
		                            <td class="cart-qty">
		                                <input type="hidden" class="product_qty" value="10">
		                                <button type="button" class="plus">&#43;</button>
		                                <input type="number" class="numBox" name="product_qty" min="0" max="0" value="${cdto.cart_pqty }" readonly disabled />
		                                <button type="button" class="minus">&#45;</button>
		                            </td>
		                            <td class="cart-deliberyFee">
		                               [조건]
		                            </td>
		                            <td class="cart-amount">
		                                <strong>₩
		                                    <span class="medium-total"> <fmt:formatNumber value="${(cdto.cart_price)*(cdto.cart_pqty)}"/> </span>
		                                </strong> 
		                                <div>
		                                    <input type="hidden" class="medium-prdPrice" value="${cdto.cart_price}">
		                                    <input type="hidden" class="medium-prdtotal" value="${(cdto.cart_price)*(cdto.cart_pqty)}">
		                                    <input type="hidden" class="medium-cartno" value="${cdto.cart_no}">
		                                </div>
		                            </td>
		                            <td class="cart-button">
		                                <button type="button" class="orderBtn">주문하기</button>
		                                <button type="button" class="deleteBtn">삭제</button>
		                            </td>
		                        </tr>
	                        </c:forEach>
	                        
	                    </table>
	                </div>
	                <div class="delete-button">
	                    <span class="dLeft">
	                        <button type="button" id="selected_delete">
	                            	선택상품삭제
	                        </button>
	                    </span>
	                    <span class="dRight">
	                        장바구니에 담긴 상품은 30일동안 보관됩니다.
	                    </span>
	                </div>
	
	
	                <div class="bold-line"></div>
	
	                <div id="totalArea">
	                    <div id="totalAmount">
	                    <span class="amountNumber">₩
	                        <span class="BtotalAmount" id="BtotalAmount">
	                            0
	                        </span>
	                    </span>
	                    <span class="amountTag">
	                        	총상품금액
	                    </span>
	                    </div>
	                    
	                    <div class="sing">
	                        <span class="minusSing">+</span>
	                    </div>
	                    
						<div id="deliberyFee">
	                        <span class="amountNumber">₩
	                            <span class="BtotalAmount" id="BdeliberyFee">
	                                3,000
	                            </span>
	                        </span>
	                        <span class="amountTag">
	                            	배송비
	                        </span>
	                    </div>
	
	                    <div class="sing">
	                        <span class="resultSing">=</span>
	                    </div>
	
	                    <div id="finalAmount">
	                        <span class="amountNumber amountResult">₩
	                            <span class="BtotalAmount" id="BfinalAmount">
	                                0
	                            </span>
	                        </span>
	                        <span class="amountTag">
	                            	최종결제 금액
	                        </span>
	                    </div>
	                </div>
	
	                <div class="thin-line"></div>
	
	                <div id="total-select">
	                    <button id="totalOrderBtn" type="button">전체상품 주문</button>
	                    <button id="selectOrderBtn" type="button">선택상품주문</button>
	                    <!-- 선택된 카트번호를 담을 input -->
	                    <input type="hidden" id="cartNoArr" name="cartNoArr" value="">
	                </div>
	                </form>
				</c:if>
				
				<c:if test="${empty clist }">
				
					<div id="cart-empty ">
						<p class="empty-notice">장바구니가 비어 있어요!</p>
						<div class="btn_medium_white">
						<button class="continueBtn"
						onclick="location.href='<%=request.getContextPath()%>/product_list.do?cno=${100}'">쇼핑계속하기</button>
						</div>
					</div>
					
				</c:if>
        </div>

        </div>
        
        <a id="back-to-top" href="#">Top</a>
    	<a id="back-to-bottom" href="#">Bot</a>
        
    </div>  
    
    <%@include file="../include/user_bottom.jsp" %>
	<script src="js/product_cartlist.js"></script>
</body>
</html>