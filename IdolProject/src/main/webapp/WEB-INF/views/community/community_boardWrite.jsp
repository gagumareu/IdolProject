<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 작성 페이지</title>
<script src="https://kit.fontawesome.com/3de1cbcb05.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="css/community_boardWrite.css">

</head>
<body>
<%@include file="../include/user_top.jsp" %>
    <div id="wrap">
        <div id="container">
            <div id="content">
                    <div class="title">
                        <h1>Board Form</h1>
                    </div>

                    <form method="post" enctype="multipart/form-data" onsubmit="return submitCheck();" 
                    action="<%=request.getContextPath()%>/community_boardwrite_ok.do">
                    <div class="mb-3">
                        <label for="exampleFormControlInput1" class="form-label">작성자 아이디</label>
                        <input type="text" class="form-control" id="exampleFormControlInput1" 
                        	   name="community_userid" placeholder="${loginInfo.member_id }" required value="${loginInfo.member_id }" readonly>
                    </div>
                    
                    <div class="mb-3">
                        <label for="formFileMultiple" class="form-label">게시글 카테고리</label>
                        <select class="form-select" aria-label="Default select example" id="boardCategory" name="category_cnofk">
                            <option value="" selected>-카테고리를 선택해 주세요-</option>
                            <option value="100">일상</option>
                            <option value="200">루머</option>
                            <option value="300">공식</option>
                            <option value="400">포토</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="exampleFormControlInput1" class="form-label" >게시글 제목</label>
                        <input type="text" class="form-control" id="exampleFormControlInput1" name="community_title"
                        		 placeholder="제목을 입력해주세요" required>
                    </div>

                    <div class="mb-3">
                        <label for="exampleFormControlTextarea1" class="form-label">내용</label>
                        <textarea class="form-control" id="exampleFormControlTextarea1" name="community_cont" required
                        		  rows="8" placeholder="내용을 입력해 주세요"></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="formFileMultiple" class="form-label">파일첨부</label>
                        <div id='image_preview'>
                            <input type='file' id='btnAtt' multiple='multiple' class="form-control" name="file"/>
                            <div id='att_zone' 
                                data-placeholder='파일을 첨부 하려면 파일 선택 버튼을 클릭하거나 파일을 드래그앤드롭 하세요'></div>
                        </div>
                    </div>
                    
                    <div id="btnGroup" align="center">
                    <button type="submit" class="btn btn-primary">게시글 등록</button>
                    <button type="button" class="btn btn-secondary" 
                    onclick="location.href='community_boardList.do'">메인페이지로</button>
                    </div>
                </form>	

            </div> <!-- contnet -->
        </div>
    </div> 

<%@include file="../include/user_bottom.jsp" %>
<script src="js/community_boardWrite.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>