package com.idol.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminMusicDAOImpl implements AdminMusicDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 음원 생성하기 
	@Override
	public int insertMusic(MusicDTO dto) {
		return this.sqlSession.insert("musicInsert", dto);
	}

	// 음원 리스트 불러오기
	@Override
	public List<MusicDTO> getMusicList() {
		return this.sqlSession.selectList("musicList");
	}

	// 음원 상세 정보 보기
	@Override
	public MusicDTO getMusicCont(int no) {
		return this.sqlSession.selectOne("musicCont", no);
	}

	// 음원 삭제하기 
	@Override
	public int deleteMusic(int no) {

		return this.sqlSession.delete("deleteMusic", no);
	}
	
	// 음원 수정하기
	@Override
	public int musicUpdate(MusicDTO dto) {
		
		return this.sqlSession.update("musicUpdate", dto);
		
	}

	// 그룹리스트 불러오기
	@Override
	public List<GroupDTO> getGroupList() {
		return this.sqlSession.selectList("getGList");
	}

	// 셀럽 리스트 불러오기
	@Override
	public List<CelebDTO> getCelebList() {
		return this.sqlSession.selectList("getCList");
		
	}
	
	// 음원 삭제 후 넘버링 재정의
	@Override
	public void updateMusicSequen(int no) {
		this.sqlSession.update("updateMusicSequen", no);
		
	}
	
	// 음원 검색 
	@Override
	public List<MusicDTO> getMusicSearchList(String keyword) {
		return this.sqlSession.selectList("searchMusic", keyword);
	}

	// 앨범 리스트 불러오기
	@Override
	public List<MusicDTO> getAlbumList() {
		return this.sqlSession.selectList("getAlbumList");
	}

	// 앨범 안에 음원 리스트 불러오기
	@Override
	public List<MusicDTO> getMusicInAlbum(String aname) {
		return this.sqlSession.selectList("mList", aname);
	}
	
	

}
