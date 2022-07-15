package com.idol.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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

import com.idol.model.AdminImagesDAO;
import com.idol.model.ImagesDTO;

@Controller
public class AdminImageController {

	@Autowired
	private AdminImagesDAO dao;
	
	// 메인페이지로 이동
	@RequestMapping("admin_main_image.do")
	public String ImageMainPage() {
		return "admin/admin_image_main";
	}
	
	// 이미지 등록 페이지로 이동
	@RequestMapping("admin_image_insert.do")
	public String insertImagePage() {
		return "admin/admin_image_insert";
	}
	
	// 이미지 등록 성공 
	@RequestMapping("admin_insert_image_ok.do")
	public void insertImageOk(ImagesDTO dto, HttpServletResponse response, 
			MultipartHttpServletRequest mRequest) throws IOException {
		
		Iterator<String> iterator = mRequest.getFileNames();
		
		String uploadFileName = iterator.next();
		
        List<MultipartFile> fileList = mRequest.getFiles(uploadFileName);

        String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\images\\";

        String dbFileName = "";
        
        for (MultipartFile mFile : fileList) {
        	
            String originFileName = mFile.getOriginalFilename(); // 원본 파일 명
                  
            long fileSize = mFile.getSize(); // 파일 사이즈

            System.out.println("originFileName : " + originFileName);
            
            System.out.println("fileSize : " + fileSize);

            String saveFile = path + originFileName;
            
            dbFileName += originFileName;
            
            try {
            	
            	mFile.transferTo(new File(saveFile));
            	
            	
            	
            } catch (Exception e) {
                
            } 
        }
		
        dto.setImage_path(dbFileName);
		
		int check = this.dao.insertImage(dto);
		
		System.out.println("check : " + check );
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			
			out.println("<script>");
			out.println("alert('등록 성공 :)')");
			out.println("location.href='admin_images_list.do'");
			out.println("</script>");
			
		}else {
			
			out.println("<script>");
			out.println("alert('등록 실패 :(')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		
	}
	
	// 이미지 전체리스트 불러오기 to main
	@RequestMapping("admin_images_list.do")
	public String imagesList(Model model) {
		
		List<ImagesDTO> list = this.dao.imagesList();
		
		model.addAttribute("imagesList", list);
		
		return "admin/admin_image_main";
		
	}
	
	// 이미지 상세 정보 가져오기
	@RequestMapping("admin_images_content.do")
	public String imagesCont(@RequestParam("no") int no, Model model) {
		
		ImagesDTO dto = this.dao.imagesCont(no);
		
//		String imgs = dto.getImage_path();
		
//		StringTokenizer tokenizer = new StringTokenizer(imgs, "|");
		
//		String[] arrayImgs = new String[tokenizer.countTokens()];
		
//		for(int i =0; i < arrayImgs.length; i++) {
			
//			arrayImgs[i] = tokenizer.nextToken();
//		}
		
//		model.addAttribute("arrayImgs", arrayImgs);
		
		model.addAttribute("imageCont", dto);
		
		return "admin/admin_images_cont";
		
	}
	
	// 이미지 삭제 후 넘버링 재정의 및 이미지 파일 삭제
	@RequestMapping("admin_images_delete.do")
	public void imagesDelete(@RequestParam("no") int no, @RequestParam("imgs") String imgs, HttpServletResponse response) throws IOException {
		
		
		int check = this.dao.imageDelete(no);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			
			
			// 이미지 파일 삭제 시키기
			String path ="C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\images\\";
			
//			StringTokenizer tokenizer = new StringTokenizer(imgs, "|");
			
//			String[] tokenList = new String[tokenizer.countTokens()];
			
//			for(int i = 0; i < tokenList.length; i++) {
				
//				tokenList[i] = tokenizer.nextToken();
				
//				File file = new File(path + tokenList[i]);
				
//				file.delete();
//			}
			
			System.out.println("imgs >>> " + imgs);
			
			File file = new File(path + imgs);
			
			file.delete();
			
			this.dao.imageNoSequen(no);
			
			out.println("<script>");
			out.println("alert('이미지 삭제 성공 :)')");
			out.println("location.href='admin_images_list.do'");
			out.println("</script>");
		}else {
			
			out.println("<script>");
			out.println("alert('이미지 삭제 실패 :(')");
			out.println("history.back()");
			out.println("</script>");
			
		}
		
	}
	
	
	// 이미지 수정 폼 페이지로 가기 
	@RequestMapping("admin_images_modify.do")
	public String imageModify(Model model, @RequestParam("no") int no) {
		
		ImagesDTO dto = this.dao.imagesCont(no);
		
		model.addAttribute("imagesModify", dto);
		
		return "admin/admin_images_modify";
	}
	
	// 이미지 수정 완료 
	@RequestMapping("admin_images_modify_ok.do")
	public void imageModifyOk(ImagesDTO dto, HttpServletResponse response,
			MultipartHttpServletRequest mRequest, @RequestParam("oldPath") String oldPath) throws IOException {
		
		System.out.println("==== updateImage & no ====:" + dto.getImage_no());

		
		String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\images\\";
		
		System.out.println("oldPath : " + oldPath );
		
		Iterator<String> iterator = mRequest.getFileNames();
		
		String uploadFileName =  iterator.next();
		
		System.out.println("uplaodFileName : " + uploadFileName);
		
		List<MultipartFile> fileList = mRequest.getFiles(uploadFileName);
		
		String dbFileName = "";
		long fileSize = 0;
		
		for(MultipartFile mFile : fileList) {
			
			String originFileName = mFile.getOriginalFilename();
			
			fileSize = mFile.getSize();
			
			System.out.println("fileSize : " + fileSize);
			
			String saveFile = path + originFileName;
			
			System.out.println("saveFile :" + saveFile);
			
			dbFileName += originFileName ;
			
			try {
            	
            	mFile.transferTo(new File(saveFile));
       	
            } catch (Exception e) {
               
            }
			
		} // for end
		
		
		// 파일 첨부 하지 않음
		if(fileSize == 0) {
			
			dto.setImage_path(oldPath);
			
			int check = this.dao.imageModifyOk(dto);
			
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			System.out.println("path 1:" + dto.getImage_path());
			System.out.println("link 1:" + dto.getImage_link());
			System.out.println("priorority 1:" + dto.getImage_priority());
			System.out.println("visible 1:" + dto.getImage_visible());
			System.out.println("check  1: " + check);
			
			if(check >0) {
				
				out.println("<script>");
				out.println("alert('수정 성공(이미지수정X) :)')");
				out.println("location.href='admin_images_content.do?no="+dto.getImage_no()+"'");
				out.println("</script>");
			
			}else {
				
				out.println("<script>");
				out.println("alert('수정 실패(이미지수정X) :(')");
				out.println("history.back()");
				out.println("</script>");
				
			}
		
		// 파일 첨부 오케이
		}else {
			
//			StringTokenizer tokenizer = new StringTokenizer(oldPath, "|");
			
//			String[] tokenList = new String[tokenizer.countTokens()];
			
//			for(int i = 0; i < tokenList.length; i++) {
				
//				tokenList[i] = tokenizer.nextToken();
				
//				File file = new File(path + tokenList[i]);
				
//				file.delete();
				
//			}
			
			File file = new File(path + oldPath);
			
			file.delete();
			
			dto.setImage_path(dbFileName);
			
			int check = this.dao.imageModifyOk(dto);
			
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			System.out.println("path 2:" + dto.getImage_path());
			System.out.println("link 2:" + dto.getImage_link());
			System.out.println("priorority 2:" + dto.getImage_priority());
			System.out.println("visible 2:" + dto.getImage_visible());
			System.out.println("check  2: " + check);
			
			if(check >0) {
				
				out.println("<script>");
				out.println("alert('수정 성공(이미지수정) :)')");
				out.println("location.href='admin_images_content.do?no="+dto.getImage_no()+"'");
				out.println("</script>");
			
			}else {
				
				out.println("<script>");
				out.println("alert('수정 실패(이미지수정) :(')");
				out.println("history.back()");
				out.println("</script>");
				
			}
			
			
		}

		
	}
	
	
	
	
	
	
	
}
