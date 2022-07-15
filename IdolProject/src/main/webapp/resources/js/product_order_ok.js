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