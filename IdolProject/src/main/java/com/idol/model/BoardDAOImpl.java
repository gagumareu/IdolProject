package com.idol.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired
	private SqlSession sqlSession;

	
	//게시물 전체 리스트를 출력하는 메서드
	@Override
	public List<BoardDTO> getAllBoardList() {
		return sqlSession.selectList("allBoardList");
	}

	// 게시물 작성
	@Override
	public int boardWrite(BoardDTO boarddto) {
		return sqlSession.insert("boardWrite", boarddto);
	}

	// 베스트게시물 리스트 출력
	@Override
	public List<BoardDTO> getBestList() {
		return sqlSession.selectList("BestList");
	}
	
	// 일반주제 리스트 출력
	@Override
	public List<BoardDTO> getTopicList(int cno) {
		return sqlSession.selectList("TopicList", cno);
	}
	
	// 검색 게시물 리스트 출력
	@Override
	public List<BoardDTO> getSearchList(String keyword) {
		return sqlSession.selectList("searchList", keyword);
	}
	
	// 마지막 게시물 번호를 획득
	@Override
	public int getMaxBoardNo() {
		return sqlSession.selectOne("maxNo");
	}
	
	// 게시물 상세정보
	@Override
	public BoardDTO getboardDetail(int bno) {
		return sqlSession.selectOne("boardDetail", bno);
	}

	// 게시물 조회수 업데이트
	@Override
	public void boardHitUp(int bno) {
		sqlSession.update("hitUp", bno);
		
	}

	// 게시물 삭제
	@Override
	public int deleteBoard(int bno) {
		return sqlSession.delete("deleteBoard", bno);
	}

	// 게시물 업데이트
	@Override
	public int boardUpdate(BoardDTO boarddto) {
		return sqlSession.update("boardUpdate", boarddto);
	}
	
	// 게시물 추천수 증가
	@Override
	public void boardRecommendAdd(int bno) {
		sqlSession.update("recommendtAdd", bno);
		
	}
	
	// 게시물 추천수 감소
	@Override
	public void boardRecommendMinus(int bno) {
		sqlSession.update("recommendtMinus", bno);
		
	}
	
	// 게시물 작성갯수에 따른 유저랭킹
	@Override
	public List<BoardrankingDTO> boardrankingList() {
		return sqlSession.selectList("rangkingList");
	}
	
	// 게시물 카테고리에 따른 날짜 및 추천수에 따른 게시물 리스트
	@Override
	public List<BoardDTO> boardDateRecommendList(int cno) {
		return sqlSession.selectList("boardDateRecommendList", cno);
	}
	

}
