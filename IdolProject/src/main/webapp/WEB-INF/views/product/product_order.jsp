<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품주문 페이지</title>
    <script src="https://kit.fontawesome.com/3de1cbcb05.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <link rel="stylesheet" href="css/product_order.css">
</head>
<body>
<%@include file="../include/user_top.jsp" %>
    <div id="wrap">
        <div id="container">
        <div id="content">
            <div class="order-title">
                <h2>Order</h2>
            </div>
            <form method="post" action="<%=request.getContextPath()%>/product_order_ok.do">
            	<c:set var="clist" value="${cartList }"/>
            	<c:set var="celeblist" value="${celebList }"/>
            	<c:set var="prdlist" value="${prdList }"/>
                <input type="hidden" id="memNo" value="${loginInfo.member_no }">
                <input type="hidden" id="memName" value="${loginInfo.member_name }">
                <input type="hidden" id="memEmail1" value="${email1 }">
                <input type="hidden" id="memEmail2" value="${email2 }">
                <input type="hidden" id="memAddr1" value="${addr1 }">
                <input type="hidden" id="memAddr2" value="${addr2 }">
                <input type="hidden" id="memAddr3" value="${addr3 }">
                <input type="hidden" id="memAddr4" value="${addr4 }">
                <input type="hidden" id="memPhone1" value="${phone1 }">
                <input type="hidden" id="memPhone2" value="${phone2 }">
                <input type="hidden" id="memMileage" value="${memMileage }">
                <input type="hidden" id="memprdMileage" name="prdmileagetotal" value="${prdmileagetotal }">
                <input type="hidden" id="memPrdtotal" value="${prdtotal }">
                
            <div class="list-title">
                <h3>국내 배송상품 주문내역</h3>
            </div>
            <div class="order-table">
                <table cellspacing="0">
                    <tr>
                        <th colspan="2">상품정보</th>
                        <th>수량</th>
                        <th>배송비</th>
                        <th>주문금액</th>
                    </tr>
                    <c:if test="${!empty clist}">
                    <c:forEach items="${clist }" var="cdto">
                    <input type="hidden" name="cartNo" value="${cdto.cart_no}">
                    <tr>
                        <td class="order-image">
                            <a href="<%=request.getContextPath()%>/product_detail.do?pno=${cdto.cart_pno}">
                                <img src="product/${cdto.cart_pimage}" alt="카트 제품이미지">
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
                        <td class="order-deliberyFee">[조건]</td>
                        <td class="order-amount"><strong>₩<fmt:formatNumber value="${cdto.cart_pqty * cdto.cart_price }"/></strong></td>
                    </tr>
                    </c:forEach>
                    </c:if>
                    

                    <tr id="order-tableRight">
                        <td colspan="6">
                            <div id="mileage-total">
                                <div id="mileage">
                                    마일리지 보유&nbsp;&nbsp;&nbsp;&nbsp;₩ <fmt:formatNumber value="${memMileage }"/>
                                    &nbsp;&nbsp;&nbsp;<input type="number" name="mileageUse"
                                    id="mileageUseInput" min="0" value="0"> &nbsp;&nbsp;<button type="button" id="mileageAllUse">전액사용</button>
                                    &nbsp;&nbsp;
                                    <button type="button" id="mileageApply">적용</button>
                                </div>

                                <div id="total">
                                상품합계&nbsp;&nbsp;&nbsp;&nbsp;₩ <span id="prdTotalAmount"><fmt:formatNumber value="${prdtotal }"/></span> 
                                <span class="plus_sign">+</span>
                                배송비&nbsp;&nbsp;&nbsp;&nbsp;
                                <span id="prdDeliberyFee"><fmt:formatNumber value="3000"/></span>
                                <span class="plus_sign">-</span>
                                마일리지&nbsp;&nbsp;&nbsp;&nbsp;
                                <span id="mileageUseAmount">0</span>
                                <span class="plus_sign_line">&nbsp;</span> 
                                총 합계 &nbsp;
                                <strong></strong>₩&nbsp;<span id="totalAmount"><fmt:formatNumber value="${prdtotal+3000 }"/></strong></span>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="back-button">
                <span class="gLeft">
                    <button type="button" onclick="location.href='product_cartList.do?memno=${loginInfo.member_no }'">
                        	장바구니페이지
                    </button>
                </span>
                <span class="gRight"><i class="fa-solid fa-circle-exclamation"></i>&nbsp;
                    상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.
                </span>
            </div>

            <div id="orderAreaContainer">
                <div id="orderAreaLeft">
                    <div class="title">
                        <h3>주문자 정보</h3>
                        <span class="required"><em class="ico_required">·</em> 필수입력사항</span>
                    </div>
                    <div class="userInfo-table">
                        <table cellspacing="0">
                            <tr>
                                <th><em class="ico_required">·</em>주문하시는 분</th>
                                <td><input id="oname" name=""  placeholder="" size="20" value="${loginInfo.member_name }" type="text" readonly></td>
                            </tr>
                            <tr>
                                <th><em class="ico_required">·</em>주소</th>
                                <td>
                                    <input type="text" id="sample4_postcode1" placeholder="우편번호" value="${addr1 }"> <!-- addr1 -->
                                    <button id="addrButton" type="button" onclick="sample4_execDaumPostcode1()">
                                        주소찾기
                                    </button><br>
                                    <input type="text" id="sample4_roadAddress1" placeholder="도로명주소" value="${addr2 }"><!-- addr2 -->
                                    <input type="text" id="sample4_jibunAddress1" placeholder="지번주소">
                                    <span id="guide1" style="color:#999;display:none"></span>
                                    <input type="text" id="sample4_detailAddress1" placeholder="상세주소" value="${addr3 }"> <!-- addr2 -->
                                    <input type="text" id="sample4_extraAddress1" placeholder="참고항목" value="${addr4 }"> <!-- addr4 -->

                                    <!-- <input id="ozipcode" name="" placeholder="" size="6" maxlength="6"  value="" type="text">
                                    <button id="addrButton" type="button" onclick="sample4_execDaumPostcode()">
                                        주소찾기
                                    </button>
                                    <br>
                                    <input id="oaddr1" name="" placeholder="기본주소" size="40"  value="" type="text">
                                    <br>
                                    <input id="oaddr2" name="" placeholder="나머지주소" size="40" value="" type="text"> -->

                                </td>
                            </tr>

                            <tr>
                                <th><em class="ico_required">·</em>휴대전화</th>
                                <td class="number_box">
                                    <input id="ophone1_1" name="" readonly value="010" type="text" style="width: 100px;">
                                    - <input id="ophone2" name="" maxlength="4" size="4" value="${phone1 }" type="text" style="width: 100px;">
                                    - <input id="ophone3" name="" maxlength="4" size="4" value="${phone2 }" type="text" style="width: 100px;"> 
                                </td>
                            </tr>

                            <tr>
                                <th><em class="ico_required">·</em>이메일</th>
                                <td>
                                    <input id="oemail1" name="" value="${email1 }" type="text" style="width: 161px;">
                                    @
                                    <input id="oemail2" type="text" style="width: 161px;" readonly>
                                    <select id="oemail3">
                                    <option value="" selected="selected">- 이메일 선택 -</option>
                                    <option value="naver.com" <c:if test="${email2 == 'naver.com'}">selected</c:if> >naver.com</option>
                                    <option value="daum.net" <c:if test="${email2 == 'daum.net'}">selected</c:if> >daum.net</option>
                                    <option value="nate.com" <c:if test="${email2 == 'nate.com'}">selected</c:if> >nate.com</option>
                                    <option value="hotmail.com" <c:if test="${email2 == 'hotmail.com'}">selected</c:if> >hotmail.com</option>
                                    <option value="yahoo.com" <c:if test="${email2 == 'yahoo.com'}">selected</c:if> >yahoo.com</option>
                                    <option value="empas.com" <c:if test="${email2 == 'empas.com'}">selected</c:if> >empas.com</option>
                                    <option value="korea.com" <c:if test="${email2 == 'korea.com'}">selected</c:if> >korea.com</option>
                                    <option value="dreamwiz.com" <c:if test="${email2 == 'dreamwiz.com'}">selected</c:if> >dreamwiz.com</option>
                                    <option value="gmail.com" <c:if test="${email2 == 'gmail.com'}">selected</c:if> >gmail.com</option>
                                    <option value="etc">직접입력</option>
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="title">
                        <h3>배송 정보</h3>
                        <span class="required"><em class="ico_required">·</em> 필수입력사항</span>
                    </div>
                    <div class="delivery-table">
                        <table cellspacing="0">
                            <tr>
                                <th><em class="ico_required">·</em>배송지 선택</th>
                                <td>
                                    <div class="address">
                                        <input id="sameaddr0" name="sameaddr0" value="T" type="radio"><label for="sameaddr0">주문자 정보와 동일</label>
                                        &nbsp;&nbsp;&nbsp;
                                        <input id="sameaddr1" name="sameaddr0" value="F" type="radio"><label for="sameaddr1">새로운 배송지</label>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th><em class="ico_required">·</em>받으시는 분</th>
                                <td><input id="dname" name="order_receivername"  placeholder="" size="20" value="${loginInfo.member_name }" type="text" required></td>
                            </tr>
                            <tr>
                                <th><em class="ico_required">·</em>주소</th>
                                <td>
                                    <input type="text" id="sample4_postcode2" name="addr1" placeholder="우편번호" value="${addr1 }" required> <!-- addr2 -->
                                    <button id="addrButton" type="button" onclick="sample4_execDaumPostcode2()">
                                        주소찾기
                                    </button><br>
                                    <input type="text" id="sample4_roadAddress2" name="addr2" placeholder="도로명주소" value="${addr2 }" required><!-- addr2 -->
                                    <input type="text" id="sample4_jibunAddress2" placeholder="지번주소">
                                    <span id="guide2" style="color:#999;display:none"></span>
                                    <input type="text" id="sample4_detailAddress2" name="addr3" placeholder="상세주소" value="${addr3}" required> <!-- addr3 -->
                                    <input type="text" id="sample4_extraAddress2" name="addr4" placeholder="참고항목" value="${addr4 }"> <!-- addr4 -->

                                    <!-- <input id="ozipcode" name="" placeholder="" size="6" maxlength="6"  value="" type="text">
                                    <button id="addrButton" type="button">
                                        주소찾기
                                    </button>
                                    <br>
                                    <input id="oaddr1" name="" placeholder="기본주소" size="40"  value="" type="text">
                                    <br>
                                    <input id="oaddr2" name="" placeholder="나머지주소" size="40" value="" type="text"> -->

                                </td>
                            </tr>

                            <tr>
                                <th><em class="ico_required">·</em>휴대전화</th>
                                <td class="number_box">
                                    <input id="dphone1_1" name="phone1" readonly value="010" type="text" style="width: 100px;">
                                    - <input id="dphone2" name="phone2" maxlength="4" ize="4" value="${phone1 }" type="text" style="width: 100px;" required>
                                    - <input id="dphone3" name="phone3" maxlength="4" size="4" value="${phone2 }" type="text" style="width: 100px;" required> 
                                </td>
                            </tr>

                            <tr>
                                <th><em class="ico_required"></em>배송메시지</th>
                                <td>
                                    <textarea id="omessage" name="omessage" maxlength="255" cols="70"></textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div id="orderAreaRight">
                    <div class="title">
                        <h3>할인 쿠폰/적립 혜택</h3>
                    </div>
                    <div class="mileageBox">
                        <div class="afterMileage">
                            적립예정금액 <span>${prdmileagetotal}P</span>
                        </div>
                    </div>
                    
                        <div class="order-deliberyInfo" style="font-size:13px;display: block;margin-top:20px;">
                            <b>[주문 및 배송정보]</b>
                            <span>
                            <p>[국내 일반 배송]
                            <br>· 배송방식 : YOUR &amp;CELEB  물류센터 직접배송(우체국택배)
                            <br>· 배송지역 : 전국(일부지역 제외)
                            <br>· 배송비용 : 3,000원 / 주문금액 50,000원 이상 시 무료배송
                            <br>· 배송기간 : 결제 후 3~5일 이내 (영업일 기준)
                            </p>
                            <p>- 오후 3시 이전 결제 완료 시 당일 배송이 원칙이며 그 외는 익일 발송됩니다.
                            <br>- 산간벽지나 도서지방은 별도의 추가금액을 지불하셔야 하는 경우가 있습니다.
                            <br>- 상품의 재고상황에 따라 배송기간이 다소 지연될 수도 있습니다.
                            <br>- 물류센터 사정으로 인해 배송이 지연될 수 있습니다.
                            <span style="color: rgb(255, 0, 0);"><br><br>- 사전예약/주문제작 등 당일 배송이 어려운 상품을 함께 구매하시는 경우 모든
                            상품이 배송 가능한 상태가 되는 시점에 주문하신 상품이 함께 배송 됩니다.
                            (예약판매 상품은 순차배송일 기준, ARTISTCASE는 주문완료 후 약 2주 소요) 
                            </span>
                            <br>- 기본 배송기간 이상 소요되는 상품 또는 품절된 상품은 개별 연락 드리겠습니다.</p>
                        </div>
                    
                </div>
            </div>

            <!-- 결제수단 -->
            <div class="payTitle">
                결제수단
            </div>
            <div class="payArea">
            <input type="hidden" id="order_type" name = "order_type" value="1">
            <input type="hidden" id="payMethod" name = "payMethod" value="">
                <div class="method">
                    <span>카드결제</span>
                    <span>에스크로(실시간 계좌이체)</span>
                    <span>카카오페이(간편결제)</span>
                    <span>페이코(간편결제)</span>
                </div>

                <div class="payingCardArea">
					
                    <div class="cardTable">
                        <table>
                            <tr>
                                <th>카드선택</th>
                                <td>
                                    <select name="cardKind" id="">
                                        <option value="신한카드">신한카드</option>
                                        <option value="우리카드">우리카드</option>
                                        <option value="국민카드">국민카드</option>
                                        <option value="롯데카드">롯데카드</option>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <th>할부기간</th>
                                <td>
                                    <select name="cardPeriod" id="" disabled>
                                        <option value="일시불" selected>일시불</option>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <th>결제안내</th>
                                <td>
                                    <button type="button" class="BtnNormal">공인인증서 발급안내</button>
                                    <button type="button" class="BtnNormal">안심클릭 안내</button>
                                    <button type="button" class="BtnNormal">안전결제 (ISP)안내</button>
                                </td>
                        
                            </tr>
                        </table>
                    </div>

                    <div class="cardAgree" >
                        <div class="paymentAgree selected">
                            <div class="all">
                                <div class="checkbox-button">
                                <input type="checkbox" id="allClick" > &nbsp;
                                <span>결제대행서비스 약관에 모두 동의합니다.
                                </span>
                                </div>
                                <button type="button" class="btnToggle">전체보기</button>
                            </div>
                            <div class="detail">
                                <p class="check">
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <input type="checkbox" class="card_agree_checkbox" required>
                                    <span>전자금융거래 기본약관</span>
                                    <a href="#" onclick="" class="view">[내용보기]</a>
                                </p>
                            </div>
                        </div>
                    </div>
 
                    <div class="payHelp" >
                        <p class="ec-base-help"><i class="fa-solid fa-circle-exclamation"></i>소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.</p>
                    </div>
                </div>

                <div class="payingEscrow">
                    <div class="escrowTable">
                        <table>
                            <tr>
                                <th>예금주명</th>
                                <td>
                                    <input class="escrowInputName" type="text">
                                </td>
                            </tr>

                            <tr>
                                <th></th>
                                <td>
                                    <input type="checkbox">
                                    <span>
                                    에스크로(구매안전)서비스를 적용합니다.
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="payHelp" >
                        <p class="ec-base-help"><i class="fa-solid fa-circle-exclamation"></i>소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.</p>
                    </div>
                </div>

                <div class="payingKakao">
                    <div id="kakaopay_info" >
                        <p class="ec-base-help">휴대폰에 설치된 카카오톡 앱에서 비밀번호 입력만으로 빠르고 안전하게 결제가 가능한 서비스 입니다.</p>
                        <p class="ec-base-help">안드로이드의 경우 구글 플레이, 아이폰의 경우 앱 스토어에서 카카오톡 앱을 설치 한 후, 최초 1회 카드 및 계좌 정보를 등록하셔야 사용 가능합니다.</p>
                        <p class="ec-base-help">인터넷 익스플로러의 경우 8 이상에서만 결제 가능합니다.</p>
                        <p class="ec-base-help">BC카드 중 신한, 하나, 국민카드는 결제가 불가능합니다.</p>
                    </div>
                </div>

                <div class="payingPayco">
                    <div id="payco_info">
                        <p class="ec-base-help">페이코 결제 팝업창에서 비밀번호 입력만으로 빠르고 안전하게 결제가 가능한 서비스 입니다.</p>
                        <p class="ec-base-help"><a href="//www.payco.com" target="_blank">www.payco.com</a> 에 회원가입 후, 최초 1회 카드 및 계좌 정보를 등록하셔야 사용 가능합니다.</p>
                    </div>
                </div>

                <div id="totalArea">
                    <div id="totalAmount">
                    <span class="amountNumber">₩
                        <span class="BtotalAmount" id="BtotalAmount">
                            <fmt:formatNumber value="${prdtotal }"/> 
                        </span>
                    </span>
                    <span class="amountTag">
                        	총삼품금액
                    </span>
                    </div>
                    
                    <div class="sing">
                        <span class="minusSing">+</span>
                    </div>
                    
					<div id="deliberyFee">
                        <span class="amountNumber">₩
                            <span class="BtotalAmount" id="BdeliberyFee">
                                <fmt:formatNumber value="3000"/>
                            </span>
                        </span>
                        <span class="amountTag">
                            	배송비
                        </span>
                    </div>
                    
                    
                    <div class="sing">
                        <span class="minusSing">-</span>
                    </div>

                    <div id="mileageUse">
                        <span class="amountNumber">₩
                            <span class="BtotalAmount" id="BmileageUse">
                                <fmt:formatNumber value="0"/>
                            </span>
                        </span>
                        <span class="amountTag">
                            	마일리지 사용금액
                        </span>
                    </div>

                    <div class="sing">
                        <span class="resultSing">=</span>
                    </div>

                    <div id="finalAmount">
                        <span class="amountNumber amountResult">₩
                            <span class="BtotalAmount" id="BfinalAmount">
                                <fmt:formatNumber value="${prdtotal+3000 }"/>
                            </span>
                        </span>
                        <span class="amountTag">
                            	최종결제 금액
                        </span>
                    </div>
                </div>
                
            </div>

            <div id="payingBtnContainer">
                <div id="deliberyInfo">
                    사전예약상품을 구매하신 경우 모든 상품이 준비되었을 때 배송이 시작되오니 주문하신 상품의 배송예정일을 다시 한 번 확인 부탁드립니다. <br>
                    ※ 순차배송일이 각각 다른 상품을 함께 주문하실 경우 순차배송일이 가장 늦은 상품의 배송일자 기준으로 합배송(묶음배송) 됩니다.
                </div>

                <div id="payingBtn">
                    <button type="submit">결제하기</button>
                </div>
            </div>

            </form>


        </div>
        </div>


        <a id="back-to-top" href="#">Top</a>
        <a id="back-to-bottom" href="#">Bot</a>
    </div>  
    <%@include file="../include/user_bottom.jsp" %>
    <script src="js/product_order.js"></script>
</body>
</html>