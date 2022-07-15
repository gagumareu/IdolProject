package com.idol.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UsedCommentDAOImpl implements UsedCommentDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertUsedComment(UsedCommDTO dto) {
	
		return this.sqlSession.insert("used_comment_add", dto);
	}

	@Override
	public List<UsedCommDTO> getUsedCommentList(int no) {
		
		return this.sqlSession.selectList("used_comment_list", no);
	}

	@Override
	public int usedCommentDelete(int no) {
		
		return this.sqlSession.update("used_comment_delete", no);
	}

	@Override
	public List<UsedCommDTO> getAllCommentList() {
		
		return this.sqlSession.selectList("allComment");
	}

	

}
