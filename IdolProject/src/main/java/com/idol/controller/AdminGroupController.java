package com.idol.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.Response;

import org.apache.commons.fileupload.FileUploadBase.FileSizeLimitExceededException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.idol.model.AdminGroupDAO;
import com.idol.model.CelebDTO;
import com.idol.model.GroupDTO;

@Controller
public class AdminGroupController {
	

	@Autowired
	private AdminGroupDAO dao;
	
	// 그룹 등록 페이지로 이동!
	@RequestMapping("admin_group_insert.do")
	public String insertGroup() {
		
		return "admin/admin_group_insert"; 
	}
	
	// 그룹 등록 완료 !! 후 리스트 페이지로 이동
	@RequestMapping("admin_group_insert_ok.do")
	public void insertGroupOk(GroupDTO dto, HttpServletResponse response, 
			MultipartHttpServletRequest mRequest) throws IOException {
		
		System.out.println("==== gourp insert page =====");
		
		Iterator<String> iterator = mRequest.getFileNames();
		
		String uploadFileName = iterator.next();
		
        List<MultipartFile> fileList = mRequest.getFiles(uploadFileName);

        String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\group\\";

        String dbFileName = "";
        
        long fileSize = 0;
        
        for (MultipartFile mFile : fileList) {
        	
            String originFileName = mFile.getOriginalFilename(); // 원본 파일 명
                  
            fileSize = mFile.getSize(); // 파일 사이즈

            System.out.println("originFileName : " + originFileName);
            
            System.out.println("fileSize : " + fileSize);

            String safeFile = path + System.currentTimeMillis() + originFileName;
            
            dbFileName += System.currentTimeMillis() + originFileName + "|";
            
            try {
            	
            	mFile.transferTo(new File(safeFile));
            	
            	
            	
            } catch (IllegalStateException e) {
                
            }
        }
        
        // 파일 첨부 하지 않을 경우
        if(fileSize == 0) {
        	
       	 	dto.setGroup_image("");

        	 int check = this.dao.insertGroup(dto);
             
             response.setContentType("text/html; charset=UTF-8");
             
             PrintWriter out = response.getWriter();
             
             
             if(check > 0) {
             	out.println("<script>");
             	out.println("alert('그룹 등록 성공 :)')");
             	out.println("location.href='admin_group_list.do'");
             	out.println("</script>");
             }else {
             	out.println("<script>");
             	out.println("alert('실패 :(')");
             	out.println("history.back()");
             	out.println("</script>");
             }
             
        // 파일 첨부 했을 경우 
        }else {
        	
        	 dto.setGroup_image(dbFileName);
             
             int check = this.dao.insertGroup(dto);
             
             response.setContentType("text/html; charset=UTF-8");
             
             PrintWriter out = response.getWriter();
             
             
             if(check > 0) {
             	out.println("<script>");
             	out.println("alert('그룹 등록 성공 :)')");
             	out.println("location.href='admin_group_list.do'");
             	out.println("</script>");
             }else {
             	out.println("<script>");
             	out.println("alert('실패 :(')");
             	out.println("history.back()");
             	out.println("</script>");
             }
        	
        	
        }

	}
	
	// 그룹 리스트 불러오기 
	@RequestMapping("admin_group_list.do")
	public String GroupList(Model model) {
		
		List<GroupDTO> list = this.dao.getGroupList();
		
		List<CelebDTO> slist = this.dao.getSoloList();
		
		model.addAttribute("groupList", list);
		
		model.addAttribute("soloList", slist);
		
		return "admin/admin_group_list";
	}
	
	
	//그룹 정보 수정
	@RequestMapping("admin_group_modify")
	public String groupModify(@RequestParam("no") int no, Model model) {
		
		GroupDTO dto = this.dao.getGroupCont(no);
		
		model.addAttribute("groupCont", dto);
		
		return "admin/admin_group_modify";
		
	}
		
	// 그룹 정보 수정 업데이트 
	@RequestMapping("admin_group_modify_ok.do")
	public void groupModifyOk(GroupDTO dto, @RequestParam("oldImgs") String oldeImgs, 
			MultipartHttpServletRequest mRequest, HttpServletResponse response) throws IOException {
		
		System.out.println("==== group update =====");
		
		String path ="C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\group\\";
		
		System.out.println("oldImgs :" + oldeImgs);
		System.out.println("dtoImgs : " + dto.getGroup_image());
		
		Iterator<String> iterator = mRequest.getFileNames();
		
		String uploadFileName = iterator.next();
		
		System.out.println("uploadFileName : " + uploadFileName);
		
		List<MultipartFile> fileList = mRequest.getFiles(uploadFileName);
		
		String dbFileName = "";
		
		long fileSize = 0;
		
		for(MultipartFile mFile : fileList) {
			
			String originFileName = mFile.getOriginalFilename();
			
			System.out.println("originFileName : " + originFileName);
			
			fileSize = mFile.getSize();
			
			System.out.println("fileSize : " + fileSize);
			
			String saveFile = path + System.currentTimeMillis() + originFileName;
			
			System.out.println("svaFile : " + saveFile);
			
			dbFileName += System.currentTimeMillis() + originFileName + "|";
			
			System.out.println("dbFilName : " + dbFileName);
			
			try {
				
				mFile.transferTo(new File(saveFile));
				
			} catch (Exception e) {
				
			} 
		}// for end 
		
		if(fileSize == 0) {
			
			dto.setGroup_image(oldeImgs);
			
			System.out.println("oldimgs-dto" + dto.getGroup_image());

			int check = this.dao.updateGroup(dto);
			
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			if(check > 0) {
				
				out.println("<script>");
				out.println("alert('그룹 정보 수정 성공 with oldone :)')");
				out.println("location.href='admin_groupMember_list.do?gName="+dto.getGroup_name()+"'");
				out.println("</script>");
				
			}else {
				
				out.println("<script>");
				out.println("alert('그룹 정보 수정 실패 with oldone :(')");
				out.println("history.back()");
				out.println("</script>");
			}
			
			
			
		}else {
			
			// 기존 파일을 삭제 시자!
			StringTokenizer tokenizer = new StringTokenizer(oldeImgs, "|");
			
			String[] tokenList = new String[tokenizer.countTokens()];
			
			for(int i = 0; i < tokenList.length; i++) {
				
				tokenList[i] = tokenizer.nextToken();
				
				File file = new File(path + tokenList[i]);
				
				file.delete();
				
			}
			
			dto.setGroup_image(dbFileName);
			
			System.out.println("dtoImgs(dbFileName) : " + dto.getGroup_image());
			
			int check = this.dao.updateGroup(dto);
			
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			if(check > 0) {
				
				out.println("<script>");
				out.println("alert('그룹 정보 수정 성공 with newone :)')");
				out.println("location.href='admin_groupMember_list.do?gName="+dto.getGroup_name()+"'");
				out.println("</script>");
				
			}else {
				
				out.println("<script>");
				out.println("alert('그룹 정보 수정 실패 with newone :(')");
				out.println("history.back()");
				out.println("</script>");
			}
			
			
			
		}// else end
		
		
	}
		
	// 그룹 삭제 
	@RequestMapping("admin_group_delete.do")
	public void deleteGroup(@RequestParam("no") int no, 
			HttpServletResponse response, @RequestParam("imgs") String imgs) throws IOException {
		
		int check = this.dao.deleteGroup(no);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			
			// 파일도 같이 삭제하기 
			String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\group\\";
			
			System.out.println("imgs : " + imgs);
			
			StringTokenizer tokenizer = new StringTokenizer(imgs, "|");
			
			String[] tokenList = new String[tokenizer.countTokens()];
			
			for(int i = 0; i < tokenList.length; i++) {
				
				tokenList[i] = tokenizer.nextToken();
				
				File file = new File(path + tokenList[i]);
				
				file.delete();
			}
			
			
			this.dao.updateGroupSeque(no);
			
			out.println("<script>");
			out.println("alert('그룹 삭제 성공 :)')");
			out.println("location.href='admin_group_list.do'");
			out.println("</script>");
		}else {
			
			out.println("<script>");
			out.println("alert('그룹 삭제 실패 :(')");
			out.println("history.back()'");
			out.println("</script>");
			
		}
		
	}
	
	
	
	
	
	
	
	
	
}
