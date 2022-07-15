package com.idol.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CartDAOImpl implements CartDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 카트테이블에 제품정보 추가
	@Override
	public int addCart(CartDTO cartdto) {
		return sqlSession.insert("addCart", cartdto);
	}
	
	// 카트테이블 카트번호에 해당하는 정보 삭제
	@Override
	public int deleteCart(int cno) {
		return sqlSession.delete("deleteCart", cno);
	}
	
	// 유저정보에 저장되어 있는 카트정보 리스트 출력
	@Override
	public List<CartDTO> getCartList(int userno) {
		return sqlSession.selectList("CartList", userno);
	}
	
	// 유저정보에 저장되어 있는 카트정보의 세부사항 출력
	@Override
	public CartDTO getcartDetail(int cno) {
		return sqlSession.selectOne("cartDetail", cno);
	}

	// 카트 수량변경
	@Override
	public int UpdateCart(int cno, int cqty) {
		Map<String, Integer> map = new HashMap<String, Integer>(); 
		map.put("cart_no", cno);
		map.put("cart_pqty", cqty);
		return sqlSession.update("updateCart", map);
	}
	
	// 유저번호와 제품번호를 인자로 받아 카트에 제품이 존재하는지 여부를 확인
	@Override
	public int checkCart(int memno,int pno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("cart_userno", memno);
		map.put("cart_pno", pno);
		
		return sqlSession.selectOne("cartCheck", map);
	}

	
}
