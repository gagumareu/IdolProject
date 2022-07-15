//   header active script
var activeLinks = document.querySelectorAll(".active-link");
var header = document.querySelector("#header");
var body = document.querySelector("body");
var menu = document.querySelector("#menu");

body.addEventListener("scroll", function(event){
	if(event.target.scrollTop > 30){
		header.classList.add("scroll");
	}else{
		header.classList.remove("scroll");
	}
});
	
/**
 * active 될 이전 box id
 * 다른 active-link에 mouseenter를 한 경우 보여주는 box를 구분하기 위해서
 */
var activeBoxId = null;

/**
 * .active-link 에 있는 active class를 모두 제거한다.
 * 모두 제거한뒤 mouseenter 된 target에 active를 다시 적용시켜서 bold 고정 처리
 */
function removeLinkClass() {
  activeLinks.forEach(function (activeLink) {
    activeLink.classList.remove("active");
  });
}

activeLinks.forEach(function (activeLink) {
  activeLink.addEventListener("mouseenter", function (ev) {
    removeLinkClass(); // active 초기화

    header.classList.add("active");
    ev.target.classList.add("active");

    var id = ev.target.id; // a.active-link의 id (self)

    if (activeBoxId === id) return; // 만약 이전 박스와 현재 박스가 같다면 return

    // 기존 active box를 제거하는 부분
    if (activeBoxId !== null && activeBoxId !== id) {
      var boxId = "#" + activeBoxId + "-box";
      var box = document.querySelector(boxId);

      box.classList.remove("active");
    }

    // 새로운 active box를 추가하는 부분
    activeBoxId = id;
    var boxId = "#" + id + "-box"; // #actist-box || #product-box
    var box = document.querySelector(boxId);
    box.classList.add("active");
  });
});

// menu 영역에서 벗어나면 header에 있는 active class를 제거한다.
header.addEventListener("mouseleave", function (ev) {
  removeLinkClass();
  header.classList.remove("active");
});

// artist 부분에서 오른쪽에 나오는 앨범데이터 정보

var albumList = [
  {
    singer: "SHINEE",
    title: "Don't Call Me",
    img: "./resources/upload/group/1655171607721SHINEE_GOURP1.jpg",
  },
  {
    singer: "싸이(PSY)",
    title: "That That (prod. & feat. SUGA of BTS)",
    img: "https://cdnimg.melon.co.kr/cm2/album/images/109/37/474/10937474_20220428225312_500.jpg?cbc115ca0a2db2fed082e94f5862e8bd/melon/resize/282/quality/80/optimize",
  },
  {
    singer: "(여자)아이들",
    title: "TOMBOY",
    img: "https://image.bugsm.co.kr/album/images/200/40724/4072414.jpg?version=20220315063707.0",
  },
  {
    singer: "AESPA",
    title: "Girls",
    img: "./resources/upload/group/1655170280995AESPA_GROUP1.jpg",
  },
  {
    singer: "BTS",
    title: "Yet To Come",
    img: "./resources/upload/group/1655170032483BTS_GROUP1.png",
  },
  {
    singer: "BLACK PINK",
    title: "How You Like That",
    img: "./resources/upload/group/1655183364336BLACKPINK_GROUP1.jpg",
  },
  {
    singer: "RED VELVET",
    title: "Feel My Rhythm",
    img: "https://blog.kakaocdn.net/dn/LRxS3/btrwAZ3RsJZ/GAITCTgusH7LFMFK1qXask/img.png",
  },
  {
    singer: "박재범(JAY PARK)",
    title: "GANADARA (Feat. 아이유)",
    img: "https://image.bugsm.co.kr/album/images/200/40723/4072354.jpg?version=20220312065959.0",
  },
  {
    singer: "STAYC",
    title: "RUN2U",
    img: "./resources/upload/group/1655172037878STAYC_GROUP1.jpg",
  },
  {
    singer: "BEAST",
    title: "DAYDREAM",
    img: "https://image.bugsm.co.kr/album/images/200/40729/4072984.jpg?version=20220322063253.0",
  },
  {
    singer: "IVE",
    title: "LOVE DIVE",
    img: "./resources/upload/group/1655170890582IVE_GROUP1.jpg",
  },
  {
    singer: "LE SSERAFIM",
    title: "FEARLESS",
    img: "https://image.bugsm.co.kr/album/images/200/40751/4075173.jpg?version=20220503063751.0",
  },
];

var artistList = document.querySelectorAll(".artist-menu li a");
var img = document.querySelector("#img");
var title = document.querySelector("#title");
var singer = document.querySelector("#singer");

// artist index를 사용해서 앨범 리스트의 index를 가져와 데이터를 setInfodp 넘겨준다.
artistList.forEach(function (artist, i) {
  artist.addEventListener("mouseenter", function () {
    var data = albumList[i];
    setInfo(data);
  });
});

// set 데이터 함수
function setInfo(data) {
  img.src = data.img;
  title.innerHTML = data.title;
  singer.innerHTML = data.singer;
}

// 최초 1번 랜더링
setInfo(albumList[0]);