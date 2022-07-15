<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 리스트 페이지</title>
    <script src="https://kit.fontawesome.com/3de1cbcb05.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="css/community_boardList.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
</head>
<body>
<%@include file="../include/user_top.jsp" %>
    <div id="wrap">
        <div id="container">
            <div id="topic-container">
                <div id="search-container">
                    <form method="post" action="<%=request.getContextPath()%>/community_searchList.do">          
                        <div class="input-group mb-3">
                            <button class="btn btn-outline-secondary" type="submit" id="button-addon2">
                                <i class="fa-solid fa-magnifying-glass fa-2x"></i>
                            </button>
                            <input type="text" name="search_keyword" class="search_keyword" required placeholder="관심있는 내용을 검색해 보세요!">
                       </div>
                    </form> 
                </div>
                <c:set var="categorylist" value="${categoryList}"/>
                <c:set var="bestlist" value="${bestList}"/>
                <c:set var="baordlist" value="${baordList}"/>
                <c:set var="bestcomcountlist" value="${bestcomcountList}"/>
                <c:set var="boardcomcountlist" value="${boardcomcountList}"/>
                <c:set var="recommendlist" value="${recommendList}"/>
                <c:set var="topicCountlist" value="${topicCountList}"/>
                <c:set var="memRankinglist" value="${memRankingList}"/>

                <!-- 베스트 게시글 start  -->
                <div class="topit-list-best">
                    <div class="topic-title">
                        <i class="fa-solid fa-crown fa-2x"></i>
                        <h2>베스트 게시글</h2>
                        <div class="view-more">
                            <a href="<%=request.getContextPath()%>/community_topicList.do?cno=${0}">더보기></a>
                        </div>
                    </div>
                    <div class="topic-list">
                    	<c:if test="${!empty bestlist}">
                    	<!-- 하나의 for문에서 두개의 리스트를 사용하기 위해 varStatus를 사용하여 준다. -->
                    	<c:forEach items="${bestlist}" var="bestdto" begin="0" end="4" step="1" varStatus="status">
                        <div class="article">
                            <div class="topicAndtitle">
                            <c:forEach items="${categorylist }" var="cdto">
                            <c:if test="${cdto.category_cno == bestdto.category_cnofk }">
                            <span class="topic"><a href="<%=request.getContextPath()%>/community_topicList.do?cno=${cdto.category_cno}" class="">
                            ${cdto.category_cname}</a>
                            </span>
                            </c:if>
                            </c:forEach> 
                            <a href="<%=request.getContextPath()%>/community_boardContent.do?bno=${bestdto.community_no}" class="article-title">
                            <c:if test="${bestdto.community_title.length() > 20 }">
                            ${bestdto.community_title.substring(0,20) }...
                            </c:if>
                            <c:if test="${bestdto.community_title.length() <= 20 }">
                            ${bestdto.community_title}
                            </c:if>
                            </a> 
                            </div>
                            <div class="likeAndComment">
                                <a href="#"><i class="fa-solid fa-thumbs-up"></i>${bestdto.community_recommend }</a> 
                                <a href="#" class="#"><i class="fa-solid fa-comment"></i>
                                	${bestcomcountlist[status.index]}
                                </a> 
                            </div>
                        </div>     
                        </c:forEach>
                        </c:if>            
                    </div>
                    
                </div> 
                <!-- 베스트 게시글 end  -->

                <!-- 일반 게시글 start -->
                <c:if test="${!empty categorylist }">
                <c:forEach items="${categorylist}" var="cdto">
                <div class="topit-list-topic">
                    <div class="topic-title">
                        <i class="${cdto.category_icname}"></i>
                        <h2>${cdto.category_cname}</h2>
                        <div class="view-more">
                            <a href="<%=request.getContextPath()%>/community_topicList.do?cno=${cdto.category_cno}">더보기></a>
                        </div>
                    </div>
                    <c:if test="${!empty baordlist}">
                    <!-- 일반게시글을 5개의 리스트만 출력하기위해 사용하는 인덱스와 조건문을 위한 변수처리 -->
					<c:set var="i" value="${0 }"/>
					<c:set var="doneLoop" value="false"/>
                    <c:forEach items="${baordlist}" var="boarddto" varStatus="status" >
                    <c:if test="${not doneLoop}">
                    <c:if test="${boarddto.category_cnofk == cdto.category_cno }">
                    <c:set var="i" value="${i+1 }"/>
                    <div class="topic-list">
                        <div class="article">
                            <div class="topicAndtitle">
                            <!-- <span class="topic"><a href="#" class="">TV·연예</a></span>  -->
                            <a href="<%=request.getContextPath()%>/community_boardContent.do?bno=${boarddto.community_no}" class="article-title">
                            <c:if test="${boarddto.community_title.length() > 20 }">
                            ${boarddto.community_title.substring(0,20)}...
                            </c:if>
                            <c:if test="${boarddto.community_title.length() <= 20 }">
                            ${boarddto.community_title}
                            </c:if>
                            </a> 
                            </div>
                            <div class="likeAndComment">
                                <a href="#"><i class="fa-solid fa-thumbs-up 0.5x"></i>${boarddto.community_recommend }</a> 
                                <a href="#"><i class="fa-solid fa-eye 0.5x"></i>${boarddto.community_hit }</a> 
                            </div>
                        </div>
                    </div>
                    </c:if>
                    <c:if test="${i == 5 }">
						<c:set var="doneLoop" value="true"/>
  					</c:if>
  					</c:if>
                    </c:forEach>
                    </c:if>
                </div>
                </c:forEach>
                </c:if>
                <!-- 일반 게시글 end -->
            </div>  <!-- 베스트, 일반 게시글 end -->

            <div id="right-container">
            
				<div id="member-ranking">
				<div id="topMember-title">
						<img alt="" src="community/top1.png">
						&nbsp;&nbsp;<span>게시글수</span>
				</div>
				<div class="card">
					  <div class="card-image">
					    <figure class="image is-4by1">
					      <img src="upload/member_image/${topMember.member_no}/${topMember.member_cover}" alt="Placeholder image">
					    </figure>
					  </div>
					  <div class="card-content">
					    <div class="media">
					      <div class="media-left">
					        <figure class="image is-48x48">
					          <img src="upload/member_image/${topMember.member_no}/${topMember.member_image}" alt="Placeholder image">
					        </figure>
					      </div>
					      <div class="media-content">
					        <a href="<%=request.getContextPath()%>/myfeed.do?id=${topMember.member_id}">
					        <p class="title is-4">${topMember.member_id}</p>
					        </a>
					        <p class="subtitle is-6">${topMember.member_nickname}</p>
					      </div>
					    </div>
					  </div>
				</div>

					<table class="table">
					  <thead>
					    <tr>
					      <th scope="col">순위</th>
					      <th scope="col">아이디</th>
					      <th scope="col">게시글 수</th>
					    </tr>
					  </thead>
					  <tbody>
					  <!-- 유저순위를 top5순위까지 반복 -->
					  <c:set var="j" value="${0 }"/>
					  <c:set var="doneLoop2" value="false"/>
					  <c:if test="${!empty memRankinglist }">
					  	<c:forEach items="${memRankinglist }" var="rankingdto" varStatus="status">
					  	<c:if test="${not doneLoop2}">
					  	
					  	<c:set var="j" value="${j+1 }"/>
					    <tr>
					      <th class="ranking-count" scope="row">${j }</th>
					      <td>
					      <a href="<%=request.getContextPath()%>/myfeed.do?id=${rankingdto.member_id }">
					      ${rankingdto.member_id }
					      </a>
					      </td>
					      
					      <td class="ranking-boardcount">${rankingdto.boardcount }</td>
					    </tr>
						    <c:if test="${j == 5 }">
							<c:set var="doneLoop2" value="true"/>
	  						</c:if>
	  						
					    </c:if>
					    </c:forEach>
					  </c:if>
					  </tbody>
					</table>
				</div>
				

            </div>
        </div>
    </div>  
<%@include file="../include/user_bottom.jsp" %>
</body>
</html>