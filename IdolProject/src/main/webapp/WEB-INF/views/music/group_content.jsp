<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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
	
	.celeb_info{
		margin: 20px 0;
		display: flex;
		flex-direction: row;
		border: 1px solid lightgray;
	}
	
	.celeb_left{
		flex: 1;
		margin: 20px;
	}
	
	.celeb_right{
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
	
	.menu{
		display: flex;
		flex-direction: row;
		text-align: center;
	}
	
	.menu_gray{
		flex: 1;
		background-color: lightgray;
		padding: 10px;
		border-left : 1px solid white;
		border-right : 1px solid white;
	}
	
	.menu_white{
		flex: 1;
		color: green;
		weight: bold;
		padding: 10px;
	}
	
	.detail{
		padding: 10px;
	}
	
	.detail_like{
		margin: 20px 0;
		display: grid;
		grid-template-columns: 1fr 1fr 1fr 1fr;
		grid-gap: 10px;
	}
	
	.like_row{
		display: flex;
		flex-direction: row;
	}
	
	.like{
		flex: 1;
	}
	
	.music_grid{
		margin: 20px 0;
		display: grid;
		grid-template-columns: 1fr 1fr 1fr;
		grid-gap: 10px;
	}
	
	.music_row{
		display: flex;
		flex-direction: row;
	}
	
	.music_image{
		flex: 2;
	}
	
	.music_content{
		flex: 3;
	}
	
	.photo_grid{
		margin: 20px 0;
		display: grid;
		grid-template-columns: 1fr 1fr 1fr 1fr 1fr 1fr;
		grid-gap: 24px;
	}
	
	.photo{
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
</style>
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
			
			<h1><br>아티스트<br></h1>
			
			<div class="celeb_info">
			
				<div class="celeb_left">
					<img src="resources\\upload\\group/${imageList.get(0) }"
					width="200" height="200">
				</div>
				
				<div class="celeb_right">
					<h2>${gdto.group_name}</h2>
					<c:forEach items="${groupMember }" var="i">
						<a href="<%=request.getContextPath()%>/artist_content.do?no=${i.celeb_no}">${i.celeb_name }</a>
						&nbsp;&nbsp;
					</c:forEach>
					<br><br><br>
					
					<div class="info_row">
					
						<div class="info_left">
							데뷔<br><br>
							활동유형<br><br>
							소속사<br><br>
						</div>
						
						<div class="info_right">
							 ${groupMember.get(0).getCeleb_debutdate().substring(0, 10)}<br><br>
							
							 그룹<br><br>
							 
							 ${groupMember.get(0).getCeleb_agency() }<br><br>
						</div>
						
					</div>
					
				</div>
				
			</div>
			
			<hr width="100%" color="gray" >
			
			<!-- 상세정보 페이지 -->
			<c:if test="${type == 'detail' }">
				
				<div class="menu">
					<div class="menu_white">
						상세정보
					</div>
					
					<div class="menu_gray">
						<a href="<%=request.getContextPath() %>/group_content.do?group=${gdto.group_name}&type=music">곡</a>
					</div>
					
					<div class="menu_gray">
						<a href="<%=request.getContextPath() %>/group_content.do?group=${gdto.group_name}&type=album">앨범</a>
					</div>
					
					<div class="menu_gray">
						<a href="<%=request.getContextPath() %>/group_content.do?group=${gdto.group_name}&type=photo">포토/스토리</a>
					</div>
					
					<div class="menu_gray">
						비디오
					</div>
					
					<div class="menu_gray">
						팬
					</div>
					
					<div class="menu_gray">
						Hi-Fi
					</div>
				</div>
				
				<br><br>
				<h2>&nbsp;&nbsp;아티스트 소개</h2><br>	
				<hr width="100%" color="lightgray">
				
				<div class="detail">
					${gdto.group_info }
				</div>

				<br><br>
				<h2>&nbsp;&nbsp;그룹 멤버</h2><br>
				<hr width="100%" color="lightgray">
			
				<div class="detail_like">
					
					<c:forEach items="${groupMember }" var="i">
						
						<div class="like_row">
							<div class="like">
								<%	CelebDTO i = (CelebDTO)pageContext.getAttribute("i");
									String image = i.getCeleb_pimage();
									StringTokenizer st = new StringTokenizer(image, "|");
									String[] array = new String[st.countTokens()];
									
									for(int j=0; j<array.length; j++){
										array[j] = st.nextToken();
									}
									pageContext.setAttribute("image", array[0]);
								%>
								<a href="<%=request.getContextPath()%>/artist_content.do?no=${i.celeb_no}">
								<img src="resources\\upload\\celeb/${image }"
									width="100" height="100"></a>
							</div>
							
							<div class="like">
								<a href="<%=request.getContextPath()%>/artist_content.do?no=${i.celeb_no}">
								<b>${i.celeb_name }</b></a><br><br>
								${i.celeb_group }<br><br>
								${i.celeb_agency }
							</div>
						</div>
						
					</c:forEach>
					
				</div>
				
				<c:if test="${agencyMember.size() != 0 }">
					<br><br>
					<h2>&nbsp;&nbsp;같은 소속사 아티스트</h2><br>
					<hr width="100%" color="lightgray">
				
					<div class="detail_like">
						
						<c:forEach items="${agencyMember }" var="i">
						
							<div class="like_row">
								<div class="like">
									<%	CelebDTO i = (CelebDTO)pageContext.getAttribute("i");
										String image = i.getCeleb_pimage();
										StringTokenizer st = new StringTokenizer(image, "|");
										String[] array = new String[st.countTokens()];
										
										for(int j=0; j<array.length; j++){
											array[j] = st.nextToken();
										}
										pageContext.setAttribute("image", array[0]);
									%>
									<a href="<%=request.getContextPath()%>/artist_content.do?no=${i.celeb_no}">
									<img src="resources\\upload\\celeb/${image }"
										width="100" height="100">
									</a>
								</div>
								
								<div class="like">
									<a href="<%=request.getContextPath()%>/artist_content.do?no=${i.celeb_no}">
									<b>${i.celeb_name }</b></a><br><br>
									
									<c:if test="${i.celeb_group != 'solo'}">
										<a href="<%=request.getContextPath()%>/group_content.do?group=${i.celeb_group}">
									</c:if>
									${i.celeb_group }
									<c:if test="${i.celeb_group != 'solo'}">
										</a>
										
									</c:if><br><br>
									
									${i.celeb_agency }
								</div>
							</div>
								
						</c:forEach>
						
					</div>
		
				</c:if>
			
			</c:if>
			<!-- 상세 정보 End -->
			
			<!-- 곡 페이지 -->
			<c:if test="${type == 'music' }">
				
				<div class="menu">
					<div class="menu_gray">
						<a href="<%=request.getContextPath() %>/group_content.do?group=${gdto.group_name}">상세정보</a>
					</div>
					
					<div class="menu_white">
						곡
					</div>
					
					<div class="menu_gray">
						<a href="<%=request.getContextPath() %>/group_content.do?group=${gdto.group_name}&type=album">앨범</a>
					</div>
					
					<div class="menu_gray">
						<a href="<%=request.getContextPath() %>/group_content.do?group=${gdto.group_name}&type=photo">포토/스토리</a>
					</div>
					
					<div class="menu_gray">
						비디오
					</div>
					
					<div class="menu_gray">
						팬
					</div>
					
					<div class="menu_gray">
						Hi-Fi
					</div>
				</div>
				
				<br><br><br>
				<div style="text-align: right;"><b>최신순</b>&nbsp;&nbsp;|&nbsp;&nbsp;가나다순&nbsp;&nbsp;|&nbsp;&nbsp;인기순</div><br>
				<hr width="100%" color="lightgray">
				
				<div class="music_grid">
				
					<c:forEach items="${musicList }" var="i">
					
						<div class="music_row">
							<div class="music_image">
								<a href="<%=request.getContextPath() %>/user_music_content.do?no=${i.music_no }">
								<img src="resources\\upload\\music/${i.music_coverimage.substring(0, i.music_coverimage.length()-1) }"
											width="100" height="100">
								</a>
							</div>
							
							<div class="music_content">
								<c:if test="${i.music_name.length() > 26}">
									<b>${i.music_name.substring(0,25) }...</b>
								</c:if>
								<c:if test="${i.music_name.length() <= 25}">
									<b>${i.music_name }</b>
								</c:if>
								<br>
								${i.music_aname }<br><br>
								<span style="color:green;">
										${i.group_name }
								</span><br>
								${i.music_release_date.substring(0,10) }
							</div>
						</div>
					
					</c:forEach>
					
				</div>
				
			</c:if>
			<!-- 곡 End -->
			
			<c:if test="${type == 'album' }">
			<div class="menu">
					<div class="menu_gray">
						<a href="<%=request.getContextPath() %>/group_content.do?group=${gdto.group_name}">상세정보</a>
					</div>
					
					<div class="menu_gray">
						<a href="<%=request.getContextPath() %>/group_content.do?group=${gdto.group_name}&type=music">곡</a>
					</div>
					
					<div class="menu_white">
						앨범
					</div>
					
					<div class="menu_gray">
						<a href="<%=request.getContextPath() %>/group_content.do?group=${gdto.group_name}&type=photo">포토/스토리</a>
					</div>
					
					<div class="menu_gray">
						비디오
					</div>
					
					<div class="menu_gray">
						팬
					</div>
					
					<div class="menu_gray">
						Hi-Fi
					</div>
				</div>
				
				<br><br><br>
				<div style="text-align: right;"><b>최신순</b>&nbsp;&nbsp;|&nbsp;&nbsp;가나다순&nbsp;&nbsp;|&nbsp;&nbsp;인기순</div><br>
				<hr width="100%" color="lightgray">
				
				<div class="music_grid">
				
					<c:forEach items="${albumList }" var="album">
					
						<div class="music_row">
							<div class="music_image">
								<a href="<%=request.getContextPath() %>/user_album_content.do?no=${album.music_no }">
								<img src="resources\\upload\\music/${album.music_coverimage.substring(0, album.music_coverimage.length()-1) }"
											width="100" height="100">
								</a>
							</div>
							
							<div class="music_content">
								<c:if test="${album.music_aname.length() > 26}">
									<b>${album.music_aname.substring(0,25) }...</b>
								</c:if>
								<c:if test="${album.music_aname.length() <= 25}">
									<b>${album.music_aname }</b>
								</c:if>
								<br>
								<%-- ${i.music_aname } --%><br><br>
								<span style="color:green;">
										${album.group_name }
								</span><br>
								${album.music_release_date.substring(0,10) }
							</div>
						</div>
					
					</c:forEach>
					
				</div>
			
			
			
			</c:if>
			<!-- 앨범 End -->
			<c:if test="${type == 'photo' }">
				
				<div class="menu">
					<div class="menu_gray">
						<a href="<%=request.getContextPath() %>/group_content.do?group=${gdto.group_name}">상세정보</a>
					</div>
					
					<div class="menu_gray">
						<a href="<%=request.getContextPath() %>/group_content.do?group=${gdto.group_name}&type=music">곡</a>
					</div>
					
					<div class="menu_gray">
						<a href="<%=request.getContextPath() %>/group_content.do?group=${gdto.group_name}&type=album">앨범</a>
					</div>
					
					<div class="menu_white">
						포토/스토리
					</div>
					
					<div class="menu_gray">
						비디오
					</div>
					
					<div class="menu_gray">
						팬
					</div>
					
					<div class="menu_gray">
						Hi-Fi
					</div>
				</div>
				
				<br><br><br>
				<div style="text-align: right;"><b>최신순</b>&nbsp;&nbsp;|&nbsp;&nbsp;인기순</div><br>
				<hr width="100%" color="lightgray">
				
				<div class="photo_grid">
				
					<c:forEach items="${imageList }" var="i">
				
						<div class="photo">
							<img src="resources\\upload\\group/${i }"
										width="148" height="148">
						</div>
						
					</c:forEach>
					
					<c:forEach items="${groupMember }" var="i">
						
						<%	CelebDTO i = (CelebDTO)pageContext.getAttribute("i");
							String image = i.getCeleb_pimage();
							StringTokenizer st = new StringTokenizer(image, "|");
							String[] array = new String[st.countTokens()];
							List<String> groupImageList = new ArrayList<String>();
							
							for(int k=0; k<array.length; k++){
								array[k] = st.nextToken();
							}
							for(int l=0; l<array.length; l++) {
								groupImageList.add(array[l].trim());
							}
							pageContext.setAttribute("groupImageList", groupImageList);
						%>
						<c:forEach items="${groupImageList }" var="j">
						
							<div class="photo">
								<img src="resources\\upload\\celeb/${j }"
										width="148" height="148">
							</div>
						
						</c:forEach>
					
					</c:forEach>
					
				</div>
				
			</c:if>
		</div>
		
	</div>
	<%@ include file="../include/user_bottom.jsp" %>
</body>
</html>