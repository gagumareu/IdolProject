/**
 * 
 */

let prd_box = document.getElementsByClassName('prd-box'); // 제품박스
let rowsize = 6; //한번에 보여질 제품 수
let totalRecord = prd_box.length // 전체 제품 수
let allBlock = Math.ceil(totalRecord/rowsize); //리스트 블럭수
let moreBtn = document.querySelector('.main_product_more'); //더보기 버튼
let blockCount = 0; // 보여진 블럭수
let viewProduct = 0; // 보여질 제품수
let shownProduct = 0; // 보여진 제품수

// 처음리스트 출력시 전부 비활성화 한다.
for(let i=0;i<prd_box.length;i++){
    prd_box[i].style.display = 'none';
}
//console.log(prd_box.length); // 전체 제품수
//console.log(allBlock); // 보여질 수 있는 블럭 수

if(totalRecord <= rowsize){
    moreBtn.style.display = 'none';
}

function ClickView(){
    blockCount += 1;
    viewProduct += rowsize;
    if(viewProduct>totalRecord){
        viewProduct = totalRecord;
    }
    for(let i=0;i<viewProduct;i++){
        prd_box[i].style.display = 'block';
        setTimeout(function(){
            prd_box[i].style.opacity = 1;
            prd_box[i].style.transform = 'scale(1)';
          },0);
    }
    if(blockCount == allBlock){
        moreBtn.style.display = 'none';
    }
}

moreBtn.addEventListener('click',ClickView);
ClickView();


let product_list = document.querySelector("#product_list");
let prdBox = document.getElementsByClassName('prd-box');
let prdImgBox = document.getElementsByClassName('prd-img-box');
let prdImg = document.getElementsByClassName('prd-img');
let prdName = document.getElementsByClassName('prd-name');

function changeWidh(){
    let screenWith = document.body.offsetWidth;
    if(screenWith<1750){
        product_list.style.width = '910px';
        for(let i=0;i<prdBox.length;i++){
            prdBox[i].style.width = '260px';
            prdImgBox[i].style.width = '260px';
            prdImg[i].style.width = '260px';
            prdName[i].style.width = '220px';
        }
    }
    else{
        product_list.style.width = '1020px';
        for(let i=0;i<prdBox.length;i++){
            prdBox[i].style.width = '300px';
            prdImgBox[i].style.width = '300px';
            prdImg[i].style.width = '300px';
            prdName[i].style.width = '250px';
        }
 }
}

document.body.onresize = changeWidh;

changeWidh();

/*사이드바 카테고리 show hidden*/
let showBtn = document.getElementsByClassName('fa-chevron-down');
let hiddenBtn = document.getElementsByClassName('fa-chevron-up');
let main_category = document.getElementsByClassName('product_main_category');

/*showBtn clickEvent*/
for(let i=0;i<showBtn.length;i++){
    showBtn[i].addEventListener('click',function(){
        let detail_category = main_category[i].getElementsByClassName('product_detail_category');
        allHidden();
        showBtn[i].style.display = 'none';
        hiddenBtn[i].style.display = 'block';
        for(let j=0;j<detail_category.length;j++){
            detail_category[j].style.display = 'block';
        setTimeout(function(){
            detail_category[j].style.opacity = 1;
            detail_category[j].style.transform = 'scale(1)';
        },0);
        }
    });
}

/*showBtn clickEvent*/
for(let y=0;y<hiddenBtn.length;y++){
    hiddenBtn[y].addEventListener('click',function(){
        allHidden();
    });
}

function allHidden(){
    let category = document.getElementsByClassName('product_detail_category');
    
    for(let x=0;x<category.length;x++){
        category[x].style.opacity = 0;
        category[x].style.transform = 'scale(0)';
        category[x].style.display = 'none';
    }

    for(let z=0;z<showBtn.length;z++){
        showBtn[z].style.display = 'block';
        hiddenBtn[z].style.display = 'none';
    }
}

// 제품의 제고가 없을 경우 리스트 페이지에서 제품이미지를 흐리게 설정하는 이벤트
let prdQty = document.getElementsByClassName('prd-qty');
let prdMainImg = document.getElementsByClassName("prd-img");

for(let i=0;i<prdQty.length;i++){
	if(prdQty[i].value <= 0){
		prdMainImg[i].style.opacity = '0.5';
	}
	
}


/* 리스트 페이지 상단 슬라이더기능*/
/*swiper 기능*/
// 변수 지정
let sliderWrapper = document.getElementsByClassName('slider-container'),//클래스명 container
    sliderContainer = document.getElementsByClassName('slider-innercontainer'), //클래스명 slider-container
    slides = document.getElementsByClassName('slide'), //클래스명 slide
    slideCount = slides.length, //슬라이드의 개수
    currentIndex = 0,
    topHeight = 0,
    navPrev = document.getElementById('prev'), //id prev
    navNext = document.getElementById('next'), // id next
    bullet = document.getElementsByClassName('slider-bullet');

//슬라이드의 높이 확인하여 부모의 높이로 지정하기
function calcuateTallestSlide(){
    /*
        for(시작;끝값(조건);증감){
            실제로 반복할 일
        }
    */
     for(let i=0;i<slideCount;i++){
         if(topHeight<slides[i].offsetHeight){
             topHeight = slides[i].offsetHeight;
         }
        }
    sliderWrapper[0].style.height =  topHeight +'px';
    sliderContainer[0].style.height =  topHeight +'px';
}
calcuateTallestSlide();
    
// 슬라이드가 있으면 가로로 배열하기
for(let i=0;i<slideCount;i++){
    slides[i].style.left = i*100 + '%';
}

// 슬라이드 이동 함수 
function goToSlide(idx){
    sliderContainer[0].classList.add('animated');
    sliderContainer[0].style.left = (idx * -100) + '%';
    currentIndex = idx;
    // bullet 버튼을 기본 스타일로 전부 초기화한다.
    for(let i = 0;i<bullet.length;i++){
        bullet[i].style.border = '1px solid #a7a9b4';
        bullet[i].style.width = '11px';
        bullet[i].style.height = '11px';
        bullet[i].style.background= '#a7a9b4';
        if(i==idx){
            bullet[i].style.border = '0.5px solid gray';
            bullet[i].style.background= 'white';
            bullet[i].style.width = '14px';
            bullet[i].style.height = '14px';
        } 
    }
}



navPrev.addEventListener('click',function(event){
    event.preventDefault();
    //goToSlide(currentIndex-1);
 if(currentIndex > 0){
        goToSlide(currentIndex-1);
    }else{
        goToSlide(slideCount-1);
    }
});

// 버튼을 클릭하면 슬라이드 이동시키기
navNext.addEventListener('click',function(event){
    event.preventDefault();
    if(currentIndex < slideCount-1){
        goToSlide(currentIndex+1);
    }else{
        goToSlide(0);
    }

});

let bulletCount =0;
// bullet 버튼을 클릭하면 슬라이드 이동시키기
for(let i=0;i<bullet.length;i++){
    bullet[i].addEventListener('click',function(){
        goToSlide(i);
        currentIndex = i;
    });
}

// 첫번째 슬라이드 먼저 보이도록 하기
goToSlide(0);

// 슬라이드를 한칸씩 자동으로 이동시키기
setInterval(function(){
    currentIndex += 1;
    if(currentIndex < slideCount-1){
        goToSlide(currentIndex);
    }else{
        currentIndex = 0;
        goToSlide(0);
    }
},5000);


/*리스트페이지 back-toTopBottom 기능*/
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
 
 
 // 장바구니 Ajax 및 장바구니 actionScreen 제어
 let cartImg =  document.getElementsByClassName('prd-cart-img');
 let pno =  document.getElementsByClassName('pno');
 let pimage =  document.getElementsByClassName('pimage');
 
 
 
 
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
 
 
 
 
  function checkCart(index){
  	let result = 0;
  	// Ajax 를 통해 값을 리턴받는경우 기본적으로 비동기 방식이때문에  값이 Undefined 가 return 이됩니다.
 	$.ajax({
		type: "POST",
		url: "product_checkbasket.do",
		async: false,     //값을 리턴시 해당코드를 추가하여 동기로 변경
		data:{
				memno: $('#memno').val(),
				pno : pno[index].value
				},
		datatype: "text",
		success: function(data){
			if(Number(data) == 1){
				result = Number(data);
			}
		},
		error: function(data){
			alert("통신오류다.");
		}
		});
		return result;
 }
 
 
 function addCart(index){
 	$.ajax({
		type: "POST",
		url: "product_addbasket.do",
		data:{
				pno : pno[index].value,
				pqty: 1,
				pimage : pimage[index].value
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
			alert('다시 로그인해 주세요');
 			location.href = 'login.do';
		}
		});
 }
 
  // 장바구니 Ajax
 for(let i = 0; i<cartImg.length;i++){
 	cartImg[i].addEventListener('click',function(){
 	
 		if( $('#memno').val() != ""){
 		if(checkCart(i) == 1){
 			if(confirm('장바구니에 동일한 상품이 존재합니다. 정말로 추가하시겠습니까?')){
 				addCart(i);
 			}
 		}else{
 			addCart(i);
 		}
 		}else{
 			alert('로그인을 먼저 진행해 주세요');
 			location.href = 'login.do';
 		}
 		
 	});
 }
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

