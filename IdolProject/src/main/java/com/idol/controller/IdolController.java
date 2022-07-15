package com.idol.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.idol.model.MemberDAO;
import com.idol.model.MemberDTO;
import com.idol.model.PageDTO;
import com.idol.model.UsedCommentDAO;
import com.idol.model.UsedCommDTO;
import com.idol.model.UsedDAO;
import com.idol.model.UsedDTO;
import com.idol.model.Used_CategoryDTO;

@Controller
public class IdolController {

	@Autowired
	private UsedDAO usedDAO;
	@Autowired
	private UsedCommentDAO usedCommentDAO;
	@Autowired
	private MemberDAO memberDAO;
	
	private final int rowsize = 20;     // 한 페이지당 보여질 게시물의 수
	private int totalRecord = 0;       // DB 상의 전체 게시물의 수
	
	@RequestMapping("used_list.do")
	// 페이징 처리 작업
	public String used_list(HttpServletRequest request, Model model) {
		
		int page;   // 현재 페이지 변수'
		
		HttpSession sesstion = request.getSession();
		
		MemberDTO loginInfo = (MemberDTO)sesstion.getAttribute("loginInfo");
		if(loginInfo != null) {
			model.addAttribute("loginInfo", loginInfo);
		}
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}else {
			page = 1;    // 처음으로 게시물 전체 목록 태그를 선택한 경우
		}
		
		// DB 상의 전체 게시물의 수를 확인하는 메서드 호출
		totalRecord = this.usedDAO.getListCount();
		
		PageDTO dto = new PageDTO(page, rowsize, totalRecord);
		
		// 페이지에 해당하는 게시물을 가져오는 메서드 호출
		List<UsedDTO> list = this.usedDAO.getUsedList(dto);
		
		//이미지 추출하기 
		
		for(int i=0; i<list.size(); i++) {
			if(list.get(i).getUsed_image() != null ) {
			StringTokenizer st = new StringTokenizer(list.get(i).getUsed_image(), "|");
			String image = st.nextToken();
			
			list.get(i).setUsed_image(image);
			}
		}
		
		List<MemberDTO> mdtoList = this.memberDAO.getMemeberList();

		List<UsedCommDTO> commentList = this.usedCommentDAO.getAllCommentList();
		
		model.addAttribute("List", list);
		model.addAttribute("Paging", dto);
		model.addAttribute("mdtoList", mdtoList);
		model.addAttribute("commentList", commentList);
		
		return "board/used_list";
	}
	
	@RequestMapping("used_write.do")
	public String used_write(HttpServletRequest request, Model model) {
		
		// 임시 //
		String id = request.getParameter("id").trim();
		// 임시 //
		
		//중고 카테고리 리스트
		List<Used_CategoryDTO> cdto = this.usedDAO.getUsedCategory();
		
		model.addAttribute("id", id);
		model.addAttribute("Category", cdto);
		
		return "board/used_write";
	}
	
	@RequestMapping("used_write_ok.do")
	   public void used_write_ok(UsedDTO dto,
	         HttpServletResponse response,
	         MultipartHttpServletRequest mRequest, Model model) throws IOException {
	      
	      // 임시 //
//	      String id = mRequest.getParameter("id").trim();
	      // 임시 //
	      
	      String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\used";
	      Iterator<String> iterator = mRequest.getFileNames();
	      String uploadFileName = iterator.next();
	      long filesize = 0;
	      List<MultipartFile> fileList =  mRequest.getFiles(uploadFileName);
	      
	      String dbFileName = "";
	      
	      
	      for(MultipartFile mFile : fileList) {
	         
	         String originFileName = mFile.getOriginalFilename(); // 원본 파일 명
	      
	            
	            String saveFile = System.currentTimeMillis() + originFileName;
	            
	            dbFileName += saveFile + "|";
	         
	            mFile.transferTo(new File(path+"/"+saveFile));
	            
	      }
	      //dto에 파일이름 저장하기 
	      
	      if(filesize == 0) {
	         dbFileName ="";
	      }
	      
	      dto.setUsed_image(dbFileName);
	      
	      int check = this.usedDAO.insertUsed(dto);
	      
	      response.setContentType("text/html; charset=UTF-8");
	      
	      PrintWriter out = response.getWriter();
	      
	      if(check > 0) {
	         out.println("<script>");
	         out.println("location.href='used_list.do'");
	         out.println("</script>");
	      }else {
	         out.println("<script>");
	         out.println("alert('게시글 추가 실패')");
	         out.println("history.back()");
	         out.println("</script>");
	      }
	      
	   }
	
	@RequestMapping("used_content.do")
	public String used_content(@RequestParam("no") int no,
			@RequestParam("id") String id,
			@RequestParam("page") int nowPage, Model model) {
		
		// 조회수를 증가시켜 주는 메서드 호출
		this.usedDAO.readCount(no);
		
		// 게시글 상세 내역을 조회하는 메서드 호출
		UsedDTO dto = this.usedDAO.usedCont(no);
		
		//이미지 분할하여 저장
		List<String> images = new ArrayList<String>();
		
		if(dto.getUsed_image() != null) {
			
			StringTokenizer st = new StringTokenizer(dto.getUsed_image(), "|");
			
			while(st.hasMoreTokens()) {
				
				String str = st.nextToken();
				if(str != null) {
				images.add(str);
				}
				
			}
			
		}
		
		
		// 게시글 댓글 리스트 조회
		List<UsedCommDTO> comment_list = this.usedCommentDAO.getUsedCommentList(no);
		
		List<MemberDTO> mdtoList = this.memberDAO.getMemeberList();
		
		List<UsedCommDTO> allCommentList = this.usedCommentDAO.getAllCommentList();
		
		model.addAttribute("dto", dto);
		model.addAttribute("comment_list", comment_list);
		model.addAttribute("allCommentList", allCommentList);
		model.addAttribute("id", id);
		model.addAttribute("page", nowPage);
		model.addAttribute("Images", images);
		model.addAttribute("mdtoList", mdtoList);
		
		return "board/used_content";
	}
	
	@RequestMapping("used_search.do")
	public String used_search(@RequestParam("field") String field,
			@RequestParam("keyword") String keyword,
			@RequestParam("page") int nowPage, Model model) {
		
		// 검색분류와 검색어에 해당하는 게시글의 수를 DB에서 확인하는 작업
		totalRecord = this.usedDAO.searchBoardCount(field, keyword);
		
		PageDTO pdto = 
				new PageDTO(nowPage, rowsize, totalRecord, field, keyword);
		
		System.out.println("검색 게시물 수 >>> " + pdto.getTotalRecord());
		
		System.out.println("검색 전체 페이지 수 >>> " + pdto.getAllPage());
		
		// 검색 시 한페이지당 보여질 게시물의 수만큼 검색한 게시물을 List로 가져오는 메서드.
		List<UsedDTO> list = this.usedDAO.searchBoardList(pdto);
		
		model.addAttribute("searchPageList", list);
		
		model.addAttribute("Paging", pdto);
		
		return "board/used_search";
		
	}
	
	@RequestMapping("used_comment_write.do")
	public void used_comment_write(UsedCommDTO dto,
			@RequestParam("page") int nowPage,
			HttpSession session,
			HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		int check = this.usedCommentDAO.insertUsedComment(dto);
		
		if(check > 0) {
			out.println("<script>");
			out.println("location.href='used_content.do?no=" + dto.getUsed_nofk() + "&id=" + dto.getComment_writer() + "&page=" + nowPage +"'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('게시글 추가 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
	
	@RequestMapping("used_comment_delete.do")
	public void used_comment_delete(@RequestParam("no") int no,
			@RequestParam("nofk") int used_nofk,
			@RequestParam("id") String id,
			@RequestParam("page") int nowPage,
			HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		int check = this.usedCommentDAO.usedCommentDelete(no);
		
		if(check > 0) {
			out.println("<script>");
			out.println("location.href='used_content.do?no=" + used_nofk + "&id=" + id + "&page=" + nowPage +"'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('댓글 삭제 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
}