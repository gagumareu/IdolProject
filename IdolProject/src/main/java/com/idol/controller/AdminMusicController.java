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

import com.idol.model.AdminMusicDAO;
import com.idol.model.CelebDTO;
import com.idol.model.GroupDTO;
import com.idol.model.MusicDTO;

@Controller
public class AdminMusicController {

	@Autowired
	private AdminMusicDAO dao;
	
	// 음원 등록 페이지로 가기
	@RequestMapping("admin_music_insert.do")
	public String musicInsert(Model model) {
		
		List<CelebDTO> cList = this.dao.getCelebList();
		
		List<GroupDTO> gList = this.dao.getGroupList();
		
		model.addAttribute("cList", cList);
		
		model.addAttribute("gList", gList);
		
		return "admin/admin_music_insert";
	}
	
	// 음원 등록 okay
	@RequestMapping("admin_music_insertOk.do")
	public void musicInsertOk(MusicDTO dto, 
			HttpServletResponse response, MultipartHttpServletRequest mRequest) throws IOException {
		
		Iterator<String> iterator = mRequest.getFileNames();
		
		String uploadFileName = iterator.next();
		
        List<MultipartFile> fileList = mRequest.getFiles(uploadFileName);
        
        //String src = mRequest.getParameter("src");
        
        //System.out.println("src value : " + src);

        String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\music\\";

        String dbFilesName = "";
        
        System.out.println("===========================");
        
        for (MultipartFile mFile : fileList) {
        	
            String originFileName = mFile.getOriginalFilename(); // 원본 파일 명
                  
            long fileSize = mFile.getSize(); // 파일 사이즈
            
           

            System.out.println("originFileName : " + originFileName);
            
            System.out.println("fileSize : " + fileSize);

            String saveFile = path + System.currentTimeMillis() + originFileName;
            
            dbFilesName += System.currentTimeMillis() + originFileName + "|";
            
            try {
            	
            	mFile.transferTo(new File(saveFile));
       	
            } catch (Exception e) {
               
            } 
        } // for() end 
		
		dto.setMusic_coverimage(dbFilesName);
		
		int check = this.dao.insertMusic(dto);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			out.println("<script>");
			out.println("alert('등록 성공 :)')");
			out.println("location.href='admin_music_list.do'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('등록 실패 :(')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		
	}
	
	// 음원 전체리스트 페이지
	@RequestMapping("admin_music_list.do")
	public String adminMusicList(Model model) {
		
		List<MusicDTO> list = this.dao.getMusicList();
		
		model.addAttribute("musicList", list);
		
		return "admin/admin_music_list";
		
	}
	
	// 음원 상세 정보 페이지 이동
	@RequestMapping("admin_music_content.do")
	public String adminMusicCont(@RequestParam("no") int no, 
			Model model) {
		
		System.out.println("========= music content ==========");
		
		MusicDTO dto = this.dao.getMusicCont(no);
		
		String str = dto.getMusic_coverimage();
		
		System.out.println("str : " + str);
		
		StringTokenizer tokened = new StringTokenizer(str, "|");
		
		String[] arrtokened = new String[tokened.countTokens()];
		
		for(int i = 0; i < arrtokened.length; i++) {
			
			arrtokened[i] = tokened.nextToken();
			
			System.err.println("arrtokened.length : " + arrtokened.length);
			
			System.out.println(arrtokened[i]);
		}
		
		System.out.println("dtocoverimage : " + dto.getMusic_coverimage());
		
		model.addAttribute("arrtokened", arrtokened);
		
		model.addAttribute("musicCont", dto);
		
		return "admin/admin_music_cont";
	}
	
	// 음원 삭제 !
	@RequestMapping("music_delete.do")
	public void musicDelete(@RequestParam("no") int no, @RequestParam("img") String imgs, 
			HttpServletResponse response) throws IOException {
		
		int check = this.dao.deleteMusic(no);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			
			// 이미지도 함께 삭제 하자!
			String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\music\\";
			
			System.out.println("imgs : " + imgs);
			
			StringTokenizer tokenizer = new StringTokenizer(imgs, "|");
			
			String[] tokenList = new String[tokenizer.countTokens()];
			
			for(int i = 0; i < tokenList.length; i++) {
				
				tokenList[i] = tokenizer.nextToken();
				
				System.out.println("tokenList : " + tokenList);
				
				File file = new File(path + tokenList[i]);
				
				file.delete();
			}
			
			this.dao.updateMusicSequen(no);
			
			out.println("<script>");
			out.println("alert('음원 삭제 성공 :)')");
			out.println("location.href='admin_music_list.do'");
			out.println("</script>");
			
		}else {
			
			out.println("<script>");
			out.println("alert('음원 삭제 실패  :(')");
			out.println("history.back()");
			out.println("</script>");
			
		}
		
	}
	
	// 음원 수정 폼 페이지로 이동
	@RequestMapping("music_content.do")
	public String musicModify(Model model, @RequestParam("no") int no) {
		
		System.out.println("music_content.do");
		System.out.println("no: " + no);
		
		MusicDTO dto = this.dao.getMusicCont(no);
		
		String imgs = dto.getMusic_coverimage();
		System.out.println("imgs: " + imgs);

		StringTokenizer tokenizer = new StringTokenizer(imgs, "|");
		System.out.println("tokenizer: " + tokenizer);
		
		String[] arrImgs = new String[tokenizer.countTokens()];
		System.out.println("arrImgs 1: " + arrImgs);

		for(int i = 0; i < arrImgs.length; i++) {
			
			arrImgs[i] = tokenizer.nextToken();
		}
		
		System.out.println("arrImgs 2: " + arrImgs);

		List<CelebDTO> cList = this.dao.getCelebList();
		
		List<GroupDTO> gList = this.dao.getGroupList();
		
		model.addAttribute("cList", cList);
		
		model.addAttribute("gList", gList);
		
		model.addAttribute("arrimgs", arrImgs);
		
		model.addAttribute("musicCont", dto);
		
		return "admin/admin_music_update";
	}
	
	// 음원 정보 수정 (파일 새로 업로드시 이전 파일 삭제 후 저장)
	@RequestMapping("admin_music_update_ok.do")
	public void musicUpdateOk(MultipartHttpServletRequest mRequest, HttpServletResponse response, 
			MusicDTO dto, @RequestParam("oldimgs") String oldOne) throws IOException {
		
		// 파일을 받아서 경로를 정하고 저장하자 !
		String path ="C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\music\\";
		
		System.out.println("======= music update info ==========");
		System.out.println("oldOne : " + oldOne);
		System.out.println("이미지 dto 0 : " + dto.getMusic_coverimage());
		
		Iterator<String> iterator = mRequest.getFileNames();
		
		String uploadFileName = iterator.next();
		
		System.out.println("iterator : " + iterator);
		System.out.println("uploadFileName : " + uploadFileName);
		
		List<MultipartFile> fileList = mRequest.getFiles(uploadFileName);
		
		String dbFilesName = "";
		
		long fileSize = 0;
		
		for (MultipartFile mFile : fileList) {
			
			String originFileName = mFile.getOriginalFilename(); 
			
			fileSize = mFile.getSize();
			
			System.out.println("originFileNmae :" + originFileName);
			System.out.println("fileSize : " + fileSize);
			
			String saveFiles = path + System.currentTimeMillis() + originFileName;
			
			System.out.println("saveFiles :" + saveFiles);
			
			dbFilesName += System.currentTimeMillis() + originFileName + "|";
			
			System.out.println("dbFilesName :" + dbFilesName);
			
			try {
				
				mFile.transferTo(new File(saveFiles));
				
			} catch (Exception e) {
		
			} 
		} // for() end
		
		// 파일 사이즈가 0이여서 폼 태그에서 넘어온 파일이 없음 
		if(fileSize == 0) {
			
			System.out.println("fileSize 0 N oldone :" + oldOne);
			
			dto.setMusic_coverimage(oldOne);
			
			System.out.println("dto :" + dto.getMusic_coverimage());
			
			int check = this.dao.musicUpdate(dto);
			
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			if(check > 0) {
				
				out.println("<script>");
				out.println("alert('음원 수정 성공(old) :) ')");
				out.println("location.href='admin_music_content.do?no="+dto.getMusic_no()+"'");
				out.println("</script>");
				
			}else {
				
				out.println("<script>");
				out.println("alert('음원 수정 실패(old) :( ')");
				out.println("history.back()");
				out.println("</script>");
				
			}
			
			
		}else {             // 파일 새로 업로드 할 경우 
			
			// 기존 이미지 파일들을 삭제 시키자 !!
			StringTokenizer tokenizer = new StringTokenizer(oldOne, "|");
			
			String[] tokenList = new String[tokenizer.countTokens()];
			
			for(int i = 0; i < tokenList.length; i ++) {
				
				tokenList[i] = tokenizer.nextToken();
				
				File file = new File(path + tokenList[i]);
				
				file.delete();
			}
			
			// 저장할 이미지들을 dto에 담기
			
			System.out.println("dbFilesName(addedFiles) :" + dbFilesName);
			
			dto.setMusic_coverimage(dbFilesName);
			
			int check = this.dao.musicUpdate(dto);
			
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			if(check > 0) {
				
				out.println("<script>");
				out.println("alert('음원 수정 성공(new) :) ')");
				out.println("location.href='admin_music_content.do?no="+dto.getMusic_no()+"'");
				out.println("</script>");
				
			}else {
				
				out.println("<script>");
				out.println("alert('음원 수정 실패(new) :( ')");
				out.println("history.back()");
				out.println("</script>");
				
			}

		}
	}
	
	@RequestMapping("admin_album_list.do")
	public String albumList(Model model) {
		
		List<MusicDTO> aList = this.dao.getAlbumList();
		
		model.addAttribute("aList", aList);
		
		return "admin/admin_music_album";
	}
	
	
	
	
	@RequestMapping("admin_music_search.do")
	public String miscSearch(@RequestParam("music_search") String keyword, Model model) {
		
		System.out.println("keyword : " + keyword);
		
		List<MusicDTO> list = this.dao.getMusicSearchList(keyword);
		
		model.addAttribute("musicList", list);
		
		return "admin/admin_music_list";
	}
	
	
	@RequestMapping("admin_musicList_intAlbum.do")
	public String musicListInAlbum(Model model, @RequestParam("aname") String aname) {
		
		List<MusicDTO> mlist = this.dao.getMusicInAlbum(aname);
		
		MusicDTO dto = mlist.get(0);
		
		String img = dto.getMusic_coverimage();
		
		System.out.println("img :" + img);
		
		StringTokenizer tokenizer = new StringTokenizer(img, "|");
		
		System.out.println("tokenizer :" + tokenizer);
		
		String timg = tokenizer.nextToken();
		
		System.out.println("timg : " + timg);
		
		model.addAttribute("mList", mlist);
		
		model.addAttribute("timg", timg);
		
		return "admin/admin_music_inAlbum";
	}
	
	
	
	
}
