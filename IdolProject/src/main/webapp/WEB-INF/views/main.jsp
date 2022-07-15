<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="./include/user_top.jsp" %>
    
    <style>
    
    main{
    position: relative;
    }
    
    #main-bg{
    position: absolute;
    top: 0;
    left:0;
    height: 600px;
    width: 100%;
    transition: all 0.25s;
    transform: translateY(-98px);
    }
      #mainSwiper {
        width: 100%;
        height: 630px;
      }
	 
	 #mainH1{
	 margin-top: 24px;
	 margin-bottom: 40px;
     font-size: 40px;
     font-weight: 700;
     text-align: center;
	 
	 }
	  .item-sec .productSwiper swiper-wrapper swiper-slide{
	  	width: 100%;
	  	heigth: 500px;
	  }
	  
	  #issueSwiper{
	  	width: 100%;
	  	heigth: 500px;
	  }
      .swiper-slide-img-wrap {
        width: 880px;
        height: 575px;
        margin: 0 auto;
      }
      
      .swiper-slide-img-wrap img {
        object-fit: cover;
        height: 100%;
        width: 100%;
      }
 
     
      .swiper-slide img {
        display: block;
        width: 100%;
        height: 100%;
        object-fit: cover;
      }
      
      .swiper-slide-items-wrap{
      width: 230px;
      height: 300px;
      }
      
      .swiper-slide-issue-wrap{
      width: 320px;
      height: 520px;
      }
      
      .swiper-slide-album-wrap{
      width: 350px;
      height: 350px;
      
      }
      .swiper-slide .swiper-slide-items-wrap a img{
       width: 230px;
       height: 250px;
       margin: 25px auto;
       box-sizing: border-box;
       border:0;
      }
      .swiper-slide .swiper-slide-issue-wrap a img{
      width: 320px;
      height: 480px;
      }
      
      .swiper-slide .swiper-slide-album-wrap a img{
      width: 260px;
      height: 260px;
      margin: 0 auto;
      }
      
      .main_section02{
      height: 500px;
      width: 1200px;
      margin: 0 auto;
      }
      
      .main_section03{
      height: 700px;
      width: 1100px;
      margin: 0 auto;
      }
      
      .main_section04{
      height: 700px;
      width: 100%;
      margin: 0 auto;
      background-color: #CCE5FF;
      }
      .albumSwiper{
      width:95%;
      height: 70%;
      }
      .albumSwiper-wrap{
      min-height: 100%;
      margin: 0 auto;
      padding-top: 20px;
      padding-bottom: 40px;
      }
      
      .albumSwiper .swiper-wrapper{
      height: 400px;
      
      }
      
      #view_all{
      text-align: right;
      font-weight: 600;
      color: gray;
      }
      
     .new_album_text{
     text-align: center;
     
     }
     
    .new_album_text span{
     font-size: 16px;
    color: #2d2f43;
    line-height: 25px;
    text-align: center;
    display: block;
    font-weight: 400;
    padding-top: 16px;

     
     }
     
    </style>
    
    <main>
    	<div id="main-bg"></div>
      <!-- Slider main container -->
      <div class="swiper" id="mainSwiper">
        <!-- Additional required wrapper -->
        <div class="swiper-wrapper">
          <!-- Slides -->
          
     		<c:forEach items="${images }" var="dto">
     		<c:if test="${dto.image_visible == 1 }">
     	     <div class="swiper-slide" id="main_img1">
        	    <div class="swiper-slide-img-wrap" >
        	   	<a href="<%=request.getContextPath() %>/${dto.image_link}">
            	  <img
                	src="./resources/upload/images/${dto.getImage_path() }"/></a>
            	</div>
          	 </div>
          	 </c:if>
          </c:forEach>
        </div>
        <!-- If we need pagination -->
        <div class="swiper-pagination"></div>

        
      </div>
    </main>

		
	<!-- product swiper -->
	<div class="main_section02">
		<div class="item-sec">
			<h1 align="center" id="mainH1">New Items</h1>
			<div id="view_all">
   				<a href="<%=request.getContextPath()%>/product_list.do?cno=100"><span>전체보기</span></a>
   			</div>
  	 		<div class="swiper productSwiper">
     			<div class="swiper-wrapper">
	        		<c:forEach items="${plist }" var="pdto">
		     	     	<div class="swiper-slide">
		        	    	<div class="swiper-slide-items-wrap" >
	        	    			<a href="<%=request.getContextPath()%>/product_detail.do?pno=${pdto.product_no}">
	            	  				<img src="./resources/upload/product/${pdto.product_image }"/>
	            	  			</a>
	            	  			<div class="card_overlay">
	            	  				<div class="card_header">
	            	  					<div class="card_header_txt">
	            	  						<a href="<%=request.getContextPath()%>/product_list.do?id=${pdto.product_no}">
	            	  							<span class="card_title">${pdto.product_name }</span>
	            	  						</a>
	            	  						<span class="card_price">?? ${pdto.product_price }
				            	  				<a href="#"><i class="fa-solid fa-cart-shopping"></i></a>
	            	  						</span>
	            	  					</div>
	            	  				</div>
	            	  			</div>
		            		</div>
		          	 	</div>
	          		</c:forEach>
	      		</div>
	      		<div class="swiper-button-next"></div>
	      		<div class="swiper-button-prev"></div>
	      		<div class="swiper-scrollbar"></div>
   			</div>
   		</div>
	</div>
		
	<!-- issue swiper -->
	<c:set var="paging" value="${Paging }"/>
	<c:set var="cid" value="${cid }"/>
	<c:set var="bid" value="${bid }"/>
	<div class="main_section03">
		<div>
			<h1 align="center" id="mainH1">New Issue</h1>
	 		<div class="swiper issueSwiper">
	   			<div class="swiper-wrapper">
	        		<c:forEach items="${elist }" var="edto">
     	     		<div class="swiper-slide" id="main_img1">
        	    		<div class="swiper-slide-issue-wrap" >
        	    			<a href="<%=request.getContextPath()%>/event_cont.do?no=${edto.notice_no}&page=1&category_id=1&board_id=${edto.notice_type=='CELEB'?1:2}">
            	  				<img src="./resources/upload/notice/${edto.notice_image }"/>
            	  			</a>
            			</div>
          			</div>
          			</c:forEach>
        		</div>
        		<!-- If we need pagination -->
        		<div class="swiper-pagination"></div>
      		</div>
		</div>
	</div>


	<div class="main_section04">
		<div class="albumSwiper-wrap">
			<h1 align="center" id="mainH1">New Album</h1>
  	 		<div class="swiper albumSwiper">
     			<div class="swiper-wrapper">
	        		<c:forEach items="${mlist }" var="mdto">
		     	     <div class="swiper-slide">
		        	    <div class="swiper-slide-album-wrap" >
		        	    <a href="<%=request.getContextPath()%>/user_music_content.do?no=${mdto.music_no}">
		            	  <img
		                	src="./resources/upload/music/${mdto.music_coverimage }"/>
		                	
		                	<div class="new_album_text">
		                	<c:if test="${mdto.celeb_name ==null }">
		                		<span>${mdto.group_name }</span>
		                	</c:if>
		                	<c:if test="${mdto.group_name=='solo' }">
		                		<span>${mdto.celeb_name }</span>
		                	</c:if>
		                	<strong>${mdto.music_aname }</strong>
		                	</div>
		                	</a>
		            	</div>
		          	 </div>
		          </c:forEach>
		        </div>
	        	 <!-- If we need pagination -->
				<div class="swiper-scrollbar"></div>
			</div>
		</div>
	</div>
		
  <script>

    const swiper = new Swiper("#mainSwiper", {
   	  slidesPerView: 1,
      spaceBetween: 20,
      loop: true,
      autoplay: {
        delay: 3000,
      },
      // If we need pagination
      pagination: {
        el: ".swiper-pagination",
      },
      // Navigation arrows
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
    });
  	var itemSwiper = new Swiper(".productSwiper", {
        slidesPerView: 4,
        spaceBetween: 20,
        loop: true,
        autoplay: {
            delay: 4000,
          },
        scrollbar: {
            el: ".swiper-scrollbar",
            hide: true,
          },
      
      centeredSlides: true,
    });
  	
  	var issueSwiper = new Swiper(".issueSwiper", {
        slidesPerView: 3,
        spaceBetween: 30,
		loop: true,
        grabCursor: true,
        pagination: {
            el: ".swiper-pagination",
            clickable: true,
          },
    });
  	var albumSwiper = new Swiper(".albumSwiper", {
        slidesPerView: 4,
        spaceBetween: 30,
		loop: true,
        grabCursor: true,
        autoplay: {
            delay: 3000,
          },
        scrollbar: {
            el: ".swiper-scrollbar",
            hide: true,
          },
      
      centeredSlides: true,
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
    });
  	
  	var backSwiper = new Swiper(".bg-swiper",{
  		spaceBetween: 30,
        centeredSlides: true,
        autoplay: {
          delay: 2500,
          disableOnInteraction: false,
        },
        
  	});
  	const mainBG = document.querySelector("#main-bg")
  	const colors = ["#CC99FF", "aqua","#99FFCC", "pink", "#FFFF99", "#A7EEFF"]
  	
  	function changeBackground(activeIndex){
  		const index = Math.floor(Math.random() * colors.length);
  		mainBG.style = "background-color:" + colors[index];

  	}
  	
  	changeBackground(1);
  	
  	swiper.on("slideChange", function(){
  		changeBackground(this.activeIndex);
  	});
  	
  </script>

  <%@include file="./include/user_bottom.jsp" %>