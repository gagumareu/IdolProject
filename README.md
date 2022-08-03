## 개발 목표
k-pop 아이돌 통합 커뮤니티 사이트 [팀 구성원: 5명]
- [메인 페이지 / 팀원 4명]
  - 가수 상세 정보 
  - 회원 전용 커뮤니티 포럼
  - 회원 랭킹 시스템(활동 횟수)
  - 회원 중고거래 포럼
- [관리자 모드 / 본인]
  - 가수, 음원, 이벤트, 공지 등록, 수정, 삭제 모드
  - 회원 정보 상제 조회
  - 회원 1:1 문의 답변


## 사용기술
- 서버 : apache - tomcat - 9.0.11

- Spring Tool Suite 3

- Database : Oracle SQL Developer

- 사용 언어 : Java, HTML, CSS, Javascript, Jquery, JSP, SQL

- 버전 관리 : Git

## 담당 역할
- 관리자 페이지 기능
- 관리자 페이지 CSS


## Advanced Feature
- 이미지 파일 다중 등록
- 다중 파일 수정 시 다중 등록 및 기존 파일 삭제
- 기간 범위 판매내역 리스트 조회


## 개선 사항
- 컨트롤러 통합
- 중복 mapping 정리
- 최적화
- 회원 계정 정리 기능 
- 스크립틀릿 쓰지 않고 if문 대신 c:foreach 문으로 
- 반응형 CSS 

## 시연


### 관리자 모드 로그인 (ID: idolmaster / PWD: 1234)
![관리자로그인](https://user-images.githubusercontent.com/98436199/179349355-576d8427-92e3-466a-a150-81296c6777d4.png)

### 메인페이지
![메인페이지](https://user-images.githubusercontent.com/98436199/179349304-db7bfbe4-a091-4793-8320-fbf9a5042d6a.png)

### 가수 리스트
![가수리스트](https://user-images.githubusercontent.com/98436199/179349371-291cfdc9-60c7-4cde-9e5c-30995071acb1.png)

### 다중파일 등록
![다중등록](https://user-images.githubusercontent.com/98436199/179350966-87b37269-9e36-4c0d-b89d-55dd8ec0d954.png)

### 앨범 리스트
![앨범리스트](https://user-images.githubusercontent.com/98436199/179349389-797ca81b-fb4e-4686-a97b-f50f59968583.png)

### 음원 리스트
![음원리스트2](https://user-images.githubusercontent.com/98436199/179349392-9f77ca0e-8130-497a-95e5-765a7a61ec3c.png)

### 세일즈 관리 모드
- 기간별 판매 리스트 조회
![기간검색2](https://user-images.githubusercontent.com/98436199/179349483-30d0e54b-d8e6-46f5-9463-166deb117706.png)
- 판매리스트 조회 
![기간별구매내역](https://user-images.githubusercontent.com/98436199/179349489-88b43c97-ab34-4141-88f1-0928a607d622.png)
- 주문 번호 리스트
![주문번호_리스트](https://user-images.githubusercontent.com/98436199/179349491-63bf25e9-d981-4197-801d-d8e270c5b4cb.png)
- 회원 구매내역 전체 
![회원별_구매내역](https://user-images.githubusercontent.com/98436199/179349492-344870f7-f8be-41f6-812b-5b695f7de0b5.png)

### 회원 관리
- 회원 리스트
![회원리스트](https://user-images.githubusercontent.com/98436199/179350448-32749822-4b93-4bad-bdd2-14e8fc38aebb.png)
- 회원 정보 조회
![회원_상세내용](https://user-images.githubusercontent.com/98436199/179350463-d72fc76a-1965-4a38-9b35-93d4ef1a25e3.png)
- 회원이 작성한 게시물 조회
![맴버_커뮤니티게시물_리스트](https://user-images.githubusercontent.com/98436199/179350466-89dd7fc3-9dff-4a86-b9f5-34c183d2d838.png)

### 1:1 문의 관리
- 카테고리 별로 1:1 문의 리스트 조회
![문의내용_리스트](https://user-images.githubusercontent.com/98436199/179350570-d5c8eb4d-af7c-45f2-a1e4-878b5bf39db2.png)
- 문의 답변 및 문의 내역 
![문의게시물](https://user-images.githubusercontent.com/98436199/179350592-fdf135a6-8aba-4946-8e0a-51cf8a3b7402.png)



