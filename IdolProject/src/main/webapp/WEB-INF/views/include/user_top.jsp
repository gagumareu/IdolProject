<%@page import="com.idol.model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="stylesheet" href="./resources/css/all.min.css">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="./resources/css/global.css" />
	    <link rel="stylesheet" href="./resources/css/gnb.css" />
	    <link rel="stylesheet" href="./resources/css/main.css" />
	    <link
	      rel="stylesheet"
	      href="https://unpkg.com/swiper@8/swiper-bundle.min.css"
	    />
    	<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
		<title>YOUR CELEB</title>
		<script type="text/javascript">
		function loginAlert() {
		      alert("사용 권한이 없습니다. 로그인 해주세요");
		  } 
		</script>
	</head>
	<body>
		<!-- include header -->
              <div id="g_nav">
                 <ul class="main_login_section">
				<% if(session.getAttribute("login_id") == null){ 
				 %>
           			<li><a href="<%=request.getContextPath()%>/login.do">Login</a></li>
          			<li><a href="<%=request.getContextPath()%>/join.do">Join</a></li>
				<%} else{ %>
                    <li><a href="<%=request.getContextPath()%>/logout.do">Logout</a></li>
                <%} %>	
                 </ul>
              </div>
   		<header id="header">
      <div class="gnb">
        <div class="gnb-wrap">
	      <div class="logo"><a href="<%=request.getContextPath()%>/"><img src="././resources/upload/logo.png"></a></div>
          <div class="gnb-menu">
            <ul>
              <li>
                <a href="#" class="active-link" id="artist">ARTIST</a>
              </li>
              <li>
                <a href="<%=request.getContextPath()%>/product_list.do?cno=${100}" class="active-link" id="product">PRODUCT</a>
              </li>
              <li><a href="<%=request.getContextPath()%>/community_boardList.do">FORUM</a></li>
              <li><a href="<%=request.getContextPath()%>/event_list.do?board_id=1&category_id=1">EVENT</a></li>
              <li><a href="<%=request.getContextPath()%>/whole_ranking.do">MEMBERS</a></li>
              <li><a href="<%=request.getContextPath()%>/used_list.do">MARKET</a></li>
            </ul>
            
          </div>


          <div class="gnb-tool">
            <ul>
            <!-- 로그인이 안 되어 있을 경우 -->
            <% if(session.getAttribute("login_id")==null){ %>
              <li>
              <!-- MYPAGE -->
                <a href="#" onclick="loginAlert()"><i class="fa-solid fa-user"></i></a>
              </li>
              <!-- SEARCH -->
              <li><a href="#"><i class="fa-solid fa-magnifying-glass"></i></a></li>
				
			  <!-- CART -->
              <li><a href="#" onclick="loginAlert()"><i class="fa-solid fa-cart-shopping"></i></a></li>
            
            </ul>
            <%}else { %>
            <ul>
              <li>
              <!-- MYPAGE -->
                <a href="<%=request.getContextPath()%>/myfeed.do?id=<%=(String)session.getAttribute("login_id")%>"><i class="fa-solid fa-user"></i></a>
              </li>
              <!-- SEARCH -->
              <li><a href="#"><i class="fa-solid fa-magnifying-glass"></i></a></li>
			  <!-- CART -->
			  <%
			  	MemberDTO memberdto = (MemberDTO)session.getAttribute("loginInfo");
			  	if(memberdto != null){
			  	int memno = memberdto.getMember_no();
			  	pageContext.setAttribute("memno", memno);
			  	}
			  %>
              <li><a href="<%=request.getContextPath()%>/product_cartList.do?memno=${memno}">
              <i class="fa-solid fa-cart-shopping"></i></a></li>
            </ul> 
            <%} %>
          </div>
        </div>
        <div class="menu" id="menu">
        <div class="menu-wrap">
          <!-- artist sub menu -->
          <div id="artist-box">
            <ul class="artist-menu">
              <li>
                <a href="<%=request.getContextPath()%>/group_content.do?group=SHINEE">SHINEE</a>
              </li>
              <li>
                <a href="<%=request.getContextPath()%>/artist_content.do?no=22">싸이</a>
              </li>
              <li>
                <a href="#">(여자)아이들</a>
              </li>
              <li>
                <a href="<%=request.getContextPath()%>/group_content.do?group=AESPA">AESPA</a>
              </li>
              <li>
                <a href="<%=request.getContextPath()%>/group_content.do?group=방탄소년단(BTS)">BTS</a>
              </li>
              <li>
                <a href="<%=request.getContextPath()%>/group_content.do?group=BLACKPINK">BLACK PINK</a>
              </li>
              <li>
                <a href="<%=request.getContextPath()%>/group_content.do?group=레드벨벳">RED VELVET</a>
              </li>
              <li>
                <a href="<%=request.getContextPath()%>/artist_content.do?no=32">박재범</a>
              </li>
              <li>
                <a href="<%=request.getContextPath()%>/group_content.do?group=STAYC">STAYC</a>
              </li>
              <li>
                <a href="#">BEAST</a>
              </li>
              <li>
                <a href="<%=request.getContextPath()%>/group_content.do?group=IVE">IVE</a>
              </li>
              <li>
                <a href="<%=request.getContextPath()%>/group_content.do?group=LE SSERAFIM">LE SSERAFIM</a>
              </li>
            </ul>

            <div class="artist-album">
              <div>
                <div class="artist-album-img">
                  <img id="img" src="" />
                </div>
                <div class="artist-album-info">
                  <p class="artist-album-singer" id="singer"></p>
                  <p class="artist-album-tit" id="title"></p>
                  <a class="artist-album-detail-link" href="#">자세히보기</a>
                </div>
              </div>
            </div>
          </div>
          <!-- product sub menu -->
          <div id="product-box">
            <div class="product-wrap-vertical">
              <div class="product-wrap">
                <div class="tit"><a href="<%=request.getContextPath()%>/product_list.do?cno=${100}">MUSIC</a></div>
                <ul class="product-menu">
                  <li>
                    <a href="<%=request.getContextPath()%>/product_list.do?cno=${110}">CD</a>
                  </li>
                  <li>
                    <a href="<%=request.getContextPath()%>/product_list.do?cno=${120}">DVD</a>
                  </li>
                  <li>
                    <a href="<%=request.getContextPath()%>/product_list.do?cno=${130}">etc.</a>
                  </li>
                </ul>
              </div>

              <div class="product-wrap">
                <div class="tit"><a href="<%=request.getContextPath()%>/product_list.do?cno=${200}">PHOTO</a></div>
                <ul class="product-menu">
                  <li>
                    <a href="<%=request.getContextPath()%>/product_list.do?cno=${210}">Printed</a>
                  </li>
                  <li>
                    <a href="<%=request.getContextPath()%>/product_list.do?cno=${220}">Photo Book</a>
                  </li>
                </ul>
              </div>

              <div class="product-wrap">
                <div class="tit"><a href="<%=request.getContextPath()%>/product_list.do?cno=${300}">CONCERT</a></div>
                <ul class="product-menu">
                  <li>
                    <a href="<%=request.getContextPath()%>/product_list.do?cno=${310}">Official Fanlight</a>
                  </li>
                  <li>
                    <a href="<%=request.getContextPath()%>/product_list.do?cno=${320}">Concert Goods</a>
                  </li>
                </ul>
              </div>
            </div>
            <div class="product-wrap">
              <div class="tit"><a href="<%=request.getContextPath()%>/product_list.do?cno=${400}">LIVING</a></div>
              <ul class="product-menu">
                
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${410}">Home</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${420}">Kitchen</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${430}">F&B</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${440}">Tech</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${450}">Book</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${460}">Pet</a></li>
              </ul>
            </div>
            <div class="product-wrap">
              <div class="tit"><a href="<%=request.getContextPath()%>/product_list.do?cno=${500}">BEAUTY</a></div>
              <ul class="product-menu">
                
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${510}">Skin Care</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${520}">Make Up</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${530}">Cleansing</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${540}">Body & Hair</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${550}">Pack & Masks</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${560}">Perfume</a></li>
	   			<li><a href="<%=request.getContextPath()%>/product_list.do?cno=${570}">Tool</a></li>
	   			<li><a href="<%=request.getContextPath()%>/product_list.do?cno=${580}">Men's</a></li>
              </ul>
        </div>
          <div class="product-wrap">
              <div class="tit"><a href="<%=request.getContextPath()%>/product_list.do?cno=${600}">STATIONERY</a></div>
              <ul class="product-menu">
                
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${610}">Note</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${620}">Office</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${630}">Pen</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${640}">Deco</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${650}">Binder</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${660}">Toy</a></li>
              </ul>
        </div>
        <div class="product-wrap-vertical">
        <div class="product-wrap">
              <div class="tit"><a href="<%=request.getContextPath()%>/product_list.do?cno=${700}">FASHION</a></div>
              <ul class="product-menu">
                
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${710}">Clothing</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${720}">Acc</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${730}">Jewelry</a></li>
              </ul>
         </div>
            
        <div class="product-wrap">
              <div class="tit"><a href="<%=request.getContextPath()%>/product_list.do?cno=${800}">CUSTOMIZING</a></div>
              <ul class="product-menu">
                
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${810}">Phone Case</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${820}">Fashion</a></li>
                <li><a href="<%=request.getContextPath()%>/product_list.do?cno=${830}">Acc</a></li>
              </ul>
        </div>
        
        </div>
        
        </div>
      </div>
      </div>
      </div>
    </header>
    <!-- include header -->