package com.idol.model;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminCelebDAOImpl implements AdminCelebDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;

	
	
	
	// 관리자 정보 불러오기
	@Override
	public AdminDTO getAdminCont(String id) {
		
		return this.sqlSession.selectOne("admin_check", id);		
	}


	// 가수 전체 리스트 불러오기
	@Override
	public List<CelebDTO> selectCelebList() {

		return this.sqlSession.selectList("celebList");
		
	}

	// 가수 전체 리스트 불러오기
	@Override
	public List<CelebDTO> celebList() {
		
		return this.sqlSession.selectList("celectList");
		
	}
		
	// 그룹 이름 리스트 불러오기
	//@Override
	//public List<CelebDTO> selectGroupList() {
	//	return this.sqlSession.selectList("groupList");
	//}

	
	// 그룹 가수 멤버 가져오기 
	@Override
	public List<CelebDTO> getGroupMemberList(String gName) {
		
		return this.sqlSession.selectList("gmList", gName);
	}
	
	
	
	// 이름으로 가수 상세 내역 불러오괴 by name
	@Override
	public CelebDTO getCelebContByName(String celeb_name) {
		
		return this.sqlSession.selectOne("celebCont", celeb_name);
	}
	
	// 가수 상세 정보 불러 오기 by number
	@Override
	public CelebDTO getCelebContByNo(int no) {
		
		return this.sqlSession.selectOne("contentByNO", no);
		
	}
	
	
	// 가수 등록
	@Override
	public int insertCeleb(CelebDTO dto) {
		
		return this.sqlSession.insert("insertCeleb", dto);
		
	}
	
	// 가수 등록 후 그룹 일 경우 그룹 이미지 넣기
	@Override
	public int updateGroupImage(CelebDTO dto) {
		
		return this.sqlSession.update("updateGimage", dto);
		
	}
	
	// 가수 정보 수정 
	@Override
	public int updateCeleb(CelebDTO dto) {
		
		return this.sqlSession.update("celebUpdate", dto);
		
	}

	// 가수 삭제 하는 로직
	@Override
	public int deleteCeleb(int no) {
		
		return this.sqlSession.delete("deleteCeleb", no);
		
		
	}

	// 가수 삭제 후 넘버링 재정의
	@Override
	public void updateSequen(int no) {
		
		this.sqlSession.update("updateSequ", no);
		
	}



	@Override
	public GroupDTO getGroupCont(String gName) {
		
		return this.sqlSession.selectOne("groupCont", gName);

	}


	// 그룹명 불러오기 
	@Override
	public List<GroupDTO> getGroupNameList() {
		return this.sqlSession.selectList("getGroupList");
	}


	//그룹 리스트 불러오기
	@Override
	public List<GroupDTO> getGroupList() {
		return this.sqlSession.selectList("getGroupAllList");
	}


	// 음원리스트 가져오기
	@Override
	public List<MusicDTO> getMusicList() {
		// TODO Auto-generated method stub
		return null;
	}


	// 공지사항 리스트 가져오기
	@Override
	public List<NoticeDTO> getNoticeList() {
		// TODO Auto-generated method stub
		return null;
	}


	// 이미지스 리스트 가져오기
	@Override
	public List<ImagesDTO> getImagesList() {
		// TODO Auto-generated method stub
		return null;
	}

	// 그룹에 관련된 공지 가져오기
	@Override
	public List<NoticeDTO> getGroupNotice(String name) {
		return this.sqlSession.selectList("getGroupNotice", name);
	}


	// 셀럽 개인에 관련된 공지 가져오기
	@Override
	public List<NoticeDTO> getCelebNotice(String name) {
		
		System.out.println("impl-name : " + name);
		
		return this.sqlSession.selectList("getCelebNotice", name);
	}
	
	
	


	
	

	
	
	
	
	
	
	
	
	
	


	
	
}
