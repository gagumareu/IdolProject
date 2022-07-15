package com.idol.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminGroupDAOImpl implements AdminGroupDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 그룹 등록
	@Override
	public int insertGroup(GroupDTO dto) {
		
		return this.sqlSession.insert("groupInsert", dto);
	}
	
	// 그룹 리스트 불러오기
	@Override
	public List<GroupDTO> getGroupList() {
		
		return this.sqlSession.selectList("groupList");
	}
	
	// 그룹 상세정보 불러오기
	@Override
	public GroupDTO getGroupCont(int no) {
		return this.sqlSession.selectOne("groupContforUpdate", no);
	}

	// 그룹 수정
	@Override
	public int updateGroup(GroupDTO dto) {
		return this.sqlSession.update("updateGroup", dto);
	}
	
	// 그룹 삭제
	@Override
	public int deleteGroup(int no) {
		return this.sqlSession.delete("deleteGroup", no);
		
	}
	
	// 삭제 후 시퀀스 업데이트
	@Override
	public void updateGroupSeque(int no) {
		this.sqlSession.update("updateGroupSequen", no);
		
	}
	
	//셀럽 솔로 리스트
	@Override
	public List<CelebDTO> getSoloList() {
		
		return this.sqlSession.selectList("getSoloList");
		
	}

	

	
	
}
