package com.idol.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.idol.model.AdminMemberDAO;
import com.idol.model.AdminProductDAO;
import com.idol.model.BoardCategoryDTO;
import com.idol.model.BoardCommentDTO;
import com.idol.model.BoardDTO;
import com.idol.model.CelebDTO;
import com.idol.model.Comm_CategoryDTO;
import com.idol.model.Comm_CommentDTO;
import com.idol.model.CommunityDTO;
import com.idol.model.GroupDTO;
import com.idol.model.InquiryDTO;
import com.idol.model.Inquiry_CategoryDTO;
import com.idol.model.MemberDTO;
import com.idol.model.OrderDTO;
import com.idol.model.ProductDTO;
import com.idol.model.UsedCommDTO;
import com.idol.model.UsedDTO;
import com.idol.model.Used_CategoryDTO;

@Controller
public class AdminMemberController {

	@Autowired
	private AdminMemberDAO dao;
	
	@Autowired
	private AdminProductDAO pdao;
	
	
	
	// 맴버 페이지 메인화면 가기
	@RequestMapping("admin_member_main.do")
	public String AdminMemberMain(Model model) {
		
		List<MemberDTO> list = this.dao.getMemberList();
		
		model.addAttribute("mList", list);
		
		return "admin/admin_member_main";
	}
	
	// 고객 문의 페이지 가기
	@RequestMapping("admin_member_contact.do")
	public String adminMemberContact(Model model) {
		
		List<InquiryDTO> list =this.dao.getInquirList();
		
		List<Inquiry_CategoryDTO> iclist = this.dao.getInquiryCategoryList();
		
		List<MemberDTO> mlist = this.dao.getMemberList();
		
		int first = 1;
		int second = 2;
		int third = 3;
		int fourth = 4;
		int fiveth = 5;
		
		// 카테고리 별로 문의 게시판 리스트 뽑기
		List<InquiryDTO> returnList = this.dao.getInquiryListByCategory(first);
		List<InquiryDTO> itemsList = this.dao.getInquiryListByCategory(second);
		List<InquiryDTO> transList = this.dao.getInquiryListByCategory(third);
		List<InquiryDTO> exchangeList = this.dao.getInquiryListByCategory(fourth);
		List<InquiryDTO> etcList = this.dao.getInquiryListByCategory(fiveth);
		List<InquiryDTO> OkList = this.dao.getInquiryOkList();
		
		model.addAttribute("returnList", returnList);
		model.addAttribute("itemsList", itemsList);
		model.addAttribute("transList", transList);
		model.addAttribute("exchangeList", exchangeList);
		model.addAttribute("etcList", etcList);
		model.addAttribute("OkList", OkList);
		
		model.addAttribute("mList", mlist);
		
		model.addAttribute("iList", list);
		
		model.addAttribute("icList", iclist);
		
		
		return "admin/admin_member_contact";
	}
	
	// 문의 게시글 상세 페이지로 가기
	@RequestMapping("admin_member_inquiryCont.do")
	public String adminMemberInquiryCont(@RequestParam("no") int no, @RequestParam(value="pno", required=false, defaultValue="0") int pno, 
			@RequestParam(value="ono", required=false, defaultValue="0") int ono, 
				Model model, @RequestParam(value="gno", required=false, defaultValue="0") int gno) {
		
		System.out.println("no >>> " + no);
		System.out.println("ono >>> " + ono);
		System.out.println("pno >>> " + pno);
		System.out.println("gno >>> " + gno);
		
		
		
		// inquiry 상세 정보
		InquiryDTO idto = this.dao.getmemberInquiryCont(no);
		
		model.addAttribute("iCont", idto);

		String imgs = idto.getInquiry_image();
		
		if(imgs != null) {
			
			StringTokenizer tokenizer = new StringTokenizer(imgs, "|");
			
			String[] imgsList = new String[tokenizer.countTokens()];
			
			for(int i =0; i < imgsList.length; i++) {
				
				imgsList[i] = tokenizer.nextToken();
			}
			
			model.addAttribute("imgsList", imgsList);
		}else {
			
		}
		
		// 그룹 번호가 있는 경우 정보 넘기자!
		if(gno != 0) {
			
			// inquiry group list 불러오기 by inquriy_group
			List<InquiryDTO> glist = this.dao.getInquiryReplyList(gno);
			
			model.addAttribute("gList", glist);
			
		}else {
			
		}
		
		// 주문 번호가 있는 경우 정보를 넘기자!!
		if(ono != 0) {
			
			OrderDTO odto = this.dao.getOrderContByNo(ono);
			
			String oimgs = odto.getOrder_pimage();
			
			StringTokenizer tokenizerO = new StringTokenizer(oimgs, "|");

			String[] oimgsList = new String[tokenizerO.countTokens()];
			
			for(int i = 0; i< oimgsList.length; i++) {
				
				oimgsList[i] = tokenizerO.nextToken();

			}
			
			// order 상세 정보 by order_no
			model.addAttribute("odto", odto);	
			
			// order 이미지 리스트
			model.addAttribute("oimgsList", oimgsList);
			
		}else {
			
		}

		// 상품 번호가 있는 경우 정보를 넘기자 !!
		if(pno != 0) {
			
			ProductDTO pdto = this.pdao.getProductCont(pno);
			
			String pimgs = pdto.getProduct_image();
			
			StringTokenizer tokenizerP = new StringTokenizer(pimgs, "|");
			
			String[] pimgsList = new String[tokenizerP.countTokens()];
			
			for(int i = 0; i < pimgsList.length; i ++) {
				
				pimgsList[i] = tokenizerP.nextToken();
				
			}
			
			// product 상세 정보 by product_no
			model.addAttribute("pdto", pdto);
			
			// product 이미지 리스트
			model.addAttribute("pimgsList", pimgsList);
			
		}else {
			
		}
		
		return "admin/admin_member_inquiryCont";
		
	}
	
	// 문의게시글 답변 페이지로 가기
	@RequestMapping("admin_inquiry_reply.do")
	public String inquiryReply(@RequestParam("no") int no, Model model, 
			@RequestParam(value="originNo", required=false, defaultValue="0") int originNo) {
		
		System.out.println("before reply page");
		
		System.out.println("originNo1 :" + originNo );
		System.out.println("no :" + no );
		
		
		if(originNo != 0) {
			
			InquiryDTO idto = this.dao.getmemberInquiryCont(no);
			
			model.addAttribute("iCont", idto);	
			
			model.addAttribute("oldNo", originNo);
			
		}else {
			
			InquiryDTO idto = this.dao.getmemberInquiryCont(no);

			model.addAttribute("iCont", idto);	
			
			model.addAttribute("oldNo", no);
		}
		
		
		return "admin/admin_member_inquiryReply";
	}
	
	// 답글 작성 완료
	@RequestMapping("admin_inquiry_replayOk.do")
	public void inquiryReplayOk(InquiryDTO dto, HttpServletResponse response,
			@RequestParam("originNo") int originNo) throws IOException {
		
		System.out.println("====replyOk.do=====");
		// 문의글 답변 상태 완료로 바꾸기
		this.dao.updateReplyStatus(dto);
		
		// 문의글 관련 그룹 step +1 하기
		this.dao.updateReplyStep(dto);
		
		// db에 문의 답글 저장하기
		int check = this.dao.insertInquiryReply(dto);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			
			System.out.println("originNo2 : " + originNo);
			out.println("<script>");
			out.println("alert('답변 글 작성 성공 :)')");
			out.println("location.href='admin_member_inquiryCont.do?no="+originNo+"&pno="+dto.getProduct_no()+"&gno="+dto.getInquiry_group()+"&ono="+dto.getOrder_no()+"'");
			out.println("</script>");
		}else {
			
			out.println("<script>");
			out.println("alert('답변 글 작성 실패 :)')");
			out.println("history.back()");
			out.println("</script>");
			
		}
		
	}
	
	// 답변 수정 폼 페이지로 가기
	@RequestMapping("admin_inquiry_modify.do")
	public String updateReply(@RequestParam("no") int no, Model model, 
			@RequestParam("originNo") int originNo){
		
		InquiryDTO dto = this.dao.getReplyCont(no);
		
		model.addAttribute("replyCont", dto);
		
		model.addAttribute("originNo", originNo);
		
		return "admin/admin_reply_update";
	}
	
	//답변글 수정 오케이
	@RequestMapping("admin_reply_update_ok.do")
	public void updateReplyOk(InquiryDTO dto, HttpServletResponse response, 
			@RequestParam("originNo") int originNo,@RequestParam("product_no") int pno, @RequestParam("order_no") int ono) throws IOException {
		
		System.out.println("dto_NO : " + dto.getInquiry_no());
		System.out.println("originNo : " + originNo);
		
		int check = this.dao.updateReply(dto);
		
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			
			out.println("<script>");
			out.println("alert('답변글 수정 완료 :)')");
			out.println("location.href='admin_member_inquiryCont.do?no="+originNo+"&gno="+originNo+"&pno="+pno+"&ono="+ono+"'");
			out.println("</script>");
		
		}else {
			
			out.println("<script>");
			out.println("alert('답변글 수정 실패 :(')");
			out.println("history.back()");
			out.println("</script>");
			
		}
		
	}
	
	// 답변글 삭제 하기 
	@RequestMapping("admin_reply_delete.do")
	public void deleteReply(@RequestParam("no")int no, HttpServletResponse response) throws IOException {
		
		System.out.println("no : " + no);
		
		int check = this.dao.deleteInquiry(no);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			
			this.dao.updateInquirySequen(no);
			
			out.println("<script>");
			out.println("alert('답변글 삭제 완료 :)')");
			out.println("location.href='admin_member_contact.do'");
			out.println("</script>");
			
		}else {
			
			out.println("<script>");
			out.println("alert('답변글 삭제 실패 :(')");
			out.println("history.back()");
			out.println("</script>");
			
		}
		
	}
	
	
	
	// 맴버 상세 내역 불러오기 ( 모든 리스트 )
	@RequestMapping("admin_member_cont.do")
	public String getMemberAlldate(@RequestParam("no") int no, @RequestParam("id") String id, Model model) {
		
		System.out.println("NO. : " + no);
		
		System.out.println("id : "  + id);
		
		MemberDTO dto = this.dao.getMemberCont(no);
		
		// 맴버가 좋아하는 셀럽 번호를 쪼개서 보내자 !
		String mCeleb = dto.getMember_favorite_celeb();
		
		System.out.println("mCeleb : " + mCeleb);
		
		if(mCeleb != null) {
			
			StringTokenizer tokenizer = new StringTokenizer(mCeleb, ",");
			
			String[] celebs = new String[tokenizer.countTokens()];
			
			for(int i = 0; i < celebs.length; i++) {
				celebs[i] = tokenizer.nextToken();
			}
			
			model.addAttribute("celebs", celebs);
			
		}else {
			
			
		}
		
		// 맴버 주소를 토크나져로 조지쟈! 
		String address = dto.getMember_address();
		
		StringTokenizer addressToken = new StringTokenizer(address, "|");
		
		String[] addressList = new String[addressToken.countTokens()];
		
		for(int i = 0; i < addressList.length; i++) {
			addressList[i] = addressToken.nextToken();
		}
		

		List<OrderDTO> orderList = this.dao.getMemberOrderListByID(id);
		
		
		List<UsedDTO> usedList = this.dao.getUsedListById(id);
		
		List<UsedCommDTO> usedCommList = this.dao.getUsedCommByid(id);
		
		List<Used_CategoryDTO> used_category = this.dao.getUsedCategory();
		
		
		List<CommunityDTO> commList = this.dao.getCommunityListById(id);
		
		List<Comm_CommentDTO> commCommList = this.dao.getCommunityCommById(id);
		
		List<Comm_CategoryDTO> comm_category = this.dao.getCommunityCategory();
		
		
		List<InquiryDTO> inquiryList = this.dao.getinquiryListById(id);
		
		List<Inquiry_CategoryDTO> inquiry_category = this.dao.getInquiryCategoryList();
		
		
		List<CelebDTO> celebList = this.dao.getCelebList();
		
		List<GroupDTO> groupList = this.dao.getGroupList();
		
		
		System.out.println("commList  " + commList.size());
		
		model.addAttribute("mdto", dto);
		
		model.addAttribute("orderList", orderList);
		
		model.addAttribute("usedList", usedList);
		model.addAttribute("usedCommList", usedCommList);
		model.addAttribute("used_category", used_category);
		
		model.addAttribute("commList", commList);
		model.addAttribute("commCommList", commCommList);
		model.addAttribute("comm_category", comm_category);
		
		model.addAttribute("inquiryList", inquiryList);
		model.addAttribute("inquiry_category", inquiry_category);
		
		model.addAttribute("celebList", celebList);
		model.addAttribute("groupList", groupList);
		
		model.addAttribute("address", addressList);
		
		
		return "admin/admin_member_cont";
	}
	
	
	@RequestMapping("admin_inquiry_showMore.do")
	public String getInquiryAllListByCategory(@RequestParam("no") int no, Model model) {
		
			
		if(no == 0) {
			
			List<InquiryDTO> olist = this.dao.getInquiryOkList();
			
			model.addAttribute("okList", olist);
			
		}else {
			
			List<InquiryDTO> clist = this.dao.getInquiryListByCategory(no);
			
			model.addAttribute("categoryByNo", clist);
		}
		
		
		List<MemberDTO> mlist = this.dao.getMemberList();
		
		model.addAttribute("mList", mlist);
		
		return "admin/admin_inquiry_listByCate";
	}
	
	
	@RequestMapping("admin_killing_member.do")
	public String killMember(Model model) {
		
		List<MemberDTO> list = this.dao.getKilledMemberList();
		
		List<MemberDTO> meberList = this.dao.getMemberList();
				
		model.addAttribute("people", list);
		
		model.addAttribute("mList", meberList);
		
		return "admin/admin_killingField";
	}
	
	@RequestMapping("admin_member_search.do")
	public String searchmember(@RequestParam("member_id") String id,
			Model model) {
		
		System.err.println("member_id : " + id);
		
		List<MemberDTO> list = this.dao.getSearchMemberList(id);
		
		model.addAttribute("mList", list);
		
		return "admin/admin_member_main";
	}
	
	
	@RequestMapping("admin_member_killing")
	public void killingMember(@RequestParam("id") String id, HttpServletResponse response) {
		
		
		
	}
	
	
	
}
