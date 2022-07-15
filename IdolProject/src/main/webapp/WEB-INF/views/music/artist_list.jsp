<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/user_top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<c:forEach items="${artistList }" var="i">
		<a href="<%=request.getContextPath()%>/artist_content.do?no=${i.celeb_no}">
			<img src="resources\\upload\\celeb/${i.celeb_pimage }"
				width="300" height="300">
		</a>
	</c:forEach>
	
</body>
</html>