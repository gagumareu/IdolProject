package com.idol.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//희원님
@Repository
public class UserEventDAOImpl implements UserEventDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<EventDTO> eventList(HashMap<String, Object> map) {
		return this.sqlSession.selectList("eventList", map);
	}

	@Override
	public List<EventDTO> concertList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return this.sqlSession.selectList("concertList", map);
	}

	@Override
	public int getListCount(HashMap<String, String> map) {
		return this.sqlSession.selectOne("count", map);
	}

	@Override
	public void readCount(int no) {
		this.sqlSession.update("read", no);
		
	}

	@Override
	public EventDTO eventCont(int no) {
		return this.sqlSession.selectOne("event_cont", no);
	}

	@Override
	public List<EventDTO> allList() {
		return this.sqlSession.selectList("all");
	}

	
}