package com.idol.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.annotation.processing.FilerException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import com.idol.model.AdminCelebDAO;
import com.idol.model.AdminDTO;
import com.idol.model.CelebDTO;
import com.idol.model.GroupDTO;
import com.idol.model.ImagesDTO;
import com.idol.model.MusicDTO;
import com.idol.model.NoticeDTO;

@Controller
public class AdminCelebController {

	@Autowired
	private AdminCelebDAO dao;
	
	
	// 관리자 로그인 페이지 접속
	@RequestMapping("admin_login.do")
	public String adminLogin() {
		
		return "admin/admin_login";
	}
	
	// 세션 종료 후 메인 페이지 접속 
	@RequestMapping("admin_logout.do")
	public String adminLogout(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		
		session.invalidate();
		
		
		return "redirect:/";
	}
	
	
	// 관리자 메인 페이지 접속
	@RequestMapping("admin_main.do")
	public String adminMain(Model model) {
		
		List<CelebDTO> cList = this.dao.selectCelebList();
		
		List<GroupDTO> gList = this.dao.getGroupList();
		
		List<ImagesDTO> iList = this.dao.getImagesList();
		
		List<MusicDTO> mList = this.dao.getMusicList();
		
		List<NoticeDTO> nList = this.dao.getNoticeList();
		
		
		
		model.addAttribute("iList", iList);
		
		model.addAttribute("mList", mList);
		
		model.addAttribute("nList", nList);
		
		model.addAttribute("cList", cList);
		
		model.addAttribute("gList", gList);
		
		return "admin/admin_main";
	}
	
	// 관리자 로그인 확인 
	@RequestMapping("admin_login_ok.do")
	public void adminLoginOk(@RequestParam("admin_id") String id, 
			@RequestParam("admin_pwd") String pwd, HttpServletResponse response, 
				HttpServletRequest request) throws IOException {
		
		
		
		AdminDTO dto = this.dao.getAdminCont(id);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
		
		
		if(dto.getAdmin_id() != null) {
			
				if(dto.getAdmin_pwd().equals(pwd)) {
				
				session.setAttribute("admin_id", dto.getAdmin_id());
				session.setAttribute("admin_pwd", dto.getAdmin_pwd());
				session.setAttribute("admin_name", dto.getAdmin_name());
				session.setAttribute("admin_email", dto.getAdmin_email());
				session.setAttribute("admin_date", dto.getAdmin_date());
							
				out.println("<script>");
				out.println("alert('로그인 성공 :)')");
				out.println("location.href='admin_main.do'");
				out.println("</script>");
				
			}else {                             // 비밀번호가 틀렸을 경우
				
				out.println("<script>");
				out.println("alert('비밀 번호가 틀립니다 :(')");
				out.println("history.back()");
				out.println("</script>");
				
			}
		}else {
			
			out.println("<script>");
			out.println("alert('아이디가 존재하지 않거나 일치 하지 않습니다 :(')");
			out.println("history.back()");
			out.println("</script>");
			
			
		}
		
	
		
		
	} //adminLoginOk() end 
	
	
	//가수 등록 페이지 접속
	@RequestMapping("admin_celeb_insert.do")
	public String adminCelebInsert(Model model) {
		
		// 가수 전체 리스트 불러오기
		List<CelebDTO> cList = this.dao.selectCelebList();
		// 그룹 이름 리스트 불러오기
		List<GroupDTO> gList =  this.dao.getGroupNameList();
		
		model.addAttribute("celebList", cList);
		
		model.addAttribute("groupList", gList);

		return "admin/admin_celeb_insert";
	}
	
	// 가수 등록 완료
	@RequestMapping("admin_celeb_insert_ok.do")
	public void celebInsertOk(MultipartHttpServletRequest mRequest, CelebDTO dto, HttpServletResponse response) throws IOException {
		
		Iterator<String> iterator = mRequest.getFileNames();
		
		String uploadFileName = iterator.next();
		
        List<MultipartFile> fileList = mRequest.getFiles(uploadFileName);

        String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\celeb\\";

        String dbFileName = "";
        
        for (MultipartFile mFile : fileList) {
        	
            String originFileName = mFile.getOriginalFilename(); // 원본 파일 명
                  
            long fileSize = mFile.getSize(); // 파일 사이즈

            System.out.println("originFileName : " + originFileName);
            
            System.out.println("fileSize : " + fileSize);

            String saveFile = path + System.currentTimeMillis() + originFileName;
            
            dbFileName += System.currentTimeMillis() + originFileName + "|";
            
            try {
            	
            	mFile.transferTo(new File(saveFile));
            	
            	
            	
            } catch (IllegalStateException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        
        // 가수 개인 이미지들 등록
        dto.setCeleb_pimage(dbFileName);
        int check = this.dao.insertCeleb(dto);
        
        response.setContentType("text/html; charset=UTF-8");
        
        PrintWriter out = response.getWriter();
        
        System.out.println("check.val " + check);

        System.out.println("dto name " + dto.getCeleb_name());

        System.out.println("dto no " + dto.getCeleb_no());
        
        if(check > 0) {
        	out.println("<script>");
        	out.println("alert('가수 등록 성공 :)')"); 
        	out.println("location.href='admin_celeb_list.do'");
        	out.println("</script>");
        }else {
        	out.println("<script>");
        	out.println("alert('가수 등록 실패 :(')");
        	out.println("history.back()");
        	out.println("</script>");
        }
        
		
	}
//
//	// 가수 등록 후 해당 가수 상세내역 불러오기 (오른쪽 파트로)
//	@RequestMapping("admin_insertCeleb_next.do")
//	public String insertCelebNext(@RequestParam("name") String celeb_name, Model model) {
//		
//		CelebDTO dto = this.dao.getCelebContByName(celeb_name);
//		
//		model.addAttribute("contByname", dto);
//		
//		String str = dto.getCeleb_pimage();
//				
//		System.out.println("-str : " + str);
//		
//		StringTokenizer tokened = new StringTokenizer(str, "|");
//		
//		String[] arrtokened = new String[tokened.countTokens()];
//		
//		for(int i = 0; i < arrtokened.length; i++) {
//			
//			arrtokened[i] = tokened.nextToken();
//			
//			System.out.println("-arrtokened.length : " + arrtokened.length);
//			
//			System.out.println("-" + arrtokened[i]);
//
//		}
//	
//		model.addAttribute("arrtokened", arrtokened);
//		
//		
//		
//		return "admin/admin_celeb_insert";
//	}
	
	
	
	// 가수 전체 리스트 불러오기 
	@RequestMapping("admin_celeb_list.do")
	public String celebList(Model model) {
		
		List<CelebDTO> list = this.dao.celebList();
		
		
		//************ test  ***************
		String[] imgList = null;
		
		for(int i = 0; i < list.size(); i++) {
			
			CelebDTO dto = list.get(i);
			
			String img = dto.getCeleb_pimage();
			
			StringTokenizer tokenizer = new StringTokenizer(img, "|");
			
			imgList = new String[tokenizer.countTokens()];
			
			for(int j = 0; j < imgList.length; j++) {
				imgList[j] = tokenizer.nextToken();
			}
		}
		
		
		List<GroupDTO> glist = this.dao.getGroupList();
		
		model.addAttribute("celecList", list);
		
		model.addAttribute("groupList", glist);
		
		model.addAttribute("imgList", imgList);
		
		return "admin/admin_celeb_list";
	}
	
	
	
	
	// 가수 상세 정보 페이지 이동 from list
	@RequestMapping("admin_celeb_content.do")
	public String celebContent(@RequestParam("no") int no, Model model) {
		
		CelebDTO dto = this.dao.getCelebContByNo(no);
		
		String str = dto.getCeleb_pimage();
		
		System.out.println("dtogetImg(content) : " + str);
		
		StringTokenizer tokened = new StringTokenizer(str, "|");
		
		String[] arrtokened = new String[tokened.countTokens()];
		
		for(int i = 0; i < arrtokened.length; i++) {
			
			arrtokened[i] = tokened.nextToken();
			
			System.out.println("arrtokened.length : " + arrtokened.length);
			
			System.out.println(arrtokened[i]);

		}
		
		System.out.println("dtoPimages : " + dto.getCeleb_pimage());
		
		String cname = dto.getCeleb_name();
		
		String gname = dto.getCeleb_group();
		
		System.out.println("cname : " + cname);
		
		List<NoticeDTO> cList = this.dao.getCelebNotice(cname);
								
		List<NoticeDTO> gList = this.dao.getGroupNotice(gname);
		
		model.addAttribute("gList", gList);
		
		model.addAttribute("cList", cList);
		
		model.addAttribute("arrtokened", arrtokened);
		
		model.addAttribute("celebContByNo", dto);
		
		
		return "admin/admin_celeb_content";
	}
	
	// 가수 삭제 okay
	@RequestMapping("celeb_delete.do")
	public void celebDelete(@RequestParam("no") int no, 
			@RequestParam("img") String img, HttpServletResponse response) throws IOException {
		
		
		int check = this.dao.deleteCeleb(no);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {

			String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\celeb\\";
		
			System.out.println("img : " + img);
			
			StringTokenizer tokenizer = new StringTokenizer(img, "|");
					
			String[] tokenList = new  String[tokenizer.countTokens()];
			
			for(int i = 0; i < tokenList.length; i ++) {
				
				tokenList[i] = tokenizer.nextToken();
				
				System.out.println("tokenList : " + tokenList);
				
				File file = new File(path + tokenList[i]);
				
				file.delete();
			}
		
			this.dao.updateSequen(no);
			
			out.println("<script>");
			out.println("alert('삭제 성공 :)')");
			out.println("location.href='admin_celeb_list.do'");
			out.println("</script>");
			
		}else {
			
			out.println("<script>");
			out.println("alert('삭제 실패 :(')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		
	} // end of celebDelete()
	
	// 가수 정보 수정 페이지로 가기
	@RequestMapping("admin_celeb_modify.do")
	public String modifyCeleb(@RequestParam("no") int no, Model model) {
		
		CelebDTO dto = this.dao.getCelebContByNo(no);
		
		List<GroupDTO> gList = this.dao.getGroupNameList();
		
		model.addAttribute("celebCont", dto);

		model.addAttribute("gList", gList);
		
		return "admin/admin_celeb_update";
		
	}
	
	// 가수 정보 수정 (파일 새로 업로드 시 이전 파일 삭제 후 저장) 
	@RequestMapping("admin_celeb_modify_ok.do")
	public void celebUpdateOk(MultipartHttpServletRequest mRequest, 
			@RequestParam("originFiles") String paramFiles, CelebDTO dto, 
			HttpServletResponse response) throws IOException {
		
	
		String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\celeb\\";
		  
        System.out.println("===========================");
		System.out.println("paramFiles 0 : " + paramFiles);
		System.out.println("이미지 dto 0 : " + dto.getCeleb_pimage());

		Iterator<String> iterator = mRequest.getFileNames();
		
		String uploadFileName = iterator.next();
		
		System.out.println("iterator : " + iterator);
		System.out.println("uploadFileName : " + uploadFileName);
		System.out.println("uploadFileName.length : " + uploadFileName.length());
		
		List<MultipartFile> fileList = mRequest.getFiles(uploadFileName);

        String dbFilesName = "";
        long fileSize = 0;
        
        for (MultipartFile mFile : fileList) {
        	
            String originFileName = mFile.getOriginalFilename(); // 원본 파일 명

            fileSize = mFile.getSize(); // 파일 사이즈
            
            System.out.println("originFileName : " + originFileName);
            
            System.out.println("fileSize : " + fileSize);


        	String saveFile = path + System.currentTimeMillis() + originFileName;
          
        	System.out.println("saveFile : " + saveFile);

            dbFilesName += System.currentTimeMillis() + originFileName + "|";
            
            System.out.println("dbFilesName : " + dbFilesName);

            try {
            	
            	mFile.transferTo(new File(saveFile));
       	
            } catch (Exception e) {
               
            }
            
        }// for end
        
        System.out.println("paramFiles 0.1 : " + paramFiles);
		System.out.println("이미지 dto 0.1 : " + dto.getCeleb_pimage());
        
        // 이미지 업로드 하지 않음  [파일 사이즈가 0이면 수정할 파일들을 첨부 하지 않음]
		if(fileSize == 0) {
    	
	    	System.out.println("paramFiles imgX : " + paramFiles);
	    	
	    	dto.setCeleb_pimage(paramFiles);
	    	
			System.out.println("이미지 dto (첨부 X) : " + dto.getCeleb_pimage());
			
			int check2 = this.dao.updateCeleb(dto);
			
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out2 = response.getWriter();
			
			if(check2 > 0) {
				
				out2.println("<script>");
				out2.println("alert('수정 성공(이미지X) :)')");
				out2.println("location.href='admin_celeb_content.do?no="+dto.getCeleb_no()+"'");
				out2.println("</script>");
				
			}else {  
				
				out2.println("<script>");
				out2.println("alert('수정 실패(이미지X) :(')");
				out2.println("history.back()");
				out2.println("</script>");
			}
		
		// 수정할 이미지들을 첨부하였음 
		}else {
			
			// 기존 이미지 파일들을 삭제 시키자 !
			StringTokenizer tokenizer = new StringTokenizer(paramFiles, "|");
			
			String[] tokenList = new  String[tokenizer.countTokens()];
			
			for(int i = 0; i < tokenList.length; i ++) {
				
				tokenList[i] = tokenizer.nextToken();
				
				System.out.println("tokenList : " + tokenList);
				
				File file = new File(path + tokenList[i]);
				
				file.delete();
			}
			
			System.out.println("paramFiles imgO : " + paramFiles);

	        // 기존 이미지들 삭제 후 저장할 이미지들을 dto에 담기
	        dto.setCeleb_pimage(dbFilesName);
	        
			System.out.println("dtoNO : " + dto.getCeleb_no());
			
			int check = this.dao.updateCeleb(dto);
			
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			if(check > 0) {
				
				out.println("<script>");
				out.println("alert('수정 성공(이미지 포함) :)')");
				out.println("location.href='admin_celeb_content.do?no="+dto.getCeleb_no()+"'");
				out.println("</script>");
				
			}else {
				
				out.println("<script>");
				out.println("alert('수정 실패(이미지 포함) :(')");
				out.println("history.back()");
				out.println("</script>");
			}
			
	    } // else end
        
		
		
	}
	
	 
	// 그룹 맴버 리스트 페이지로 가기 !(그룹 상세 정보 , 그룸 맴버리스트, 그룹에 관한 notice테이블 정보)
	@RequestMapping("admin_groupMember_list.do")
	public String GroupContent(Model model, @RequestParam("gName") String gName) {
			
		System.out.println("gName : " + gName);
		
		// 그룹에 속한 맴버 리스트 가져오기 
		List<CelebDTO> gList = this.dao.getGroupMemberList(gName);
		
		// 그룹에 관한 노티스 정보 가져오기
		List<NoticeDTO> nlist = this.dao.getGroupNotice(gName);
		
		GroupDTO gdto = this.dao.getGroupCont(gName);
		
		// 그룹 이미지 잘라서 담기 
		GroupDTO dto = this.dao.getGroupCont(gName);

		String str = dto.getGroup_image();
		
		System.out.println("dto img :" + str);
		
		StringTokenizer tokenizer = new StringTokenizer(str, "|");
		
		String[] arrtoken = new String[tokenizer.countTokens()];
		
		for(int i = 0; i < arrtoken.length; i++) {
			
			arrtoken[i] = tokenizer.nextToken();
			
		}
		
		model.addAttribute("arrGourpImg", arrtoken);
		
		model.addAttribute("gmList", gList);
		
		model.addAttribute("nList", nlist);
		
		model.addAttribute("gCont", gdto);
		
		return "admin/admin_group_memberList";
		
	}
	
	
	

	
	@RequestMapping("test.do")
	public String test(Model model) {
		
		String gName = "BLACKPINK";
		
		GroupDTO dto = this.dao.getGroupCont(gName);
		
		String img = dto.getGroup_image();
		
		StringTokenizer str = new StringTokenizer(img, "|");
		
		String[] array = new String[str.countTokens()];
		
		for(int i = 0; i < array.length; i++) {
			array[i] = str.nextToken();
		}
		
		model.addAttribute("arrayGrouImage", array);
		
		model.addAttribute("grouCont", dto);
		
		return "admin/test";
	}
	

	
	
	
	
	
} // AdminController end
