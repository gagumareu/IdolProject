<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문완료 페이지</title>
    <script src="https://kit.fontawesome.com/3de1cbcb05.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="css/product_order_ok.css">
</head>
<body>
<%@include file="../include/user_top.jsp" %>
    <div id="wrap">
        <div id="container">
        <div id="content">
            <div class="order-title">
                <h2>Completed</h2>
            </div>
            <!-- 주문완료 -->
            <div class="orderInfo">
                <div class="cboth">
                    <i class="fa-solid fa-face-smile fa-5x"></i>
                </div>
                    <p>
                    <strong>주문이 완료되었습니다.</strong>
                    	주문내역 및 배송은 주문조회를 통하여 확인 가능합니다.
                    </p>
                    <ul>
                    <li>주문번호 <span>${orderNo}</span></li>
                    <li>주문일자 <span>${orderdate}</span></li>
                    </ul>
                </div>
            

            <!-- 주문상품 리스트 -->
            <div class="list-title">
                <h3>배송상품 주문내역</h3>
            </div>
            <div class="order-table">
            <c:set var="cartlist" value="${cartList }"/>
            <c:set var="celeblist" value="${celebList }"/>
            <c:set var="prdlist" value="${prdList }"/>
            
                <table cellspacing="0">
                    <tr>
                        <th colspan="2">상품정보</th>
                        <th>수량</th>
                        <th>적립금</th>
                        <th>배송비</th>
                        <th>주문금액</th>
                    </tr>
                    <c:if test="${!empty cartlist}">
                    <c:forEach items="${cartlist }" var="cdto">
                    <tr>
                        <td class="order-image">
                            <a href="<%=request.getContextPath()%>/product_detail.do?pno=${cdto.cart_pno}">
                                <img src="product/${cdto.cart_pimage}" alt="${cdto.cart_pname }">
                            </a>
                        </td>
                        <td class="order-prdInfo">
                            <div class="order-prdGroup">
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
                            <div class="order-prdName">
                                <a href="<%=request.getContextPath()%>/product_detail.do?pno=${cdto.cart_pno}">
                                ${cdto.cart_pname}
                                </a>
                            </div>

                        </td>
                        <td class="order-qty">${cdto.cart_pqty}</td>
                        <td class="order-prdMileage">${cdto.cart_mileage}P</td>
                        <td class="order-deliberyFee">[조건]</td>
                        <td class="order-amount">
                        	<strong>₩<fmt:formatNumber value="${cdto.cart_pqty * cdto.cart_price }"/></strong> 
                        </td>
                    </tr>
                    </c:forEach>
                    </c:if>

                    <tr id="order-tableRight">
                        <td colspan="6">
                                <div id="total">
                                상품합계&nbsp;&nbsp;&nbsp;&nbsp;₩ 
                                <span id="prdTotalAmount">
                                    <fmt:formatNumber value="${prdtotal}"/> 
                                </span> 
                                <span class="plus_sign">+</span>
                                배송비&nbsp;&nbsp;&nbsp;&nbsp;
                                <span id="prdDeliberyFee">3,000</span>
                                <span class="plus_sign">-</span>
                                마일리지&nbsp;&nbsp;&nbsp;&nbsp;
                                <span id="mileageUseAmount"><fmt:formatNumber value="${usemileage}"/></span>
                                <span class="plus_sign_line">&nbsp;</span> 
                                총 합계 &nbsp;
                                <strong>&nbsp;
                                	<span id="totalAmount">
                                    ₩<fmt:formatNumber value="${totalorder}"/>
                                    </span>
                                </strong>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>

            <div id="paymentInfo">
                <div id="leftInfo">
                    <div class="paymentInfo-title">
                    <h3>결재정보</h3>
                    </div>
                    <table cellspacing="0">
                        <tr>
                            <th>최종결제금액</th>
                            <td>₩ <fmt:formatNumber value="${totalorder}"/></td>
                        </tr>
                        <tr>
                            <th>결제수단</th>
                            <td>${payMethod }</td>
                        </tr>
                    </table>
                </div>

                <div id="rightInfo">
                    <div class="paymentInfo-title">
                    <h3>적립내역</h3>
                    </div>
                    <table cellspacing="0">
                        <tr>
                            <th>총 적립예정금액</th>
                            <td><fmt:formatNumber value="${prdmileagetotal}"/>P</td>
                        </tr>
                    </table>
                </div>
            </div>

            
            <div class="deliberyInfo-title">
                <h3>배송지정보</h3>
            </div>

            <div id="deliberyInfo">  
                <div id="deliberyInfo-left">
                    <table>
                        <tr>
                            <th>받으시는분</th>
                            <td>${receivername}</td>
                        </tr>
                        <tr>
                            <th>휴대전화</th>
                            <td>${receiverphone}</td>
                        </tr>
                    </table>
                </div>

                <div id="deliberyInfo-right">
                    <table>
                        <tr>
                            <th>우편번호</th>
                            <td>${receiverzipcode }</td>
                        </tr>
                        <tr>
                            <th>주소</th>
                            <td>${receiveraddr}</td>
                        </tr>
                        <tr>
                            <th>배송메시지</th>
                            <td>${message}</td>
                        </tr>
                    </table>
                </div>
            </div>

            <div id="bottomBtn">
                <button type="button" class="continueBtn"
                onclick="location.href='product_list.do?cno=${100}'">쇼핑계속하기</button>
                <button type="button" class="donfirmBtn" onclick="location.href='order_list.do'">주문확인하기</button>
            </div>


            <div id="bottomInfo">
                <ol>
                    <li><i class="fa-solid fa-circle-exclamation"></i>&nbsp;비회원 주문의 경우, 주문번호를 꼭 기억하세요. 주문번호로 주문조회가 가능합니다.</li>
                    <li><i class="fa-solid fa-circle-exclamation"></i>&nbsp;배송은 결제완료 후 지역에 따라 3일 ~ 5일 가량이 소요됩니다. </li>
                    <li><i class="fa-solid fa-circle-exclamation"></i>&nbsp;상품별 자세한 배송과정은 주문조회를 통하여 조회하실 수 있습니다.</li>
                    <li><i class="fa-solid fa-circle-exclamation"></i>&nbsp;주문의 취소 및 환불, 교환에 관한 사항은 이용안내의 내용을 참고하십시오.</li>
                </ol>
            </div>
            	
        </div>
        </div>
        
        <a id="back-to-top" href="#">Top</a>
        <a id="back-to-bottom" href="#">Bot</a>
    </div>  
    <%@include file="../include/user_bottom.jsp" %>
	<script src="js/product_order_ok.js"></script>
</body>
</html>