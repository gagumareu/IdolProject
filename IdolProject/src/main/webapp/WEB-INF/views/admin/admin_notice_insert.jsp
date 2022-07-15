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
		margin: 0px;
		padding: 0px;
		height: 100%;
		background-color: black;
	}

	

	.admin_notice_insert_wrapper {
		display: flex;
		flex-direction: column;
		height: 100%;
		
	}

	.admin_notice_insert_form {
		justify-content: center;
    	/* align-items: center; */
   		display: flex;
		
	}

	.notice_contents {
		color: white;
		font-family: 'VT323', monospace;
		display: flex;
		flex-direction: row;
		font-size: 1.9em;
	}

	celeb_btn {
		display: flex;
    	justify-content: center;
    	
	}
	
	.celeb_btn input {
		color: white;
		background-color: black;
	}
	
	.inset_btn {
		font-family: 'Nosifer', cursive;
		font-size: 1.4em;
		cursor: pointer;	
	}
	
	.inset_btn:hover {
		color: red;
	}
	
	.rightBtn {
		/*margin-right: 80px;*/
	}
	
	.select {
		height: 27px;
	}
	
	
	.notice_insertForm_left {
		margin-right: 20px;
		line-height: 1.2em;
	}
	
	.notice_insertForm_right {
		line-height: 1.1em;
	}
	
	.notice_insertForm_right input{
		height: 20px;
		font-family: 'VT323', monospace;
		
	}
	
	.notice_insertForm_right select{
		height: 30px;
	}
	
	.content_div {
		margin-bottom: 228px;
	
	}
</style>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&display=swap" rel="stylesheet">


</head>
<body>
	<c:set var="clist" value="${cList }" />
	<c:set var="glist" value="${gList }" />
	
	<div class="admin_notice_insert_wrapper">
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_notice_include.jsp" />
	
		<div class="admin_notice_insert_form">
			<form method="post" enctype="multipart/form-data" 
				action="<%=request.getContextPath()%>/admin_notice_insert_ok.do">
			<input type="hidden" name="admin_id" value="${admin_id }">
				
				<div class="notice_contents">
				
					<div class="notice_insertForm_left">
						<div>TITLE</div>
						<div>GROUP</div>
						<div>CELEB</div>
						<div>SELECT SORT </div>
						<div class="content_div">CONTENT</div>
						<div>END DATE</div>
						<div>IMAGES</div>
						</div> <!-- notice_insertForm_left -->
					
					<div class="notice_insertForm_right">
						<div>
							<input name="notice_title">
						</div>
						<div>
							<select name="group_name">
								<option value="">
										NONE
								</option>
								<c:forEach items="${glist }" var="g">
									<option value="${g.group_name }">
										${g.group_name }
									</option>
								</c:forEach>
							</select>
						</div>
						<div>
							<select name="celeb_name">
								<option value="">
										NONE
								</option>
								<c:forEach items="${clist }" var="c">
									
									<option value="${c.celeb_name }">
										${c.celeb_name }
									</option>
								</c:forEach>
							</select>
						</div>
						<div>
							<select name="notice_type">
							<option>
								공지 분류 선택
							</option>
							<option value="CELEB">
								CELEB
							</option>
							<option value="CONCERT">
								CONCERT
							</option>
						</select>
						</div>
						<div>
							 <textarea rows="17" cols="25" name="notice_cont"></textarea>
						</div>
						<div>
							<input type="date" name="notice_enddate">
						</div>
						<div>
							<input type="file" multiple="multiple" name="file" class="select">
						</div>
						
					</div> <!-- notice_insertForm_right -->
				
				</div> <!-- notice_contents -->
				<div class="celeb_btn">
					<input type="submit" value="GO!" class="inset_btn">
					<input type="reset" value="RESET" class="inset_btn">
				</div> <!-- celeb_btn -->
				
			</form>		
		</div><!-- admin_notice_insert_form -->
	
	</div> <!-- admin_notice_insert_wrapper -->
</body>
</html>