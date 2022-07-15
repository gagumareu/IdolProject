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

import com.idol.model.AdminProductDAO;
import com.idol.model.CelebDTO;
import com.idol.model.DateRangeDTO;
import com.idol.model.OrderDTO;
import com.idol.model.ProductCategoryDTO;
import com.idol.model.ProductDTO;

@Controller
public class AdminProductController {

	@Autowired
	private AdminProductDAO dao;
	
	// products 리스트 페이지로 가기
	@RequestMapping("admin_products_list.do")
	public String productList(Model model) {
		
		List<ProductDTO> pList = this.dao.getProductList();
		
		model.addAttribute("plist", pList);
		
		
		return "admin/admin_products_list";
		
	}
	
	// 상품 등록페이지 가기 
	@RequestMapping("admin_products_insert.do")
	public String insertProduct(Model model) {
		
		List<CelebDTO> cList = this.dao.getCelebList();
		
		List<ProductCategoryDTO> pcList = this.dao.getProductCategory();
		
		model.addAttribute("cList", cList);
		
		model.addAttribute("pcList", pcList);
		
		return "admin/admin_product_insert";
	}
	
	// 상품 카테고리 등록하기 
	@RequestMapping("admin_productCategory_insert_ok.do")
	public void insertCategory(HttpServletResponse response, ProductCategoryDTO pcdto) throws IOException {
		
		int check = this.dao.insertProductCategory(pcdto);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			
			out.println("<script>");
			out.println("alert('카테고리 생성 완료 :)')");
			out.println("location.href='admin_products_list.do'");
			out.println("</script>");
			
		}else {
			
			out.println("<script>");
			out.println("alert('카테고리 생성 실패 :(')");
			out.println("history.back()");
			out.println("</script>");
			
		}
	}
	
	// 상품 등록 완료
	@RequestMapping("admin_product_insert_ok.do")
	public void productInsertOk(MultipartHttpServletRequest mRequest, HttpServletResponse response, ProductDTO dto) throws IOException {
		
		Iterator<String> iterator = mRequest.getFileNames();
		
		String uploadFileName = iterator.next();
		
        List<MultipartFile> fileList = mRequest.getFiles(uploadFileName);

        String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\product\\";

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
            	
 
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } 
        } // for end
		
        dto.setProduct_image(dbFileName);
        
        int check = this.dao.insertPorduct(dto);
		
        response.setContentType("text/html; charset=UTF-8");
        
        PrintWriter out = response.getWriter();
        
        if(check > 0) {
			
			out.println("<script>");
			out.println("alert('상품 등록 완료 :)')");
			out.println("location.href='admin_products_list.do'");
			out.println("</script>");
			
		}else {
			
			out.println("<script>");
			out.println("alert('상품 등록 실패 :(')");
			out.println("history.back()");
			out.println("</script>");
			
		}
        
	}
	
	// 상품 상세 정보 가져오기
	@RequestMapping("admin_product_content.do")
	public String getProductCont(@RequestParam("no") int no, Model model) {
		
		ProductDTO dto = this.dao.getProductCont(no);
		
		String imgs = dto.getProduct_image();
		
		StringTokenizer tokenizer = new StringTokenizer(imgs, "|");
		
		String[] imgsList = new String[tokenizer.countTokens()];
		
		for(int i = 0; i <imgsList.length; i++) {
			
			imgsList[i] = tokenizer.nextToken();
			
		}
		
		model.addAttribute("imgsList", imgsList);
				
		model.addAttribute("productCont", dto);
		
		return "admin/admin_product_cont";
	}
	
	
	// 상품 업데이트 폼으로 가기
	@RequestMapping("admin_product_update.do")
	public String productUpdateForm(@RequestParam("no") int no, Model model) {
		
		List<CelebDTO> clist = this.dao.getCelebList();
		
		List<ProductCategoryDTO> pclist = this.dao.getProductCategory();
		
		ProductDTO dto = this.dao.getProductCont(no);
		
		String imgs = dto.getProduct_image();
		
		StringTokenizer tokenizer = new StringTokenizer(imgs, "|");
		
		String[] imgsList = new String[tokenizer.countTokens()];
		
		for(int i = 0; i <imgsList.length; i++) {
			
			imgsList[i] = tokenizer.nextToken();
			
		}
		
		model.addAttribute("imgsList", imgsList);
				
		model.addAttribute("productCont", dto);
		
		model.addAttribute("cList", clist);
		
		model.addAttribute("cpList", pclist);
		
		return "admin/admin_product_update";
	}
	
	
	// 상품 삭제하기 
	@RequestMapping("admin_product_delete.do")
	public void deleteProduct(@RequestParam("no") int no, 
			@RequestParam("imgs") String imgs, HttpServletResponse response) throws IOException {
		
		int check = this.dao.deleteProduct(no);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {

			String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\product\\";
		
			System.out.println("img : " + imgs);
			
			StringTokenizer tokenizer = new StringTokenizer(imgs, "|");
					
			String[] tokenList = new  String[tokenizer.countTokens()];
			
			for(int i = 0; i < tokenList.length; i ++) {
				
				tokenList[i] = tokenizer.nextToken();
				
				System.out.println("tokenList : " + tokenList);
				
				File file = new File(path + tokenList[i]);
				
				file.delete();
			}
		
			this.dao.updateProductSequen(no);
			
			out.println("<script>");
			out.println("alert('상품 삭제 성공 :)')");
			out.println("location.href='admin_products_list.do'");
			out.println("</script>");
			
		}else {
			
			out.println("<script>");
			out.println("alert('상품 삭제 실패 :(')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		
	}
	
	// 상품 수정 
	@RequestMapping("admin_product_update_ok.do")
	public void productUpdateOk(MultipartHttpServletRequest mRequest, ProductDTO dto, 
			HttpServletResponse response, @RequestParam("oldImgs") String oldImgs) throws IOException {
		
		String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\product\\";
		  
        System.out.println("===========================");
		System.out.println("paramFiles 0 : " + oldImgs);
		System.out.println("이미지 dto 0 : " + dto.getProduct_image());

		Iterator<String> iterator = mRequest.getFileNames();
		
		String uploadFileName = iterator.next();
		
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
        
        System.out.println("paramFiles 0.1 : " + oldImgs);
		System.out.println("이미지 dto 0.1 : " + dto.getProduct_image());
        
        // 이미지 업로드 하지 않음  [파일 사이즈가 0이면 수정할 파일들을 첨부 하지 않음]
		if(fileSize == 0) {
    		    	
	    	dto.setProduct_image(oldImgs);;
	    	
			System.out.println("이미지 dto (첨부 X) : " + dto.getProduct_image());
			
			int check2 = this.dao.updateProduct(dto);
			
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out2 = response.getWriter();
			
			if(check2 > 0) {
				
				out2.println("<script>");
				out2.println("alert('수정 성공(이미지X) :)')");
				out2.println("location.href='admin_product_content.do?no="+dto.getProduct_no()+"'");
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
			StringTokenizer tokenizer = new StringTokenizer(oldImgs, "|");
			
			String[] tokenList = new  String[tokenizer.countTokens()];
			
			for(int i = 0; i < tokenList.length; i ++) {
				
				tokenList[i] = tokenizer.nextToken();
				
				System.out.println("tokenList : " + tokenList);
				
				File file = new File(path + tokenList[i]);
				
				file.delete();
			}
			
			System.out.println("paramFiles imgO : " + oldImgs);

	        // 기존 이미지들 삭제 후 저장할 이미지들을 dto에 담기
	        dto.setProduct_image(dbFilesName);
	        
			System.out.println("dtoNO : " + dto.getCeleb_no());
			
			int check = this.dao.updateProduct(dto);
			
			response.setContentType("text/html; charset=UTF-8");
			
			PrintWriter out = response.getWriter();
			
			if(check > 0) {
				
				out.println("<script>");
				out.println("alert('수정 성공(이미지 포함) :)')");
				out.println("location.href='admin_product_content.do?no="+dto.getProduct_no()+"'");
				out.println("</script>");
				
			}else {
				
				out.println("<script>");
				out.println("alert('수정 실패(이미지 포함) :(')");
				out.println("history.back()");
				out.println("</script>");
			}
			
	    } // else end
        
		
	}
	
	// 판매 관리 페이지로 가기
	@RequestMapping("admin_products_management.do")
	public String productManagement(Model model) {
		
		List<OrderDTO> oList = this.dao.getOrderList();
		
		model.addAttribute("oList", oList);
		
		return "admin/admin_order_management";
	}
	
	// 주문 제품 하나 상세 내역
	@RequestMapping("admin_order_productCont.do")
	public String orderCont(Model model, @RequestParam("no") int no) {
		
		OrderDTO dto = this.dao.getOrderCont(no);
		
		String address = dto.getOrder_receiveraddress();
		
		StringTokenizer addrToken = new StringTokenizer(address, "|");
		
		String[] addrArray = new String[addrToken.countTokens()];
		
		for(int i = 0; i < addrArray.length; i++) {
			addrArray[i] = addrToken.nextToken();
		}
		
		model.addAttribute("address", addrArray);
	
		model.addAttribute("orderCont", dto);
		
		
		return "admin/admin_order_cont";
		
		
	}
	
	
	// 그룹 번호로 판매 내역 조회 (그룹 번호 = 주문번호)
	@RequestMapping("admin_order_groupCont.do")
	public String getOrderGroupList(Model model, @RequestParam("no") int no) {
		
		// orderGroup list 불러오기 by no
		List<OrderDTO> oList = this.dao.getOrderContList(no);
		
		System.out.println("=== product cont img list ===");
		
		String[] addrArray = null;

		for(int i = 0; i < oList.size(); i++) {
		
			OrderDTO odto = oList.get(i);
			
			String addr = odto.getOrder_receiveraddress();
			
			System.out.println("addr : " + addr);
			
			StringTokenizer tokenizer2 = new StringTokenizer(addr, "|");
			
			addrArray = new String[tokenizer2.countTokens()];
			
			for(int j = 0; j < addrArray.length; j++) {
				
				addrArray[j] = tokenizer2.nextToken();
				
				System.out.println("addrArray :" + addrArray[j]);
			}
		}
		
		
		
		
		// 사진리스트 [잘 안됌]
		model.addAttribute("addrArray", addrArray);
		
		// orderGroup list 불러오기 by no 
		model.addAttribute("oList", oList);
		
		
		return "admin/admin_order_group";
	}
	
	// 맴버 클릭시 구매내역 불러오기
	@RequestMapping("admin_memeber_purchaseInfo.do")
	public String getMemberPurchaseInfo(@RequestParam("name") String name, Model model) {
		
		List<OrderDTO> list = this.dao.getMemberPurchaseInfo(name);	
		
		model.addAttribute("mList", list);
		
		return "admin/admin_order_memberInfo";
	}
	
	
	@RequestMapping("test_result.do")
	public String dateRangeSalesList(Model model, @RequestParam("daterange") String dates, DateRangeDTO dto) {
		
		System.out.println("dates : " + dates);
		
		StringTokenizer tokenizer = new StringTokenizer(dates, "-");
		
		String[] dateList = new String[tokenizer.countTokens()];
		
		for(int i = 0; i < dateList.length; i++) {
			dateList[i] = tokenizer.nextToken();
		}
		
		System.out.println("dateList : " + dateList);

		dto.setFirstDate(dateList[0]);
		dto.setLastDate(dateList[1]);
		
		List<OrderDTO> rangeList = this.dao.getTestRange(dto);
		
		model.addAttribute("oList", rangeList);
				 	 
		return "admin/admin_order_management";
	}
	
	
	
	
}
