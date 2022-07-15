package com.idol.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class InquiryDAOImpl implements InquiryDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	//문의게시글 리스트 
	@Override
	public List<InquiryDTO> getInquiryList(String member_id) {
		return this.sqlSession.selectList("inquiryList", member_id);
	}
	
	//페이징처리 게시글 리스트
	@Override
	public List<InquiryDTO> getInquiryList(HashMap<String, Object> map) {
		//일반 게시글 리스트
		if(map.get("startDate") == null) {
			return this.sqlSession.selectList("listwithPage", map);
		}else {
		//날짜조회 리스트 
			return this.sqlSession.selectList("listwithDate", map);
		}
		
		//날짜조회 리스트
	}
	
	//문의게시글 카테고리 
	@Override
	public List<Inquiry_CategoryDTO> getInquiryCategory() {
		return this.sqlSession.selectList("inquiryCategory");
	}

	//문의글 작성
	@Override
	public int insertInquiry(InquiryDTO dto) {
		return this.sqlSession.insert("insertInquiry", dto);
	}

	//총 게시물
	@Override
	public int getBoardCount(String id) {
		return this.sqlSession.selectOne("boardCount", id);
	}
	
	//날짜 조회 총 게시물
	@Override
	public int getBoardCount(HashMap<String, Object> map) {
		return this.sqlSession.selectOne("dateBoard", map);
	}

	//답변 대기중인 게시글 
	@Override
	public int watingReply(String id) {
		return this.sqlSession.selectOne("waitReply", id);
	}

	//문의게시글 조회수 증가
	@Override
	public void updateHit(int no) {
		this.sqlSession.update("updateHit", no);
	}

	//문의게시글 내용 
	@Override
	public InquiryDTO getInquirycont(int no) {
		return this.sqlSession.selectOne("inquiryCont", no);
	}

	//게시글 삭제
	@Override
	public int deleteInquiry(int no) {
		return this.sqlSession.delete("inquiryDel", no);
	}

	//삭제에 따른 게시글 번호 조정
	@Override
	public void adjustIno(int no) {
		
		this.sqlSession.update("adjustIno", no);
		
	}

	//원글에 답변이 있는 경우
	@Override
	public InquiryDTO getReplyCont(int no) {
		return this.sqlSession.selectOne("replyCont", no);
	}

	@Override
	public int updateInquiry(InquiryDTO dto) {
		return this.sqlSession.update("inquiryUpdate", dto);
	}

	

	
	
}
