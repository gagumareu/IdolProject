   /*키보드 엔터시 제출되는것을 방지하는 함수 */
	$('input[type="text"]').keydown(function() {
	  if (event.keyCode === 13) {
	    event.preventDefault();
	  };
	});
	
	
/*  backToTopBottom
* - 변수 지정하기
* - 문서의 높이를 계산하고 원하는 부분이 상단에서 얼마큼 떨어져 있는지 offset 값을 계산하기
* - 스크롤과 클릭 이벤트 작성하기
*/
let btt = document.getElementById("back-to-top"),
btb = document.getElementById("back-to-bottom"),
docElem = document.querySelector("body"),  
offset,
scroPos,
doHeight;
doHeight = Math.max(docElem.offsetHeight,docElem.scrollHeight);
//console.log('문서길이'+doHeight);
scroPos = docElem.scrollTop;
//console.log('스크롤길이길이'+scroPos);
if(doHeight != 0){
offset = doHeight/10;
//console.log('오프셋 길이'+offset);
}

// 스크롤 이벤트 추가
docElem.addEventListener("scroll",function(){
scroPos = docElem.scrollTop;
//console.log('스크롤길이길이 실시간'+scroPos);
btt.className=(scroPos>offset) ? 'visible':'';
btb.className=(scroPos>offset) ? 'visible':'';
});

// top-button클릭 이벤트 추가
btt.addEventListener("click",function(event){
event.preventDefault(); // 링크의 본연의 기능을 막는다.
//console.log(event.defaultPrevented); //Event 인터페이스 의 defaultPrevented 읽기 전용 속성은 Event.preventDefault() 호출 이 이벤트를 취소 했는지 여부를 나타내는 부울 값을 반환합니다 .
docElem.scrollTo({ left: 0, top: 0, behavior: "smooth" });
});

// bottom-button클릭 이벤트 추가
btb.addEventListener("click",function(event){
event.preventDefault(); // 링크의 본연의 기능을 막는다.
//console.log(event.defaultPrevented); //Event 인터페이스 의 defaultPrevented 읽기 전용 속성은 Event.preventDefault() 호출 이 이벤트를 취소 했는지 여부를 나타내는 부울 값을 반환합니다 .
let docElem2 = document.querySelector("body"),   
doHeight2;
doHeight2 = Math.max(docElem2.offsetHeight,docElem2.scrollHeight);

docElem.scrollTo({ left: 0, top: doHeight2, behavior: "smooth" });
});





/* 화면 너비에 따른 비율조정용 */
let leftContainer = document.getElementById('left-container');
function changeWidh(){
    let screenWith = document.body.offsetWidth;
    //console.log(screenWith);
    if(screenWith<1750){
        leftContainer.style.width = '1000px';
    }else{
        leftContainer.style.width = '1200px';
    }
  
}
document.body.onresize = changeWidh;
changeWidh();


/*tap click event*/
let tabContainer = document.getElementById('tab-container');
let tabElements = tabContainer.getElementsByTagName('a');
let tabInfoContainer = document.getElementById('prdInfo-container');
let tabInfo = tabInfoContainer.getElementsByClassName('tab_info');

function tabclick(index){
    for(let j=0;j<tabElements.length;j++){
        tabElements[j].style.borderBottom = 'none';
        tabInfo[j].style.display = 'none';
        if(index == j){
            tabElements[j].style.borderBottom = '1px solid black';
            tabInfo[j].style.display = 'block';
        }
    }
}

for(let i=0;i<tabElements.length;i++){
    tabElements[i].addEventListener("click",function(event){
        event.preventDefault();
        tabclick(i);
    });
}
tabclick(0);



/*right 컨테이너 적립금 마우스 엔터 및 아웃시 적립금 표시*/
let infoMileage = document.querySelector('.info-mileage');
let infoTableTr = infoMileage.getElementsByTagName('tr');
let infoTableDown = infoMileage.getElementsByClassName('fa-chevron-down');
let infoTableUp = infoMileage.getElementsByClassName('fa-chevron-up');

infoMileage.addEventListener('mouseenter',function(){
    infoTableTr[1].style.display = 'table-row';
    infoTableTr[2].style.display = 'table-row';
    infoTableDown[0].style.display = 'none';
    infoTableUp[0].style.display = 'inline-block';
});

infoMileage.addEventListener('mouseleave',function(){
    infoTableTr[1].style.display = 'none';
    infoTableTr[2].style.display = 'none';
    infoTableDown[0].style.display = 'inline-block';
    infoTableUp[0].style.display = 'none';
});


  	// 제품제고소진시 발생이벤트
  	let nowProductQty = document.querySelector('#product_qty');
  	
  	//1. 제품의 메인 이미지의 가 흐리게 변한다.
  	let productMainImage = document.querySelector('#backg-img img');
  	
  	if(nowProductQty.value <= 0){
  		productMainImage.style.opacity = '0.5';
  	}else{
  		productMainImage.style.opacity = '1';
  	}
  	
  	// 2. 제품 제고소진 상태에서 구매버튼 클릭시 모달창으로 알림표시 및 submit 취소
  	
  	function submitCheck(){
  		if(nowProductQty.value <= 0){
  			alert("품절된 상품은 구매가 불가능합니다.");
  			return false;
  		}
  	
  	}
  	
  	
/*수량버튼 클릭시 총합가격 변경 코드 와 현재 재료량에 비교하여 수량선택 제한*/
    const totalPrice = $(".totalPrice");
    const totalPrice2 = $(".totalPrice2");
    const productPrice = $("#product_price").val();
    
    $(".plus").click(function(){
   	const num = $(".numBox").val();
    const plusNum = Number(num) + 1;
    
    if(plusNum > nowProductQty.value) {
     alert('현재 주문 가능한 수량은 '+nowProductQty.value+'개 입니다');
     $(".numBox").val(num);
     $(".totalCount").text(num);
    } else {
     $(".numBox").val(plusNum);
     $(".totalCount").text(plusNum);       
    }
    if(plusNum <= nowProductQty.value){
    totalPrice.text((parseInt(plusNum)*parseInt(productPrice)).toString()
    		  .replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
    totalPrice2.text((parseInt(plusNum)*parseInt(productPrice)).toString()
    .replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
    }   
   });
   
   $(".minus").click(function(){
    const num = $(".numBox").val();
    const minusNum = Number(num) - 1;
    
    if(minusNum <= 0) {
     alert('최소 주문수량은 1개입니다');
     $(".numBox").val(num);
     $(".totalCount").text(num);
    } else {
     $(".numBox").val(minusNum);
     $(".totalCount").text(minusNum);          
    }
    if(minusNum >0){
    totalPrice.text((parseInt(minusNum)*parseInt(productPrice)).toString()
    		  .replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
    totalPrice2.text((parseInt(minusNum)*parseInt(productPrice)).toString()
    .replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ","));
    }
    });
    
    
    
    /*구매버튼 하단 스와이퍼*/
    
    /*스와이퍼 안쪽으로 마우스가 들어나고 나갈때 발생하는 버튼 view이벤트*/
    let swiperBtn = document.querySelector('.swiper-btn');
    let swiperCont = document.querySelector('.swiper-container1');
    
    swiperCont.addEventListener('mouseenter',function(event){
    	swiperBtn.style.display = 'block';
    });
    
    swiperCont.addEventListener('mouseleave',function(event){
    	swiperBtn.style.display = 'none';
    });
    
    swiperBtn.addEventListener('mouseenter',function(event){
    	swiperBtn.style.display = 'block';
    });
    
    swiperBtn.addEventListener('mouseleave',function(event){
    	swiperBtn.style.display = 'none';
    });
    
	const swiper1 = new Swiper('.swiper-container1', {
    //기본 셋팅
    //방향 셋팅 vertical 수직, horizontal 수평 설정이 없으면 수평
    direction: 'horizontal',
    //한번에 보여지는 페이지 숫자
    slidesPerView: 2,
    //페이지와 페이지 사이의 간격
    spaceBetween: 10,
    //드레그 기능 true 사용가능 false 사용불가
    debugger: true,
    //마우스 휠기능 true 사용가능 false 사용불가
    mousewheel: true,
    //반복 기능 true 사용가능 false 사용불가
    loop: true,
    //선택된 슬라이드를 중심으로 true 사용가능 false 사용불가 djqt
    centeredSlides: true,
    // 페이지 전환효과 slidesPerView효과와 같이 사용 불가
    // effect: 'fade',
    
    //자동 스크를링
     autoplay: {
       //시간 1000 이 1초
       delay: 5000,
       disableOnInteraction: false,
      },
    
    //방향표
    navigation: {
      //다음페이지 설정
      nextEl: '.swiper-button-next',
      //이전페이지 설정
      prevEl: '.swiper-button-prev',
    }
    
  	});  
  	
  	
  	
  	
// 장바구니 Ajax 및 장바구니 actionScreen 제어

let pno = document.getElementById('pno');
let pqty = document.getElementById('pqty');
let pimage = document.getElementById('pimage');

  // 장바구니 actionScreen 제어
  // 상단 닫기버튼 클릭
 $('#bclose').click(function(event){
 	event.preventDefault();
 	$('#basketaddContainer').css('display','none');
 });
 
  //쇼핑 계속하기 버튼 클릭
 $('#bcancle').click(function(event){
 	event.preventDefault();
 	$('#basketaddContainer').css('display','none');
 });
 
  //장바구니 이동 버튼 클릭은 페이지에서 제어


// 장바구니 버튼
let cartButton = document.getElementById('cart-button');
let memno = document.getElementById('memno');

// 장바구니 버튼 클릭시 장바구니에 동일한 제품이 있는지 여부 확인
  function checkCart(){
  	let result = 0;
  	// Ajax 를 통해 값을 리턴받는경우 기본적으로 비동기 방식이때문에  값이 Undefined 가 return 이됩니다.
 	$.ajax({
		type: "POST",
		url: "product_checkbasket.do",
		async: false,     //값을 리턴시 해당코드를 추가하여 동기로 변경
		data:{
				memno: memno.value,
				pno : pno.value
				},
		datatype: "text",
		success: function(data){
			if(Number(data) == 1){
				result = Number(data);
			}
		},
		error: function(data){
			alert('다시 로그인해 주세요');
 			location.href = 'login.do';
		}
		});
		return result;
 }
 
 
// 장바구니 버튼 클릭시 Ajax 기능을 통하여 장바구니에 항목 추가
function addCart(){
	$.ajax({
		type: "POST",
		url: "product_addbasket.do",
		data:{
				pno : pno.value,
				pqty: pqty.value,
				pimage : pimage.value
				},
		datatype: "text",
		success: function(data){
			 if(Number(data) == 1){
				$('#basketaddContainer').css('display','block');
				
			}else{
				alert("장바구니 추가 실패!!");
			}
		},
		error: function(data){
			alert("통신오류다.");
		}
		});
}

// 장바구니 버튼 클릭이벤트
cartButton.addEventListener('click',function(){
	if(memno.value != ""){
	if(checkCart() == 1){
 			if(confirm('장바구니에 동일한 상품이 존재합니다. 정말로 추가하시겠습니까?')){
 				addCart();
 			}
 		}else{
 			addCart();
 		}
 	}else{
		alert('로그인을 먼저 진행해 주세요');
		location.href = 'login.do';
 	
 	}
 });
 
 
 function submitCheck(){
 	if(memno.value == ""){
 		alert('로그인을 먼저 진행해 주세요');
 		location.href = 'login.do';
		return false;
 	}
 	
 }





  	
  	
  	
    
    
    
    
    
    
    
    
    