package com.idol.model;

import java.util.List;

public interface BoardRecommendDAO {
	
	// 회원번호를 받아 회원의 추천한정보를 리스트로 받아온다.
	List<BoardRecommendDTO> getRecommendList(int memno);
	
	// 게시물 추천정보 추가
	int insertRecommend(BoardRecommendDTO recommenddto);
	
	// 게시물 추천정보 삭제
	int deleteRecommend(int bno);

}
