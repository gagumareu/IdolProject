<%@page import="com.idol.model.CelebDTO"%>
<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

	a{
		text-decoration:none;
		color: black;
	}
	
	.wrapper	{
		font-family: NotoSans Kor;
		margin : 0 0 50px 0;
	}
	
	.music_wrapper {
		display: flex;
		flex-direction: column;
		min-height: 100vh;
		width: 65%;
		text-align: left;
		font-size: 12px;
	}
	
	.music_search {
		margin: 50px 0;
	}
	
	.music_info{
		margin: 20px 0;
		display: flex;
		flex-direction: row;
		border: 1px solid lightgray;
	}
	
	.music_left{
		flex: 1;
		margin: 20px;
	}
	
	.music_right{
		flex: 4;
		margin: 20px;
	}
	
	.info_row{
		display: flex;
		flex-direction: row;
	}
	
	.info_left{
		flex : 1;
	}
	
	.info_right{
		flex : 9;
	}
	
	.lyrics{
		padding: 10px;
		height: 200px;
		overflow: hidden;
	}
	
	.lyrics_auto{
		display: none;
		padding: 10px;
	}
	
	.fold{
		text-align: center;
	}
	
	.composer_lyricst_grid{
		margin: 10px 0;
		display: grid;
		grid-template-columns: 1fr 1fr 1fr 1fr;
		grid-gap: 10px;
	}
	
	.composer_lyricst_row{
		display: flex;
		flex-direction: row;
	}
	
	.composer_lyricst_image{
		flex: 1;
		border-radius: 70%;
		overflow: hidden;
	}
	
	.composer_lyricst_content{
		flex: 1;
		padding: 20px;
	}
	
	select.green{
		padding: 10px;
		font-size: 12px;
		border: 1px solid green;
		border-radius: 15px;
	}
	
	input.green{
		padding: 10px;
		font-size: 12px;
		width: 25%;
		border: 1px solid green;
		border-radius: 15px;
	}
	
	button.green{
		padding: 10px;
		font-size: 12px;
		border: 1px solid green;
		background-color: white;
		border-radius: 15px;
	}
	
	#lyrics{
		border: 0;
		font-size: 15px;
		color: gray;
		width: 300px;
		height: 200px;
		overflow: hidden;
		resize: none;
	}
	
	#lyrics_auto{
		border: 0;
		font-size: 15px;
		color: gray;
		width: 300px;
		min-height: 200px;
		overflow: hidden;
		resize: none;
	}
	
	button.foldbutton{
		background-color: white;
		border: 0;
	}
	
	button.like{
		background-color: white;
		border: 0;
		font-size: 20px;
		color: green;
	}
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	
	$( document ).ready( function() {
        $( '.foldbutton' ).click( function() {
          $( '.lyrics_auto' ).slideToggle( 400, 'swing', function(){
        	  	$('#lyrics_auto').height(1).height( $('#lyrics_auto').prop('scrollHeight')+12 );
        	  if($('.foldbutton').html() == '펼치기'){
        		  $('.foldbutton').html('접기')
        	  } else{
        		  $('.foldbutton').html('펼치기')
        	  }
          });
          $('.lyrics').slideToggle();
          
        } );
      } );
	
</script>

</head>
<body>
	<%@ include file="../include/user_top.jsp" %>
	
	<div class="wrapper" align="center">
		
		<div class="music_search">
			<form method="post" action="<%=request.getContextPath() %>/music_search.do">
			      
		      	<select class="green" name="field">
				    <option value="artist">가수</option>
				    <option value="group">그룹</option>
				    <option value="music">곡</option>
			    </select>
			    
		      	<input class="green" name="keyword">&nbsp;
			    
		    	<button class="green">검색</button>
			    	
			</form>
		</div>
			
		<div class="music_wrapper">
			
			<hr width="100%" color="lightgray">
			
			<h1><br>곡 정보<br></h1>
			
			<div class="music_info">
			
				<div class="music_left">
					<img src="resources\\upload\\music/${dto.music_coverimage.substring(0, dto.music_coverimage.length()-1) }"
					width="200" height="200">
				</div>
				
				<div class="music_right">
					<span style="font-size:30px; weight:bold;">${dto.music_name}</span><br>
					
					<span style="font-size:20px; weight:bold; color:green;">
						<c:if test="${dto.group_name == 'solo' }">
							<c:forEach items="${artistList }" var="i">
								<c:if test="${i.celeb_name == dto.celeb_name }">
									<a href="<%=request.getContextPath() %>/artist_content.do?no=${i.celeb_no }">${dto.celeb_name }</a>
								</c:if>
							</c:forEach>
						</c:if>
						
						<c:if test="${dto.group_name != 'solo' }">
							<a href="<%=request.getContextPath()%>/group_content.do?group=${dto.group_name }">${dto.group_name }</a>
						</c:if>
					</span>
					<br><br>
					
					<div class="info_row">
						<div class="info_left">
							앨범<br><br>
							발매일<br><br>
							
							<c:if test="${confirmFollow == 1 }">
								<button class="like"
								onclick="location.href='<%=request.getContextPath()%>/music_unlike.do?no=${dto.music_no}&type=music'">♥</button>
							</c:if>
							
							<c:if test="${confirmFollow == 0 }">
								<button class="like"
								onclick="location.href='<%=request.getContextPath()%>/music_like.do?no=${dto.music_no}&type=music'">♡</button>
							</c:if>
								
						</div>
						
						<div class="info_right">
							 ${dto.music_aname }<br><br>
							 ${dto.music_release_date.substring(0,10) }<br><br>
							 <h2>${countFollow }</h2>
						</div>
					</div>
					
				</div>
				
			</div>
			
			<hr width="100%" color="gray" >
			<br><br>
			<h2>가사</h2><br>	
			<hr width="100%" color="lightgray">
			
			<div class="lyrics">
				<textarea id="lyrics" readonly>${dto.music_lyrics }</textarea>
			</div>
			
			<div class="lyrics_auto">
				<textarea id="lyrics_auto" readonly>${dto.music_lyrics }</textarea>
			</div>
			
			<div class="fold">
				<button class="foldbutton">펼치기</button>
			</div>
			
			<br><br>
			<h2>작사 / 작곡</h2><br>
			<hr width="100%" color="lightgray">
			
			<div class="composer_lyricst_grid">
			
				<c:forEach items="${composerList }" var="i">
				
					<div class="composer_lyricst_row">
					
						<div class="composer_lyricst_image">
						
							<c:set var="a" value="0" />
							
							<!-- 싸이의 경우 싸이 (PSY) 라고 작사/작곡가에 기재되어 있다... -->
							<c:forEach items="${artistList }" var="j">
								
								<c:if test="${i.equalsIgnoreCase(j.celeb_name)}">
									<%	CelebDTO j = (CelebDTO)pageContext.getAttribute("j");
											String image = j.getCeleb_pimage();
											StringTokenizer st = new StringTokenizer(image, "|");
											String[] array = new String[st.countTokens()];
											
											for(int k=0; k<array.length; k++){
												array[k] = st.nextToken();
											}
											pageContext.setAttribute("image", array[0]);
										%>
									<a href="<%=request.getContextPath()%>/artist_content.do?no=${j.celeb_no}">
									<img src="resources\\upload\\celeb/${image }"
									width="100%" height="100%">
									</a>
									<c:set var="a" value="1" />
								</c:if>
								
							</c:forEach>
							
							<c:if test="${a == 0 }">
								<img src="resources\\upload\\celeb/프사없음.jpeg"
									width="100%" height="100%">
							</c:if>
						</div>
						
						<div class="composer_lyricst_content">
							<span style="color:green; font-size: 15px;">${i }</span>
							<br><br>작곡
						</div>
						
					</div>
					
				</c:forEach>
				
				<c:forEach items="${lyricstList }" var="i">
				
					<div class="composer_lyricst_row">
					
						<div class="composer_lyricst_image">
						
							<c:set var="a" value="0" />
							
							<!-- 데이터 안의 이름을 통일할 필요가 있음. 싸이 / 싸이 (PSY) -->
							<c:forEach items="${artistList }" var="j">
								<c:if test="${i.equalsIgnoreCase(j.celeb_name)}">
									<%	CelebDTO j = (CelebDTO)pageContext.getAttribute("j");
											String image = j.getCeleb_pimage();
											StringTokenizer st = new StringTokenizer(image, "|");
											String[] array = new String[st.countTokens()];
											
											for(int k=0; k<array.length; k++){
												array[k] = st.nextToken();
											}
											pageContext.setAttribute("image", array[0]);
										%>
									<a href="<%=request.getContextPath()%>/artist_content.do?no=${j.celeb_no}">
									<img src="resources\\upload\\celeb/${image }"
									width="100%" height="100%">
									</a>
									<c:set var="a" value="1" />
								</c:if>
							</c:forEach>
							
							<c:if test="${a == 0 }">
								<img src="resources\\upload\\celeb/프사없음.jpeg"
									width="100%" height="100%">
							</c:if>
						</div>
						
						<div class="composer_lyricst_content">
							<span style="color:green; font-size: 15px;">${i }</span>
							<br><br>작사
						</div>
						
					</div>
					
				</c:forEach>
				
			</div>
		</div>
		
	</div>
	<%@ include file="../include/user_bottom.jsp" %>
</body>
</html>