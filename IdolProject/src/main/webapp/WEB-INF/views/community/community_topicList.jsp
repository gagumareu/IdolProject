<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <title>topicList</title>
    <script src="https://kit.fontawesome.com/3de1cbcb05.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="css/community_topicList.css">
</head>
<body>
<%@include file="../include/user_top.jsp" %>

    <div id="wrap">
        <div id="container">
            <div id="content">
				<input type="hidden" id="tabNo" value="${tabNo}">
				<input type="hidden" id="memNo" value="${loginInfo.member_no}">
                <div id="tab-bar">
                    <div class="tab-menu"><a href="<%=request.getContextPath()%>/community_topicList.do?cno=${0}">베스트 게시글</a></div>
                    <div class="tab-menu"><a href="<%=request.getContextPath()%>/community_topicList.do?cno=${100}">일상</a></div>
                    <div class="tab-menu"><a href="<%=request.getContextPath()%>/community_topicList.do?cno=${200}">루머</a></div>
                    <div class="tab-menu"><a href="<%=request.getContextPath()%>/community_topicList.do?cno=${300}">공식</a></div>
                    <div class="tab-menu"><a href="<%=request.getContextPath()%>/community_topicList.do?cno=${400}">포토</a></div>
                    <div class="tab-menu"> <button id="boardWrite">글쓰기</button> 
                    
                    </div>
                </div>
                <div id="list-container">
                <c:set var = "topiclist" value="${topicList }"/>
                <c:set var = "memlist" value="${memList }"/>
                <c:set var = "imgCountlist" value="${imgCountList }"/>
                <c:set var = "comcountlist" value="${comcountList }"/>
                <c:set var = "recommentStslist" value="${recommentStsList }"/>
                <input type="hidden" id="loginId" value="${loginInfo.member_id }">
                <input type="hidden" id="loginNo" value="${loginInfo.member_no }">
                	<c:if test="${!empty topiclist }">
                	<c:forEach items="${topiclist }" var="topicdto" varStatus="status">
                	<input type="hidden" class=ImgTrue value="${topicdto.community_image}">
                	<input type="hidden" class="imgCount" value="${imgCountlist.get(status.index)}">
                	<input type="hidden" class="recommendStatus" value="${recommentStslist.get(status.index)}">
                	<input type="hidden" class="bno" value="${topicdto.community_no}">
                    <div class="article">
                        <!-- <div class="new">new</div> -->
                        <!-- <div class="hot">Hot</div> -->
                        <div class="title">
                        <a href="<%=request.getContextPath()%>/community_boardContent.do?bno=${topicdto.community_no}">
                        <c:if test="${topicdto.community_title.length() > 25 }">
                        <h3>${topicdto.community_title.substring(0,25) }...</h3>
                        </c:if>
                        <c:if test="${topicdto.community_title.length() <= 25 }">
                        <h3>${topicdto.community_title}</h3> 
                        </c:if> 
                        </a>
                        </div>
                        <div class="content">
                            <a href="<%=request.getContextPath()%>/community_boardContent.do?bno=${topicdto.community_no}" class="">
                            	<c:if test="${topicdto.community_cont.length() > 70 }">
                            	${topicdto.community_cont.substring(0,70)}....
                            	</c:if>
                            	<c:if test="${topicdto.community_cont.length() <= 70 }">
                            	${topicdto.community_cont}
                            	</c:if>
                            </a>
                        </div> 
                        <div class="sub">
                        	<c:forEach items="${memlist }" var="memdto">
                        	<c:if test="${topicdto.community_userid == memdto.member_id }">
                        	<c:if test="${!empty memdto.member_nickname }">
                            <div class="user">
                            	${topicdto.community_userid } | ${memdto.member_nickname }
                            </div>
                            </c:if>
                            <c:if test="${empty memdto.member_nickname }">
                            <div class="user">
                            	${topicdto.community_userid }
                            </div>
                            </c:if>
                            <div class="user-feed">
                            	<ul>
                            		 <li><a href="<%=request.getContextPath()%>/myfeed.do?id=${topicdto.community_userid}">회원 프로필</a></li> 
                            		 <li><a href="">1대1채팅</a></li> 
                            	</ul>
                            	<input type="hidden" class="feed-OnOff" value="0">
                            </div>
                            </c:if>
                            </c:forEach>
                            
                            <c:if test="${!empty topicdto.community_image }">
                            <div class="imgBox">
                            	<img alt="이미지" src="community/${topicdto.community_image }">
                            </div>
                            <c:if test="${imgCountlist.get(status.index) > 1 }">
                            <div class="imgNoBox">
                            	+${imgCountlist.get(status.index)}
                            </div>
                            </c:if>
                            </c:if>
                            <div class="content-info">
                                <div class="info-left">
                                    <i class="fa-solid fa-eye"></i>${topicdto.community_hit } &nbsp;&nbsp;
                                    <i class="fa-solid fa-thumbs-up"></i><span class="recommendCount">${topicdto.community_recommend }</span> &nbsp;&nbsp;
                                    <i class="fa-solid fa-comment"></i>${comcountlist[status.index]} &nbsp;&nbsp;
                                </div>
                                <div class="info-right">
                                    <i class="fa-solid fa-clock"></i>${topicdto.community_date.substring(0,10) }
                                </div>
                            </div>
                        </div>
                    </div>
                    </c:forEach>
                    </c:if>
                
                </div><!-- list-container end -->
                <div id="article_more">더보기 +</div>

                
            </div> <!-- contnet -->
        </div>
        <a id="back-to-top" href="#">Top</a>
        <a id="back-to-bottom" href="#">Bot</a>
    </div>  
    <script src="js/community_topicList.js?ver=1"></script>
<%@include file="../include/user_bottom.jsp" %>    
</body>
</html>