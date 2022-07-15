package com.idol.model;

import java.util.List;

public interface AdminProductDAO {
	
	// 상품 리스트 불러오기
	public List<ProductDTO> getProductList();
	// 상품 카테고리 생성하기 (insert)
	public int insertProductCategory(ProductCategoryDTO pCategoryDTO);
	// 셀럽 리스트 가져오기
	public List<CelebDTO> getCelebList();
	// productCategory 리스트 가져오기
	public List<ProductCategoryDTO> getProductCategory();
	// 상품 등록 하기 
	public int insertPorduct(ProductDTO dto);
	// 상품 상세 정보 가져오기
	public ProductDTO getProductCont(int no);
	// 상품 삭제 하기 
	public int deleteProduct(int no);
	// 상품 삭제후 넘버링 재정의
	public void updateProductSequen(int no);
	// 상품 업데이트 하기 
	public int updateProduct(ProductDTO dto);
	// 주문리스트 불러오기
	public List<OrderDTO> getOrderList();
	// 주문 상세 정보 불러오기 
	public OrderDTO getOrderCont(int no);
	// 주문 그룹 리스트 불러오기 by order_group (그룹 번호 = 주문번호)
	public List<OrderDTO> getOrderContList(int no);
	// 맴버별 구매내역 불러오기 
	public List<OrderDTO> getMemberPurchaseInfo(String name);
	// test
	public List<OrderDTO> getTestRange(DateRangeDTO dto);
	
	
	
}
