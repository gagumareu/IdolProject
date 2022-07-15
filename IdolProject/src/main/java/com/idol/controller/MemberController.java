package com.idol.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.idol.model.AdminCelebDAO;
import com.idol.model.AdminDTO;
import com.idol.model.BoardCategoryDAO;
import com.idol.model.BoardCategoryDTO;
import com.idol.model.CelebDAO;
import com.idol.model.CelebDTO;
import com.idol.model.CommunityDAO;
import com.idol.model.CommunityDTO;
import com.idol.model.FollowDAO;
import com.idol.model.FollowDTO;
import com.idol.model.GroupDAO;
import com.idol.model.GroupDTO;
import com.idol.model.InquiryDAO;
import com.idol.model.InquiryDTO;
import com.idol.model.Inquiry_CategoryDTO;
import com.idol.model.MemberDAO;
import com.idol.model.MemberDTO;
import com.idol.model.MileageDAO;
import com.idol.model.MileageDTO;
import com.idol.model.MusicDAO;
import com.idol.model.MusicDTO;
import com.idol.model.OrderDAO;
import com.idol.model.OrderDTO;
import com.idol.model.PageDTO;
import com.idol.model.ProductDAO;
import com.idol.model.ProductDTO;

//회원과 관련된 지시를 처리하는 컨트롤러 
//회원가입, 로그인, 마이페이지, 마이피드

@Controller
public class MemberController {

	//회원
	@Autowired
	private MemberDAO dao;
	
	//가수
	@Autowired
	private CelebDAO cdao;
	
	//그룹
	@Autowired
	private GroupDAO gdao;
	
	//문의게시판
	@Autowired
	private InquiryDAO idao;
	
	//마일리지
	@Autowired
	private MileageDAO mdao;
	
	//커뮤니티게시판
	@Autowired
	private CommunityDAO comDao;
	
	//커뮤니티 카테고리
	@Autowired
	private BoardCategoryDAO bcDao;
	
	//팔로워
	@Autowired
	private FollowDAO followDao;
	
	//제품테이블
	@Autowired
	private ProductDAO pdao;
	
	//구매테이블
	@Autowired
	private OrderDAO odao;
	
	@Autowired
	private AdminCelebDAO acdao;

	//MUSIC테이블
	@Autowired
	private MusicDAO musicDao;
	
	
	
	//게시판 페이지 관련 
	//페이지 처리용 변수
	private final int rowsize = 3;  //한 페이지당 보이는 게시글의 수
	private int totalRecord ;       //DB상 전체 게시글 수 
	
	/* **********************************이슬************************************ */
	
	// ************************************************* 회원가입 관련 *************************************************
	
	//회원가입 폼페이지 이동
	@RequestMapping("join.do")
	public String join(Model model){
		
		//대표 그룹 리스트
		List<CelebDTO> totalList = this.cdao.representList();
		
		//솔로가수 리스트
		List<CelebDTO> cList = this.cdao.soloList();
		
		
		for(int i=0; i<cList.size() ; i++) {
			totalList.add(cList.get(i)); //솔로리스트를 totalList에 추가하기
		}
		
		
		model.addAttribute("totalList", totalList);
		
		return "member/join";
	}

//	//회원가입폼페이지 아이디중복체크 메서드
//		@ResponseBody
//		@RequestMapping(value="/idCheck.do", method=RequestMethod.POST, produces="application/json")
//		public int idCheck(HttpServletRequest request){
//			
//
//			String id = request.getParameter("member_id");
//			System.out.println("중복확인 id:"+id);
//			
//			int result = this.dao.idcheck(id);
//			
//			return result;
//		}
	
	
	//회원가입폼페이지 아이디중복체크 메서드

   @ResponseBody
   @RequestMapping(value="/idCheck.do", method=RequestMethod.POST)
   public String idCheck(HttpServletRequest request){
		

		String id = request.getParameter("member_id");
		System.out.println("중복확인 id:"+id);
		
	    String result1 = "";
		
		if(this.dao.idcheck(id) == 1) {
			
			result1 ="1";
		}else {
			result1 ="0";
		}
		
	   return result1;
	}
	
	
   //회원가입폼에서  입력한 정보 DB에 저장 
   @RequestMapping("join_ok.do")
   public void joinOk(MemberDTO dto, HttpServletRequest request, HttpServletResponse response) throws IOException{
      
      
      //별명을 입력하지 않은 경우 아이디를 별명으로 저장
      if(dto.getMember_nickname() == null) {
         dto.setMember_nickname(dto.getMember_id());
      }
      
      //MemberDTO에 자동 저장되지 않고 폼페이지에서 넘어온 변수들 정리 
      String addr = request.getParameter("postnum").trim()+"|"+request.getParameter("addr1").trim()+"|"
               +request.getParameter("addr2").trim()+"|"+request.getParameter("addr3").trim();
      
      String phone = request.getParameter("phone1").trim()+request.getParameter("phone2").trim()
               +request.getParameter("phone3").trim();
      
      String birth = request.getParameter("year").trim()+"-"+request.getParameter("month").trim()+"-"
               +request.getParameter("day").trim();
      
      String fav = request.getParameter("checked_celeb"); //쉼표로 구분되어 저장됨
      
      
      
      //MemberDTO에 저장 
      dto.setMember_address(addr);
      dto.setMember_phone(phone);
      dto.setMember_dateofbirth(birth);
      dto.setMember_favorite_celeb(fav);
      
      //회원가입시 프로필사진은 프사없음으로 초기화 
      dto.setMember_image("프사없음.jpeg");
      
      int check = dao.insertMember(dto);
      
      response.setContentType("text/html; charset=UTF-8");
      
      PrintWriter out = response.getWriter();
      
      HttpSession session = request.getSession();
      
      if(check>0) {
         
         //신규회원 마일리지 레코드 생성
         MileageDTO mdto = new MileageDTO();
         mdto.setMileage_memno(dto.getMember_no());
         mdto.setMileage_remaining(1000);
         mdto.setMileage_earn(1000);
         mdto.setMileage_deduction(0);
         mdto.setMileage_accumulated(1000);
         mdto.setMileage_type("회원가입 적립");
         
         int mile = this.mdao.insertMileageInfo(mdto);
         
         MemberDTO login = this.dao.getMemInfo(dto.getMember_id());
         //회원가입 완료 후, 자동 로그인  (회원정보 저장)
         session.setAttribute("loginInfo", login);
         session.setAttribute("login_id", dto.getMember_id());
         
         out.println("<script>");
         /* out.println("alert('회원가입 완료되었습니다')"); */
         out.println("location.href='makeFolder.do?id="+dto.getMember_id()+"'"); //회원가입완료 후 메인화면으로 이동하기
         out.println("</script>");
      }else {
         out.println("<script>");
         out.println("alert('회원가입 실패')");
         out.println("history.back()");
         out.println("</script>");
      }
      
      //Printwriter를 안쓰면 (알림창안떠도되면
      //String타입메서드에 return "redirect:/" ; 로 쓰면 main.jsp로 갈 수 있음 
      
   }
   
   //회원가입 즉시 프사없음폴더 만들기
   @RequestMapping("makeFolder.do")
   public void makeFolder(@RequestParam("id")String id, HttpServletResponse response, 
                HttpServletRequest request) throws Exception {
      
      MemberDTO dto = dao.getMemInfo(id);
      
      //회원가입 시, 회원 이미지 '프사없음'사진으로 초기화 
      String uploadPath = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\member_image";
            
            
      //회원번호 폴더가 생김
      String homedir = uploadPath +"/"+dto.getMember_no();
            
      File path1 = new File(homedir);
         
      //폴더가 존재하지 않으면 폴더 만들어주기
      if(! path1.exists()) {
            path1.mkdir();
      }
      
      //원본파일 불러주기
      FileInputStream fis = new FileInputStream("C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\celeb\\프사없음.jpeg");
      
      //원본파일 복사될 곳 
      FileOutputStream fos = new FileOutputStream(homedir+"/프사없음.jpeg");
      
      int readByte = 0;
      
      while(true) {
         
         readByte = fis.read();
         
         if(readByte == -1) {
            break;
         }
         
         fos.write(readByte);
      }
      
      fos.close();fis.close();   
      
      File check = new File(homedir+"/프사없음.jpeg");
      
      response.setContentType("text/html; charset=UTF-8");
      
      PrintWriter out = response.getWriter();
      
      if(check.exists()) {
         
         out.println("<script>");
         out.println("alert('회원가입 완료되었습니다')");
         out.println("location.href='"+request.getContextPath()+"/'"); //회원가입완료 후 메인화면으로 이동하기
         out.println("</script>");
      }else {
         out.println("<script>");
         out.println("alert('회원가입 실패(파일오류)')");
         out.println("history.back()");
         out.println("</script>");
      }
      
   }
	
	
	//************************************************* 로그인 관련 *************************************************
	//로그인 폼페이지 이동 
	@RequestMapping("login.do")
	public String login() {
		return "member/login";
	}
	
	//로그인 완료 후 메인페이지 이동 
	@RequestMapping("login_ok.do")
	public void loginOk(MemberDTO dto, HttpServletResponse response, HttpServletRequest request) 
				throws IOException {
		
		int check = this.dao.login(dto);
		
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		HttpSession session = request.getSession();
	
	    if(check == 1 ) {
			
			MemberDTO login = this.dao.getMemInfo(dto.getMember_id());
			
			session.setAttribute("loginInfo", login);
			session.setAttribute("login_id", dto.getMember_id());
			
			out.println("<script>");
			out.println("alert('로그인 성공')");
			out.println("location.href='"+request.getContextPath()+"/'");
			out.println("</script>");
			
		}else if(check == 0) {
			out.println("<script>");
			out.println("alert('없는 아이디입니다. 다시 확인해주세요')");
			out.println("history.back()");
			out.println("</script>");
			
		}else if(check == -1) {
			out.println("<script>");
			out.println("alert('비밀번호가 틀렸습니다. 다시 확인해주세요')");
			out.println("history.back()");
			out.println("</script>");
			
		}else if(check == 99) {//정환님코드 추가
			
		 AdminDTO adto = this.acdao.getAdminCont(dto.getMember_id());
			
			session.setAttribute("admin_id", adto.getAdmin_id());
			session.setAttribute("admin_pwd", adto.getAdmin_pwd());
			session.setAttribute("admin_name", adto.getAdmin_name());
			session.setAttribute("admin_email", adto.getAdmin_email());
			session.setAttribute("admin_date", adto.getAdmin_date());
			
			out.println("<script>");
			out.println("alert('관리자 모드 로그인 성공 :)')");
			out.println("location.href='admin_main.do'");
			out.println("</script>");
			
		}else if(check == 88) {
			out.println("<script>");
			out.println("alert('비밀번호가 틀렸습니다. 다시 확인해주세요')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
	
	//아이디,비밀번호찾기 폼 이동
	@RequestMapping("findIdPwd.do")
	public String findIdPwd() {
		return "member/idpwd_find";
	}
	
	//아이디,비밀번호찾기 확인 후 결과 화면 이동
	@RequestMapping("findIdPwd_ok.do")
	public String findId(MemberDTO dto, HttpServletRequest request, Model model)  {
		
		String vf = request.getParameter("verification"); //인증방법(email, phone)
		String find = request.getParameter("find_word"); //구분(id, pwd)
		String phone = request.getParameter("phone1").trim()+request.getParameter("phone2").trim()
					+request.getParameter("phone3").trim();
		
		//핸드폰번호 저장하기
		dto.setMember_phone(phone);

		String result = "";
		String path ="";
		//파라미터 저장 
		HashMap<String, String> params = new HashMap<String, String>();
		
		
		if(find.equals("id")) {//아이디찾기라면 
			if(vf.equals("email")) {//아이디-이메일로 찾기
				params.put("member_name", dto.getMember_name());
				params.put("member_email",dto.getMember_email());
			}else if(vf.equals("phone")) {//아이디-전화번호로 찾기
				params.put("member_name", dto.getMember_name());
				params.put("member_phone",dto.getMember_phone());
			}else {
				System.out.println("아이디 - 이메일,휴대폰으로 인증 문제발생");
			}
		}else if(find.equals("pwd")) {//비밀번호 찾기라면
			if(vf.equals("email")) {//비밀번호-이메일로 찾기
				params.put("member_id", dto.getMember_id());
				params.put("member_name", dto.getMember_name());
				params.put("member_email",dto.getMember_email());
			}else if(vf.equals("phone")) {//비밀번호-전화번호로 찾기
				params.put("member_id", dto.getMember_id());
				params.put("member_name", dto.getMember_name());
				params.put("member_phone",dto.getMember_phone());
			}else {
				System.out.println("비밀번호 - 이메일,휴대폰으로 인증 문제발생");
			}
		}else {
			System.out.println("아이디,비밀번호찾기 문제발생");
		}
		
		
		result = this.dao.findIdPwd(params, find);
		
		if(result == null) {
			
			model.addAttribute("find_result", "null");
			return "member/idpwd_find";
			
		}
			System.out.println("result:"+result);
			System.out.println("find"+find);
			
			model.addAttribute("result", result); //아이디,비밀번호찾기 겨로가
			model.addAttribute("find", find);//아이디, 비밀번호 구분 
		
		 return "member/idpwd_result";
	}
	
	@RequestMapping("idpwd_result.do")
	public String idpwd_result() {
		
		return "member/idpwd_result";
	}
	
	//************************************************* 마이페이지 *************************************************
	
	//마이페이지 이동 
	@RequestMapping("mypage.do")
	public String mypage(HttpSession session, HttpServletRequest request, Model model) {
		
		//로그인한 회원정보
		MemberDTO dto = (MemberDTO)session.getAttribute("loginInfo");
//		session.setAttribute("memInfo", dto);//회원정보 세션저장
		
		//마일리지 정보
		int mileage = this.mdao.getreamining(dto.getMember_no());
		
		//주문내역
		List<OrderDTO> oList = this.odao.getOrderList(dto.getMember_id());
		
		//문의내역
		List<InquiryDTO> iList = this.idao.getInquiryList(dto.getMember_id());
		
		//문의내역 - 답변대기중인 게시글 수
		int waiting = this.idao.watingReply(dto.getMember_id());
		
		//최근 3일간 구매한 건수 
		int ThreeDaysOrder = this.odao.get3daysOrder(dto.getMember_id());
		
		
		//값전달
		model.addAttribute("mileage", mileage); //회원에 대한 마일리지 정보
		model.addAttribute("waiting", waiting);//답변대기 문의글
		model.addAttribute("iList",iList); //문의내역
		model.addAttribute("oList", oList);
		model.addAttribute("threedays", ThreeDaysOrder);
		
		return "member/mypage";
	}
	
	
	//로그아웃
	@RequestMapping("logout.do")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	//마이페이지 - 회원정보 관리 폼으로 이동
	@RequestMapping("mySettings.do")
	public String mymanage(Model model, HttpSession session) {
		
		MemberDTO dto = this.dao.getMemInfo((String)session.getAttribute("login_id"));
		
		// '|'로 이어진 주소를 배열에 담기
		StringTokenizer st = null;
		
		
		String addr = dto.getMember_address();
		String fav = dto.getMember_favorite_celeb();
		
		st= new StringTokenizer(addr, "|");
		
		String [] mem_addr = new String[st.countTokens()];
		
		for(int i =0; i<mem_addr.length; i++){
			mem_addr[i]=st.nextToken();
		}
		
		model.addAttribute("mem_addr", mem_addr);
		
		// ','로 이어진 가수 번호 나눠 배열에 담기
		
		String[] mem_fav = null;
		
		if(fav != null) {
			
		st = new StringTokenizer(fav,",");
		
		 mem_fav= new String[st.countTokens()];
		
		for(int i =0; i<mem_fav.length; i++){
			mem_fav[i]=st.nextToken();
		}
		
		}
		model.addAttribute("mem_fav", mem_fav);
		
		
		//대표 그룹 리스트
		List<CelebDTO> totalList = this.cdao.representList();
				
		//솔로가수 리스트
		List<CelebDTO> cList = this.cdao.soloList();
				
				
		for(int i=0; i<cList.size() ; i++) {
		
			totalList.add(cList.get(i)); //솔로리스트를 totalList에 추가하기
		}
				
				
		model.addAttribute("totalList", totalList);
		
		
		model.addAttribute("celebList", cList);
		
		session.setAttribute("loginInfo", dto);
		model.addAttribute("memInfo", dto);
		
		
		return "member/mypage_settings";
		
	}
	
	//마이페이지 - 회원정보 수정
	@RequestMapping("member_update.do")
	public void memUpdate(MemberDTO dto, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		//별명을 입력하지 않은 경우 아이디를 별명으로 저장
			if(dto.getMember_nickname() == null) {
					dto.setMember_nickname(dto.getMember_id());
		}
				
		//MemberDTO에 자동 저장되지 않고 폼페이지에서 넘어온 변수들 정리 
		String addr = request.getParameter("postnum").trim()+"|"+request.getParameter("addr1").trim()+"|"
							+request.getParameter("addr2").trim()+"|"+request.getParameter("addr3").trim();
				
		String phone = request.getParameter("phone1").trim()+request.getParameter("phone2").trim()
							+request.getParameter("phone3").trim();
			
		String fav = request.getParameter("checked_celeb"); //쉼표로 구분되어 저장됨
				
				
				
		//MemberDTO에 저장 
		dto.setMember_address(addr);
		dto.setMember_phone(phone);
		dto.setMember_favorite_celeb(fav);
		
		int check = this.dao.updateMember(dto);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check>0) {
			out.println("<script>");
			out.println("alert('회원 수정 성공')");
			out.println("location.href='mySettings.do'");
			out.println("</script>");
			
		}else {
			out.println("<script>");
			out.println("alert('회원 수정 실패')");
			out.println("location.href='history.back()'");
			out.println("</script>");
		}
		
	}
	
	//프로필 사진 수정 - 마이페이지 또는 피드 
	@RequestMapping("editProfile.do")
	public void editProfile(MultipartHttpServletRequest multi, MemberDTO dto, HttpServletResponse response, HttpServletRequest request) throws IOException {
		
		//요청을 넘기는 곳의 정보  - mypage_*.jsp 또는 feed_*.jsp
		String uri = request.getParameter("uri");
		String path = request.getContextPath()+"/WEB-INF/views/member";
		System.out.println("uri"+uri);
		System.out.println("path"+path);
		
		
		String command = uri.substring(path.length()+1);
		System.out.println("command:"+command);
		
		//저장되었던 이미지 이름
		String old_img = multi.getParameter("old_img");
		
		
		
		int result =0;
		String uploadPath = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\member_image";
				
				//업로드된 파일들의 이름 목록을 제공하는 메서드
				Iterator<String> it = multi.getFileNames();
		
				while(it.hasNext()) {
					
					String uploadFileName = it.next();
					
					MultipartFile mFile = multi.getFile(uploadFileName);
					
					//업로드한 파일의 이름을 구하는 메서드
					String originalFileName = mFile.getOriginalFilename();
					
					//실제 폴더 만들기 
					//회원번호 폴더가 생김
					String homedir = uploadPath +"/"+dto.getMember_no();
					
					File path1 = new File(homedir);
					
					//폴더가 존재하지 않으면 폴더 만들어주기
					if(! path1.exists()) {
						path1.mkdir();
					}
					
					//원래있던 저장되어있던 이미지 삭제해주기
					if( path1.exists() && old_img != null) {
						
						File file = new File(homedir+"/"+old_img);
						file.delete();
					}
					
					
					//실제 파일만들기
					String saveFileName = originalFileName;
					
						
					
					
					dto.setMember_image(saveFileName);
					
					result = this.dao.profileUpload(dto);
					
					try {
						
						File origin= new File(homedir+"/"+saveFileName);
						mFile.transferTo(origin);
						
						
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} 
					
				}
				
				String redirect="";
				
				if(command.substring(0,1).equals("m")) {//마이페이지에서 프로필 수정한 경우
					redirect = "mypage.do";
				}else if(command.substring(0, 1).equals("f")){
					
					redirect = "myfeed.do?id="+dto.getMember_id();
				}
				
				System.out.println("redirect:"+redirect);
				
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				if(result>0) {
					out.println("<script>");
					out.println("alert('프로필 사진 업로드 성공')");
					out.println("location.href='"+redirect+"'");
					out.println("</script>");
					
				}else {
					out.println("<script>");
					out.println("alert('프로필 사진 업로드 실패')");
					out.println("history.back()");
					out.println("</script>");
				}
	}
	
	//피드 커버사진 수정
	@RequestMapping("editCover.do")
	public void editCover(MultipartHttpServletRequest multi, MemberDTO dto, HttpServletResponse response) throws IOException {
		
		//저장되었던 이미지 이름
		String old_img = multi.getParameter("old_img");
		System.out.println("old_img:"+old_img);
		
		int result =0;
		String uploadPath = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\member_image";
				
				//업로드된 파일들의 이름 목록을 제공하는 메서드
				Iterator<String> it = multi.getFileNames();
		
				while(it.hasNext()) {
					
					String uploadFileName = it.next();
					
					MultipartFile mFile = multi.getFile(uploadFileName);
					
					//업로드한 파일의 이름을 구하는 메서드
					String originalFileName = mFile.getOriginalFilename();
					
					//실제 폴더 만들기 
					//회원번호 폴더가 생김
					String homedir = uploadPath +"/"+dto.getMember_no();
					
					File path1 = new File(homedir);
					
					//폴더가 존재하지 않으면 폴더 만들어주기
					if(! path1.exists()) {
						path1.mkdir();
					}
					
					//원래있던 저장되어있던 이미지 삭제해주기
					if(  path1.exists() && old_img != null) {
						
						File file = new File(homedir+"/"+old_img);
						file.delete();
					}
					
					//실제 파일만들기
					String saveFileName = "head_"+originalFileName;
					
					dto.setMember_cover(saveFileName);
					
					result = this.dao.coverUpload(dto);
					
					try {
						
						File origin= new File(homedir+"/"+saveFileName);
						mFile.transferTo(origin);
						
						
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} 
					
				}
				
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				if(result>0) {
					out.println("<script>");
					out.println("alert('커버 사진 업로드 성공')");
					out.println("location.href='myfeed.do?id="+dto.getMember_id()+"'");
					out.println("</script>");
					
				}else {
					out.println("<script>");
					out.println("alert('커버 사진 업로드 실패')");
					out.println("history.back()");
					out.println("</script>");
				}
	}
	
	
	//마이페이지 - 구매내역페이지 이동
	@RequestMapping("order_list.do")
	public String order_list(HttpSession session, Model model) {

		String login_id = (String)session.getAttribute("login_id");

		//구매내역 날짜들 뽑기
		List<String> orderDates = this.odao.getOrderDates(login_id);	

		HashMap<Integer, List> maps = new HashMap<Integer, List>();//날짜별 구매내역 리스트담을 map

		HashMap<String, String> params = new HashMap<String, String>();//mybatis 다중파라미터로 사용

		params.put("id", login_id);

		//날짜에 해당하는 구매리스트 가져오기
		for(int i =0; i<orderDates.size(); i++) {
			params.put("date", orderDates.get(i));
			maps.put(i, this.odao.getOrderDateList(params)); //아이디와 날짜 넘김

		}

		model.addAttribute("dateMap", maps);
		model.addAttribute("dates", orderDates);

		return"member/mypage_orderList" ;
	}
	
        //마이페이지 - 문의게시글 날짜검색
		@RequestMapping("order_date.do")
		public String order_date(HttpServletRequest request, Model model,
				HttpSession session) throws ParseException {
			
			String login_id = (String)session.getAttribute("login_id");
			
			//날짜 조회 
			int search_date = Integer.parseInt(request.getParameter("search_date"));
			
			//오늘날짜 기준 
			Calendar cal = Calendar.getInstance();
			
			int year = cal.get(Calendar.YEAR);
			int month =cal.get(Calendar.MONTH)+1;
			int day =cal.get(Calendar.DAY_OF_MONTH);
			
			String endDate = year+"-"+month+"-"+day;
			String startDate = "";
			
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date date = format.parse(endDate);
			
			cal.setTime(date);
			
			switch (search_date) {
			case 0: //오늘
				startDate = endDate;
				break;
			case 7: //일주일
				cal.add(Calendar.DATE, -7);
				startDate = format.format(cal.getTime());
				break;
			case 1: //한달
				cal.add(Calendar.DATE, -30);
				startDate = format.format(cal.getTime());
				break;
			case 3: //3달
				cal.add(Calendar.DATE, -90);
				startDate = format.format(cal.getTime());
				break;
			case 6: //6달
				cal.add(Calendar.DATE, -180);
				startDate = format.format(cal.getTime());
				break;
			case 12: //1년
				cal.add(Calendar.DATE, -365);
				startDate = format.format(cal.getTime());
				break;
			}
			
			HashMap<String, Object> map = new HashMap<String, Object>();//날짜조회 sql 파라미터들
			
			System.out.println("startdate"+startDate);
			System.out.println("enddate"+endDate);
			
			map.put("order_userid", login_id);
			map.put("startDate", startDate);
			map.put("endDate", endDate);
			

			//날짜검색한 구매내역 날짜들 뽑기
			List<String> orderDates = this.odao.getOrderDates(map);	
			
			System.out.println("orderDates.size"+orderDates.size());

			HashMap<Integer, List> maps = new HashMap<Integer, List>();//날짜별 구매내역 리스트담을 map

			HashMap<String, String> params = new HashMap<String, String>();//mybatis 다중파라미터로 사용

			params.put("id", login_id);

			//날짜에 해당하는 구매리스트 가져오기
			for(int i =0; i<orderDates.size(); i++) {
				params.put("date", orderDates.get(i));
				maps.put(i, this.odao.getOrderDateList(params)); //아이디와 날짜 넘김

			}
			
			model.addAttribute("dateMap", maps);
			model.addAttribute("dates", orderDates);
			model.addAttribute("search_date", search_date);

			return "member/mypage_orderDate";
			
		}
	
	
	
	//마이페이지 - 구매내역 상세페이지 
	@RequestMapping("orderlist_cont")
	public String orderCont(@RequestParam("ogno")int ogno, Model model) {
		
		
		//주문그룹 내역 리스트
		List<OrderDTO> orderCont = this.odao.getOrderGroup(ogno);
		
		//제품 정보리스트
		List<ProductDTO> pList = new ArrayList<ProductDTO>();
		
		int pay = 0; //실제 결제금액
		int totalPrice =0; //구매가격 total
		int trans =0; //배송비
		String payDate =""; //구매날짜
		
		String receiveName = "";
		String receiveAddr = "";
		String receivePhone = "";
		
		
		
		for(int i=0; i<orderCont.size(); i++) {
			
			OrderDTO dto = orderCont.get(i);
			
			ProductDTO pdto = this.pdao.getProductDetail(dto.getOrder_pname());
			
			
			totalPrice += dto.getOrder_qty()*dto.getOrder_pprice();
			pay += dto.getOrder_total();
			trans += dto.getOrder_tcost();
			
			if(payDate == "" || receiveName == "" || receiveAddr == "" || receivePhone == "") {
				System.out.println("if문진입");
				payDate = dto.getOrder_date().substring(0, 10);
				
				receiveName = dto.getOrder_receivername();
				receiveAddr = dto.getOrder_receiveraddress();
				receivePhone = dto.getOrder_receiverphone();
			}
			
			if(receiveAddr != null) {
				
				StringTokenizer st= new StringTokenizer(receiveAddr, "|");
				
				String [] mem_addr = new String[st.countTokens()];
				
				for(int j =0; j<mem_addr.length; j++){
					mem_addr[j]=st.nextToken();
				}
				
				model.addAttribute("Addr", mem_addr);
			}
			
			pList.add(pdto);
		}
		
		
		model.addAttribute("orderGroup", orderCont);
		model.addAttribute("pList", pList);
		model.addAttribute("pay", pay);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("trans", trans);
		model.addAttribute("payDate", payDate);
		model.addAttribute("name", receiveName);
		model.addAttribute("phone", receivePhone);
		
		return "member/mypage_orderCont";
	}
	
	//구매내역(그룹별) 삭제 
	@RequestMapping("order_delete")
	public void orderDelete (@RequestParam("ogno")int ogno, HttpServletResponse response) throws IOException {
		
		int  check = this.odao.deleteOgno(ogno);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(check>0) {
			
			out.println("<script>");
			out.println("alert('구매내역 삭제 완료')");
			out.println("location.href='order_list.do'");
			out.println("</script>");
			
		}else {
			out.println("<script>");
			out.println("alert('구매내역 삭제 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
 
	
	//마이페이지 - 문의내역페이지 이동
	@RequestMapping("inquiry_list.do")
	public String qnaist(HttpServletRequest request, Model model,
				HttpSession session) {
		
		String login_id = (String)session.getAttribute("login_id");
		
		int page; //현재 페이지 변수
		
		if(request.getParameter("page") != null) {
			page= Integer.parseInt(request.getParameter("page"));
		}else {
			page =1; //넘겨받은 page 변수가 없다면 1페이지로 설정 
		}
		
		//DB상 리스트 전체 게시물 수 확인하기
		totalRecord = this.idao.getBoardCount(login_id);
		
		PageDTO pdto = new PageDTO(page, rowsize, totalRecord);
		
		//mybatis 다중 파라미터용 
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("inquiry_userid", login_id);
		map.put("page", pdto);
		
		//페이지에 해당하는 게시물 가져오기
		List<InquiryDTO> list = this.idao.getInquiryList(map);
		
		//문의게시글 상품정보를 불러오기
		//문의게시글에 대응하는 상품정보리스트
		List<ProductDTO> pList = new ArrayList<ProductDTO>();
		
		for(int i =0; i<list.size(); i++) {
			
			InquiryDTO idto = list.get(i);
			
			if(idto.getProduct_no() == 0) {//문의게시글에 상품정보가 없으면 null값 넣어주기 
				
				pList.add(null);
				
			}else {//문의게시글에 상품정보가 있으면 정보를 불러와 넣어주기 
				
			ProductDTO product = this.pdao.getProductDetail(idto.getProduct_no());
				pList.add(product);
			}
		}
		
		
		//답변 대기 중인 문의 수
		int waiting = this.idao.watingReply(login_id);
		
		
		model.addAttribute("List", list);
		model.addAttribute("pCont", pList); //문의게시글 리스트에 대응하는 제품정보리스트
		model.addAttribute("paging", pdto);
		model.addAttribute("waiting", waiting);
		
		return "member/mypage_qnaList";
	}
	
	//마이페이지 - 문의게시글 날짜검색
	@RequestMapping("inquiry_date.do")
	public String inquiry_date(HttpServletRequest request, Model model,
			HttpSession session) throws ParseException {
		
		String login_id = (String)session.getAttribute("login_id");

		int page; //현재 페이지 변수

		if(request.getParameter("page") != null) {
			page= Integer.parseInt(request.getParameter("page"));
		}else {
			page =1; //넘겨받은 page 변수가 없다면 1페이지로 설정 
		}
		
		//날짜 조회 
		int search_date = Integer.parseInt(request.getParameter("search_date"));
		
		//오늘날짜 기준 
		Calendar cal = Calendar.getInstance();
		
		int year = cal.get(Calendar.YEAR);
		int month =cal.get(Calendar.MONTH)+1;
		int day =cal.get(Calendar.DAY_OF_MONTH);
		
		String endDate = year+"-"+month+"-"+day;
		String startDate = "";
		
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date date = format.parse(endDate);
		
		cal.setTime(date);
		
		switch (search_date) {
		case 0: //오늘
			startDate = endDate;
			break;
		case 7: //일주일
			cal.add(Calendar.DATE, -7);
			startDate = format.format(cal.getTime());
			break;
		case 1: //한달
			cal.add(Calendar.DATE, -30);
			startDate = format.format(cal.getTime());
			break;
		case 3: //3달
			cal.add(Calendar.DATE, -90);
			startDate = format.format(cal.getTime());
			break;
		case 6: //6달
			cal.add(Calendar.DATE, -180);
			startDate = format.format(cal.getTime());
			break;
		case 12: //1년
			cal.add(Calendar.DATE, -365);
			startDate = format.format(cal.getTime());
			break;
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
	
		map.put("inquiry_userid", login_id);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		

		//DB상 리스트 전체 게시물 수 확인하기
		totalRecord = this.idao.getBoardCount(map);

		PageDTO pdto = new PageDTO(page, rowsize, totalRecord);

		//mybatis 다중 파라미터용 
		map.put("page", pdto);

		//페이지에 해당하는 게시물 가져오기
		List<InquiryDTO> list = this.idao.getInquiryList(map);
		
		
		//문의게시글 상품정보를 불러오기
		//문의게시글에 대응하는 상품정보리스트
		List<ProductDTO> pList = new ArrayList<ProductDTO>();

		for(int i =0; i<list.size(); i++) {

			InquiryDTO idto = list.get(i);

			if(idto.getProduct_no() == 0) {//문의게시글에 상품정보가 없으면 null값 넣어주기 

				pList.add(null);

			}else {//문의게시글에 상품정보가 있으면 정보를 불러와 넣어주기 

				ProductDTO product = this.pdao.getProductDetail(idto.getProduct_no());
				pList.add(product);
			}
		}

		//답변 대기 중인 문의 수
		int waiting = this.idao.watingReply(login_id);
		


		model.addAttribute("List", list);
		model.addAttribute("pCont", pList); //문의게시글 리스트에 대응하는 제품정보리스트
		model.addAttribute("paging", pdto);
		model.addAttribute("search_date", search_date);
		model.addAttribute("waiting", waiting);

		return "member/mypage_qnaListDate";
		
	}
	
	
	//마이페이지 - 문의게시글 작성하기 
	@RequestMapping("inquiry_write.do")
	public String inquiry_write(HttpServletRequest request, Model model) {
		
		//문의게시판 카테고리 리스트
		List<Inquiry_CategoryDTO> cList = this.idao.getInquiryCategory();
		
	    int pno = 0; 
		
		if(request.getParameter("pno") == null && request.getParameter("ono") == null) {
			
			System.out.println("제품정보 및 주문정보 없음");
			
		}else if( request.getParameter("ono") != null && request.getParameter("pno") == null){
			//주문정보가 있는 경우 , 주문관련 문의
			
		    //주문 정보
			OrderDTO odto = this.odao.getOrderCont(Integer.parseInt(request.getParameter("ono")));
			
		    //주문한 제품정보 가져오기 (이름으로 찾기)
			ProductDTO product = this.pdao.getProductDetail(odto.getOrder_pname());
			
			//제품정보 넘기기
			model.addAttribute("pCont", product);
			model.addAttribute("ono", odto.getOrder_no());
			
		}else if(request.getParameter("pno") != null && request.getParameter("ono") == null) { //제품정보만 있다면 상품문의
			
			pno = Integer.parseInt(request.getParameter("pno"));
			ProductDTO product = this.pdao.getProductDetail(pno);
			model.addAttribute("pCont", product);
		}
		
		
	
		model.addAttribute("cList", cList);
		
		
		return "member/mypage_qnaWrite";
	}
	
	//문의글 작성 시 제품 검색창으로 이동
	@RequestMapping("inquiry_product.do")
	public String inquiry_product(HttpServletRequest request) {
		
		
		return "member/mypage_qnaProduct";
	}
	
	//문의글 제품검색창 검색 했을 경우
	@RequestMapping("inquiry_productSearch.do")
	public String inquiry_productSearch(HttpServletRequest request, Model model) {
		
		int page; //현재 페이지 변수
		
		if(request.getParameter("page") != null) {
			page= Integer.parseInt(request.getParameter("page"));
		}else {
			page =1; //넘겨받은 page 변수가 없다면 1페이지로 설정 
		}
		
		HashMap<String, Object> maps = new HashMap<String, Object>();
		
		//검색 필드 및 단어
		String search_field = request.getParameter("search_field").trim(); //상품명(product_name), 가수명(celeb_name)
		String search_word = request.getParameter("search_word").trim();
		
		maps.put("field", search_field);
		maps.put("word", search_word);
		
		//DB상 검색한 제품 리스트 전체 게시물 수 확인하기
		totalRecord = this.pdao.productTotalRecord(maps);
		
		PageDTO pagedto = new PageDTO(page, rowsize, totalRecord);
		
		maps.put("page", pagedto);
		
		//페이지에 해당하는 제품리스트 가져오기
		List<InquiryDTO> list = this.pdao.productListPage(maps);
		
		
		model.addAttribute("pList", list);
		model.addAttribute("map", maps);
		
		
		return "member/mypage_qnaProduct";
	}
	
	
	//문의게시글 등록 완료
	@RequestMapping("inquiry_write_ok.do")
	public void qna_writeOk(InquiryDTO dto, MultipartHttpServletRequest multi, HttpServletResponse response) throws IOException {
		
		//올린 이미지 저장
		Iterator<String> iterator = multi.getFileNames();

		String uploadFileName = iterator.next();

		List<MultipartFile> fileList = multi.getFiles(uploadFileName);

		
		String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\inquiry_board";

		String dbFileName = "";

		long fileSize = 0;
		
		
		for (MultipartFile mFile : fileList) {

			String originFileName = mFile.getOriginalFilename(); // 원본 파일 명
			
			fileSize = mFile.getSize(); // 파일 사이즈

//			System.out.println("originFileName : " + originFileName);
//			System.out.println("fileSize : " + fileSize);
			
			if(fileSize != 0) {
			String saveFile = dto.getInquiry_userid()+"_" + originFileName;

			dbFileName += dto.getInquiry_userid()+"_" + originFileName + "|";
			
			dto.setInquiry_image(dbFileName);
			
			try {

				mFile.transferTo(new File(path+"/"+saveFile));

			} catch (IllegalStateException e) {

			}
			
			}else {
				break;
			}
		}
		
		int check = this.idao.insertInquiry(dto);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		
		if(check>0) {
			
			out.println("<script>");
			out.println("alert('게시글 작성 완료')");
			out.println("location.href='inquiry_list.do'"); 
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('게시글 작성 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
	}
	
	//마이페이지 - 문의게시글 내용 
	@RequestMapping("inquiry_cont.do")
	public String qna_cont(@RequestParam("no")int no, @RequestParam("page") int page,
						Model model) {
		
		//조회수 증가
		this.idao.updateHit(no);
		
		//문의글 내용
		InquiryDTO dto = this.idao.getInquirycont(no);
		
		//문의글 첨부파일 이미지 
		String[] img = null;

		StringTokenizer st = null;
		if(dto.getInquiry_image() != null) {
			st = new StringTokenizer(dto.getInquiry_image(),"|");

			img= new String[st.countTokens()];

			for(int i =0; i<img.length; i++){
				img[i]=st.nextToken();	
			}
		}
		
		//상품 정보가 있는 경우 
		if(dto.getProduct_no() != 0) {
			
			ProductDTO pdto = this.pdao.getProductDetail(dto.getProduct_no());
			model.addAttribute("pCont", pdto);
		}
		
		
		//원글에 답변글 있는경우 
		InquiryDTO reply = this.idao.getReplyCont(no);
		
		model.addAttribute("Cont", dto);
		model.addAttribute("page", page);
		model.addAttribute("Img", img);
		model.addAttribute("Reply", reply);
		
		return "member/mypage_qnaCont";
	}
	
	//문의게시글 삭제
	@RequestMapping("inquiry_delete.do")
	public void inquiry_delete(@RequestParam("no")int no, HttpServletResponse response) throws IOException {
		
		int check = this.idao.deleteInquiry(no);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(check>0) {
			
			this.idao.adjustIno(no);
			
			out.println("<script>");
			out.println("alert('삭제 완료')");
			out.println("location.href='inquiry_list.do'");
			out.println("</script>");
			
		}else {
			out.println("<script>");
			out.println("alert('삭제 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
	
	//문의게시글 수정
	@RequestMapping("inquiry_update.do")
	public String inquiry_update(@RequestParam("no")int no, @RequestParam("page") int page,
			Model model) {
		
		//문의글 내용
		InquiryDTO dto = this.idao.getInquirycont(no);
		
		//상품 정보가 있는 경우 
				if(dto.getProduct_no() != 0) {
					
					ProductDTO pdto = this.pdao.getProductDetail(dto.getProduct_no());
					model.addAttribute("pCont", pdto);
		}
		
		
		
		model.addAttribute("Cont", dto);
		model.addAttribute("page", page);
		
		return "member/mypage_qnaUpdate";
		
	}
	
	//문의게시글 수정 완료
	@RequestMapping("inquiry_updateOk.do")
	public void inquiry_updateOk(InquiryDTO dto, MultipartHttpServletRequest multi,
				HttpServletResponse response) throws IOException {
		
		//수정 이미지 파일 저장
		Iterator<String> iterator = multi.getFileNames();

		String uploadFileName = iterator.next();

		List<MultipartFile> fileList = multi.getFiles(uploadFileName);


		String path = "C:\\Users\\JUNGHWAN\\Documents\\The Final\\IdolProject\\src\\main\\webapp\\resources\\upload\\inquiry_board";

		String dbFileName = "";

		long fileSize = 0;


		for (MultipartFile mFile : fileList) {

			String originFileName = mFile.getOriginalFilename(); // 원본 파일 명

			fileSize = mFile.getSize(); // 파일 사이즈

//					System.out.println("originFileName : " + originFileName);
//					System.out.println("fileSize : " + fileSize);

			if(fileSize != 0) {
				String saveFile = dto.getInquiry_userid()+"_" + originFileName;

				dbFileName += dto.getInquiry_userid()+"_" + originFileName + "|";

				dto.setInquiry_image(dbFileName);

				try {

					mFile.transferTo(new File(path+"/"+saveFile));

				} catch (Exception e) {

				}

			}else {
				break;
			}
		}//for문 end
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		int page = Integer.parseInt(multi.getParameter("page"));

		int check = this.idao.updateInquiry(dto);

		if(check>0) {

			out.println("<script>");
			out.println("alert('수정 성공')");
			out.println("location.href='inquiry_cont.do?no="+dto.getInquiry_no()+"&page="+page+"'");
			out.println("</script>");

		}else {

			out.println("<script>");
			out.println("alert('수정 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
		
		
	}
	
	//마일리지 내역 
	@RequestMapping("mileage_list.do")
	public String mileageList(HttpSession session, Model model) {
		
		//로그인한 회원정보
		MemberDTO dto = (MemberDTO)session.getAttribute("loginInfo");
		
		//마일리지 리스트 불러오기
		List<MileageDTO> mileage = this.mdao.getMileageList(dto.getMember_no());
		
		
		model.addAttribute("mileage", mileage);
		
		return "member/mypage_mileage";
	}
	
	
	
	
	//********************************************* 마이피드 *************************************************
	
	//마이피드 메인 (about 화면이 디폴트)
	@RequestMapping("myfeed.do") //get방식으로 id가 넘어옴
	public String feed(@RequestParam("id")String id, HttpSession session, Model model) {
		
		//피드에 담길 정보들을 저장하는 map타입
		HashMap<String, Object> feedInfo = new HashMap<String, Object>();
		
		//누른 feed의 회원 정보
		MemberDTO dto = this.dao.getMemInfo(id);
		feedInfo.put("mInfo", dto);
		
		//누른 feed의 회원 게시글 리스트
		List<CommunityDTO> commList = this.comDao.getCommunityList(id);
		feedInfo.put("commList", commList);
		if(commList != null) {
			model.addAttribute("community", commList);
			
			// 게시글 카테고리 리스트를 가져옴
			List<BoardCategoryDTO> categorylist = this.bcDao.getCategoryList();
					
			model.addAttribute("cList", categorylist);
			
		}
		
		
		
		//누른 feed의 회원의 팔로우,팔로워 정보
		//내가 팔로우 하는 사람들 팔로잉 follow
		List<FollowDTO> following = this.followDao.getFollowList(id);
		feedInfo.put("following", following);
		
		//나를 등록한 사람들 follower  
		List<FollowDTO> follower = this.followDao.getFollowerList(id);
		feedInfo.put("follower", follower);
		
		//로그인 회원 정보 받기 
		String login_id = (String)session.getAttribute("login_id");
		
	
		//로그인한 회원의 팔로우한 내역들
		if(login_id != null) {
		List<FollowDTO> login_follow = this.followDao.getFollowList(login_id);
		feedInfo.put("login_follow", login_follow);
		}
	
		
		//about에 나오는 정보
		//feed회원의 좋아하는 가수 정보 가져오기 
		
		// ','로 이어진 가수 번호 나눠 배열에 담기
		String fav = dto.getMember_favorite_celeb();
				
		String[] mem_fav = null;

		StringTokenizer st = null;
		if(fav != null) {
			st = new StringTokenizer(fav,",");
						
			mem_fav= new String[st.countTokens()];
						
  		    for(int i =0; i<mem_fav.length; i++){
					mem_fav[i]=st.nextToken();			
					}
		}
		
		//좋아하는 가수 정보 담은 리스트
		List<String[]> favList = new ArrayList<String[]>();

		//배열에 담긴 각각 가수에 대해 정보 불러오기
		//Celeb테이블에서 가수 정보를 불러왔기 때문에 celeb에서 1차로 정보 확인 후 그룹가수일 경우 group테이블에서 확인 필요 
		if(mem_fav != null) {
		for(int i=0; i<mem_fav.length; i++) {
			CelebDTO celebDto = this.cdao.getCelebInfo(Integer.parseInt(mem_fav[i]));
			
			String [] img = null;//가수,그룹이미지 담을 배열
			
			//솔로+그룹 가수 통합 정보 담는 배열 
			String [] groupCeleb = new String [4]; // 0: 번호 , 1:이름, 2:이미지, 3:그룹,솔로 구분 

			if(celebDto.getCeleb_group().equalsIgnoreCase("solo")) {//솔로 가수일 경우
				
				st= new StringTokenizer(celebDto.getCeleb_pimage(), "|");
				img = new String[st.countTokens()];
				
				for(int z =0; z<img.length; z++) {
					img[z] = st.nextToken();
				}
				
				groupCeleb[0] = celebDto.getCeleb_no()+"";
				groupCeleb[1] = celebDto.getCeleb_name();
				groupCeleb[2] = img[0];
				groupCeleb[3] = "solo";

			}else {//그룹 가수라면 
				
				GroupDTO groupDto = this.gdao.getGroupInfo(celebDto.getCeleb_group());
				
				st= new StringTokenizer(groupDto.getGroup_image(), "|");
				img = new String[st.countTokens()];
				
				for(int z =0; z<img.length; z++) {
					img[z] = st.nextToken();
				}
				
				groupCeleb[0] = groupDto.getGroup_no()+"";
				groupCeleb[1] = groupDto.getGroup_name();
				groupCeleb[2] = img[0];
				groupCeleb[3] = "group";

			}
			

			favList.add(groupCeleb);

		}
		}
		
		//피드 관련 include에 들어갈 정보 
		session.setAttribute("feedInfo", feedInfo); //세션에 저장
		
		model.addAttribute("id", id);
		model.addAttribute("favList", favList);
		
		
		return "member/feed_about";
	}
	
	//팔로워 리스트 
	@RequestMapping("feed_follower.do")
	public String feed_follwer(@RequestParam("id")String id, HttpSession session, Model model) {
		
		//피드 회원을 팔로우 하고있는 리스트들의 회원정보 (팔로워)
		List<MemberDTO> followerCont = new ArrayList<MemberDTO>();
		
		HashMap maps = (HashMap<String, Object>)session.getAttribute("feedInfo");
		
		//피드 회원의 follower 리스트를 불러오기
		List<FollowDTO> follower = (List<FollowDTO>)maps.get("follower");
		
		//팔로워리스트에 담겨져있는 회원들의 정보를 새로운 리스트에 저장
		for(int i=0; i<follower.size(); i++) {
			
			FollowDTO fdto = follower.get(i);
			
			//회원정보 가져오기
			MemberDTO mdto = this.dao.getMemInfo(fdto.getFollower_name());
			
			//회원정보 저장
			followerCont.add(mdto);
		}
		
		model.addAttribute("followerCont", followerCont);
		model.addAttribute("id", id); //피드 아이디
		
		return "member/feed_follower";
	}
	
	//팔로워 리스트 
	@RequestMapping("feed_following.do")
	public String feed_following(@RequestParam("id")String id, HttpSession session, Model model) {
			
		//피드 회원을 팔로우 하고있는 리스트들의 회원정보 (팔로워)
		List<MemberDTO> followingCont = new ArrayList<MemberDTO>();
			
		HashMap maps = (HashMap<String, Object>)session.getAttribute("feedInfo");
		List<FollowDTO> following = (List<FollowDTO>)maps.get("following");
			
		//팔로워리스트에 담겨져있는 회원들의 정보를 새로운 리스트에 저장
		for(int i=0; i<following.size(); i++) {
				
			FollowDTO fdto = following.get(i);
				
			//회원정보 가져오기
			MemberDTO mdto = this.dao.getMemInfo(fdto.getFollow_name());
				
			//회원정보 저장
			followingCont.add(mdto);
		}
			
		model.addAttribute("followingCont", followingCont);
		model.addAttribute("id", id); //피드 아이디
			
		return "member/feed_following";
		}
	
	//회원 언팔 기능
	@RequestMapping("unfollow.do")
	public void unfollow(@RequestParam("id")String id, @RequestParam("feed")String feed,
			HttpServletResponse response, HttpSession session) throws IOException {
		
		String login = (String)session.getAttribute("login_id");
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("login",login);
		param.put("id", id);
		
		
		int check = this.followDao.deleteFollow(param);
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		
		if(check>0) {
			out.println("<script>");
			out.println("alert('언팔 완료')");
			out.println("location.href='myfeed.do?id="+feed+"'");
			out.println("</script>");
			
		}else {
			out.println("<script>");
			out.println("alert('언팔 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
	}
	
	//회원 팔로우기능
	@RequestMapping("follow.do")
	public void follow(@RequestParam("id")String id, @RequestParam("feed")String feed,HttpServletResponse response, HttpSession session) throws IOException {
		
		//id : 팔로우한 아이디 , feed : 누구의 feed에서 동작을 했는지 구분
		
		System.out.println("id:"+id +"feed:"+feed);
		
		//팔로우한 아이디 정보
		MemberDTO followInfo = this.dao.getMemInfo(id);
		
		//로그인아이디 정보
		MemberDTO login = this.dao.getMemInfo((String)session.getAttribute("login_id"));
		
		int check = this.followDao.insertFollow(login, followInfo);
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check>0) {
			out.println("<script>");
			out.println("alert('팔로우 성공')");
			out.println("location.href='myfeed.do?id="+feed+"'");
			out.println("</script>");
			
		}else {
			out.println("<script>");
			out.println("alert('팔로우 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
	
	//마이피드 - LIKE
	@RequestMapping("feed_like.do")
	public String feed_like(@RequestParam("id")String id, Model model) {
		
		//좋아요 누른 MUSIC 리스트 
		List<FollowDTO> musicLike = this.followDao.getMusicLike(id);
		
		//좋아요한 곡에 대한 정보 리스트
		List<MusicDTO> musicCont = new ArrayList<MusicDTO>();
		
		
		for(int i=0; i<musicLike.size(); i++) {
			
			FollowDTO fdto = musicLike.get(i);
			
			//좋아요한 곡 정보를 담아 리스트에 저장하기 
			MusicDTO mdto = this.musicDao.getMusicCont(fdto.getFollow_no());
			
			musicCont.add(mdto);
			
		}
		
		model.addAttribute("mLike", musicLike);
		model.addAttribute("mCont", musicCont);
		model.addAttribute("id", id);
		
		return "member/feed_like";
	}
	
	//
	@RequestMapping("delLike.do")
	public void delLike(@RequestParam("fno") int fno, @RequestParam("type") String type, HttpSession session,
					HttpServletResponse response) throws IOException {
		
		String login = (String)session.getAttribute("login_id");
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		
		param.put("login", login);
		param.put("fno", fno);
		param.put("type", type);
		
		int check = this.followDao.deleteLike(param);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check>0) {
			out.println("<script>");
			out.println("alert('좋아요 삭제 성공')");
			out.println("location.href='feed_like.do?id="+login+"'");
			out.println("</script>");
			
		}else {
			out.println("<script>");
			out.println("alert('좋아요 삭제 실패')");
			out.println("history.back()");
			out.println("</script>");
		}
		
	}
	
	
	//마이피드 - 포스팅 
	@RequestMapping("feed_posting.do")
	public String feed_posting(@RequestParam("id")String id, Model model, HttpSession session) {
		
		//내가 쓴 커뮤니티게시판 글 리스트 가져오기  - myfeed.do에서 세션 저장해둠 
//		List<CommunityDTO> commList = this.comDao.getCommunityList(id);
//		feedInfo.put("commList", commList);
		
		// 게시글 카테고리 리스트를 가져옴
		List<BoardCategoryDTO> categorylist = this.bcDao.getCategoryList();
		
		
		model.addAttribute("cList", categorylist);
		model.addAttribute("id", (String)session.getAttribute("login_id"));
		return "member/feed_posting";
	}
	
	}
