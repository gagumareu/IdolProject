package com.idol.model;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardCategoryDAOImpl implements BoardCategoryDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<BoardCategoryDTO> getCategoryList() {
		return sqlSession.selectList("boardCategory");
	}

}
