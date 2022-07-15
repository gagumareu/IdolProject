package com.idol.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RankingDAOImpl implements RankingDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
/* **********************희원님 *************************/
	
	@Override
	public List<RankingDTO> mostMessages(HashMap<String, String> map) {
		return sqlSession.selectList("message", map);
	}


	@Override
	public List<RankingDTO> mostMileage(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("accumulated", map);
	}


	@Override
	public List<MemberDTO> todayBirth(HashMap<String, String> map) {
		return sqlSession.selectList("birth", map);
	}


	@Override
	public List<RankingDTO> mostPurchase(HashMap<String, String> map) {
		return sqlSession.selectList("purchase", map);
	}


	@Override
	public List<RankingDTO> mostReferrals(HashMap<String, String> map) {
		return sqlSession.selectList("referrals", map);
	}


	@Override
	public List<RankingDTO> mostComment(HashMap<String, String> map) {
		return sqlSession.selectList("comment", map);
	}
	
	
}
