<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품정보 페이지</title>
<link rel="stylesheet" href="css/product_detail.css">
<script src="https://kit.fontawesome.com/3de1cbcb05.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" /> -->
<link rel="stylesheet" href="css/product_detail_swiper.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
</head>
<body>
<%@include file="../include/user_top.jsp" %>
	<c:set var="pdto" value="${PDetail}"/>
	<c:set var="cdto" value="${CDetail}"/>
	<c:set var="plist" value="${PList}"/>
	<c:set var="dimlist" value="${PdImageList}"/>
	<c:set var="user" value="${loginInfo}"/><!-- 유저 DTO -->
	
	<div id="wrap">
        <div id="container">
            <div id="left-container">
                <div id="backg-img">
                    <img src="product/${PmImage}" alt="대표이미지">
                    <!-- ajax에 들어갈 pimage파라메터값을 위한 id부여 -->
                    <input type="hidden" id="pimage" value="${PmImage}">
                </div>
				<c:if test="${!empty dimlist}">
				<c:forEach items="${dimlist}" var="dimdto">
                <div class="detail-img">
                    <img src="product/${dimdto}" alt="제품이미지">
                </div>
                </c:forEach>
                </c:if>

                <div id="tab-container">
                        <a id="tab_info" href="#none">상품정보</a>
                        <a id="tab_order" href="#none">주문 및 배송 안내</a>
                        <a id="tab_exchange" href="#none">교환 및 환불 안내</a>
                        <a id="tab_quality" href="#none">품질보증기준</a>
                </div>

                <div id="prdInfo-container">
                    <div class="prd_info tab_info">
                        <b>[상품정보]</b>
                        - 상품 : ${pdto.product_detail}
                    </div>
            
                    <div class="prd_order tab_info">
                        <b>[주문 및 배송정보]</b>
                        <p>[국내 일반 배송]
				                        ・배송방식 : YOUR &amp;CELEB  물류센터 직접배송(CJ대한통운)
				                        ・배송지역 : 전국(일부지역 제외)
				                        ・배송비용 : 3,000원 / 주문금액 50,000원 이상 시 무료배송
				                        ・도서산간지역은 추가 배송비가 발생할 수 있습니다.
				                        ・배송기간 : 결제 후 3~5일 이내 (영업일 기준)
				        </p>
                        <p>
                        - 상품의 재고상황에 따라 배송기간이 다소 지연될 수도 있습니다.
                        - 물류센터 사정으로 인해 배송이 지연될 수 있습니다.</p>
                        <p>
                        - 예약판매 상품, 아티스트 케이스 상품 등 당일 배송이 어려운 상품을 함께 구매하는 경우
                     	   모든 상품이 배송 가능한 상태가 되는 시점에 주문하신 상품이 함께 배송됩니다.
                        (예약판매 상품은 순차배송일 기준, 아티스트 케이스는 주문완료 후 약 2주 소요)
                        - 기본 배송기간 이상 소요되는 상품이거나 품절된 상품은 개별 연락 드리겠습니다.
                        </p>										
                    </div>
            
                    <div class="prd_exchange tab_info">
                        <b>[교환 및 환불정보]</b>
                        <span style="white-space: pre-wrap;">[교환∙반품 방법]</span>
                        <br><br>
                                             상품 수령일로부터 7일 이내에 교환/반품 사유가 확인 가능한 사진 (상품 전체 혹은 불량 부분 확대 사진)을 첨부하여&nbsp;
                                             주문번호, 상품바코드, &nbsp;반송사유 등을 cscenter@yourceleb.com로 이메일 발송 혹은 고객센터로 문의 부탁드립니다.
                        <br> ・상품교환∙반품단계
                        <br>- Step1: 교환∙반품 기간확인
                        <br>- Step2: 마이페이지 또는 1:1문의로 교환∙반품접수
                        <br>- Step3: CS담당자의 안내 후 7일 이내 지정 반품지 및 지정 반품수단으로 교환, 반품 배송
                        <br>- Step4: 반품지에 상품 입고 및 검품 후 교환∙반품 진행
                        <br>- Step5: 교환∙반품 완료
                        <br><br>

                        [교환∙반품시 유의사항]
                                                                ・상품의 색상은 모니터 사양에 따라 실제 색상과는 다소 차이가 있을 수 있으며, 상품 라벨의 위치나 색상은 이미지와 다를 수 있습니다.
						 <br>- 구성품 누락 및 불량으로 인한 교환/환불을 위해서는 택배 박스 및 상품 개봉(구성품 포함) 영상이 반드시 필요합니다.
                        <br>
                        &nbsp; 개봉 영상이 없을 경우 교환 및 환불이 어려울 수 있습니다
                        <br>- 개봉 영상은 개봉 전 박스의 모든 면이 보이고, 상품 개봉 장면이 온전하게 보이도록 촬영 하셔야 합니다.
                        <br>- 구성품이 랜덤인 상품의 경우, 교환 진행 시 교환 상품도 랜덤으로 발송됩니다.
                        <br>- 상품 결함의 경우 5mm 이하의 찍힘 자국과 상품 공정상 발견 될 수 있는 스크래치 및 눌림, 찍힘 자국은 교환 및 반품의 대상이 되지 않습니다.
                        <br>- 인화류/지류 및 초상 상품의 경우 뒷면, 배경 등 초상 이외의 결함과 공정 과정에서 발생 할 수 있는 스크래치, 눌림 및 찍힘은 교환 및 반품의 대상이 되지 않습니다.
                        <br>- 모든 상품은 빛 반사가 없는 상태에서 보이는 하자일 경우에만 교환/환불 가능합니다.
                        <span style="font-size: 14px;">
                        <br>- PVC 상품의 경우 소재 특성상 주변환경(온. 습도)의 영향에 따라 형태의 변형 또는 PVC 간 달라붙음 등의 하자가 발생할 수 있으며, 그로인한 교환 및 반품의 대상이 되지 않습니다.
                        </span>
                        <br>
                        <br>・교환∙반품 가능기간
                        <br>- 변심, 배송오류, 파손, 불량 등 상품 결함 : 단순 변심, 상품 하자, 오배송의 경우 수령일로부터 7일 이내까지 1:1문의 또는 CS CENTER로 접수 가능합니다.
                       	<br>
                       	・교환∙반품 불가한 경우
                        <br>- 상품 수령 후 7일을 초과한 경우
                        <br>- 상품의 가치가 감소한 경우 (포장지 훼손, 세탁, 상품 얼룩, 향수 냄새, 탈취제 냄새, 증정품 훼손, 구성품 훼손, 사용 흔적 등)
                        <br>- 구매자의 사용 또는 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우
                        <br>- 시간의 경과에 의하여 재판매가 곤란할 정도로 상품등의 가치가 현저히 감소한 경우(상품 바코드 제거, 수선 등)
                        <div>
                        - 주문제작 상품이나 세일 상품, 음반 등 상품 상세페이지에 교환/환불 불가를 공지한 상품의 경우 
                        <br>- 복제가 가능한 상품등의 포장을 훼손한 경우
                        </div>
                        - 제품의 오배송, 불량 상품이라도 사용 흔적, 훼손 등의 흔적이 있을 경우 
                        <br>- 촬영 또는 해상도 등의 영향으로 고객님의 모니터에서 확인되는 색상과 실제 수령한 상품의 색상 차이가 있을 경우 
                        <br>- 상품의 프린트 혹은 패턴이 있는 경우 상품상세페이지 이미지와 다를 수 있습니다.


                        <br>- 교환/반품 진행시 이벤트, 프로모션으로 증정된 증정품을 함께 보내주셔야 하며, 누락시 교환/환불이 불가합니다.


                        <br>- 모든 상품 특성상 재고가 조기 소진될 수 있어 단순변심에 의한 교환은 어려울 수 있으며,

                        <br>반품/교환은 전자상거래 등에서의 소비자 보호에 관한 법률에 의거한 규정을 따릅니다.


                        <br>- YOUR &amp;CELEB 온라인스토어에서 구매하신 상품은 공식 오프라인 매장에서 교환/환불이 절대 불가합니다.


                        <br>- 공식 오프라인 매장에서 구매하신 상품은 YOUR &amp;CELEB 온라인스토어에서 교환/환불이 절대 불가합니다.

                        <div>
                        - 각 상품별로 교환/환불 정책은 차이가 있을 수 있으며 자세한 사항은 상품정보에서 확인 부탁드립니다.
                        <br>(자세한 내용은 1:1문의 또는 CS CENTER를 이용해 주시기 바랍니다)
                       	<br> ・교환∙반품 비용
                        <br>- 변심 : 단순 변심으로 반품을 원할 경우에는 구매자가 왕복배송비 지불
                        <br>- 배송오류, 파손, 불량 등 상품 결함 : 상품하자, 오배송의 경우에는 판매자가 배송비 지불
                        (정확한 교환∙반품비용은 1:1문의 또는 CS CENTER를 이용해 주시기 바랍니다)
                        </div>
                        <div><br></div>
                        <div><br></div>
                        <div>
                        [미성년자 권리보호안내]
                      	  미성년 고객께서 상품을 주문(계약) 하시는 경우, 법정대리인(부모님 등)이 그 주문(계약)에 동의하지 않으면
                      	</div>
                      	<div>미성년자 본인 또는 법정대리인(부모님 등)이 그 주문(계약)을 취소하실 수 있습니다.&nbsp;</div>      
                   	</div>

                    <div class="prd_quality tab_info">
                        <b>[품질보증기준]</b>
                       	 제품의 품질에 이상이 있을 경우, 반품, 교환, A/S, 환불 , 품질보증 및 피해보상 등에 관한 사항은 소비자분쟁해결기준(공정거래위원회 고시)에 의거하여 처리됩니다.        
                    </div>
                </div>
                
            </div>

            <div id="right-container">
                <div id="infoArea">
                <form method="post" action="<%=request.getContextPath()%>/product_directorder.do" onsubmit="return submitCheck();">
                <!-- submit시(구매버튼클릭) cart에 우선으로 담은 후에 order페이지로 이동한다  -->
                <!-- ajax에 들어갈 pno파라메터값을 위한 id부여 -->
                <input type="hidden" id="pno" name="cart_pno" value="${pdto.product_no }">
                <input type="hidden" id="memno" name="cart_userno" value="${user.member_no}">
                <input type="hidden" name="cart_pname" value="${pdto.product_name }">   
                <!-- cart_pqty는 아래 input number에 있음 -->
                <input type="hidden" name="cart_price" value="${pdto.product_price }">
                <input type="hidden" name=cart_psize value="${pdto.product_size }">
                <input type="hidden" name="cart_pcolor" value="${pdto.product_color }">
                <input type="hidden" name="cart_pimage" value="${PmImage}">
                <input type="hidden" name="cart_mileage" value="${pdto.product_mileage }">
                
                <!-- 제품이 등록될때 제품의 수량이 정해진다 이를통해 구매가능한 제품의 수량을 정할 수 있다. -->
                <input type="hidden" id="product_qty" value="${pdto.product_qty }">
                    <div class="info-head">
                        <div class="info-celeb">
                        <!-- 셀럽그룹이 있으면 해당 셀럽 그룹명을 호출 하되 그룹명이 없으면 셀럽네임을 호출한다. -->
                        <c:if test="${cdto.celeb_group ne 'solo'}">
                            ${cdto.celeb_group }  
                        </c:if>
                        
                        <c:if test="${cdto.celeb_group eq 'solo'}">
                            ${cdto.celeb_name }  
                        </c:if>
                        
                        </div>
                        <c:if test="${pdto.product_qty <= 0 }">
                        <div class="info-prdName">
                            ${pdto.product_name } <br> <span style="color: red;">[SOLD OUT]</span>
                        </div>
                        </c:if>
                        
                        <c:if test="${pdto.product_qty > 0 }">
                        <div class="info-prdName">
                            ${pdto.product_name }
                        </div>
                        </c:if>
                        
                        <div class="info-prdPrice">
                            ₩<fmt:formatNumber>${pdto.product_price }</fmt:formatNumber>
                            <i class="fa-solid fa-share-nodes fa-lg"></i>
                        </div>
                    </div>
                    <div class="info-mileage">
                        <table width="100%">
                            <tr> 
                                <td class="table-title">적립금</td>
                                <td class="table-cont">0.5%(${pdto.product_mileage } P)</td>
                                <td class="table-icon">
                                    <i class="fa-solid fa-chevron-down"></i>
                                    <i class="fa-solid fa-chevron-up" style="display: none;"></i>
                                </td>
                            </tr>
                            <tr style="display: none;"> 
                                <td class="table-title">회원등급별</td>
                                <td class="table-cont">PINK SILVER 기본적립금 +0.2%</td>
                            </tr>
                            <tr style="display: none;"> 
                                <td class="table-title">추가적립금</td>
                                <td class="table-cont">PINK GOLD 기본적립금 +0.3%</td>
                            </tr>
                        </table>
                    </div>
                    
                    <div class="info-order">
                        *해당 상품은 ${Month}/${Day+5}~${Day+10} 이내에 순차 출고될 예정입니다.
                        <br>
                        *각 제품별 수량이 한정되어 있어 조기에 품절될 수 있습니다.
                    </div>
                    <c:if test="${!empty pdto.product_size}">
                    <div class="info-size">
                        size : ${pdto.product_size}
                    </div>
                    </c:if>
                    <c:if test="${!empty pdto.product_color}">
                    <div class="info-color">
                        color : ${pdto.product_color}
                    </div>
                    </c:if>
                    <div class="info-count">
                        <span class="prdName">${pdto.product_name }</span>
                        <br>
                        <span class="count_btn">
                        	<c:if test="${pdto.product_qty > 0 }">
                            <button type="button" class="plus">&#43;</button>
                            <!-- ajax에 들어갈 pqty파라메터값을 위한 id부여 -->
                            <input type="number" id="pqty" class="numBox" name="cart_pqty" min="1" max="10" value="1" readonly/>
                            <input id="product_price" name="price" type="hidden" value="${pdto.product_price }">
                            <button type="button" class="minus">&#45;</button>
                            <span class="totalPrice">
                                <fmt:formatNumber>${pdto.product_price }</fmt:formatNumber>
                            </span>
                            
                            </c:if>
                            <c:if test="${pdto.product_qty <= 0 }">
                            <button type="button" class="plus" disabled>&#43;</button>
                            <input type="number" class="numBox" name="product_qty" min="0" max="0" value="0" readonly disabled/>
                            <input id="product_price" name="price" type="hidden" value="45000">
                            <button type="button" class="minus" disabled>&#45;</button>
                            <span class="totalPrice">
                                <fmt:formatNumber>0</fmt:formatNumber>
                            </span>
                            </c:if>
                        </span>

                    </div>
                    <div class="info-total">
                        <span class="total">TOTAL</span>
                        <span class="price-count">
                        	<c:if test="${pdto.product_qty > 0 }">
                            <span class="totalPrice2"><fmt:formatNumber>${pdto.product_price }</fmt:formatNumber></span>&nbsp;
                            (<span class="totalCount">1</span> )개
                            </c:if>
                            <c:if test="${pdto.product_qty <= 0 }">
                            <span class="totalPrice2"><fmt:formatNumber>0</fmt:formatNumber></span>&nbsp;
                            (<span class="totalCount">0</span> )개
                            </c:if>
                        </span>
                        
                    </div>
                    <div class="info-button">
                        <button class="now-button" type="submit">바로구매하기</button>
                        <br>
                        <button id="cart-button" class="cart-button" type="button">장바구니 담기</button>
                        <button class="wish-button" type="button">위시리스트 담기</button>
                    </div>

					<!-- 구매버튼 하단 스와이퍼 -->
					<div class="swiper-introduce">
					함께하면 좋은상품
                    </div>
					<div class="swiper-container1">
                        <!-- 보여지는 영역 -->
                        <div class="swiper-wrapper">
                          <!-- <div class="swiper-slide">내용</div> 를 추가하면된다 -->
                          <c:if test="${!empty plist }">
                          <c:forEach items="${plist }" var="pldto">
                          <div class="swiper-slide">
                          	<div class="swiper-img">
                          		<a href="<%=request.getContextPath()%>/product_detail.do?pno=${pldto.product_no}">
                          	   <img alt="제품이미지" src="product/${pldto.product_image }">
                          	   </a>
                          	</div>
                          	<div class="swiper-prdName">
                          		<a href="<%=request.getContextPath()%>/product_detail.do?pno=${pldto.product_no}">
                          		${pldto.product_name }
                          		</a>
                          	</div>
                          	<div class="swiper-prdPrice">
                          		₩<fmt:formatNumber value="${pldto.product_price }"/>
                          	</div>
                          </div>
                          </c:forEach>
                          </c:if>
                    	</div>
                    	
                    </div>
                    </form>
                    <!-- 방향 버튼 상황에 따라 추가 삭제가능 -->
					<div class="swiper-btn">
                    <div class="swiper-button-prev">
	                <i class="fa-solid fa-circle-chevron-left fa-2x"></i>
	                </div>
	                <div class="swiper-button-next">
	                <i class="fa-solid fa-circle-chevron-right fa-2x"></i>
	                </div>
	                </div>
                </div>
            </div>
        </div>
    <a id="back-to-top" href="#">Top</a>
    <a id="back-to-bottom" href="#">Bot</a>
    </div>
    
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
<script src="js/product_detail.js"></script>
</body>
</html>