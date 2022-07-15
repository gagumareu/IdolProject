<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN NOTICE UPDATE</title>
<style type="text/css">
	html, body {
		margin: 0px;
		padding: 0px;
		height: 100%;
		background-color: black;
	}
	
	.admin_notice_modify_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	}
	
	.admin_notice_modify_container{
		width: 100%;
		height: 100%;
		display: flex;
		flex-direction: row;
		justify-content: center;
	}
	
	
	

	
	
/***************************************/
	
	
	.notice_cont_slider {
		/*width: 500px;*/
		/*height: 600px;*/
		width: 40%;
		height: 40%;
		align-self: center;
	}
	
	.notice_cont_slider img{
		width: 100%;
		height: 100%;
		cursor: pointer;
	}
	
	
	.draggable {
   		height: 100%;
		width: 100%;
	}
	
	.slick-track {
		height: 100%;
		width: 100%;
	}
	
	.slick-dots {
		display: flex;
		color: white;
		background-color: black;
		font-family: 'Press Start 2P', cursive;
		
	}
	
/***************************************/


	.notice_modify_form {
		color: white;
		display: flex;
    	align-items: center;
    	width: 30%;
		margin-left: 10%;
		font-family: 'Press Start 2P', 'Gugi', cursive;
		line-height: 1.378;
	}
 	
 	.notice_update_btn {
 		display: flex;
   		justify-content: center;
 	
 	}
 
 	.update_btn {
 		font-family: 'Creepster', cursive;
 		color: white;
 		background-color: black;
 		font-size: 1.8em;
 		
 	}
	
	.update_btn:hover {
		color: red;
		cursor: pointer;
	}
	
	.notice_modify_form textarea {
		background-color: black;
    	color: white;
	}
	
	.notice_modify_form input {
		background-color: black;
    	color: white;
    	
	}
	
	.notice_modify_form select {
		background-color: black;
    	color: white;
	}
	
	#title{
		height: 24px;
    	width: 280px;
	}
</style>
</head>
<body>
	<c:set var="nCont" value="${noticeCont }" />
	<c:set var="nlist" value="${nList }" />
	<c:set var="glist" value="${gList }" />
	<c:set var="clist" value="${cList }" />
	<c:set var="imgs" value="${arrayImgs }" />
	
	<div class="admin_notice_modify_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_notice_include.jsp" />
	
		<div class="admin_notice_modify_container">
			
			<div class="notice_cont_slider">
				<c:forEach items="${arrayImgs }" var="imgs">
			    	<img alt="" src="./resources/upload/notice/${imgs }">
			    </c:forEach>
			 </div> <!-- notice_cont_slider -->
			 
			 	
			<div class="notice_modify_form">
			
				<form enctype="multipart/form-data" method="post" 
					action="<%=request.getContextPath() %>/admin_notice_update_ok.do">
					
					<input type="hidden" value="${nCont.notice_image }" name="oldimgs">
					<input type="hidden" value="${nCont.notice_no }" name="notice_no">
					<input type="hidden" value="${nCont.admin_id }" name="admin_id">
					<input type="hidden" value="${nCont.notice_date }" name="notice_date">
					
					<div>
						TITLE<input id="title" name="notice_title" value="${nCont.notice_title }" readonly>
					</div>
					<div>
					SELECT GROUP
						<select name="group_name">
							<option value="">
								NONE
							</option>
							<c:forEach items="${glist }" var="g">
								<c:if test="${g.group_name == nCont.group_name }">
									<option value="${g.group_name }" selected>
										${g.group_name }
									</option>
								</c:if>
								<c:if test="${g.group_name != nCont.group_name }">
									<option value="${g.group_name }">
										${g.group_name }
									</option>
								</c:if>
							</c:forEach>
						
						</select>
					</div>
					<div>
					SELECT CELEB
						<select name="celeb_name">
							<option value="">
								NONE
							</option>
							<c:forEach items="${clist }" var="c">
								<c:if test="${c.celeb_name == nCont.celeb_name }">
									<option value="${c.celeb_name }" selected>
										${c.celeb_name }
									</option>
								</c:if>
								<c:if test="${c.celeb_name != nCont.celeb_name }">
									<option value="${c.celeb_name }">
										${c.celeb_name }
									</option>
								</c:if>
							</c:forEach>
						
						</select>
					</div>
					<div>
						WHAT ABOUT
						<select name="notice_type">
							<c:if test="${nCont.notice_type == 'CELEB' }">
								<option value="CELEB" selected>
									CELEB
								</option>
								<option value="CONCERT">
									CONCERT
								</option>
							</c:if>
							<c:if test="${nCont.notice_type != 'CELEB' }">
								<option value="CONCERT" selected>
									CONCERT
								</option>
								<option value="CELEB">
									CELEB
								</option>
							</c:if>
						</select>
					</div>
					<div>
						<textarea rows="20" cols="50" id="cont" name="notice_cont">${nCont.notice_cont }</textarea>
					</div>
					
					<div>
						<input type="file" name="file1" multiple="multiple">
					</div>
					
					<div style="margin-top: 10px">
						END DATE <input id="enddate" type="date" name="notice_enddate" value="${nCont.notice_enddate.substring(0, 10) }">
					</div>
					<div class="notice_update_btn">
						<input class="update_btn" type="submit" value="GO!!">
						<input class="update_btn" type="reset" value="RESET">
					</div>
				</form>
				
			</div> <!--notice_modify_form -->
			
			
			
		</div> <!-- admin_notice_modify_container -->
	</div> <!-- admin_notice_modify_wrapper -->

<script type="text/javascript">

	$('.notice_cont_slider').slick({
		  dots: false,
		  infinite: true,
		  speed: 500,
		  fade: true,
		  cssEase: 'linear',
		  autoplay: true,
		  adaptiveHeight: true,
		  arrows: false,
		  pauseOnFocus: true
		 
		  
		});
							

</script>



</body>
</html>