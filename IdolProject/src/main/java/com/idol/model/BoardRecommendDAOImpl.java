package com.idol.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardRecommendDAOImpl implements BoardRecommendDAO {
	@Autowired
	private SqlSession sqlSession;

	// 회원번호를 받아 회원의 추천한정보를 리스트로 받아온다.
	@Override
	public List<BoardRecommendDTO> getRecommendList(int memno) {
		return sqlSession.selectList("recommendList",memno);
	}
	
	// 게시물 추천정보 추가
	@Override
	public int insertRecommend(BoardRecommendDTO recommenddto) {
		return sqlSession.insert("insertRecommend", recommenddto);
	}
	// 게시물 추천정보 삭제
	@Override
	public int deleteRecommend(int bno) {
		return sqlSession.delete("deleteRecommend", bno);
	}
	
	
}
