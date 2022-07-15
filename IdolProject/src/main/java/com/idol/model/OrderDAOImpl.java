package com.idol.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderDAOImpl implements OrderDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int addOrder(OrderDTO orderdto) {
		return sqlSession.insert("addOrder", orderdto);
	}

	//회원의 구매내역 전체리스트 불러오기
	@Override
	public List<OrderDTO> getOrderList(String id) {
		return this.sqlSession.selectList("orderAllList", id);
	}
	
	//구매내역 날짜 리스트
	@Override
	public List<String> getOrderDates(String id) {
		return this.sqlSession.selectList("orderDates", id);
	}

	//날짜별 구매리스트
	@Override
	public List<OrderDTO> getOrderDateList(HashMap<String, String> params) {
		return this.sqlSession.selectList("orderListDate", params);
	}

	
	//원석
	// 새로운 주문그룹을 반환하는 메서드
	@Override
	public int newGroupNo() {
		return sqlSession.selectOne("newGroupno");
	}

	@Override
	public List<OrderDTO> getLastOrderList(String memid) {
		return sqlSession.selectList("lastorder", memid);
	}

	//주무정보 불러오기
	@Override
	public OrderDTO getOrderCont(int ono) {
		return this.sqlSession.selectOne("orderCont", ono);
	}

	//주문 그룹 정보 불러오기
	@Override
	public List<OrderDTO> getOrderGroup(int ogno) {
		return this.sqlSession.selectList("orderGroup", ogno);
	}

	//주문그룹내역 삭제
	@Override
	public int deleteOgno(int ogno) {
		return this.sqlSession.delete("deleteOgno", ogno);
	}

	//날짜검색한 구매내역 날짜들 
	@Override
	public List<String> getOrderDates(HashMap<String, Object> map) {
		return this.sqlSession.selectList("orderListDateSearch", map);
	}

	//최근 3일간 구매한 건수 
	@Override
	public int get3daysOrder(String member_id) {
		return this.sqlSession.selectOne("3daysOrder", member_id);
	}

	
	
	
}
