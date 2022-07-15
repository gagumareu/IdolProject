package com.idol.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommunityDAOImpl implements CommunityDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<CommunityDTO> getCommunityList(String id) {
		return this.sqlSession.selectList("commList", id);
	}

	@Override
	public int getCommTotalRecord(String id) {

		return this.sqlSession.selectOne("commTotalRecord", id);
	}
	
}
