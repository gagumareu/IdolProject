<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN MEMBER CONTENT</title>

<script src="http://code.jquery.com/jquery-3.6.0.js"></script>


<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">

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
	.member_cont_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	}
	
	.member_cont_container {
		display: flex;
	
	}
	
	
	
	
	/******* member_info ******/
	
	.member_content_wrapper {
		flex: 50%;
		max-width: 50%;
		color: white;
		display: flex;
    	justify-content: center;
    	text-transform: uppercase;
		
	}
	
	.member_content {
		position: fixed;
		display: flex;
	    flex-direction: column;
	    align-items: center;
	    padding-bottom: 55px;
	    width: 50%;
	}
	
	.member_personal_info {
		display: flex;
	    flex-direction: column;
	    align-items: center;
		line-height: 1.4;
		/*width: 50%;*/
	}
	
	.member_img {
		width: 300px;
		height: 300px;
	}
	.member_content img {
		width: 100%;
		height: 100%;
		border-radius: 50% 20% / 10% 40%
		
	}
	
	.member_favorite_celeb {
		margin-top: 30px;
	    display: flex;
	    flex-direction: column;
	    align-items: center;
		line-height: 1.5;
	}
	
	/******* member_info ******/
	
	
	
	
	
	
	
	
	/******* inquiry board ******/
	
	.member_allOfboard_wrapper {
		flex: 50%;
		max-width: 50%;
		color: white;
		display: flex;
   		flex-direction: column;
   		/*margin-bottom: 50px;*/
	}
	
	.member_inquiry_wrapper {
		display: flex;
    	flex-direction: column;
    	width: 90%;
	}
	
	.member_inquiry_category_box {
		margin-top: 16px;
	}
	
	
	
	.member_inquiry_box {
		height: auto;
	    margin: 10px 0px;
	    height: 50px;
	    /* border: 1px solid gold; */
	    background-color: #263238;
	    display: flex;
	    border-radius: 20px;
	}
	
	.member_inquiry_link{
		display: flex;
	    flex-direction: row;
		justify-content: space-evenly;
		padding: 0px;
		color: white;
		height: 100%;
	}
	
	.member_inquiry_link {
		display: flex;
		
	}
	
	.left_side_div {
		display: flex;
		flex-direction: column;
		flex: 19%;
		max-width: 19%;
		margin-left: 10px;
		justify-content: inherit;
	}
	
	.left_side {
		align-items: center;
	}
	
	.groupNo {
		font-size: 0.7em;
	}
	
	.right_side_div {
		flex: 81%;
		max-width: 81%;
		/*display: flex;
   		flex-direction: row;
   		margin: 0px 10px;*/
   		display: grid;
   		grid-template-columns: 18% 53% 10% 17%;
	}
	
	.board_no {
		font-size: 1.2em;
	}
	
	.right_side {
		display: flex;
	    justify-content: space-around;
	    align-items: center;
	}
	
	.userid {
		font-size: 0.9em;
	}
	
	.board_title {
		color: gold;
	}
	
	.sort_title {
		margin-top: 50px;
	}
	
	
	/******* inquiry board end ******/
	
	
	
	
	
	
	
	/******** cummunity board ******/
	
	.community_board_wrapper {
		display: flex;
	    flex-direction: column;
	    width: 90%;
	}
	
	.comm_sort_title {
		margin-top: 16px;
	}
	
	.comm_text {
		margin: 5px 0px;
		padding: 0px 6px;
	}
	
	
	.member_community_boxes{
	    background-color: #455a64;
	    color: #bdbdbd;
	    border-radius: 20px;
	    margin: 18px 0px;
	
	}
	
	
	
	.no {
		font-size: 0.9em;
	}
	
	
	.member_comm_reply_box {
	    display: grid;
	    grid-template-columns: 15% 85%;
	    color: #d3b8ae;
	    background-color: #4e342e;
	    border-radius: 20px;
		margin: 16px 0px;
		height: 50px;
	}
	
	.rno {
		font-size: 0.a6em;
		
	}
	
	
	 .group{
		font-size: 0.4em;
	}
	
	.step {
		font-size: 0.4em;
	}
	
	.writer {
		font-size: 0.9em;
	}
	
	.date {
		font-size: 0.7em;
	}
	.comm_reply_right_side {
		display: grid;
    	grid-template-columns: 20% 62% 18%;
		align-items: center;
	}
	
	.reply_text {
		padding: 0px 6px;
	}
	
	
	.comm_reply_left_side {
		display: flex;
	    flex-direction: column;
	    justify-content: space-around;
	
	}
	
	.reply_cate {
		margin-top: 18px;
	}
	/******** cummunity board ******/
	
	.comm_inside {
		display: none;
	}
	
	.inside2{
		display: none;
	}
	
	.favo_celeb:hover{
		color: gold;
	}
	
	.killing_btn {
	 	color: white;
	 	background-color: black;
	 	cursor: pointer;
	}
	
</style>

<script type="text/javascript">
	

	$(function(){
		$('.comm_top').click(function(){
			$(this).next().slideToggle().siblings('.comm_inside').slideUp();
		});
		
	});
	

</script>

</head>
<body>
<!-- 멤서 상세 내용 및 맴버가 좋아하는 셀럽 리스트 -->
<c:set var="mdto" value="${mdto }" />
<c:set var="mceleb" value="${celebs }" />

<c:set var="orderlist" value="${orderList }" />

<c:set var="usedlist" value="${usedList }" />
<c:set var="usedCommlist" value="${usedCommList }" />
<c:set var="usedCategory" value="${used_category }" />

<c:set var="commlist" value="${commList }" />
<c:set var="commCommlist" value="${commCommList }" />
<c:set var="commCategory" value="${comm_category }" />

<c:set var="inquirylist" value="${inquiryList }" />
<c:set var="inquiryCategory" value="${inquiry_category }" />

<c:set var="celeblist" value="${celebList }" />
<c:set var="grouplist" value="${groupList }" />

<c:set var="addr" value="${address }" />
<c:set var="phone" value="${phoneNumber }" />


	<div class="member_cont_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_member_include.jsp" />
	
		<div class="member_cont_container">
		
		
		<div class="member_content_wrapper">
		
			<div class="member_content">
				
				<div class="member_personal_info">
					<div class="member_img">
						<img alt="" src="./resources/upload/member_image/${mdto.member_no }/${mdto.member_image} ">
					</div>
					
					<div style="margin-top: 20px">
					No. ${mdto.member_no }
					</div>
					<div>
					ID: ${mdto.member_id }
					</div>
					<div>
					NAME: ${mdto.member_name }
					</div>
					<div>
					<c:if test="${mdto.member_gender == 'M'}">
							male
					</c:if>
					 <c:if test="${mdto.member_gender == 'F'}">
							female
					</c:if>
					</div>
					<div>
					E-MAIL: ${mdto.member_email }
					</div>
					<div>
					
					<c:set var="first" value="${mdto.member_phone.substring(0, 3) }" />
					<c:set var="second" value="${mdto.member_phone.substring(3, 7) }" />
					<c:set var="third" value="${mdto.member_phone.substring(7) }" />
						PHONE: ${first }-${second }-${third }  
					
					</div>
					<div>
					DATE OF BIRTH: ${mdto.member_dateofbirth.substring(0, 10) }
					</div>
					<div> 
						<c:forEach begin="0" end="0" items="${address }" var="addr">
							<span>[${addr }]</span>
						</c:forEach>
						<c:forEach begin="1" items="${address }" var="addr">
							<span>${addr }</span>
						</c:forEach>
					</div>
					<div style="margin: 13px">
					SINCE DATE: ${mdto.member_join_date.substring(0, 10) }
					</div>
					<div>
					</div>
						<c:if test="${!empty mdto.member_introduction }">
							<div style="width: 60%">${mdto.member_introduction }</div>
						</c:if>
						<c:if test="${empty mdto.member_introduction }">
							<div>[자기소개가 없습니다.]</div>
						</c:if>
				</div>
			
				<div class="member_favorite_celeb">
					
					<div>
					[FAVORITE CELEB]
					</div>
					
					<c:if test="${!empty celebs}">
						<c:forEach items="${celeblist }" var="c">
							<c:forEach items="${celebs }" var="mc">
								<c:if test="${c.celeb_no == mc }">
									<c:if test="${c.celeb_group != 'solo' }">
										<div>
										<a class="favo_celeb" href="<%=request.getContextPath()%>/admin_groupMember_list.do?gName=${c.celeb_group}">
											${c.celeb_group }
										</a>
										</div>
									</c:if>
									<c:if test="${c.celeb_group == 'solo' }">
										<div>
										<a class="favo_celeb" href="<%=request.getContextPath()%>/admin_celeb_content.do?no=${c.celeb_no}">
											${c.celeb_name }
										</a>
									</div>
									</c:if>
									
								</c:if>
							</c:forEach>
						</c:forEach>
					</c:if>
					<c:if test="${empty celebs }">
						[좋아하는 셀럽이 아직 없습니다 :( ]
					</c:if>
				</div> <!-- member_favorite_celeb -->
			<div>
				<input class="killing_btn" type="button" value="KILLING"
				onclick="location.href='<%=request.getContextPath()%>/admin_member_killing?id=${mdto.member_id}'">
			
			</div>	
				
			</div> <!-- member_content -->
		</div> <!-- member_content_wrapper -->
		
<!-- =============================================================================== -->			
	
		<div class="member_allOfboard_wrapper">	
			<div class="member_inquiry_wrapper">
				
			<div>
			[INQUIRY BOARD]
			</div>
				
			<c:if test="${!empty inquirylist }">
				<c:forEach items="${inquiryCategory}" var="icate">
					<c:forEach items="${inquirylist }" var="i">
						<!-- 카테고리 번호와 게시판 카테고리 번호가 같은 경우 -->
						<c:if test="${icate.category_ino == i.category_inofk}">
							<!-- 게시반 답변 대기인 경우 -->
							<c:if test="${i.inquiry_status =='0' }">
								<div class="member_inquiry_category_box">
									[${icate.category_iname }]
									<div class="member_inquiry_box">
										<a style="width: 100%" href="<%=request.getContextPath() %>/admin_member_inquiryCont.do?no=${i.inquiry_no}">
											<div class="member_inquiry_link">
												<div class="left_side_div">
													<div class="left_side board_no">
														No. ${i.inquiry_no }
													</div>
													<div class="left_side groupNo">
														GROUP : ${i.inquiry_group }
													</div>	
												</div>
												
												<div class="right_side_div">
												
													<div class="right_side userid">
														${i.inquiry_userid }
													</div>
													
													<div class="right_side board_title">
														${i.inquiry_title }
													</div>
													<div class="right_side">
														<c:if test="${i.inquiry_step == '0'}">
															원글 
														</c:if>
														<c:if test="${i.inquiry_step == '1'}">
															댓글 
														</c:if>
														<c:if test="${i.inquiry_step > '1'}">
															대댓글 
														</c:if>
													</div>
													 
													<div class="right_side">
														<c:if test="${!empty i.inquiry_update }">
															${i.inquiry_update.substring(0, 10) }
														</c:if>
														<c:if test="${empty i.inquiry_update }">
															${i.inquiry_date.substring(0, 10) }
														</c:if>
													</div>
													
												</div>
											</div>	
										</a>
									</div> <!-- member_inquiry_box -->
								</div> <!-- member_inquiry_category_box -->
							</c:if>
						</c:if>
					</c:forEach>
				</c:forEach>
			</c:if>
			<c:if test="${empty inquirylist }">
				작성한 문의 게시글이 없습니다.
			</c:if>
				
				
				
<%-- 				<c:forEach items="${inquirylist }" var="i"> --%>
<%-- 					<c:if test="${i.inquiry_status =='1' }"> --%>
<!-- 					<div class="member_inquiry_category_box"> -->
<!-- 						[답변완료] -->
<!-- 					</div> -->
<!-- 						<div class="member_inquiry_box"> -->
<%-- 							<a style="width: 100%" href="<%=request.getContextPath() %>/admin_member_inquiryCont.do?no=${i.inquiry_no} --%>
<%-- 										&pno=${i.product_no}&ono=${i.order_no}&gno=${i.inquiry_group}"> --%>
<!-- 							<div class="member_inquiry_link"> -->
<!-- 								<div class="left_side_div"> -->
<!-- 									<div class="left_side board_no"> -->
<%-- 										No. ${i.inquiry_no } --%>
<!-- 									</div> -->
<!-- 									<div class="left_side groupNo"> -->
<%-- 										GROUP : ${i.inquiry_group } --%>
<!-- 									</div>	 -->
<!-- 								</div> -->
								
<!-- 								<div class="right_side_div"> -->
<!-- 									<span class="right_side userid"> -->
<%-- 										${i.inquiry_userid } --%>
<!-- 									</span> -->
<!-- 									<span class="right_side board_title"> -->
<%-- 										${i.inquiry_title } --%>
<!-- 									</span> -->
									
<!-- 									<span class="right_side"> -->
<%-- 										<c:if test="${i.inquiry_step == '0'}"> --%>
<!-- 											원글  -->
<%-- 										</c:if> --%>
<%-- 										<c:if test="${i.inquiry_step == '1'}"> --%>
<!-- 											댓글  -->
<%-- 										</c:if> --%>
<%-- 										<c:if test="${i.inquiry_step > '1'}"> --%>
<!-- 											대댓글  -->
<%-- 										</c:if> --%>
<!-- 									</span> -->
									 
<!-- 									<span class="right_side"> -->
<%-- 										<c:if test="${!empty i.inquiry_update }"> --%>
<%-- 											${i.inquiry_update.substring(0, 10) } --%>
<%-- 										</c:if> --%>
<%-- 										<c:if test="${empty i.inquiry_update }"> --%>
<%-- 											${i.inquiry_date.substring(0, 10) } --%>
<%-- 										</c:if> --%>
<!-- 									</span> -->
								
<!-- 								</div> -->
<!-- 							</div>			 -->
<!-- 							</a> -->
<!-- 						</div> -->
<%-- 					</c:if> --%>
<%-- 					<c:if test="${empty inquirylist }"> --%>
<!-- 						<div>답변완료 게시물이 없습니다</div> -->
<%-- 					</c:if> --%>
<%-- 				</c:forEach> --%>
				
			</div> <!-- member_inquiry -->
			
				
			<div class="community_board_wrapper">
			
				<div class="sort_title">
					[COMMUNITY BOARD]
				</div>
				
				<c:if test="${!empty commlist }">
					<!-- 커뮤니티 카테고리 리스트 불러오기 -->
					<c:forEach items="${commCategory }" var="comCate">
						<div class="member_commnuity_container" style="border:1px solid black">
							<div class="comm_sort_title">[${comCate.category_cname }]</div>
							<!-- 커뮤니티 게시글 리스트 불러오기 -->
							<c:forEach items="${commlist }" var="comdto">
								<!-- 커뮤니티 카테고리랑 게시판 카테고리 번호가 같은 경우 리스트 뽑기 -->
								<c:if test="${comdto.category_cnofk == comCate.category_cno }">
									<div class="member_community_boxes">
										 <div class="comm_top">
											<div class="comm_text no">
												NO. ${comdto.community_no }
											</div>
											<div class="comm_text id">
												ID: ${comdto.community_userid }
											</div>
											<div class="comm_text title">
												TITLE [${comdto.community_title }]
											</div>
										</div>
										<div class="comm_inside">
<!-- 											<div> -->
<%-- 												<img alt="" src="./resources/upload/community/${comdto.community_image }"> --%>
<!-- 											</div> -->
											<div class="comm_text cont">
												${comdto.community_cont }
											</div>
											<div class="comm_text hit">
												조회수: ${comdto.community_hit }
											</div>
											<div class="comm_text recomm">
												추천수: ${comdto.community_recommend }
											</div>
											<div class="comm_text date">
												<c:if test="${comdto.community_update != null }">
													수정일: ${comdto.community_update.substring(0, 10) }
												</c:if>
												<c:if test="${comdto.community_update == null }">
													작성일: ${comdto.community_date.substring(0, 10) }
												</c:if>
											</div>
										</div>
									</div> <!-- member_community_boxes -->
								</c:if>
							</c:forEach>
						</div> <!-- member_commnuity_container -->
					</c:forEach>
				</c:if>
				<c:if test="${empty commlist }">
					<span>작성한 커뮤니티 게시판 글이 없습니다.</span>
				</c:if>
				
				
				<div class="sort_title">
					[COMMUNITY BOARD REPLY]
				</div>
				<c:if test="${!empty commCommlist }">
					<!-- 커뮤니티 카테고리 리스트 불러오기 -->
					<c:forEach items="${commCategory }" var="cCate">
						<div class="member_commu_reply_boxes">
						<div class="reply_cate">[${cCate.category_cname }]</div>
							<!-- 커뮤니티 답글 리스트 불러오기 -->
							<c:forEach items="${commCommlist }" var="ccdto">
								<c:if test="${ccdto.category_cnofk == cCate.category_cno}">
									<div class="member_comm_reply_box">
										
										<div class="comm_reply_left_side">
											<div class="reply_text rno">
												No. ${ccdto.comment_no }
											</div>
										
											<div class="reply_text group">
												GROUP: ${ccdto.comment_group }
											</div>
											<div class="reply_text step">
												STEP: ${ccdto.comment_step }
											</div>
											
										</div>
										<div class="comm_reply_right_side">
											<div class="reply_text writer">
												 ${ccdto.comment_writer }
											</div>
											<div class="reply_text cont">
												${ccdto.comment_cont }
											</div>
											<div class="reply_text date">
												<c:if test="${!empty ccdto.comment_update }">
													${ccdto.comment_update.substring(0, 10) }
												</c:if>
												<c:if test="${empty ccdto.comment_update }">
													 ${ccdto.comment_date.substring(0, 10) }
												</c:if>
											</div>
										</div>
										
									</div>
								</c:if>
							</c:forEach>
						</div> <!-- member_commu_reply_boxes -->
					</c:forEach>
				</c:if>
				<c:if test="${empty commCommlist }">
					<div>작성한 댓글이 없습니다.</div>
				</c:if>
			</div>	<!-- community_board_wrapper -->
		</div> <!-- member_allOfboard_wrapper -->
			
			
	</div> <!-- member_cont_container -->
		
		
	</div> <!-- member_cont_wrapper -->
	


</body>
</html>