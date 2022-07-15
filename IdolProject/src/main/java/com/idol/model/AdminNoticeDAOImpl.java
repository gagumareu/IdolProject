package com.idol.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminNoticeDAOImpl implements AdminNoticeDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 공지 등록
	@Override
	public int insertNotice(NoticeDTO dto) {

		return this.sqlSession.insert("insertNotice", dto);
	}

	// 공지 리스트 불러오기
	@Override
	public List<NoticeDTO> getNoticeList() {
		return this.sqlSession.selectList("noticeLsit");
	}

	// 공지 상세 내역 불러오기 
	@Override
	public NoticeDTO getNoticeContent(int no) {
		return this.sqlSession.selectOne("noticeCont", no);
	}

	// 공지 삭제 하기
	@Override
	public int deleteNotice(int no) {
		return this.sqlSession.delete("deleteNotice", no);
	}

	// 넘버링 시퀀스
	@Override
	public void updateNoticeSeque(int no) {
		this.sqlSession.update("updateNoticeSeque", no);
		
	}
	
	// 노티스 수정 오케이
	@Override
	public int updateNoticeOk(NoticeDTO dto) {
		return this.sqlSession.update("updateNotice", dto);
	}
	
	// 그룹 리스트 가져오기
	@Override
	public List<GroupDTO> getGroupList() {
		return this.sqlSession.selectList("groupList");
	}
	
	// 셀럽 리스트 가져오기
	@Override
	public List<CelebDTO> getCelebList() {
		return this.sqlSession.selectList("celebList");
	}
	
	

}
