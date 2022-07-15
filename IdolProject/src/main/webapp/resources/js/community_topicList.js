
/*탭 메뉴바 선택*/
let tabNo = $('#tabNo').val();

function tabSelect(index){
	$(".tab-menu").eq(index).css("border-bottom","2px solid black")	
							.css("color","black");
}

tabSelect(tabNo);

/게시물 더보기/
let articles = $('.article');
let rowsize = 4; //한번에 보여질 게시물 수
let totalRecord = articles.length // 전체 게시물 수
let allBlock = Math.ceil(totalRecord/rowsize); //리스트 블럭수
let moreBtn = $("#article_more"); // 더보기 버튼
 let blockCount = 0; // 보여진 블럭수
 let viewarticle = 0; // 보여질 게시물 수
 let shownarticle = 0; // 보여진 게시물 수

 for(let i=0;i<articles.length;i++){
 	articles.eq(i).css("display","none");
 }
 
  if(totalRecord <= rowsize){
     moreBtn.css("display","none");
 }
 
  function ClickView(){
     blockCount += 1;
     viewarticle += rowsize;
     if(viewarticle>totalRecord){
         viewarticle = totalRecord;
     }
     for(let i=0;i<viewarticle;i++){
         articles.eq(i).css("display","block");
         setTimeout(function(){
             articles.eq(i).css("opacity",1)
             				.css("transform","scale(1)");
           },0);
     }
     if(blockCount == allBlock){
         moreBtn.css("display","none");
     }
 }
 
 moreBtn.click(ClickView);
 
 ClickView();
 
 
 
 
 
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
offset = doHeight/15;
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

/*글쓰기 버튼 클릭시 로그인 여부를 확인하여 글쓰기 페이지로 이동*/
$('#boardWrite').click(function(){
	
	if($('#memNo').val() != ""){
		location.href='community_boardwrite.do';
	}else{
		Swal.fire({
	  icon: 'error',
	  title: '로그인을 진행해 주세요!.',
	  footer: '<a href="login.do"><로그인 페이지로 이동></a>'
	})
	
	}
	
});



// 제품의 이미지가 있을 경우 요소 크기 조절 및 이미지 갯수에 따른 갯수표시
let ImgTrue = $('.ImgTrue');
for(let j=0;j<ImgTrue.length;j++){
	if(ImgTrue.eq(j).val() != ""){
		$('.title').eq(j).css("padding-right","120px");
		$('.content').eq(j).css("padding-right","120px");
		
	}
}

let imgCount = $('.imgCount');
for(let y=0;y<imgCount.length;y++){
	if(imgCount.eq(y).val() > 1){
		$('.imgBox img').eq(y).css("opacity","0.5");
	}
}

// 회원피드 표시 
for(let i=0;i<$('.user').length;i++){
	$('.user').eq(i).click(function(){
		
		if($('.feed-OnOff').eq(i).val() == 0){
			for(let j=0;j<$('.user').length;j++){
				if(j==i){
					$('.feed-OnOff').eq(j).val(1);
					$('.user-feed').eq(j).css("display","inline-block");
				}else{
					$('.feed-OnOff').eq(j).val(0);
					$('.user-feed').eq(j).css("display","none");
				}
			}
		}else{
			for(let j=0;j<$('.user').length;j++){
					$('.feed-OnOff').eq(j).val(0);
					$('.user-feed').eq(j).css("display","none");
			}
		}

	});
}

// 로그인 상태라면 회원이 추천한 게시물의 추천여부 확인
let recommendStatus = $('.recommendStatus');
for(let i=0;i<recommendStatus.length;i++){
	if(recommendStatus.eq(i).val() == 1){
		$('.fa-thumbs-up').eq(i).css("color","blue");
	}
}

// 로그인한 상태에서 게시물 추천버튼 클릭시 추천이벤트
for(let i=0;i<recommendStatus.length;i++){
	$('.fa-thumbs-up').eq(i).click(function(){
		if($('#loginId').val() != ""){
			$.ajax({
			type: "POST",
			url: "community_recommend.do",
			data:{
					recommendStatus : recommendStatus.eq(i).val(),
					bno:$(".bno").eq(i).val(),
					memno:$("#loginNo").val()
					},
			datatype: "text",
			success: function(data){
				let recommendCount = $('.recommendCount').eq(i).text();
				if(Number(data) == 1){
					recommendStatus.eq(i).val(1);
					$('.fa-thumbs-up').eq(i).css("color","blue")
					.css("opacity","1");
					$('.recommendCount').eq(i).text(Number(recommendCount)+1);
				}else{
					recommendStatus.eq(i).val(0);
					$('.fa-thumbs-up').eq(i).css("color","gray")
					.css("opacity","0.5");
					$('.recommendCount').eq(i).text(Number(recommendCount)-1);
				}
				
			},
			error: function(data){
			  Swal.fire({
			  icon: 'error',
			  title: '통신에러 발생!.',
			  })
			}
			});
		// 로그인이 안되어 있으면 로그인 페이지로 이동 경고창
		}else{
			Swal.fire({
		    icon: 'error',
		    title: '로그인을 진행해 주세요!.',
		    footer: '<a href="login.do"><로그인 페이지로 이동></a>'
		    })
		}
	
	});
}




	


