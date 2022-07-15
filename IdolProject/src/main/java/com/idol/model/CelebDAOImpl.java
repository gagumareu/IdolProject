package com.idol.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CelebDAOImpl implements CelebDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;

	//그룹에서 'solo'인 리스트 뽑아내는 메서드
	@Override
	public List<CelebDTO> soloList() {
		// TODO Auto-generated method stub
		return this.sqlSession.selectList("soloList");
	}

	//그룹리스트 뽑아내는 메서드
	@Override
	public List<CelebDTO> representList() {
		return this.sqlSession.selectList("repList");
	}

	//celeb 정보 
	@Override
	public CelebDTO getCelebInfo(int no) {
		return this.sqlSession.selectOne("celebInfo", no);
	}
	
	
	//--------------------원석--------------------------
	@Override
	public List<CelebDTO> getCelebList() {
		return sqlSession.selectList("CelList");
	}

	@Override
	public CelebDTO getCelebDetail(int cno) {
		
		return sqlSession.selectOne("Cdetail", cno);
		
	}

	//-------------------경연----------------------------
	@Override
	public List<CelebDTO> getArtistList(String group) {
		
		return sqlSession.selectList("artistList", group);
	}

	@Override
	public List<CelebDTO> searchCeleb(String name) {
		
		return sqlSession.selectList("searchCeleb", name);
	}
	
	
	

}
