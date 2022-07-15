package com.idol.controller;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.idol.model.AdminNoticeDAO;
import com.idol.model.BoardCategoryDAO;
import com.idol.model.BoardCategoryDTO;
import com.idol.model.BoardCommentDAO;
import com.idol.model.BoardCommentDTO;
import com.idol.model.BoardDAO;
import com.idol.model.BoardDTO;
import com.idol.model.BoardRecommendDAO;
import com.idol.model.BoardRecommendDTO;
import com.idol.model.BoardrankingDTO;
import com.idol.model.EventDTO;
import com.idol.model.MemberDAO;
import com.idol.model.MemberDTO;
import com.idol.model.MileageDAO;
import com.idol.model.MileageDTO;
import com.idol.model.NoticeDTO;

@Controller
public class CommunityController {

	@Autowired
	private BoardDAO Boarddao;
	
	@Autowired
	private MemberDAO Memberdao;
	
	@Autowired
	private BoardCategoryDAO BoardCategorydao;
	
	@Autowired
	private MileageDAO Mileagedao;
	
	@Autowired
	private BoardCommentDAO boardCommentdao;
	
	@Autowired
	private BoardRecommendDAO boardRecommenddao;
	
	@Autowired 
	private AdminNoticeDAO Nonicedao;
	
	// 커뮤니티 게시물 전체리스트 페이지로 이동
	@RequestMapping("community_boardList.do")
	public String community_boardList(Model model,HttpServletRequest request) {
		
		// 게시글의 추천수가 10개 이상인 게시글의 리스트를 가져오는 메서드
		List<BoardDTO> bestlist = Boarddao.getBestList();
		
		// 전체 게시글 출력 리스트를 가져옴
		List<BoardDTO> baordlist = Boarddao.getAllBoardList();
		
		// 게시글 카테고리 리스트를 가져옴
		List<BoardCategoryDTO> categorylist = BoardCategorydao.getCategoryList();
		
		// 베스트 게시글 댓글 카운트 리스트
		List<Integer> bestcomcountlist = new ArrayList<Integer>();
		for(int i=0;i<bestlist.size();i++) {
			int commentCount = boardCommentdao.getcommentCount(bestlist.get(i).getCommunity_no());
			bestcomcountlist.add(commentCount);
		}
		
		// 각 토픽리스트 게시물의 갯수를 구한다.
		List<Integer> topicCountList = new ArrayList<Integer>();
		for(int i=0;i<categorylist.size();i++) {
			int count = 0;
			count = Boarddao.getTopicList(categorylist.get(i).getCategory_cno()).size();
			topicCountList.add(count);
		}
		
		
		// 유저 게시물작성 랭킹 리스트
		List<BoardrankingDTO> memRankingList = Boarddao.boardrankingList();
		
		// 가장많은 게시물을 작성한 회원
		MemberDTO topMember = Memberdao.getMemberCont(memRankingList.get(0).getMember_no());
		
		// top1회원의 이미지 구분자 제거
		if(topMember.getMember_cover() != null) {
		StringTokenizer st1 = new StringTokenizer(topMember.getMember_cover(), "|");
		String root1 = st1.nextToken();
		topMember.setMember_cover(root1);
		
		StringTokenizer st2 = new StringTokenizer(topMember.getMember_image(), "|");
		String root2 = st2.nextToken();
		topMember.setMember_image(root2);
		}

		
		model.addAttribute("categoryList", categorylist);
		model.addAttribute("bestList", bestlist);
		model.addAttribute("baordList", baordlist);
		model.addAttribute("bestcomcountList", bestcomcountlist);
		model.addAttribute("topicCountList", topicCountList);
		model.addAttribute("memRankingList", memRankingList);
		model.addAttribute("topMember", topMember);
		
		return "community/community_boardList";
	}
	
	// 커뮤니티 개별주제 리스트 페이지로 이동
	@RequestMapping("community_topicList.do")
	public String community_topicList(Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberDTO loginInfo = null;
		// 세션정보에 로그인정보가 있을 경우 페이지에 로그인정보를 전달
		if(session.getAttribute("loginInfo") != null) {
		loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		session.setAttribute("loginInfo", loginInfo);
		model.addAttribute("loginInfo", loginInfo);
		
		}else {
			System.out.println("세션정보 없음");
		}
		
		
		int cno = Integer.parseInt(request.getParameter("cno").trim());
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		List<MemberDTO> memlist = Memberdao.getMemeberList();
		
		int tabNo = 0;
		// 카테고리 번호가 0으로 넘어온 경우 추천수 10개 이상의 베스트 게시글로 리스트를 받는다.
		if(cno ==0) {
			list = Boarddao.getBestList();
			tabNo = 0;
		}
		// 카테고리 번호가 0이 아닐경우 일반카테고리 주제게시글로 리스트를 받는다.
		else {
			list = Boarddao.getTopicList(cno);
			if(cno == 100) {
				tabNo = 1;
			}else if(cno == 200) {
				tabNo = 2;
			}else if(cno == 300) {
				tabNo = 3;
			}else if(cno == 400) {
				tabNo = 4;
			}
		}
		
		
		List<Integer> imgCountList = new ArrayList<Integer>();
		int imgCount = 0;
		// 게시물 리스트의 이미지가 있다면 첫번째 이미지를 대표이미지로 잘라낸다.
		for(int i=0;i<list.size();i++) {
			imgCount = 0;
			if(list.get(i).getCommunity_image() != null) {
				StringTokenizer st = new StringTokenizer(list.get(i).getCommunity_image(), "|");
				imgCount = st.countTokens();
				String root = st.nextToken();
				list.get(i).setCommunity_image(root);
			}
			imgCountList.add(imgCount);
		}
		
		// 게시글 댓글 카운트 리스트
		List<Integer> comcountlist = new ArrayList<Integer>();
		for(int i=0;i<list.size();i++) {
			int commentCount = boardCommentdao.getcommentCount(list.get(i).getCommunity_no());
			comcountlist.add(commentCount);
		}
		
		// 각 게시물의 회원의 추천여부를 확인할 수 있는 statusList를 생성한다.
		List<Integer> recommentStsList = new ArrayList<Integer>();
		// 초기 추천상태 리스트를 모두 0으로 초기화 해 준다.
		for(int i=0;i<list.size();i++) {
			recommentStsList.add(0); 
		}
		
		// 로그인 정보가 있다면 게시물 리스트를 활용하여 해당 게시물이 추천상태인지를 확인한다.
		if(loginInfo != null) {
			List<BoardRecommendDTO> recommendList = boardRecommenddao.getRecommendList(loginInfo.getMember_no());
			// 게시물 리스트의 게시물번호와 추천상태 리스트의 게시물번호를 비교하여 추천게시물이 있는 경우 추천상태리스트의 값을 1로 변경하여 준다.
			for(int i=0; i<list.size();i++) {
				for(int j=0;j<recommendList.size();j++) {
					if(list.get(i).getCommunity_no() == recommendList.get(j).getCommunity_no()) {
						recommentStsList.set(i, 1);
						break;
					}
				}
			}
		}
		
		model.addAttribute("topicList", list);
		model.addAttribute("memList", memlist);
		model.addAttribute("tabNo", tabNo);
		model.addAttribute("imgCountList", imgCountList);
		model.addAttribute("comcountList", comcountlist);
		model.addAttribute("recommentStsList", recommentStsList);
		
		return "community/community_topicList";
	}
	
	// 커뮤니티 검색 게시물 리스트 페이지로 이동
	@RequestMapping("community_searchList.do")
	public String community_searchList(HttpServletRequest request,Model model) {
		
		HttpSession session = request.getSession();
		MemberDTO loginInfo = null;
		// 세션정보에 로그인정보가 있을 경우 페이지에 로그인정보를 전달
		if(session.getAttribute("loginInfo") != null) {
		loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		session.setAttribute("loginInfo", loginInfo);
		model.addAttribute("loginInfo", loginInfo);
		
		}else {
			System.out.println("세션정보 없음");
		}
		
		String keyword = request.getParameter("search_keyword").trim();
		
		// 검색된 내용을 바탕으로 게시물 리스트를 가져옴
		List<BoardDTO> seatchlist = Boarddao.getSearchList(keyword);
		
		System.out.println("검색 게시물 갯수 :"+seatchlist.size());
		
		// 게시물 작성 회원 이름과 닉네임을 가져오기 위함
		List<MemberDTO> memlist = Memberdao.getMemeberList();
		
		// 검색게시글 댓글 카운트 리스트
		List<Integer> comcountlist = new ArrayList<Integer>();
		for(int i=0;i<seatchlist.size();i++) {
			int commentCount = boardCommentdao.getcommentCount(seatchlist.get(i).getCommunity_no());
			comcountlist.add(commentCount);
		}
		
		// 각 게시물의 회원의 추천여부를 확인할 수 있는 statusList를 생성한다.
		List<Integer> recommentStsList = new ArrayList<Integer>();
		// 초기 추천상태 리스트를 모두 0으로 초기화 해 준다.
		for(int i=0;i<seatchlist.size();i++) {
			recommentStsList.add(0); 
		}
		
		// 로그인 정보가 있다면 게시물 리스트를 활용하여 해당 게시물이 추천상태인지를 확인한다.
		if(loginInfo != null) {
			List<BoardRecommendDTO> recommendList = boardRecommenddao.getRecommendList(loginInfo.getMember_no());
			// 게시물 리스트의 게시물번호와 추천상태 리스트의 게시물번호를 비교하여 추천게시물이 있는 경우 추천상태리스트의 값을 1로 변경하여 준다.
			for(int i=0; i<seatchlist.size();i++) {
				for(int j=0;j<recommendList.size();j++) {
					if(seatchlist.get(i).getCommunity_no() == recommendList.get(j).getCommunity_no()) {
						recommentStsList.set(i, 1);
						break;
					}
				}
			}
		}
		
		model.addAttribute("keyword", keyword);
		model.addAttribute("seatchList", seatchlist);
		model.addAttribute("memList", memlist);
		model.addAttribute("comcountList", comcountlist);
		model.addAttribute("recommentStsList", recommentStsList);
		
		
		return "community/community_searchList";
		
		
	}
	
	
	// 커뮤니티 게시물 작성 페이지로 이동
	@RequestMapping("community_boardwrite.do")
	public String community_boardwrite(HttpServletRequest request,Model model){
		HttpSession session = request.getSession();
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		session.setAttribute("loginInfo", loginInfo);
		
		
		model.addAttribute("loginInfo", loginInfo);
		
		return "community/community_boardWrite";
		
	}
	
	
	@RequestMapping("community_boardwrite_ok.do")
	public String community_boardwrite(MultipartHttpServletRequest mrequest,BoardDTO boarddto, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		session.setAttribute("loginInfo", loginInfo);
		
		
		List<MultipartFile> fileList = mrequest.getFiles("file");
		List<String> testlist = new ArrayList<String>();
		System.out.println("testListSize:"+testlist.size());

        String path = "C:\\NCS\\IdolProject\\IdolProject\\src\\main\\webapp\\resources\\upload\\community\\";
        
        // 등록된 이미지수만큼의 이미지가 반복적으로 저장될 String 변수
        String images = "";
        // 이미지가 저장될 때에는 다른 게시물의 파일과 중복될 경우가 있어 게시물 번호_+파일명으로 파일이 저장된다.
        
        int boardNo = Boarddao.getMaxBoardNo()+1;
        // list에는 파일이 있으나 없으나 무조건 리스트 사이즈가 1이 들어가기 때문에 1번리스트의 파일네임이 있을경우에만 해당 파일저장 로직을 수행한다.
        if(fileList.get(0).getOriginalFilename() != "") {
	        for (MultipartFile mf : fileList) {
	            String originFileName = boardNo+mf.getOriginalFilename(); // 원본 파일 명
	            long fileSize = mf.getSize(); // 파일 사이즈
	            // DB에 저장될 파일들
	            images += originFileName+"|";
	            
	            System.out.println("파일명:"+originFileName);
	            System.out.println("originFileName : " + originFileName);
	            System.out.println("fileSize : " + fileSize);

	            // 파일이 저장될 경로 에는 저장될파일 앞에 게시물 번호를 추가로 기입한다.
	            String safeFile = originFileName;
	            try {
	                mf.transferTo(new File(path+"\\"+safeFile));
	            } catch (Exception e) {
	                // TODO Auto-generated catch block
	                e.printStackTrace();
	            } 
	        }
         //업로드된 이미지를 dto에 저장
        }

        boarddto.setCommunity_image(images);
      
        int result = Boarddao.boardWrite(boarddto);
        
       
        
        if(result>0) {
        	System.out.println("게시물 등록 성공");
        	// 게시물 등록 성공시 게시물 등록 유저에게 20포인트 마일리지 적립
        	// 현재 로그인하고 있는 유저의 마일리지 정보를 받는다.
        	 MileageDTO nowmdto = Mileagedao.getMileageDetail(loginInfo.getMember_no());
        	 
        	 // DB에 새롭게 저장될 마일리지 정보
        	 MileageDTO mdto = new MileageDTO();
        	 mdto.setMileage_memno(loginInfo.getMember_no());
        	 // 기존에 남아있는 마일리지 에 20포인트를 추가한다.
        	 mdto.setMileage_remaining(nowmdto.getMileage_remaining()+20);
        	 // 획득 마일리지
        	 mdto.setMileage_earn(20);
        	 // 차감마일리지는 0이다.
        	 mdto.setMileage_deduction(0);
        	 // 기존 누적 획득금액에서 획득금액을 더한다.
        	 mdto.setMileage_accumulated(nowmdto.getMileage_accumulated()+20);
        	 mdto.setMileage_type("게시글 등록 획득");
        	 int mresult = Mileagedao.insertMileageInfo(mdto);
        	 if(mresult > 0) {
        		 System.out.println("마일리지 등록 성공");
        	 }else {
        		 System.out.println("마일리지 등록 실패");
        	 }
        	 
        	 
        }else {
        	System.out.println("게시물 등록 실패");
        }
        String cno = String.valueOf(boarddto.getCategory_cnofk());
        
        return "redirect:community_topicList.do?cno="+cno;
		
	}
	
	@RequestMapping("community_boardContent.do")
	public String community_boardContent(HttpServletRequest request, Model model){
		
		HttpSession session = request.getSession();
//		MemberDTO temporary = Memberdao.getMemberCont(1);
//		session.setAttribute("loginInfo", temporary);

		// 세션정보에 로그인정보가 있을 경우 페이지에 로그인정보를 전달
		MemberDTO loginInfo = null;
		if(session.getAttribute("loginInfo") != null) {
		loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		session.setAttribute("loginInfo", loginInfo);
		model.addAttribute("loginInfo", loginInfo);
		System.out.println("세션정보 있음");
		}else {
			System.out.println("세션정보 없음");
		}
		
		// get방식으로 게시물 번호를 받는다.
		int bno = Integer.parseInt(request.getParameter("bno").trim());
		
		// 게시물 조회수 업데이트
		Boarddao.boardHitUp(bno);
		
		// 게시물 상세정보		
		BoardDTO boardCont = Boarddao.getboardDetail(bno);
		
		// 게시물정보에 이미지가 있을경우 리스트로 담는다.
		List<String> mlist = new ArrayList<String>();

		if(boardCont.getCommunity_image() != null) {
			StringTokenizer st = new StringTokenizer(boardCont.getCommunity_image(), "|");
			while(st.hasMoreTokens()) {
				String str = st.nextToken();
				if(str != null) {
				mlist.add(str);
				}
			}
		}
		
		// 게시물 카테고리 리스트를 가져옴
		List<BoardCategoryDTO> clist = BoardCategorydao.getCategoryList();
		
		// 작성자 정보: 게시물 상세정보의 유저아이디를 통해 작성자 정보를 가져옴
		MemberDTO writerInfo = Memberdao.getMemInfo(boardCont.getCommunity_userid());	
		
		// 게시물에 대한 댓글리스트
		List<BoardCommentDTO> commentList = boardCommentdao.getCommentList(bno);
		
		// 게시물 댓글 갯수
		int commentCount = commentList.size();
		
		// 게시물 상세페이지에 로그인한 회원이 해당 게시물을 추천하였는지에 대한 여부를 확인한다.
		// 추천한 게시물이 존재하면 1 없으면 을 저장하여 상세페이지로 이동한다.
		int recommendStatus = 0;
		
		// 게시물 상세페이지 진입 이전 로그인한 상태라면  회원이 해당 게시물을 추천 여부를 확인한다.
		if(loginInfo != null) {
			List<BoardRecommendDTO> recommendList = boardRecommenddao.getRecommendList(loginInfo.getMember_no());
			for (int i = 0; i < recommendList.size(); i++) {
				if(recommendList.get(i).getCommunity_no() == bno) {
					recommendStatus = 1;
					break;
				}
			}
		}
		
		// 해당하는 카테고리의 게시물 리스트를 최신날짜와 추천수 순으로 가져온다.
		List<BoardDTO> boardList = Boarddao.boardDateRecommendList(boardCont.getCategory_cnofk());
		
		
		
		model.addAttribute("boardCont", boardCont);
		model.addAttribute("writerInfo", writerInfo);
		model.addAttribute("mList", mlist);
		model.addAttribute("cList", clist);
		model.addAttribute("commentList", commentList);
		model.addAttribute("commentCount", commentCount);
		model.addAttribute("recommendStatus", recommendStatus);
		model.addAttribute("boardList", boardList);
		
		
		return "community/community_boardcontent";
	}
	
	
	// ajax 게시물 삭제이벤트
	@RequestMapping(value="/community_delete.do", method=RequestMethod.POST)
	@ResponseBody
	public String product_cartSelectedDelete(HttpServletRequest request,Model model) {
		
		
		String path = "C:\\NCS\\IdolProject\\IdolProject\\src\\main\\webapp\\resources\\upload\\community";
		String result = "";
		int bno = Integer.parseInt(request.getParameter("bno").trim());
		
		BoardDTO board = Boarddao.getboardDetail(bno);
		
		String images = board.getCommunity_image();
		
		// 게시물 삭제시 이미지도 함께 삭제되어야 한다.
		if(images != null) {
			// 게시물의 이미지가 존재한다면 구분자를 통해 구분한다.
			StringTokenizer st = new StringTokenizer(images, "|");
			while(st.hasMoreTokens()) {
				String fileName = st.nextToken();
				// 구분자 위에값이 널이아니라면 해당 파일의 삭제를 진행한다.
				if(fileName != null) {
					File file = new File(path+"\\"+fileName);
					file.delete();
				}
			}
		}
		// 게시물 삭제시 게시물에 등록된 댓글도 함께 삭제되어야 한다.
		int commentDelResult = boardCommentdao.deleteBoardComment(bno);
		
		if(Boarddao.deleteBoard(bno) > 0) {
			result = "1";
		}
		
		return result;
	}
	
	@RequestMapping("community_boardUpdate.do")
	public String community_update(HttpServletRequest request,Model model) {
				
		HttpSession session = request.getSession();
		
		// 세션정보에 로그인정보가 있을 경우 페이지에 로그인정보를 전달
		if(session.getAttribute("loginInfo") != null) {
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		session.setAttribute("loginInfo", loginInfo);
		model.addAttribute("loginInfo", loginInfo);
		
		}else {
			System.out.println("세션정보 없음");
		}
		
		// get방식으로 게시물 번호를 받는다.
		int bno = Integer.parseInt(request.getParameter("bno").trim());
		
		// 게시물 조회수 업데이트
		Boarddao.boardHitUp(bno);
		
		// 게시물 상세정보		
		BoardDTO boardCont = Boarddao.getboardDetail(bno);
		
		// 게시물정보에 이미지가 있을경우 리스트로 담는다.
		List<String> mlist = new ArrayList<String>();

		if(boardCont.getCommunity_image() != null) {
			StringTokenizer st = new StringTokenizer(boardCont.getCommunity_image(), "|");
			while(st.hasMoreTokens()) {
				String str = st.nextToken();
				if(str != null) {
				mlist.add(str);
				}
			}
		}
		
		// 작성자 정보: 게시물 상세정보의 유저아이디를 통해 작성자 정보를 가져옴
		MemberDTO writerInfo = Memberdao.getMemInfo(boardCont.getCommunity_userid());	
		

		model.addAttribute("boardCont", boardCont);
		model.addAttribute("writerInfo", writerInfo);
		model.addAttribute("mList", mlist);
		
		return "community/community_boardupdate";
	}
	
	
	@RequestMapping("community_boardupdate_ok.do")
	public String community_boardupdate_ok(MultipartHttpServletRequest mrequest,BoardDTO boarddto, HttpServletRequest request) {
		
		int boardNo = Integer.parseInt(request.getParameter("boardNo").trim());
		
		String path = "C:\\NCS\\IdolProject\\IdolProject\\src\\main\\webapp\\resources\\upload\\community";
		
		// 삭제할 이미지 파일명이 ,구분자를 통해 파라메터값으로 들어온다.
		String delimages = request.getParameter("delImages").trim();
		
		// 기존에 저장되어있는 이미지
		String oldimages = Boarddao.getboardDetail(boardNo).getCommunity_image();
		
		// 새로이 저장할 이미지 컬럼
		String newimages = "";
		
		
		//---------------------------이미지 삭제처리로직------------------------------------------
		// 수정폼에서 이미지삭제버튼을 클릭한 경우 delimages에 ,구분자를 통하여 삭제할 파일명이 전달된다.
		if(delimages.equals("") == false) {
			StringTokenizer st = new StringTokenizer(delimages, ",");
			while(st.hasMoreTokens()) {
				String delstr = st.nextToken();
				if(oldimages.indexOf(delstr)>-1) {
					File file = new File(path+"\\"+delstr);
					file.delete();
					oldimages = oldimages.replace(delstr+"|","");
				}
			}
			System.out.println("삭제후 이미지:"+oldimages);
		}else {
			System.out.println("삭제할 이미지가 없습니다.");
		}
		
		// 삭제할 이미지 처리절차 후 새로이 저장할 이미지String에 내용이 저장된다 해당변수에 추가로 저장된 이미지 파일명이 들어간다.
		// 기존이미지를 전부 삭제처리하였다면 빈값이 들어가게 된다.
		newimages = oldimages;
		
		//---------------------------신규 이미지 저장로직------------------------------------------
		List<MultipartFile> fileList = mrequest.getFiles("file");
		
		// 이미지가 저장될 때에는 다른 게시물의 파일과 중복될 경우가 있어 게시물 번호_+파일명으로 파일이 저장된다.
		// 신규이미지를 등록하지 않더라고 리스트사이즈는 1이 들어오기때문에 첫번재 리스트의 파일네임 존재여부를 확인한다. 
		if(fileList.get(0).getOriginalFilename() != "") {
			 for (MultipartFile mf : fileList) {
				String originFileName = boardNo+mf.getOriginalFilename(); // 원본 파일 명
	            long fileSize = mf.getSize(); // 파일 사이즈
	            // DB에 저장될 파일들
	            newimages += originFileName+"|";
	            
	            System.out.println("파일명:"+originFileName);
	            System.out.println("originFileName : " + originFileName);
	            System.out.println("fileSize : " + fileSize);
	            
	            // 파일이 저장될 경로 에는 저장될파일 앞에 게시물 번호를 추가로 기입한다.
	            String safeFile = originFileName;
	            try {
	                mf.transferTo(new File(path+"\\"+safeFile));
	            } catch (Exception e) {
	                // TODO Auto-generated catch block
	                e.printStackTrace();
	            } 
			 }
		}
		System.out.println("최종이미지 저장파일"+newimages);
		
		
		// boardDTO객체에 게시글 번호와 새로운 이미지 파일명을 업데이트해준다. 해당 DTOprameter를 통해 Update Sql문 수행
		boarddto.setCommunity_no(boardNo);
		boarddto.setCommunity_image(newimages);
		
		int result = Boarddao.boardUpdate(boarddto);
		
		if(result >0) {
			System.out.println("게시글 수정 완료");
		}
		
		return "redirect:community_boardContent.do?bno="+boardNo;

	}//community_boardupdate_ok end
	
	
	// 커뮤니티 게시판 댓글 작성
	@RequestMapping("community_commentWrite.do")
	public String community_commentWrite(BoardCommentDTO boardCommentdto) {
		System.out.println(boardCommentdto.getComment_writer());
		System.out.println(boardCommentdto.getCommunity_nofk());
		System.out.println(boardCommentdto.getCategory_cnofk());
		
		int result = boardCommentdao.commentWrite(boardCommentdto);
		
		if(result>0) {
			System.out.println("댓글 등록 성공!");
		}else {
			System.out.println("댓글 등록 실패!");
		}
		
		return "redirect:community_boardContent.do?bno="+boardCommentdto.getCommunity_nofk();
	}
	
	// 커뮤니티 게시판 댓글 답변글(대댓글) 등록
	@RequestMapping("community_replyWrite.do")
	public String community_replyWrite(HttpServletRequest request, BoardCommentDTO boardcommentdto) {
		
		// 댓글에 대한 답글(대댓글)을 달기위해 이전에 달려있던 답글의 순서는 뒤로 미루어 주어야 한다.
		boardCommentdao.updateCommentStep(boardcommentdto.getComment_group(), boardcommentdto.getComment_step());
		
		// 댓글에 대한 답글(대댓글) 의 스텝, 인덴트 설정
		boardcommentdto.setComment_step(boardcommentdto.getComment_step()+1);
		boardcommentdto.setComment_indent(boardcommentdto.getComment_indent()+1);
		
		System.out.println(boardcommentdto.getComment_cont());
		
		// 댓글에 대한 답글등록
		int result = boardCommentdao.replyWrite(boardcommentdto);
		
		if(result>0) {
			System.out.println("대댓글 등록 성공!");
		}else {
			System.out.println("대댓글 등록 실패!");
		}
		
		return "redirect:community_boardContent.do?bno="+boardcommentdto.getCommunity_nofk();
	}
	
	// 커뮤니티 댓글,대댓글 삭제
	@RequestMapping("community_commentDelete.do")
	public String community_commentDelete(HttpServletRequest request) {
		
		int cno = Integer.parseInt(request.getParameter("cno").trim());
		int bno = Integer.parseInt(request.getParameter("bno").trim());
		
		 int result= boardCommentdao.deleteComment(cno);
		
		if(result>0) {
			System.out.println("댓글삭제 성공");
		}else {
			System.out.println("댓글삭제 실패");
		}
		
		return "redirect:community_boardContent.do?bno="+bno;
	}
	
	// 커뮤니티 댓글,대댓글 수정
	@RequestMapping("community_commentUpdate.do")
	public String community_commentUpdate(HttpServletRequest request) {
		String ctext = request.getParameter("ctext").trim();
		int cno = Integer.parseInt(request.getParameter("cno").trim());
		int bno = Integer.parseInt(request.getParameter("bno").trim());
		
		BoardCommentDTO boardCommentdto = new BoardCommentDTO();
		boardCommentdto.setComment_no(cno);
		boardCommentdto.setComment_cont(ctext);
		
		int result = boardCommentdao.updateComment(boardCommentdto);
		
		if(result>0) {
			System.out.println("댓글수정 성공");
		}else {
			System.out.println("댓글수정 실패");
		}
		
		return "redirect:community_boardContent.do?bno="+bno;
	}
	
	// ajax 게시물 추천 이벤트
	@RequestMapping(value="/community_recommend.do", method=RequestMethod.POST)
	@ResponseBody
	public String community_recommend(HttpServletRequest request,Model model) {
		
		int recommendStatus = Integer.parseInt(request.getParameter("recommendStatus").trim());
		int bno = Integer.parseInt(request.getParameter("bno").trim());
		int memno = Integer.parseInt(request.getParameter("memno").trim());
		String result = "";
		
		BoardRecommendDTO recommenddto = new BoardRecommendDTO();
		recommenddto.setMember_no(memno);
		recommenddto.setCommunity_no(bno);
		
		
		// 게시물의 status가 0이면 게시물의 추천수를 증가시키고 recommend 테이블의 정보를 추가한다.
		if(recommendStatus==0) {
			Boarddao.boardRecommendAdd(bno);
			boardRecommenddao.insertRecommend(recommenddto);
			result = "1";
			
		// 게시물의 status가 1이면 게시물의 추천수를 감소시키고 recommend 테이블의 정보를 추가한다.
		}else {
			Boarddao.boardRecommendMinus(bno);
			boardRecommenddao.deleteRecommend(bno);
			result = "0";
		}
		
		return result;
		
	}
	
	
}
