package com.idol.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminProductDAOImpl implements AdminProductDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 상품 리스트 불러오기
	@Override
	public List<ProductDTO> getProductList() {
		return this.sqlSession.selectList("getProductsList");
	}
	
	// 상품 카테고리 등록하기
	@Override
	public int insertProductCategory(ProductCategoryDTO pCategoryDTO) {
		return this.sqlSession.insert("insertProductCategory", pCategoryDTO);
	}

	// 셀럽리스트 불러오기 (나중에 통합하여 정리해야 됌)
	@Override
	public List<CelebDTO> getCelebList() {
		return this.sqlSession.selectList("celebList");
	}

	// 상품 카테고리 불러오기
	@Override
	public List<ProductCategoryDTO> getProductCategory() {
		return this.sqlSession.selectList("getPCategoryList");
	}

	// 상품 등록하기 
	@Override
	public int insertPorduct(ProductDTO dto) {
		return this.sqlSession.insert("insertProduct", dto);
	}

	// 상품 상세 정보 불어괴 by no
	@Override
	public ProductDTO getProductCont(int no) {
		
		return this.sqlSession.selectOne("getProductCont", no);
	}

	// 상품 삭제하기 
	@Override
	public int deleteProduct(int no) {
		return this.sqlSession.delete("deleteProduct", no);
	}
	
	// 상품 삭제 후 넘버링 재정의
	@Override
	public void updateProductSequen(int no) {
		this.sqlSession.update("updateProNoSequen", no);
		
	}

	// 상품 정보 업데이트 하기 
	@Override
	public int updateProduct(ProductDTO dto) {
		return this.sqlSession.update("updateProduct", dto);
	}

	// 주문 리스트 불러오기 by order_date
	@Override
	public List<OrderDTO> getOrderList() {
		return this.sqlSession.selectList("getOrderList");
	}
	
	// 오더번호 상세 정보 가져오기 by order_no
	@Override
	public OrderDTO getOrderCont(int no) {
		return this.sqlSession.selectOne("getOrderCont", no);
	}
	
	// 그룹 번호 리스트 불러오기 (그룹번호 = 주문번호) by order_group
	@Override
	public List<OrderDTO> getOrderContList(int no) {
		return this.sqlSession.selectList("getOrderContList", no);
	}

	@Override
	public List<OrderDTO> getMemberPurchaseInfo(String name) {
		return this.sqlSession.selectList("getMemberPurchase", name);
	}

	@Override
	public List<OrderDTO> getTestRange(DateRangeDTO dto) {
		return this.sqlSession.selectList("DateRageSales", dto);
	}
	
	
	

}
