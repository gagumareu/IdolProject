<%@page import="com.idol.model.GroupDTO"%>
<%@page import="com.idol.model.CelebDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <c:set var="cList" value="${celecList }" />
    <c:set var="gList" value="${groupList }" />
   
  
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<style type="text/css">

	/************ 공통 ***********/
	
	html, body {
		padding: 0px;
		margin: 0px;
		height: 100%;
		/*font-family: 'Kanit', sans-serif;*/
		background-color: black;
	}
	
	li {
		list-style-type: none;
		color: black;
	}
	
	a {
		text-decoration: none;
	}
	
	
	/************ 공통 ***********/

	.admin_celeb_wrapper {
		display: flex;
		flex-direction: column;
		height: 100vh;
		
	}
	
	.admin_celeb_container {
		display: flex;
	    flex-direction: row;
	    flex-wrap: wrap;
	    column-gap: 35px;
	    row-gap: 100px;
	    justify-content: center;
	    
	}
	
	.admin_celeb_content{
		/*border: 1px solid pink;*/
		width: 320px;
		height: 370px;
		background-color: white;
		display: grid;
    	grid-template-rows: 75% 25%;
		border-radius: 25% 10%;
		font-family: 'Jua', sans-serif;
		font-size: 1.2em;
		
	}
	
	.admin_celeb_img_box {
		height: 100%;
		width: 100%;
		overflow: hidden;
		grid-row: 1;
		background-size: cover;
		/*border-bottom: 1px solid gray;*/
		
	}
	
	.imgs{
		width: 100%;
		object-fit: none;
		width: 160px;
	}
	
	.admin_celeb_content_box {
		height: 100%;
		width: 100%;
		grid-row: 2;
		display: flex;
		flex-direction: column;
	}
	
	
	.celeb_name {
		padding: 10px 25px;
		color: black;
		font-weight: 600;
	}
	
	.group_name {
		padding: 10px 25px;
		font-weight: 600;
		color: black;
	}
	
	.box_bottom {
	
	}
	
	.box_top {
		display: flex;
		flex-direction: row;
		justify-content: space-between;
	
	
	}	
	
	/*********** celeb_link_tag  **************/
	.celeb_link_tag {
		color: white;
		font-family: 'Press Start 2P', cursive;
		display: flex;
		flex-direction: row;
		/*border: 1px solid white;*/
		justify-content: end;
    	margin-right: 4.5%;
   	 	align-items: center;
   	 	padding-bottom: 20px;
	}	
	
	.search_text {
		height: 23px;
    	width: 213px;
    	background-color: black;
    	color: white;
    	font-size: 1.5em;
    	font-family: 'Creepster','Kirang Haerang', cursive;
    	
	}
	
	.search_btn {
		padding: 0px 18px;
		color: white;
		background-color: black;
		font-family: 'Press Start 2P', cursive;
		font-size: 1em;
	}
	
	.insert_btn a {
		color: white;
	}
	.search_btn:hover {
		color: red;
		cursor: pointer;
	}
	
	.insert_btn a:hover {
		color: red;
		cursor: pointer;
	}
	
  	/*********** celeb_link_tag **************/
	
	
	
</style>

<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&display=swap" rel="stylesheet">

<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>

<script type="text/javascript">
	
	
	
	

</script>

</head>
<body>
	
	<div class="admin_celeb_wrapper">
	
	<jsp:include page="../include/admin_top_include.jsp" />
	<jsp:include page="../include/admin_link_include.jsp" />
	
		
	
		<div class="admin_celeb_container">
		
			<c:if test="${!empty cList }">
				<%
				List<CelebDTO> list = (List<CelebDTO>)request.getAttribute("celecList");

				List<GroupDTO> glist = (List<GroupDTO>)request.getAttribute("groupList");
				
			
				for(int i=0; i < list.size(); i++){
					
					CelebDTO dto = list.get(i);
					
					String imgs = dto.getCeleb_pimage();
					
					StringTokenizer tokenizer = new StringTokenizer(imgs, "|");
					
					String[] arrayToekn = new String[tokenizer.countTokens()];
					
					for(int j =0; j < arrayToekn.length; j++ ) {
						arrayToekn[j] = tokenizer.nextToken();
						
					}
				%>
			<a data-aos="fade-in" href="<%=request.getContextPath()%>/admin_celeb_content.do?no=<%=dto.getCeleb_no() %>">			
				<div class="admin_celeb_content">
				
					<div class="admin_celeb_img_box" style="background-image: url('./resources/upload/celeb/<%= arrayToekn[0] %>')">
						<!-- <img class="imgs" alt="" src="./resources/upload/celeb/<%= arrayToekn[0] %>">	
						 -->
					</div>
					
					<div class="admin_celeb_content_box">
					
					
						<div class="box_top">
										
							<%
							if(dto.getCeleb_group().equals("solo")){
								%>
									
							<%	} else {%>
								<div class="group_name">
									 <%=dto.getCeleb_group() %>
								</div> <!-- group_name -->
							<% } %>	
							<div class="celeb_name">
								 <%=dto.getCeleb_name() %>
							</div> <!-- celeb_name -->
						
						</div><!-- box_top -->
						
						<div class="box_bottom">
						
					
						</div> <!-- box_bottom -->
						
					</div> <!-- admin_celeb_content_box -->
					
					
					
					
				</div> <!-- admin_celeb_content -->		
			</a>		
								
			<%} %>
		</c:if>		
		</div> <!-- admin_celeb_container -->
		
	</div> <!-- admin_celeb_wrapper -->
	 <div
    data-aos="fade-up"
    data-aos-offset="200"
    data-aos-delay="50"
    data-aos-duration="1000"
    data-aos-easing="ease-in-out"
    data-aos-mirror="true"
    data-aos-once="false"
    data-aos-anchor-placement="top-center"
  >
  </div>	
	

	
	
<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
  <script>
    AOS.init();
  </script>
</body>
</html>