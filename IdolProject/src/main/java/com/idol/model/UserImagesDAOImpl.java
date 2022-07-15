package com.idol.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//희원님
@Repository
public class UserImagesDAOImpl implements UserImagesDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public List<ImagesDTO> imagesList() {
		return this.sqlSession.selectList("list");
	}
	
	
}
