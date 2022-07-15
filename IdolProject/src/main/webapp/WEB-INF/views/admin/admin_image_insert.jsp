<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN IMAGES INSERT</title>

<link href="https://fonts.googleapis.com/css2?family=Bungee+Shade&family=Creepster&family=East+Sea+Dokdo&family=Gamja+Flower&family=Gugi&family=Jua&family=Kanit:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Kirang+Haerang&family=Nosifer&family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Press+Start+2P&family=VT323&family=Wallpoet&display=swap" rel="stylesheet">

<style type="text/css">
	
	html, body {
		margin: 0px;
		padding: 0px;
		height: 100%;
		background-color: black;
	}
	.admin_image_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
	}
	
	.admin_image_container {
		display: flex;
		flex-direction: row;
		justify-content: center;
	}
	
	.admin_images_insert_text {
		color: white;
		font-family: 'Press Start 2P', cursive;
		line-height: 1.6;
		display: flex;
	    flex-direction: column;
	    align-items: center;
	
	}
	.admin_images_insert_btn{
		color: white;
		margin-top: 20px;
		display: flex;
    	justify-content: center;
	}
	
	.insert_btn {
		font-family: 'Press Start 2P', cursive;
		color: white;
		font-size: 1.2em;
		background-color: black;
		cursor: pointer;
	}
	
	.insert_btn:hover {
		color: red;
	}
	
	.insert_file {
		margin-left: 179px;
		margin-top: 12px;
	}
	
</style>
</head>
<body>
	
	<div class="admin_image_wrapper">
		
		<jsp:include page="../include/admin_top_include.jsp" />
		<jsp:include page="../include/admin_images_include.jsp" />
		
		<div class="admin_image_container">
		
			<form method="post" enctype="multipart/form-data"  
				action="<%=request.getContextPath()%>/admin_insert_image_ok.do">
				
				<div class="admin_images_insert_text">
				
					<div> 
						IMAGE PATH <input name="image_link"> 
					</div>
					
					<div> 
						IMAGE PRIORITY <input type="number" name="image_priority" min="1" max="10"> 
					</div>
				
				
					SELECT ON/OFF
					<select name="image_visible">
						<option>
							ON/OFF
						</option>
						<option value="1">
							ON (VAL=1)
						</option>
						<option value="0">
							OFF (VAL=0)
						</option>
					</select>
					
					<input class="insert_file" style="color: white" class="images_insert_btn" type="file" name="file">
				</div>
				
				
				<div class="admin_images_insert_btn">
					<input class="insert_btn" type="submit" value="GO!!">
					<input class="insert_btn" type="reset" value="RESET">
				</div>
			</form>
			
		</div> <!--admin_image_container end  -->
			
	
	</div> <!-- admin_image_wrapper end -->


</body>
</html>