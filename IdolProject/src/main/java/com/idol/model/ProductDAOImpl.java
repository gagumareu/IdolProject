package com.idol.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProductDAOImpl implements ProductDAO{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 모든 제품리스트 출력
	@Override
	public List<ProductDTO> getProductListAll() {
		return sqlSession.selectList("allList");
	}
	

	// 제품 카테고리별로 리스트를 출력
	@Override
	public List<ProductDTO> getProductList(int cno,String kind) {
		List<ProductDTO> list = null;
		
		if(cno%100 == 0) {
			// 큰카테고리의 신제품 기준으로 리스트를 불러옴
			if(kind.equals("new")) {
				list =  sqlSession.selectList("PCNList", cno);
			}
			// 큰카테고리 이름 기준으로 리스트를 불러옴
			else if(kind.equals("name")) {
				list =  sqlSession.selectList("PCNaList", cno);
			}
			// 큰카테고리 낮은가격 기준으로 리스트를 불러옴
			else if(kind.equals("row")) {
				list =  sqlSession.selectList("PCRList", cno);
			}
			// 큰카테고리 높은가격 기준으로 리스트를 불러옴
			else if(kind.equals("high")) {
				list =  sqlSession.selectList("PCHList", cno);
			}
			
		}else {
			// 세부테고리의 신제품 기준으로 리스트를 불러옴
			if(kind.equals("new")) {
				list =  sqlSession.selectList("PcNList", cno);
			}
			// 세부테고리의 이름 기준으로 리스트를 불러옴
			else if(kind.equals("name")) {
				list =  sqlSession.selectList("PcNaList", cno);
			}
			// 세부테고리의 낮은가격 기준으로 리스트를 불러옴
			else if(kind.equals("row")) {
				list =  sqlSession.selectList("PcRList", cno);
			}
			// 세부테고리의 높은가격 기준으로 리스트를 불러옴
			else if(kind.equals("high")) {
				list =  sqlSession.selectList("PcHList", cno);
			}
		}
		
		return list;
		
	}

	@Override
	public ProductDTO getProductDetail(int pno) {
		return sqlSession.selectOne("Pdetail", pno);
	}


	//문의게시글 상품검색한 데이터 수
	@Override
	public int productTotalRecord(HashMap<String, Object> maps) {
		return this.sqlSession.selectOne("totalRecord", maps);
	}

	//문의게시글 상품검색한 리스트
	@Override
	public List<InquiryDTO> productListPage(HashMap<String, Object> maps) {
		return this.sqlSession.selectList("productListPage", maps);
	}

	//메인 슬라이더용 리스트 -희원
	@Override
	public List<ProductDTO> mainProductList() {
		return this.sqlSession.selectList("mainProductList");
	}
	
	
	//제품명으로 제품정보 찾기
	@Override
	public ProductDTO getProductDetail(String order_pname) {
		return this.sqlSession.selectOne("PdetailbyName", order_pname);
	}
	

	
	
}
