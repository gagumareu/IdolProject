package com.idol.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GroupDAOImpl implements GroupDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	//celeb테이블 그룹명에 해당하는 정보 찾는 메서드
	@Override
	public GroupDTO getGroupInfo(String celeb_group) {

		return this.sqlSession.selectOne("groupInfo", celeb_group);
	}

	@Override
	public List<GroupDTO> searchGroup(String group) {
		
		return this.sqlSession.selectList("searchGroup", group);
	}
	

}
