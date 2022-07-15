package com.idol.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Savepoint;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.idol.model.AdminNoticeDAO;
import com.idol.model.CelebDTO;
import com.idol.model.GroupDTO;
import com.idol.model.NoticeDTO;

@Controller
public class AdminNoticeController {

	@Autowired
	private AdminNoticeDAO dao;
	
	// 공지 등록 폼 페이지로 이동
	@RequestMapping("admin_notice_insert.do")
	public String insertNotice(Model model) {
		
		List<GroupDTO> gList = this.dao.getGroupList();
		
		List<CelebDTO> cList = this.dao.getCelebList();
		
		model.addAttribute("gList", gList);
		
		model.addAttribute("cList", cList);
		
		return "admin/admin_notice_insert";
	}
	
	@RequestMapping("admin_notice_insert_ok.do")
	public void insertNoticeOk(MultipartHttpServletRequest mRequest, NoticeDTO dto, 
			HttpServletResponse response) throws IOException {
		
		Iterator<String> iterator = mRequest.getFileNames();
		
		String uploadFileName = iterator.next();
		
		List<MultipartFile> fileList = mRequest.getFiles(uploadFileName);
		
		String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\notice\\";
		
		String dbFileName ="";
		
		for(MultipartFile mFile : fileList) {
			
			String originFileName = mFile.getOriginalFilename();
			
			long fileSize = mFile.getSize();
			
			String saveFile = path + System.currentTimeMillis() + originFileName;
			
			dbFileName += System.currentTimeMillis() + originFileName + "|";
			
			try {
				mFile.transferTo(new File(saveFile));
			} catch (Exception e) {
				
			} 
		} // for end
		
		dto.setNotice_image(dbFileName);
		
		System.out.println("admin : " + dto.getAdmin_id());
		System.out.println("title : " + dto.getNotice_title());
		System.out.println("cont : " + dto.getNotice_cont());
		System.out.println("imgs : " + dto.getNotice_image());
		System.out.println("type : " + dto.getNotice_type());
		
		int check = this.dao.insertNotice(dto);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			out.println("<script>");
			out.println("alert('공지 등록 성공 :)')");
			out.println("location.href='admin_notice_list.do'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('공지 등록 실패 :(')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		
	}
	
	// 노티스 전체 리스트 불러오기 (ORDER BY NOTICE_ENDDATE, NOTICE_UPDATE, NOTICE_DATE)
	@RequestMapping("admin_notice_list.do")
	public String getNoticeList(Model model) {
		
		List<NoticeDTO> list = this.dao.getNoticeList();
		
		
		model.addAttribute("noticeList", list);
		
		return "admin/admin_notice_list";
	}
	
	// 노티스 상세 내역 불러오기
	@RequestMapping("admin_notice_content.do")
	public String getNoticeCont(Model model, @RequestParam("no") int no) {
		
		NoticeDTO dto = this.dao.getNoticeContent(no);
		
		String dimg = dto.getNotice_image();
		System.out.println("dimg : " + dimg);

		StringTokenizer tokenizer = new StringTokenizer(dimg, "|");
		
		String[] arrytoken = new String[tokenizer.countTokens()];
		
		for(int i =0; i < arrytoken.length; i++) {
			
			arrytoken[i] = tokenizer.nextToken();
			System.out.println(arrytoken[i]);
		}
			
		model.addAttribute("arrToken", arrytoken);
		
		model.addAttribute("noticeCont", dto);
		
		return "admin/admin_notice_cont";
	}
	
	
	@RequestMapping("admin_notice_delete.do")
	public void deleteNotice(@RequestParam("no") int no, @RequestParam("imgs") String imgs, HttpServletResponse response) throws IOException {
		
		int check = this.dao.deleteNotice(no);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			
			this.dao.updateNoticeSeque(no);
			
			String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\notice\\";
			
			System.out.println("imgs" + imgs);
			
			StringTokenizer tokenizer = new StringTokenizer(imgs, "|");
			
			String[] arrayToken = new String[tokenizer.countTokens()];
			
			for(int i =0; i < arrayToken.length; i++) {
				
				arrayToken[i] = tokenizer.nextToken();
				
				File file = new File(path + arrayToken[i]);
				
				file.delete();
				
			}
			
			out.println("<script>");
			out.println("alert('공지 삭제 완료 :)')");
			out.println("location.href='admin_notice_list.do'");
			out.println("</script>");
			
		}else {
			
			out.println("<script>");
			out.println("alert('공지 삭제 실패 :(')");
			out.println("history.back()");
			out.println("</script>");
			
		}
		
		
	}
	
	// 공지 수정 폼으로 이동
	@RequestMapping("admin_notice_modify.do")
	public String getNoticeModifyForm(@RequestParam("no") int no, Model model) {
		
		NoticeDTO dto = this.dao.getNoticeContent(no);
		
		String dimg = dto.getNotice_image();
		
		StringTokenizer tokenizer = new StringTokenizer(dimg, "|");
		
		String[] arrayToken = new String[tokenizer.countTokens()];
		
		for(int i =0; i < arrayToken.length; i++) {
			
			arrayToken[i] = tokenizer.nextToken();
		}
		
		List<NoticeDTO> nList = this.dao.getNoticeList();

		List<GroupDTO> gList = this.dao.getGroupList();
		
		List<CelebDTO> cList = this.dao.getCelebList();
		
		model.addAttribute("gList", gList);
		
		model.addAttribute("nList", nList);
		
		model.addAttribute("cList", cList);
		
		model.addAttribute("arrayImgs", arrayToken);
		
		model.addAttribute("noticeCont", dto);
		
		
		return "admin/admin_notice_update";
	}
	
	
	@RequestMapping("admin_notice_update_ok.do")
	public void updateNotice(MultipartHttpServletRequest mRequest, NoticeDTO dto, 
			@RequestParam("oldimgs") String oldimgs, HttpServletResponse response) throws IOException {
		
		String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\notice\\";
		
		Iterator<String> iterator = mRequest.getFileNames();
		
		String uploadFileName = iterator.next();
		
		List<MultipartFile> fileList = mRequest.getFiles(uploadFileName);
		
		String dbFileName = "";
		
		long fileSize = 0;
		
		for(MultipartFile mFile : fileList) {
			
			String originlFileName = mFile.getOriginalFilename();
			
			fileSize = mFile.getSize();
			
			String saveFile = path + System.currentTimeMillis() + originlFileName;
			
			dbFileName += System.currentTimeMillis() + originlFileName + "|";
			
			try {
				mFile.transferTo(new File(saveFile));
			} catch (Exception e) {
				
			}
			
		} // for end
		
		// 이미지 수정 파일 첨부 하지 않았을 경우
		if(fileSize == 0) {
			
			dto.setNotice_image(oldimgs);
			
			int check = this.dao.updateNoticeOk(dto);
			
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			if(check> 0) {
				
				out.println("<script>");
				out.println("alert('공지 사항 수정 성공(이미지X) :)')");
				out.println("location.href='admin_notice_content.do?no="+dto.getNotice_no()+"'");
				out.println("</script>");
				
			}else {  
				
				out.println("<script>");
				out.println("alert('공지사항 수정 실패(이미지X) :(')");
				out.println("history.back()");
				out.println("</script>");
			}
			
		
		// 이미지 파일 첨부 했을 경우
		}else {
			
			StringTokenizer tokenizer = new StringTokenizer(oldimgs, "|");
			
			String[] arrayToken = new String[tokenizer.countTokens()];
			
			for(int i =0; i < arrayToken.length; i++) {
				
				arrayToken[i] = tokenizer.nextToken();
				
				File file = new File(path + arrayToken[i]);
				
				file.delete();
			}
			
			
			dto.setNotice_image(dbFileName);
			
			int check = this.dao.updateNoticeOk(dto);
						
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			if(check> 0) {
				
				out.println("<script>");
				out.println("alert('공지 사항 수정 성공(이미지 첨부) :)')");
				out.println("location.href='admin_notice_content.do?no="+dto.getNotice_no()+"'");
				out.println("</script>");
				
			}else {  
				
				out.println("<script>");
				out.println("alert('공지사항 수정 실패(이미지 이미지 첨부) :(')");
				out.println("history.back()");
				out.println("</script>");
			}
			
			
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
}
