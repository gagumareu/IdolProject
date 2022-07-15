package com.idol.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminUsedDAOImpl implements AdminUsedDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	
	
}
