<%@page import="java.util.StringTokenizer"%>
<%@page import="com.idol.model.MusicDTO"%>
<%@page import="com.idol.model.FollowDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${id }님의 피드 - Like</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" ></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="./resources/css/member.css?v=2022062212">
<style type="text/css">
	
	
	
	.music_list{
		background-color:white;
		padding:30px;
		font-size:0.95em;
	}
	
	
	.music_item{
		display:flex;
		margin:10px 0;
	}
	
	.music_item .music_image {
		width:100px;
		height:100px;
		border-radius: 10px;
		margin-right:20px;
	}
	
	.music_image img{
		width:100%;
		height:100%;
	}
	
	.music_info{
		line-height: 1.5;
		width: 65%;
	}
	
	.music_link a{
		color:#2a3a52;
	}
	
	.music_link:hover{
		color:red;
	}
	
	.music_link a i{
		font-size: 2em;
		margin-right:40px;
	}
	
	.music_link input{
		margin-left:60px;
		width: 50px;
 	   border-radius: 5px;
  	  border: 1px solid #2a3a52;
   	 background-color: white;
	}
	
	.music_link input:hover {
	
		background-color:#ececec;
	
}
	.m_aname, .m_celeb{
		font-size: 0.8em;
	}
	.m_name{
		display:inline-block;
		font-size: 1.1em;
		font-weight: bold;
		margin-top:3px;
	}
	

</style>
</head>
<body>
	<c:set var="dto" value="${feedInfo.get('mInfo') }"/> <!-- 피드회원정보 -->
	<c:set var="like" value="${mLike }"/> <!-- 좋아요한 곡 리스트 -->
	<c:set var="cont" value="${mCont }"/> <!--  좋아요한 곡에 대한 정보를 담은 리스트 -->
	<%@include file="../include/user_top.jsp" %>
	
	<div class="feed_wrapper" align="center">
	<div class="myfeed_container" align="center">
		<!-- myfeed_top include 추가  -->
		<jsp:include page="../include/feed_top.jsp"/>
		
		<div class="feed_main">
			<div class="feed_title">
				<table>
					<tr>
						<td>
							<a href="<%=request.getContextPath() %>/myfeed.do?id=${dto.getMember_id()}" style="color: gray; ">
							ABOUT
							</a>
						</td>
						<td >
							<a href="<%=request.getContextPath() %>/feed_posting.do?id=${dto.getMember_id()}" style="color: gray;">POSTING</a>
						</td >
						<td style="border-bottom:1px solid #2a3a52">
							<a href="<%=request.getContextPath() %>/feed_like.do?id=${dto.getMember_id()}" style="color: black;">LIKE♥</a>
						</td>
					</tr>
				</table>
			</div><!-- class="feed_title"  end -->
			<div class="music_list" align="left">
			<c:if test="${empty mLike }">
			<div class="music_item" align="center">
			<p> 좋아요 한 곡리스트가 없습니다.</p>
			</div>
			</c:if>
			<c:if test="${!empty mLike }">
			<%
				List<FollowDTO> flist = (List<FollowDTO>)request.getAttribute("mLike");
				List<MusicDTO> mcont = (List<MusicDTO>)request.getAttribute("mCont");
				
				for(int i=0; i<flist.size(); i++){
					
					FollowDTO fdto = flist.get(i);
					MusicDTO mdto = mcont.get(i);
					
					int num = mdto.getMusic_coverimage().length();
					String music_cover = mdto.getMusic_coverimage().substring(0, (num-1));
					
			%>		
				<div class="music_item">
					<div class="music_image">
						<img src="./resources/upload/music/<%=music_cover%>">
					</div>			
					<div class="music_info">
						<span class="m_aname"><%=mdto.getMusic_aname() %></span> <br>
						<a href="<%=request.getContextPath()%>/user_music_content.do?no=<%=mdto.getMusic_no()%>"><span class="m_name"><%=mdto.getMusic_name() %></span></a> <br>
			<%
					String celeb ="";
					if(mdto.getGroup_name() == "solo"){
						celeb = mdto.getCeleb_name();
					}else{
						celeb = mdto.getGroup_name();
					}
			%>
						<span class="m_celeb"><%=celeb %></span>
					</div>
				
			<%
				//뮤비 링크 뽑아오기 
				String link = mdto.getMusic_movie_link().substring(38); //https:// ~ 
				
				StringTokenizer st = new StringTokenizer(link, " ");
				
				String[] array = new String[st.countTokens()];
				
				for(int j=0; j<array.length; j++){
					array[j] = st.nextToken();
				}
				
				int num2 = array[0].length();
				
				link = array[0].substring(0, (num2-1));
			
			%>
				<div class="music_link">
					<a href="<%=link%>" target="_blank"><i class="bi bi-play-btn-fill"></i></a>
			
				<c:if test="${login_id == dto.getMember_id() }">
					<input type="button" value="삭제" onclick="location.href='delLike.do?fno=<%=fdto.getF_no()%>&type=MUSIC'">
				</c:if>
				
				
				</div>
			
				</div><!-- class="music_item" -->
			<% 	} %>
				
				
				
			</c:if>
				
			</div><!-- class="music_list" -->
		
		</div><!-- class="feed_main" end -->
	
	</div><!-- class="myfeed_container" end -->
	</div>
	<%@include file="../include/user_bottom.jsp" %>
</body>
</html>