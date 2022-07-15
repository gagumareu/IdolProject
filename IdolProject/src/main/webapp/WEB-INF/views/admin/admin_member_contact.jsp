<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN MEMBER CONTACT</title>
<style type="text/css">

	html, body {
		padding: 0px;
		margin: 0px;
		height: 100%;
		background-color: black;
		font-family: 'Press Start 2P', 'Jua', monospace;
	}
	
	a {
		text-decoration: none;
		color: white;
	}
	
	.admin_member_contact_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	}

	.admin_member_contact_container {
		display: flex;
	    flex-direction: column;
	    row-gap: 17px;
		/*border: 1px solid gold;*/
		align-items: center;
	}
	
	
	.member_inquiry_category {
		/*border: 1px solid gold;*/
		color: white;
		width: 80%;
	}
	
	.inquiry_box {
		display: flex;
    	flex-direction: row;
		gap: 20px;
		/*justify-content: center;*/
		margin: 13px 0px;
	}

	.border_radius {
		/*border: 1px solid white;*/
	    border-radius: 30px;
	    background-color: white;
		width: 500px;
		
		
	}

	/* a tag */
	.member_box_link {   
		text-decoration: none;
		color: black;
		width: 100%;
		/*border-radius: 30px;
		display: flex;
		flex-direction: column;*/
		height: 77px;
    	width: 100%;
    	display: flex;
    	/*display: grid;
    	grid-template-columns: 20% 80%;*/
    	
	}
	
	.member_communi_text {
		flex: 80%;
		max-width: 80%;
		/*
		display: flex;
	    flex-direction: column;
	    */
	    font-size: 0.8em;
    	justify-content: center;
    	margin: 10px;
    	display: grid;
   		grid-template-columns: 80% 20%;
	}
	
	
	.content_left {
		grid-column: 1;
		display: flex;
	    flex-direction: column;
	    justify-content: center;
	    align-items: center;
	}
	.content_title {
		font-weight: bold;
		font-size: 1.2em;
		
	}
	.content_id {
		
	}
	.content_right{
		grid-column: 2;
		font-size: 0.9em;
		justify-content: center;
	    display: flex;
	    align-items: center;
	}
	.categoryNshowMore{
		display: flex;
    	justify-content: space-between;
    	margin-top: 30px;
	}
	
	.member_img_box {
		flex: 20%;
		max-width: 20%;
		height: 100%;
		border-radius: 30px;
		overflow: hidden;
	
	}
	
	.member_img {
		width: 100%;
		height: 100%;
		
	}
	
	
	.showAll{
		font-size: 0.9em;
	}
	
</style>
</head>
<body>
<!-- 문의게시판 리스트 -->
<c:set var="ilist" value="${iList }" />
<!-- 문의게시판 카테고리 리스트 -->
<c:set var="iclist" value="${icList }" />
<!-- 맴버 리스트 -->
<c:set var="mlist" value="${mList }" />

<c:set var="returnlist" value="${returnList }" />
<c:set var="itemslist" value="${itemsList }" />
<c:set var="translist" value="${transList }" />
<c:set var="exchangelist" value="${exchangeList }" />
<c:set var="etclist" value="${etcList }" />
<c:set var="Oklist" value="${OkList }" />






	<div class="admin_member_contact_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_member_include.jsp" />
	
		
		
	<div class="admin_member_contact_container">
		
		
		<div class="member_inquiry_category">
		
		<!-- 1. 취소 /환불  -->
			<div class="categoryNshowMore">
				<div>[취소/환불]</div> 
				<a href="<%=request.getContextPath()%>/admin_inquiry_showMore.do?no=1">
					<div class="showAll">Show ALL></div>
				</a>
			</div>
			<div class="inquiry_box">
				<c:forEach begin="0" end="2" items="${returnlist }" var="re"> 
						<c:forEach items="${mlist }" var="mdto">
							<!-- 맴버리스트 아이디와 문의게시판 아이디가 같은 경우 리스트 뽑기 -->
							<c:if test="${mdto.member_id == re.inquiry_userid }">
							<div class="border_radius">
								<a class="member_box_link" href="<%=request.getContextPath()%>/admin_member_inquiryCont.do?no=${re.inquiry_no}
									&pno=${re.product_no}&ono=${re.order_no}&gno=${re.inquiry_group}">
										<div class="member_img_box">
											<img class="member_img" alt="" src="./resources/upload/member_image/${mdto.member_no }/${mdto.member_image}">
										</div>
										<div class="member_communi_text">
											<div class="content_left">
												<!-- 대댓글 문의인 경우 -->
												<c:if test="${re.inquiry_indent > 0 }">
													 <div class="content_title"> (대댓글) ${re.inquiry_title }</div>
												<!-- 
													<c:forEach begin="1" end="${i.inquiry_indent }">
														
													</c:forEach>
													 -->
												</c:if>
												<!-- 원글인 경우 -->
												<c:if test="${re.inquiry_indent == 0 }">
													<div class="content_title">${re.inquiry_title }</div>	
												</c:if>
												<div class="content_id">
													${re.inquiry_userid }
												</div>
											</div>
											
											<!--  	
											<div class="content_text">${i.inquiry_cont }</div>
											-->	
											<div class="content_right">
												<c:if test="${empty re.inquiry_update }">
													${re.inquiry_date.substring(0, 10) }
												</c:if>
												<c:if test="${!empty re.inquiry_update }">
													${re.inquiry_update.substring(0, 10) }
												</c:if>
											</div>	
										</div>
									</a> <!-- member_box_link -->
								</div> <!-- border_radius -->
							</c:if>
						</c:forEach>
				</c:forEach> <!-- 문의게시판 리스트 -->
			</div> <!-- inquiry_box -->
			
		<!-- 2. 상품 문의  -->
			<div class="categoryNshowMore">
				<div>[상품문의]</div> 
				<a href="<%=request.getContextPath()%>/admin_inquiry_showMore.do?no=2">
					<div class="showAll">Show ALL></div>
				</a>
			</div>
			<div class="inquiry_box">
				<c:forEach begin="0" end="2" items="${itemslist }" var="it"> 
					<c:if test="${it.inquiry_status == '0' }">
						<c:forEach items="${mlist }" var="mdto">
							<!-- 맴버리스트 아이디와 문의게시판 아이디가 같은 경우 리스트 뽑기 -->
							<c:if test="${mdto.member_id == it.inquiry_userid }">
							<div class="border_radius">
								<a class="member_box_link" href="<%=request.getContextPath()%>/admin_member_inquiryCont.do?no=${it.inquiry_no}
									&pno=${it.product_no}&ono=${it.order_no}&gno=${it.inquiry_group}">
										<div class="member_img_box">
											<img class="member_img" alt="" src="./resources/upload/member_image/${mdto.member_no }/${mdto.member_image}">
										</div>
										<div class="member_communi_text">
											<div class="content_left">
												<!-- 대댓글 문의인 경우 -->
												<c:if test="${it.inquiry_indent > 0 }">
													 <div class="content_title"> (대댓글) ${it.inquiry_title }</div>
												<!-- 
													<c:forEach begin="1" end="${i.inquiry_indent }">
														
													</c:forEach>
													 -->
												</c:if>
												<!-- 원글인 경우 -->
												<c:if test="${it.inquiry_indent == 0 }">
													<div class="content_title">${it.inquiry_title }</div>	
												</c:if>
												<div class="content_id">
													${it.inquiry_userid }
												</div>
											</div>
											
											<!--  	
											<div class="content_text">${i.inquiry_cont }</div>
											-->	
											<div class="content_right">
												<c:if test="${empty it.inquiry_update }">
													${it.inquiry_date.substring(0, 10) }
												</c:if>
												<c:if test="${!empty it.inquiry_update }">
													${it.inquiry_update.substring(0, 10) }
												</c:if>
											</div>	
										</div>
									</a> <!-- member_box_link -->
								</div> <!-- border_radius -->
							</c:if>
						</c:forEach>
					</c:if><!-- 답변 대기만 표시하기  -->
				</c:forEach> <!-- 문의게시판 리스트 -->
			</div> <!-- inquiry_box -->
			
			<!-- 3. 배송 -->
			<div class="categoryNshowMore">
				<div>[배송]</div> 
				<a href="<%=request.getContextPath()%>/admin_inquiry_showMore.do?no=3">
					<div class="showAll">Show ALL></div>
				</a>
			</div>
			<div class="inquiry_box">
				<c:forEach begin="0" end="2" items="${translist }" var="tr"> 
					<c:if test="${tr.inquiry_status == '0' }">
						<c:forEach items="${mlist }" var="mdto">
							<!-- 맴버리스트 아이디와 문의게시판 아이디가 같은 경우 리스트 뽑기 -->
							<c:if test="${mdto.member_id == tr.inquiry_userid }">
							<div class="border_radius">
								<a class="member_box_link" href="<%=request.getContextPath()%>/admin_member_inquiryCont.do?no=${tr.inquiry_no}
									&pno=${tr.product_no}&ono=${tr.order_no}&gno=${tr.inquiry_group}">
										<div class="member_img_box">
											<img class="member_img" alt="" src="./resources/upload/member_image/${mdto.member_no }/${mdto.member_image}">
										</div>
										<div class="member_communi_text">
											<div class="content_left">
												<!-- 대댓글 문의인 경우 -->
												<c:if test="${tr.inquiry_indent > 0 }">
													 <div class="content_title"> (대댓글) ${tr.inquiry_title }</div>
												<!-- 
													<c:forEach begin="1" end="${i.inquiry_indent }">
														
													</c:forEach>
													 -->
												</c:if>
												<!-- 원글인 경우 -->
												<c:if test="${tr.inquiry_indent == 0 }">
													<div class="content_title">${tr.inquiry_title }</div>	
												</c:if>
												<div class="content_id">
													${tr.inquiry_userid }
												</div>
											</div>
											
											<!--  	
											<div class="content_text">${i.inquiry_cont }</div>
											-->	
											<div class="content_right">
												<c:if test="${empty tr.inquiry_update }">
													${tr.inquiry_date.substring(0, 10) }
												</c:if>
												<c:if test="${!empty tr.inquiry_update }">
													${tr.inquiry_update.substring(0, 10) }
												</c:if>
											</div>	
										</div>
									</a> <!-- member_box_link -->
								</div> <!-- border_radius -->
							</c:if>
						</c:forEach>
					</c:if><!-- 답변 대기만 표시하기  -->
				</c:forEach> <!-- 문의게시판 리스트 -->
			</div> <!-- inquiry_box -->
			
			<!-- 4. 교환 -->
			<div class="categoryNshowMore">
				<div>[교환]</div> 
				<a href="<%=request.getContextPath()%>/admin_inquiry_showMore.do?no=4">
					<div class="showAll">Show ALL></div>
				</a>
			</div>
			<div class="inquiry_box">
				<c:forEach begin="0" end="2" items="${exchangelist }" var="ex"> 
					<c:if test="${ex.inquiry_status == '0' }">
						<c:forEach items="${mlist }" var="mdto">
							<!-- 맴버리스트 아이디와 문의게시판 아이디가 같은 경우 리스트 뽑기 -->
							<c:if test="${mdto.member_id == ex.inquiry_userid }">
							<div class="border_radius">
								<a class="member_box_link" href="<%=request.getContextPath()%>/admin_member_inquiryCont.do?no=${ex.inquiry_no}
									&pno=${ex.product_no}&ono=${ex.order_no}&gno=${ex.inquiry_group}">
										<div class="member_img_box">
											<img class="member_img" alt="" src="./resources/upload/member_image/${mdto.member_no }/${mdto.member_image}">
										</div>
										<div class="member_communi_text">
											<div class="content_left">
												<!-- 대댓글 문의인 경우 -->
												<c:if test="${ex.inquiry_indent > 0 }">
													 <div class="content_title"> (대댓글) ${ex.inquiry_title }</div>
												<!-- 
													<c:forEach begin="1" end="${i.inquiry_indent }">
														
													</c:forEach>
													 -->
												</c:if>
												<!-- 원글인 경우 -->
												<c:if test="${ex.inquiry_indent == 0 }">
													<div class="content_title">${ex.inquiry_title }</div>	
												</c:if>
												<div class="content_id">
													${ex.inquiry_userid }
												</div>
											</div>
											
											<!--  	
											<div class="content_text">${i.inquiry_cont }</div>
											-->	
											<div class="content_right">
												<c:if test="${empty ex.inquiry_update }">
													${ex.inquiry_date.substring(0, 10) }
												</c:if>
												<c:if test="${!empty ex.inquiry_update }">
													${ex.inquiry_update.substring(0, 10) }
												</c:if>
											</div>	
										</div>
									</a> <!-- member_box_link -->
								</div> <!-- border_radius -->
							</c:if>
						</c:forEach>
					</c:if><!-- 답변 대기만 표시하기  -->
				</c:forEach> <!-- 문의게시판 리스트 -->
			</div> <!-- inquiry_box -->
			
			<!-- 5. 기타 -->
			<div class="categoryNshowMore">
				<div>[기타]</div> 
				<a href="<%=request.getContextPath()%>/admin_inquiry_showMore.do?no=5">
					<div class="showAll">Show ALL></div>
				</a>
			</div>
			<div class="inquiry_box">
				<!-- 리스트 가져오기 3개만 -->
				<c:forEach begin="0" end="2" items="${etclist }" var="etc"> 
					<!-- 답변 대기 상태만 가져오기 -->
					<c:if test="${etc.inquiry_status == '0' }">
						<!-- 맴버리스트 불러오기 -->
						<c:forEach items="${mlist }" var="mdto">
							<!-- 맴버리스트 아이디와 문의게시판 아이디가 같은 경우  -->
							<c:if test="${mdto.member_id == etc.inquiry_userid }">
							<div class="border_radius">
								<a class="member_box_link" href="<%=request.getContextPath()%>/admin_member_inquiryCont.do?no=${etc.inquiry_no}
									&pno=${etc.product_no}&ono=${etc.order_no}&gno=${etc.inquiry_group}">
										<div class="member_img_box">
											<img class="member_img" alt="" src="./resources/upload/member_image/${mdto.member_no }/${mdto.member_image}">
										</div>
										<div class="member_communi_text">
											<div class="content_left">
												<!-- 대댓글 문의인 경우 -->
												<c:if test="${etc.inquiry_indent > 0 }">
													 <div class="content_title"> (대댓글) ${etc.inquiry_title }</div>
												<!-- 
													<c:forEach begin="1" end="${i.inquiry_indent }">
														
													</c:forEach>
													 -->
												</c:if>
												<!-- 원글인 경우 -->
												<c:if test="${etc.inquiry_indent == 0 }">
													<div class="content_title">${etc.inquiry_title }</div>	
												</c:if>
												<div class="content_id">
													${etc.inquiry_userid }
												</div>
											</div>
											
											<!--  	
											<div class="content_text">${i.inquiry_cont }</div>
											-->	
											<div class="content_right">
												<c:if test="${empty etc.inquiry_update }">
													${etc.inquiry_date.substring(0, 10) }
												</c:if>
												<c:if test="${!empty etc.inquiry_update }">
													${etc.inquiry_update.substring(0, 10) }
												</c:if>
											</div>	
										</div>
									</a> <!-- member_box_link -->
								</div> <!-- border_radius -->
							</c:if>
						</c:forEach>
					</c:if><!-- 답변 대기만 표시하기  -->
				</c:forEach> <!-- 문의게시판 리스트 -->
			</div> <!-- inquiry_box -->
			
		</div> <!-- member_inquiry_category -->
		
		
	
	
		
		
	<!-- 답변 완료  -->
		<div class="member_inquiry_category">
			<div class="categoryNshowMore">
				<div>[답변완료]</div> 
				<a href="<%=request.getContextPath()%>/admin_inquiry_showMore.do?no=0">
					<div class="showAll">Show ALL></div>
				</a>
			</div>
			<div class="inquiry_box">
				<!-- 리스트 가져오기 3개만 -->
				<c:forEach begin="0" end="2" items="${Oklist }" var="ok"> 
					<!-- 답변 대기 상태만 가져오기 -->
<%-- 					<c:if test="${ok.inquiry_status == '1' }"> --%>
						<!-- 맴버리스트 불러오기 -->
						<c:forEach items="${mlist }" var="mdto">
							<!-- 맴버리스트 아이디와 문의게시판 아이디가 같은 경우  -->
							<c:if test="${mdto.member_id == ok.inquiry_userid }">
							<div class="border_radius">
								<a class="member_box_link" href="<%=request.getContextPath()%>/admin_member_inquiryCont.do?no=${ok.inquiry_no}
									&pno=${ok.product_no}&ono=${ok.order_no}&gno=${ok.inquiry_group}">
										<div class="member_img_box">
											<img class="member_img" alt="" src="./resources/upload/member_image/${mdto.member_no }/${mdto.member_image}">
										</div>
										<div class="member_communi_text">
											<div class="content_left">
												<!-- 대댓글 문의인 경우 -->
												<c:if test="${ok.inquiry_indent > 0 }">
													 <div class="content_title"> (대댓글) ${ok.inquiry_title }</div>
												<!-- 
													<c:forEach begin="1" end="${i.inquiry_indent }">
														
													</c:forEach>
													 -->
												</c:if>
												<!-- 원글인 경우 -->
												<c:if test="${ok.inquiry_indent == 0 }">
													<div class="content_title">${ok.inquiry_title }</div>	
												</c:if>
												<div class="content_id">
													${ok.inquiry_userid }
												</div>
											</div>
											
											<!--  	
											<div class="content_text">${i.inquiry_cont }</div>
											-->	
											<div class="content_right">
												<c:if test="${empty ok.inquiry_update }">
													${ok.inquiry_date.substring(0, 10) }
												</c:if>
												<c:if test="${!empty ok.inquiry_update }">
													${ok.inquiry_update.substring(0, 10) }
												</c:if>
											</div>	
										</div>
									</a> <!-- member_box_link -->
								</div> <!-- border_radius -->
							</c:if>
						</c:forEach>
<%-- 					</c:if><!-- 답변 대기만 표시하기  --> --%>
				</c:forEach> <!-- 문의게시판 리스트 -->
			</div> <!-- inquiry_box -->	
	
		</div>	<!-- member_inquiry_category -->
		
	</div> <!-- admin_member_contact_container -->
			
		
	</div> <!-- admin_member_contact_wrapper -->
	
	



</body>
</html>