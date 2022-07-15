package com.idol.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.idol.model.CartDAO;
import com.idol.model.CartDTO;
import com.idol.model.CelebDAO;
import com.idol.model.CelebDTO;
import com.idol.model.MemberDAO;
import com.idol.model.MemberDTO;
import com.idol.model.MileageDAO;
import com.idol.model.MileageDTO;
import com.idol.model.OrderDAO;
import com.idol.model.OrderDTO;
import com.idol.model.ProductDAO;
import com.idol.model.ProductDTO;


@Controller
public class ProductController {
	
	@Autowired
	private ProductDAO Productdao;
	
	@Autowired
	private CelebDAO Celebdao;
	
	@Autowired
	private MemberDAO Memberdao;
	
	@Autowired
	private CartDAO Cartdao;
	
	@Autowired
	private MileageDAO Mileagedao;
	
	@Autowired
	private OrderDAO Orderdao;
	
	
	// 제품 카테고리별로 리스트를 출력하여 제품테이블에 출력
	@RequestMapping("product_list.do")
	public String product_list(@RequestParam("cno") int cno,Model model, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		session.setAttribute("loginInfo", loginInfo);

		
		String kind = request.getParameter("list_kind");
		
		if(kind == null) {
			kind = "new";
		}

		List<ProductDTO> plist = Productdao.getProductList(cno,kind);
		List<CelebDTO> clist = Celebdao.getCelebList();
		
		//제품 리스트의 이미지를 첫번째 이미지인 대표이미지로 잘라낸다
		for(int i = 0;i<plist.size();i++) {
			StringTokenizer st = new StringTokenizer(plist.get(i).getProduct_image(), "|");
			String root = st.nextToken();
			plist.get(i).setProduct_image(root);
		}

		model.addAttribute("PList", plist);
		model.addAttribute("CList", clist);
		model.addAttribute("ListKind", kind);
		model.addAttribute("ListCate", cno);
		model.addAttribute("loginInfo", loginInfo);
		
		return "product/product_list";
	}
	

	@RequestMapping("product_detail.do")
	public String product_detail(@RequestParam("pno") int pno,Model model, HttpServletRequest request) {
		
		// 임시세션값을 가져온다.
		HttpSession session = request.getSession();
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		
		
		//제품 디테일 정보
		ProductDTO pdto = Productdao.getProductDetail(pno);
		// 셀럽 그룹명
		CelebDTO cdto = Celebdao.getCelebInfo(pdto.getCeleb_no());
		
		StringTokenizer st = new StringTokenizer(pdto.getProduct_image(),"|");
		
		// 첫번째 대표이미지를 첫번째로 저장한다.
		String mainImage = st.nextToken();

		//첫번째 대표이미지 이후 제품디테일 이미지 를 리스트로 저장
		List<String> dmList = new ArrayList<String>();
		
		while(st.hasMoreTokens()) {
			String str = st.nextToken();
			if(str != null) {
			dmList.add(str);
			}
		}
		
		List<ProductDTO> plist = Productdao.getProductList(pdto.getCategory_pnofk(),"new");
		//제품 리스트의 이미지를 첫번째 이미지인 대표이미지로 잘라낸다
		for(int i = 0;i<plist.size();i++) {
			StringTokenizer st2 = new StringTokenizer(plist.get(i).getProduct_image(), "|");
			String root = st2.nextToken();
			plist.get(i).setProduct_image(root);
		}
		
		// 출고를 위한 월&일자를 가져온다.
		Calendar cal = Calendar.getInstance();
		
		int month = cal.get(Calendar.MONTH)+1;
		int day = cal.get(Calendar.DAY_OF_MONTH);
		
		model.addAttribute("loginInfo", loginInfo); // 회원세션 정보
		model.addAttribute("PDetail", pdto); // 제품 디테일 정보
		model.addAttribute("CDetail", cdto); // 제품 셀럽에 저장된 셀럽 그룹명
		model.addAttribute("PmImage", mainImage); // 제품메인이미지
		model.addAttribute("PdImageList", dmList); // 제품 디테일 이미지 
		model.addAttribute("PList", plist); // 함께하면 좋아요 상품리스트: 제품디테일 정보의 카테고리 분류의 최신상품리스트를 가져온다.
		model.addAttribute("Month", month); // 출고날짜 알림용 월
		model.addAttribute("Day", day); // 출고날짜 알림용 일자
		
		return "product/product_detail";
	}
	
	@RequestMapping("product_cartList.do")
	public String cartlist(@RequestParam("memno") int memno, Model model, HttpServletRequest request) {
		
		// 임시세션값을 가져온다.
		HttpSession session = request.getSession();
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		
		// 세선에 저장되어있는 memberdto의 memberno값을 이용하여 해당 유저가 가지고 있는 카트리스트를 가져온다.
		List<CartDTO> cartlist = Cartdao.getCartList(memno);
		
		// 2-2 카트리스트에 저장되 있는 제품의 그룹명을 가져오기 위한 셀럽리스트
		List<CelebDTO> celeblist = Celebdao.getCelebList();
		
		// 2-3 카트리스트에 저장되 있는 제품의 그룹명을 가져오기 위한 제품리스트
		List<ProductDTO> prdlist = Productdao.getProductListAll();
		
		// 3. order 페이지에 들어가야할 hidden type input
		// 3-1. 회원번호, 회원이름 loginInfo에서 가져옴
		
		
		model.addAttribute("loginInfo", loginInfo);
		model.addAttribute("cartList", cartlist);
		model.addAttribute("celebList", celeblist);
		model.addAttribute("prdList", prdlist);

				
				
		return "product/product_cartlist";
	}
	
	
	
	// ajax 제품번호에 유저번호를 받아 유저가 동일한 제품을 장바구니에 존재하는지 여부를 확인
	@RequestMapping(value="/product_checkbasket.do", method=RequestMethod.POST)
	@ResponseBody
	public String product_checkbasket(HttpServletRequest request) {
		int memno = Integer.parseInt(request.getParameter("memno").trim());
		int pno = Integer.parseInt(request.getParameter("pno").trim());
		
		String result = "0";
		int cehck = Cartdao.checkCart(memno,pno);
		
		if(cehck > 0) {
			result = "1";
		}
		
		return result;
		
	}

	
	
	
	
	// ajax 카트리스트에서 체크박스로 선택된 항목의 카트삭제
	@RequestMapping(value="/product_cartSelectedDelete.do", method=RequestMethod.POST)
	@ResponseBody
	public void product_cartSelectedDelete(@RequestParam(value="cartno[]") List<Integer> cartno,
											HttpServletRequest request,Model model) {
		for(int i=0;i<cartno.size();i++) {
			Cartdao.deleteCart(cartno.get(i));
		}
		
		
	}
	
	// ajax 카트리스트에서 개별항목의 카트삭제
	@RequestMapping(value="/product_cartDelete.do", method=RequestMethod.POST)
	@ResponseBody
	public void product_cartSelectedDelete(HttpServletRequest request,Model model) {
		
		int cno = Integer.parseInt(request.getParameter("cno").trim());
		
		Cartdao.deleteCart(cno);
	}
	
	// ajax 카트리스트에서 각 항목의 카트수량변경
	@RequestMapping(value="/product_cartUpdate.do", method=RequestMethod.POST)
	@ResponseBody
	public void product_cartUpdate(HttpServletRequest request) {
		int cno = Integer.parseInt(request.getParameter("cno").trim());
		int cqty = Integer.parseInt(request.getParameter("cqty").trim());
		
		int result = Cartdao.UpdateCart(cno, cqty);
		
	}
	
	@RequestMapping("product_orderFromCart.do")
	public String orderFromCart2(HttpServletRequest request,Model model) {
		
		// 임시세션값을 가져온다.
		HttpSession session = request.getSession();
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		
		// 2. order 페이지에는 장바구니에 선택된에 리스트만을 출력한다. 즉 장바구니 페이지에서 선택항목에 대한 카트리스트만이 주문페이지로 이동된다.
		// 장바구니페이지에서 전달받은 카트번호에 해당하는 DTO값이 cartList에 저장된다.
		List<CartDTO> cartlist = new ArrayList<CartDTO>();
		
		String strcartno = request.getParameter("cartNoArr");
		
		StringTokenizer st = new StringTokenizer(strcartno, ",");

		int [] cartno = new int[st.countTokens()];
		int index=0;
		while(st.hasMoreTokens()) {
			cartno[index] = Integer.parseInt(st.nextToken());
			index +=1;
			
		}	
		
		for(int i=0; i<cartno.length;i++) {
			CartDTO cartdto = Cartdao.getcartDetail(cartno[i]);
			cartlist.add(cartdto);
		}
		
//		// 카트리스트에 셀럽그룹명이 보여지기 위해서는 카트에 저장되 있는 제품번호로 제품리스트를 조회 -> 제품리스트 안에 있는 셀럽번호를 조회 -> 셀럽번호를 통해 셀럽그룹명을 찾는다. 
//		// 2-2 카트리스트에 저장되 있는 제품의 그룹명을 가져오기 위한 셀럽리스트
		List<CelebDTO> celeblist = Celebdao.getCelebList();
//		
//		// 2-3 카트리스트에 저장되 있는 제품의 셀럽번호을 가져오기 위한 제품리스트
		List<ProductDTO> prdlist = Productdao.getProductListAll();
//		
//		// 3. order 페이지에 들어가야할 hidden type input
//		// 3-1. 회원번호, 회원이름 loginInfo에서 가져옴
//		
//		// 3-2. 이메일 Front
		StringTokenizer st1 = new StringTokenizer(loginInfo.getMember_email(), "@");
		String email1 = st1.nextToken();
//		
//		// 3-3. 이메일 Domain
		String email2 = st1.nextToken();
//		
//		// 3-4. 우편번호(주소1)
		StringTokenizer st2 = new StringTokenizer(loginInfo.getMember_address(), "|");
		String addr1 = st2.nextToken();
//		// 3-5. 도로명주소(주소2)
		String addr2 = st2.nextToken();
//		// 3-6. 상세주소(주소3)
		String addr3 = st2.nextToken();
//		// 3-7. 참고항목(주소4)
		String addr4 = st2.nextToken();
//		
		String phone = loginInfo.getMember_phone();
//		// 3-8. 핸드폰번호1 010(3873)2870
		String phone1 = phone.substring(3, 7);
//		// 3-9. 핸드폰번호2 0103873(2870)
		String phone2 = phone.substring(7, 11);
//		
//		// 3-11. 회원의 사용가능한 마일리지
		int memMileage = Mileagedao.getreamining(loginInfo.getMember_no()); 
//		
//		// 3-12. 카트에 저장되있는 제품갯수와 마일리지를 고려한 총 마일리지
		int prdmileagetotal = 0;
		for(int i=0;i<cartlist.size();i++) {
			prdmileagetotal += (cartlist.get(i).getCart_pqty()) * (cartlist.get(i).getCart_mileage());
		}
		
//		// 3-13. 카트에 저장되있는 제품갯수와 가격을 고려한 총금액
		int prdtotal = 0;
		for(int i=0;i<cartlist.size();i++) {
			prdtotal += (cartlist.get(i).getCart_pqty()) * (cartlist.get(i).getCart_price());
		}
		
		
		model.addAttribute("cartList", cartlist);
		model.addAttribute("celebList", celeblist);
		model.addAttribute("prdList", prdlist);
		model.addAttribute("loginInfo", loginInfo);
		model.addAttribute("email1", email1);
		model.addAttribute("email2", email2);
		model.addAttribute("addr1", addr1);
		model.addAttribute("addr2", addr2);
		model.addAttribute("addr3", addr3);
		model.addAttribute("addr4", addr4);
		model.addAttribute("phone1", phone1);
		model.addAttribute("phone2", phone2);
		model.addAttribute("memMileage", memMileage);
		model.addAttribute("prdmileagetotal", prdmileagetotal);
		model.addAttribute("prdtotal", prdtotal);
		
		return "product/product_order";
	}
	
	
	
	// 제품정보페이지에서 구매버튼을 클릭하였을 경우 이동하는 주문페이지
	@RequestMapping("product_directorder.do")
	public String order(CartDTO cartdto, Model model, HttpServletRequest request) {
		
		// 임시세션값을 가져온다.
		HttpSession session = request.getSession();
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		
		// 1. 디테일 페이지로부터 받아오는 파라미터값은 우선적으로 카트테이블에 저장된다 
		// 디테일 페이지로부터 받아와서 카트dto에 할당되는 파라미터
		// 제품번호, 유저번호, 제품이름, 제품 수량, 제품개별!가격, 제품사이즈, 제품컬러, 제품이미지, 제품개별!마일리지
		int cartResult = Cartdao.addCart(cartdto);
		
		if(cartResult >0) {
			System.out.println("카트 추가 성공!");
		}
		
		// 2. order 페이지에는 카트에 담겨있는 리스트를 전부 출력한다. 즉 구매버튼을 누르면 자동으로 카트에 추가되고 이전에 추가되었던 카트리스트까지 출력된다.
		// 세선에 저장되어있는 memberdto의 memberno값을 이용하여 해당 유저가 가지고 있는 카트리스트를 가져온다.
		List<CartDTO> cartlist = Cartdao.getCartList(loginInfo.getMember_no());
		
		// 카트리스트에 셀럽그룹명이 보여지기 위해서는 카트에 저장되 있는 제품번호로 제품리스트를 조회 -> 제품리스트 안에 있는 셀럽번호를 조회 -> 셀럽번호를 통해 셀럽그룹명을 찾는다. 
		// 2-2 카트리스트에 저장되 있는 제품의 그룹명을 가져오기 위한 셀럽리스트
		List<CelebDTO> celeblist = Celebdao.getCelebList();
		
		// 2-3 카트리스트에 저장되 있는 제품의 셀럽번호을 가져오기 위한 제품리스트
		List<ProductDTO> prdlist = Productdao.getProductListAll();
		
		// 3. order 페이지에 들어가야할 hidden type input
		// 3-1. 회원번호, 회원이름 loginInfo에서 가져옴
		

		// 3-2. 이메일 Front
		StringTokenizer st1 = new StringTokenizer(loginInfo.getMember_email(), "@");
		String email1 = st1.nextToken();
		
		// 3-3. 이메일 Domain
		String email2 = st1.nextToken();
		
		// 3-4. 우편번호(주소1)
		StringTokenizer st2 = new StringTokenizer(loginInfo.getMember_address(), "|");
		String addr1 = st2.nextToken();
		// 3-5. 도로명주소(주소2)
		String addr2 = st2.nextToken();
		// 3-6. 상세주소(주소3)
		String addr3 = st2.nextToken();
		// 3-7. 참고항목(주소4)
		String addr4 = st2.nextToken();
		
		
		String phone = loginInfo.getMember_phone();
		// 3-8. 핸드폰번호1 010(3873)2870
		String phone1 = phone.substring(3, 7);
		// 3-9. 핸드폰번호2 0103873(2870)
		String phone2 = phone.substring(7, 11);
		// 3-11. 회원의 사용가능한 마일리지
		int memMileage = Mileagedao.getreamining(loginInfo.getMember_no()); 
		
		// 3-12. 카트에 저장되있는 제품갯수와 마일리지를 고려한 총 마일리지
		int prdmileagetotal = 0;
		for(int i=0;i<cartlist.size();i++) {
			prdmileagetotal += (cartlist.get(i).getCart_pqty()) * (cartlist.get(i).getCart_mileage());
		}
		
		// 3-13. 카트에 저장되있는 제품갯수와 가격을 고려한 총금액
		int prdtotal = 0;
		for(int i=0;i<cartlist.size();i++) {
			prdtotal += (cartlist.get(i).getCart_pqty()) * (cartlist.get(i).getCart_price());
		}
		
		model.addAttribute("cartList", cartlist);
		model.addAttribute("celebList", celeblist);
		model.addAttribute("prdList", prdlist);
		model.addAttribute("loginInfo", loginInfo);
		model.addAttribute("email1", email1);
		model.addAttribute("email2", email2);
		model.addAttribute("addr1", addr1);
		model.addAttribute("addr2", addr2);
		model.addAttribute("addr3", addr3);
		model.addAttribute("addr4", addr4);
		model.addAttribute("phone1", phone1);
		model.addAttribute("phone2", phone2);
		model.addAttribute("memMileage", memMileage);
		model.addAttribute("prdmileagetotal", prdmileagetotal);
		model.addAttribute("prdtotal", prdtotal);

		return "product/product_order";
	}
	
	@RequestMapping("product_order_ok.do")
	public String orderOk(OrderDTO inputorderdto,HttpServletRequest request,Model model) {
		
		// 임시세션값을 가져온다.
		HttpSession session = request.getSession();
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		
		// -------------------------제품구매 마일리지 차감---------------------------------------
		// 결제시 사용한 마일리지 값을 가져온다.
		int usemileage = Integer.parseInt(request.getParameter("mileageUse").trim());
		// 제품결제시 마일리지가 0이 아니면 마일리지를 사용한것으로 간주 -> 마일리지 참감절차를 시행
		MileageDTO nowmdto = new MileageDTO();
		if(usemileage > 0) {
			
			// 새로운 마일리지 정보를 추가하기 위해 기존에있는 유저의 최신마일리지 정보를 획득
			nowmdto = Mileagedao.getMileageDetail(loginInfo.getMember_no());
			
			// 새로운 마일리지 정보를 기존마일리지값에 업데이트하여 추가한다.
			MileageDTO mdto = new MileageDTO();
			mdto.setMileage_memno(loginInfo.getMember_no());
			// 마일리지 사용시 남아있는 마일리지에 사용한 마일리지를 차감
			mdto.setMileage_remaining(nowmdto.getMileage_remaining()-usemileage);
			// 마일리시 사용시 획득은 제로
			mdto.setMileage_earn(0);
			// 마일리지 사용시 차감마일리지 
			mdto.setMileage_deduction(usemileage);
			// 마일리지 사용시  누적획득금액은 변동이 없으며 획득시에만 누적에 플러스
			mdto.setMileage_accumulated(nowmdto.getMileage_accumulated());
			mdto.setMileage_type("제품구매 차감");
			int mresult1 = Mileagedao.insertMileageInfo(mdto);
			if(mresult1 >0) {
				System.out.println("제품구매시 사용한 마일리지 정보 추가 완료");
			}

		}
		
		
		// -------------------------제품구매 마일리지 획득---------------------------------------
		
		int prdmileagetotal = Integer.parseInt(request.getParameter("prdmileagetotal").trim());
	
		// 새로운 마일리지 정보를 추가하기 위해 기존에있는 유저의 최신마일리지 정보를 획득
		nowmdto = Mileagedao.getMileageDetail(loginInfo.getMember_no());
		
		// 새로운 마일리지 정보를 기존마일리지값에 업데이트하여 추가한다.
		MileageDTO mdto = new MileageDTO();
		mdto.setMileage_memno(loginInfo.getMember_no());
		// 마일리지 획득시 남아있는 마일리지에 획득할 제품 총 마일리지를 추가
		mdto.setMileage_remaining(nowmdto.getMileage_remaining()+prdmileagetotal);
		// 마일리시 획득시 획득할마일리지
		mdto.setMileage_earn(prdmileagetotal);
		// 마일리지 획득시 차감마일리지는 제로 
		mdto.setMileage_deduction(0);
		// 마일리지 획득시  누적획득금액은  획득할 제품 총 마일리지를  플러스
		mdto.setMileage_accumulated(nowmdto.getMileage_accumulated()+prdmileagetotal);
		mdto.setMileage_type("제품구매 획득");
		int mresult2 = Mileagedao.insertMileageInfo(mdto);
		if(mresult2 >0) {
			System.out.println("제품구매시 획득한 마일리지 정보 추가 완료");
		}
			
			
		// 카트리스트 번호를 배열로 가져온다 가져올 때에는 Str타입이기 때문에 변환이 필요하다
		String[] strcartno = request.getParameterValues("cartNo");
		int[] cartno = new int[strcartno.length];
		
		// 카트리스트의 번호를 int 타입으로 변환후 카트번호를 통해 불러온 카트리스트에 각 dto를 추가한다.
		List<CartDTO> cartlist = new ArrayList<CartDTO>();
		
		for(int i=0; i<cartno.length;i++) {
			cartno[i] = Integer.parseInt(strcartno[i]);
			CartDTO cartdto = Cartdao.getcartDetail(cartno[i]);
			cartlist.add(cartdto);
		}
		
		
		// 결제시 카트리스트에 담겨있는 정보가 order테이블의 각 행으로 들어간다 이때 배송비는 카트리스트의 첫번째 항목만 결제테이블에 운송비에 추가된다.
		int prdtotal = 0;
		int totalorder = 0;
		int index = 0;
		int deliberyFee = 3000;
		
		int orderGroupno = Orderdao.newGroupNo();
		  for(int j=0; j<cartlist.size();j++) {
			  OrderDTO orderdto = new OrderDTO();
			  orderdto.setOrder_userid(loginInfo.getMember_id());
			  orderdto.setOrder_pimage(cartlist.get(j).getCart_pimage());
			  orderdto.setOrder_pname(cartlist.get(j).getCart_pname());
			  orderdto.setOrder_qty(cartlist.get(j).getCart_pqty());
			  prdtotal+= (cartlist.get(j).getCart_pqty() * (cartlist.get(j).getCart_price()));
			  if(j==index) {  
				  if(((cartlist.get(j).getCart_pqty()) * (cartlist.get(j).getCart_price()))+deliberyFee >= usemileage) {
				  orderdto.setOrder_total(((cartlist.get(j).getCart_pqty()) * (cartlist.get(j).getCart_price()))+deliberyFee-usemileage);
				  orderdto.setOrder_tcost(deliberyFee);  
				  totalorder += (((cartlist.get(j).getCart_pqty()) * (cartlist.get(j).getCart_price()))+deliberyFee-usemileage);
				  }else {
					  int spare = ((cartlist.get(j).getCart_pqty()) * (cartlist.get(j).getCart_price()))+deliberyFee;
					  usemileage -= spare;
					  orderdto.setOrder_total(((cartlist.get(j).getCart_pqty()) * (cartlist.get(j).getCart_price()))+deliberyFee-spare);
					  orderdto.setOrder_tcost(deliberyFee);  
					  totalorder += (((cartlist.get(j).getCart_pqty()) * (cartlist.get(j).getCart_price()))+deliberyFee-spare);
					  index +=1;
					  deliberyFee = 0;
				  }
			  }else {
				  orderdto.setOrder_total((cartlist.get(j).getCart_pqty()) * (cartlist.get(j).getCart_price()));
				  orderdto.setOrder_tcost(0); 
				  totalorder += (cartlist.get(j).getCart_pqty()) * (cartlist.get(j).getCart_price());
			  }
			  
			  orderdto.setOrder_mileage((cartlist.get(j).getCart_pqty()) * (cartlist.get(j).getCart_mileage()));
			  orderdto.setOrder_type(inputorderdto.getOrder_type());
			  orderdto.setOrder_group(orderGroupno);
			  orderdto.setOrder_receivername(inputorderdto.getOrder_receivername());
			  // 배송지 우편코드, 도로명주소, 상세주소, 참고항목
			  String addr1 = request.getParameter("addr1").trim();
			  String addr2 = request.getParameter("addr2").trim();
			  String addr3 = request.getParameter("addr3").trim();
			  String addr4 = request.getParameter("addr4").trim();
			  orderdto.setOrder_receiveraddress(addr1+"|"+addr2+"|"+addr3+"|"+addr4);
			  
			  // 배송지 연락처
			  String phone1 = request.getParameter("phone1").trim();
			  String phone2 = request.getParameter("phone2").trim();
			  String phone3 = request.getParameter("phone3").trim();
			  
			  orderdto.setOrder_receiverphone(phone1+phone2+phone3);		
			  orderdto.setOrder_pprice(cartlist.get(j).getCart_price());
			  
			  int result1 = Orderdao.addOrder(orderdto);
			  
			  if(result1 > 0) {
			  System.out.println(j+"번째 카트 주문 성공");
			  }
			  
			  
			  // 결제완료 페이지에는 카트에 저장되어 있는 항목이 주문이 완료되었다는 표시를 위해 카트리스트를 결제완료페이지로 이동시킨다. 삭제 이전에 이동시켜야 한다.
			  model.addAttribute("cartList", cartlist);
			  
			  int result2 = Cartdao.deleteCart(cartlist.get(j).getCart_no());
			  if(result2 > 0) {
				  System.out.println(j+"번째 카트정보 삭제 성공");
			   }
			  
		  }
		  
		  List<OrderDTO> orderlist = Orderdao.getLastOrderList(loginInfo.getMember_id());
		  // 제품구매날짜 : 그룹의 첫행의 날짜를 가져온다.
		  String orderdate = orderlist.get(0).getOrder_date();
		  
		  // 제품구매번호: 첫행의 날짜 + 그룹번호
		  String orderNo = orderdate.substring(0, 4)+orderdate.substring(5, 7)+orderdate.substring(8, 10)+"-"+orderlist.get(0).getOrder_group();
		  
		  // 결제타입
		  String payMethod = request.getParameter("payMethod").trim();
		  
		  // 배송지 정보
		  
		  // 수취인
		  String receivername = orderlist.get(0).getOrder_receivername();
		  
		// 수취인 연락처
		// 핸드폰번호1 010(3873)2870
		String phone1 = (String) orderlist.get(0).getOrder_receiverphone().subSequence(3, 7);
		// 핸드폰번호2 0103873(2870)
		String phone2 = (String) orderlist.get(0).getOrder_receiverphone().subSequence(7, 11);
		
		String receiverphone = "010-"+phone1+"-"+phone2;
	 
		
		//주문리스트
		// 주문완료 페이지의 리스트는 삭제 이전의 장바구니 리스트가 표출된다.
		// 주문테이블에 적용된 제품의 금액은 첫번째행부터 운송비와 마일리지가 적용된 금액이 표시되기 때문에 주문총금액 및 날짜 확인용으로 사용한다.
		
		// 배송지정보
		StringTokenizer st = new StringTokenizer(orderlist.get(0).getOrder_receiveraddress(), "|");
		// 우편번호
		String addr1 = st.nextToken();
		// 도로명주소
		String addr2 = st.nextToken();
		// 상세주소
		String addr3 = st.nextToken();
		// 참고항목
		String addr4 = st.nextToken();
		
		// 수취인 우편번호
		String receiverzipcode = addr1;
		// 수취인 주소
		String receiveraddr = addr2+" "+addr3+" "+addr4;
		
		// 배송메시지
		String message = request.getParameter("omessage").trim();
		
		// 카트리스트에 셀럽그룹명이 보여지기 위해서는 카트에 저장되 있는 제품번호로 제품리스트를 조회 -> 제품리스트 안에 있는 셀럽번호를 조회 -> 셀럽번호를 통해 셀럽그룹명을 찾는다. 
		// 카트리스트에 저장되 있는 제품의 그룹명을 가져오기 위한 셀럽리스트
		List<CelebDTO> celeblist = Celebdao.getCelebList();
		
		// 카트리스트에 저장되 있는 제품의 셀럽번호을 가져오기 위한 제품리스트
		List<ProductDTO> prdlist = Productdao.getProductListAll();
		
	
		
		
		model.addAttribute("celebList",celeblist);
		model.addAttribute("prdList",prdlist);
		
		model.addAttribute("orderNo",orderNo);
		model.addAttribute("orderdate",orderdate);
		model.addAttribute("prdtotal",prdtotal);
		model.addAttribute("totalorder",totalorder);
		model.addAttribute("payMethod",payMethod);
		model.addAttribute("prdmileagetotal",prdmileagetotal);
		model.addAttribute("usemileage",usemileage);
		model.addAttribute("receivername",receivername);
		model.addAttribute("receiverphone",receiverphone);
		model.addAttribute("receiverzipcode",receiverzipcode);
		model.addAttribute("receiveraddr",receiveraddr);
		model.addAttribute("message",message);
		
		
		return "product/product_order_ok";
	}
	
	// Ajax 장바구니 추가 
	@RequestMapping(value="/product_addbasket.do", method=RequestMethod.POST)
	@ResponseBody
	public String addbasket(@RequestParam("pno") int pno,
			@RequestParam("pqty") int pqty,@RequestParam("pimage") String pimage,HttpServletRequest request) {
		
		// 임시세션값을 가져온다.
		HttpSession session = request.getSession();
		MemberDTO loginInfo = (MemberDTO)session.getAttribute("loginInfo");
		
		ProductDTO pdto =  Productdao.getProductDetail(pno);
		CartDTO cdto = new CartDTO();
		
		if(loginInfo != null) {
		cdto.setCart_pno(pno);
		cdto.setCart_userno(loginInfo.getMember_no());
		cdto.setCart_pname(pdto.getProduct_name());
		cdto.setCart_pqty(pqty);
		cdto.setCart_price(pdto.getProduct_price());
		cdto.setCart_psize((pdto.getProduct_size() == null)? "": pdto.getProduct_size());
		cdto.setCart_pcolor((pdto.getProduct_color() == null)? "": pdto.getProduct_color() );
		cdto.setCart_pimage(pimage);
		cdto.setCart_mileage(pdto.getProduct_mileage()*pqty);
		}else {
			System.out.println("로그인 정보 못불러옴");
		}
		
		int result = Cartdao.addCart(cdto);
		
		return String.valueOf(result);
	}
	
	
}
