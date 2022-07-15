	    
	    /*키보드 엔터시 제출되는것을 방지하는 함수 */
	$('input[type="text"]').keydown(function() {
	  if (event.keyCode === 13) {
	    event.preventDefault();
	  };
	});
	    
    
    
    
    /*------------마일리지 사용--------------- */
    
    // 마일리지 input
	let mileageInput = document.getElementById("mileageUseInput");

    //마일리지 전액사용 버튼
    let allUseBtn = document.getElementById("mileageAllUse");
    
    // 상품총금액 input
    let memPrdtotal = document.getElementById("memPrdtotal");
    
    // 회원 마일리지
    let memMileage = document.getElementById("memMileage");
    //총합에서 제외할 마일리지
    let mileageUseAmount = document.getElementById("mileageUseAmount");
    // 마일리지 적용 버튼
    let mileageApply = document.getElementById("mileageApply");

    //상품합계
    let prdTotalAmount =document.getElementById("prdTotalAmount");

    // 배송비
    let prdDeliberyFee = document.getElementById("prdDeliberyFee");
    
    // 총합계
    let totalAmount = document.getElementById("totalAmount");  
    
    // 하단 마일리지 사용금액
    let BmileageUse = document.getElementById("BmileageUse");

    // 하단 최종결제 금액
    let BfinalAmount = document.getElementById("BfinalAmount");

    // console.log();

    //마일리지 전액사용 버튼 click event
    allUseBtn.addEventListener('click',function(){
    
			
            // 마일리지 최대사용금액은 제품의 총금액 + 배송비 를 초과할 수 없음.
            if(Number(memMileage.value) > Number(memPrdtotal.value)+3000){
            	mileageInput.value = Number(memPrdtotal.value)+3000;
            }else{
            	// input에 마일리지 최대금액 표시
        		mileageInput.value = memMileage.value;
            }
            
            // 마일리지 적용금액 표시
            mileageUseAmount.innerText = (mileageInput.value).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");

            // 총합계 계산
            totalAmount.innerText =  (Number(memPrdtotal.value)+3000-Number(mileageInput.value)).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
			
             // 하단 마일리지 적용금액 표시
            BmileageUse.innerText = (mileageInput.value).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");

            // 하단 최종결제금액 계산
            BfinalAmount.innerText =  (Number(memPrdtotal.value)+3000-Number(mileageInput.value)).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
    });
    
    

    // 마일리지 적용 버튼 click event
    mileageApply.addEventListener('click',function(){
    	
        if(Number(mileageInput.value) > Number(memMileage.value)){
            alert('사용가능한 마일리지 금액을 초과하였습니다.');
            // 사용가능한 마일리지 금액을 초과하였을 경우 보유하고 있는 마일리지로 변경
            mileageInput.value = memMileage.value;      
            
        // 마일리지 최대사용금액은 제품의 총금액 + 배송비 를 초과할 수 없음. 
        }else if(Number(mileageInput.value) > Number(memPrdtotal.value)+3000){
        	mileageInput.value = Number(memPrdtotal.value)+3000;
        }
        
        // 마일리지 적용금액 표시
        mileageUseAmount.innerText = (mileageInput.value).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");

        // 총합계 계산
        totalAmount.innerText = (Number(memPrdtotal.value)+3000-Number(mileageInput.value)).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");
        
        
        // 하단 마일리지 적용금액 표시
        BmileageUse.innerText = (mileageInput.value).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");

        // 하단 최종결제금액 계산
        totalAmount.innerText = (Number(memPrdtotal.value)+3000-Number(mileageInput.value)).toString().replace(/\B(?<!\.\d*)(?=(\d{3})+(?!\d))/g, ",");     
    });
    
    

    // 이메일 도메인 입력창
    let emailDomainInput = document.getElementById("oemail2");

    // 이메일 도메인 셀렉트
    let emailDomainSelect = document.getElementById("oemail3");
    
    // 도메인 입력창에 select된 항목을 기입한다.
	emailDomainInput.value = emailDomainSelect.value;
	
    emailDomainSelect.addEventListener('change',function(){
        
        if(emailDomainSelect.value == 'etc'){
            emailDomainInput.value = '';
            emailDomainInput.readOnly = false; 
            
        }else{
            emailDomainInput.value = emailDomainSelect.value;
            emailDomainInput.readOnly = true; 
        }
    });

    /*-------------주문자 정보 주소찾기 API*/
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode1() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode1').value = data.zonecode;
                document.getElementById("sample4_roadAddress1").value = roadAddr;
                document.getElementById("sample4_jibunAddress1").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress1").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress1").value = '';
                }

                var guideTextBox = document.getElementById("guide1");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }




    /*-------------배송 정보------------------------*/
    /*input hidden */
    let memName = document.getElementById("memName");
    let memAddr1 = document.getElementById("memAddr1");
    let memAddr2 = document.getElementById("memAddr2");
    let memAddr3 = document.getElementById("memAddr3");
    let memAddr4 = document.getElementById("memAddr4");
    let memPhone1 = document.getElementById("memPhone1");
    let memPhone2 = document.getElementById("memPhone2");

    /* 배송정보 입력창 */
    // 받는사람
    let dname = document.getElementById("dname");
    //우편번호
    let postcode2 = document.getElementById("sample4_postcode2");
    // 도로명주소
    let roadAddress2 = document.getElementById("sample4_roadAddress2");
    // 지번주소
    let jibunAddress2 = document.getElementById("sample4_jibunAddress2");
    // 상세주소
    let detailAddress2 = document.getElementById("sample4_detailAddress2");
    // 참고항목
    let extraAddress2 = document.getElementById("sample4_extraAddress2");

    // 휴대전화2
    let dphone2 = document.getElementById("dphone2");
    // 휴대전화3
    let dphone3 = document.getElementById("dphone3");

    // 배송지선택 radio btn
    // 주문자 정보와 동일
    let sameaddr0 = document.getElementById("sameaddr0");
    let sameaddr1 = document.getElementById("sameaddr1");

    sameaddr0.addEventListener('click',function(){
        dname.value = memName.value;
        postcode2.value = memAddr1.value;
        roadAddress2.value = memAddr2.value;
        jibunAddress2.value = "";
        detailAddress2.value = memAddr3.value;
        extraAddress2.value = memAddr4.value;
        dphone2.value = memPhone1.value;
        dphone3.value = memPhone2.value;
    });
    // 새로운 배송지
    sameaddr1.addEventListener('click',function(){
        dname.value = "";
        postcode2.value = "";
        roadAddress2.value = "";
        jibunAddress2.value = "";
        detailAddress2.value = "";
        extraAddress2.value = "";
        dphone2.value = "";
        dphone3.value = "";
    });

    /*-------------배송 정보 주소찾기 API------------------------*/
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode2() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode2').value = data.zonecode;
                document.getElementById("sample4_roadAddress2").value = roadAddr;
                document.getElementById("sample4_jibunAddress2").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress2").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress2").value = '';
                }

                var guideTextBox = document.getElementById("guide2");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
    
	/*카드결제 약관 동의*/
	let allcheck = document.getElementById("allClick");
	let agreecheck = document.getElementsByClassName('card_agree_checkbox');
	
	allcheck.addEventListener('click',function(){
		for(let i=0;i<agreecheck.length;i++){
			agreecheck[i].checked = true;
		}
	});
	
	
    /*결제수단 탭 */
    let method = document.querySelector(".method");
    let payKind = method.getElementsByTagName("span");
    let payingMethod = document.getElementsByClassName('payingMethod');

    let payingCardArea = document.querySelector('.payingCardArea');
    let payingEscrow = document.querySelector('.payingEscrow');
    let payingKakao = document.querySelector('.payingKakao');
    let payingPayco = document.querySelector('.payingPayco');
    let payMethod = document.querySelector('#payMethod');
    
    //결제수단 타입값
    let order_type = document.getElementById("order_type");

    function tabClickView(i){
        for(let j = 0; j<payKind.length;j++){
            payKind[j].style.border = '1px solid #d8d9df';
            payKind[j].style.color =  '#919198';
            if(j == i){
                payKind[j].style.border = '2px solid black';
                payKind[j].style.color = 'black';
            }

            if(i==0){
                payingCardArea.style.display = 'block';
                payingEscrow.style.display = 'none';
                payingKakao.style.display = 'none';
                payingPayco.style.display = 'none';
                order_type.value = 1;
                //카드결제시 체크박스의 필수항목 설정.
                for(let i=0;i<agreecheck.length;i++){
					agreecheck[i].required = true;
				}
				payMethod.value="카드결제";
            }else if(i==1){
                payingCardArea.style.display = 'none';
                payingEscrow.style.display = 'block';
                payingKakao.style.display = 'none';
                payingPayco.style.display = 'none';
                order_type.value = 0;
                //카드결제를 제외하고 체크박스의 필수항목 설정을 제거한다.
                for(let i=0;i<agreecheck.length;i++){
					agreecheck[i].required = false;
				}
				payMethod.value="에스크로(실시간 계좌이체)";
            }else if(i==2){
                payingCardArea.style.display = 'none';
                payingEscrow.style.display = 'none';
                payingKakao.style.display = 'block';
                payingPayco.style.display = 'none';
                order_type.value = 0;
                //카드결제를 제외하고 체크박스의 필수항목 설정을 제거한다.
                for(let i=0;i<agreecheck.length;i++){
					agreecheck[i].required = false;
				}
				payMethod.value="카카오페이(간편결제)";
            }else if(i==3){
                payingCardArea.style.display = 'none';
                payingEscrow.style.display = 'none';
                payingKakao.style.display = 'none';
                payingPayco.style.display = 'block';
                order_type.value = 0;
                //카드결제를 제외하고 체크박스의 필수항목 설정을 제거한다.
                for(let i=0;i<agreecheck.length;i++){
					agreecheck[i].required = false;
				}
				payMethod.value="페이코(간편결제)";
            }
        }
    }

    for(let i = 0; i<payKind.length;i++){
        payKind[i].addEventListener('click',function(event){
            tabClickView(i);
        });

    }

    tabClickView(0);
    

    
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
