<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	.wrapper	{
		margin: -8px;
		background-color: #EEEEEE;
		font-family: NotoSans Kor;
	}
	
	.used_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
		width: 65%;
		text-align: left;
		font-size: 12px;
	}
	
	.used_notice{
		background-color: #FFFFFF;
		padding: 10px 20px;
		min-height: 100px;
		margin: 30px 0 30px 0;
		border: 1px solid #CCCCCC;
	}
	
	.used_flex_wrapper {
		flex: 1;
		margin: 20px 0 30px 0;
		border: 1px solid #CCCCCC;
		background-color: #FFFFFF;
	}
	
	.title {
		height: 20px;
		padding: 15px;
	}
	
	.upload{
		background-color: #EEEEEE;
		height: 20px;
		padding: 15px;
	}
	
	.submit{
		display: flex;
		flex-direction: row;
		min-height: 20px;
	}
	
	.submit_left{
		flex: 8;
		text-align: left;
		padding: 15px;
	}
	
	.submit_right{
		flex: 2;
		text-align: right;
	}
	
	button.gray{
		background-color: #EEEEEE;
		width: 40px;
		height: 50px;
		border: 0;
		font-weight: bold;
	}
	
	button.white{
		background-color: #FFFFFF;
		width: 100%;
		height: 102%;
		font-weight: bold;
		font-size: 12px;
		color: red;
		border: 1px solid #EEEEEE;
	}
	
	input.white{
		border: 0;
		outline: none;
		width: 99%;
		font-size: 12px;
	}
	
	textarea{
		border: 0;
		outline: none;
		padding: 15px 10px;
	}
	
	th {
		background-color: #2A3A52; 
		color: white; 
		text-align: center;
		height: 30px;
	}
	
	select.navy{
		background-color: #2A3A52;
		color: white;
		padding: 5px;
		font-size: 12px;
	}
	
</style>
</head>
<body>
	<%@ include file="../include/user_top.jsp" %>
	<!-- include top 영역 -->
	
	<div class="wrapper" align="center">
	
		<div class="used_wrapper">
		
			<div class="used_category">
				<button class="gray" style="color:red;"
				onclick="location.href='<%=request.getContextPath() %>/used_list.do?id=${id }'">판매</button>
				<button class="gray">구매</button>
				<button class="gray">교환</button>
				<hr>
			</div>
			
			<div class="used_notice">
				
			</div>
			
			<form class="used_flex_wrapper" method="post" enctype="multipart/form-data"
	      		action="<%=request.getContextPath() %>/used_write_ok.do">
				<input type="hidden" value="${id }" name="used_userid">
				
				<div class="table">
					<table border="1" cellspacing="0" width="100%">
				    	<tr>
				   			<th>글 제목</th>
				    		<td> <input class="white" name="used_title"> </td>
				    	</tr>
				    	
				    	<tr>
				   			<th>제품명</th>
				    		<td> <input class="white" name="used_product"> </td>
				    	</tr>
				    	
				    	<tr>
				   			<th>사이즈</th>
				    		<td> <input class="white" name="used_size"> </td>
				    	</tr>
				    	
				    	<tr>
				   			<th>제품 상태</th>
				    		<td> <select class="navy" name="used_status">
									<option value="0" selected>중고</option>
									<option value="1">새 상품</option>
								 </select> </td>
				    	</tr>
				    	
				    	<tr>
				   			<th>판매 가격</th>
				    		<td> <input class="white" name="used_price" placeholder="숫자만 기입 (원)"> </td>
				    	</tr>    
				    </table>
				</div>
				
				<div class="used_cont">
					<textarea rows="40" cols="140" placeholder="내용" name="used_cont"></textarea>
				</div>
				
				<div class="upload">
					<input type="file" name="used_image" multiple />
					파일 크기 제한 : 2.00MB (허용 확장자 : *.jpeg;*.jpg;*.png;*.gif;)
				</div>
				
				<div class="submit">
					<div class="submit_left">
						<a href="<%=request.getContextPath() %>/used_list.do" style="text-decoration:none; color:red;">돌아가기</a>
					</div>
					
					<div class="submit_right">
						<button class="white" type="submit">등록</button>
					</div>
				</div>
				
			</form>
			
		</div>
		
	</div>
	<%@include file="../include/user_bottom.jsp" %>
</body>
</html>