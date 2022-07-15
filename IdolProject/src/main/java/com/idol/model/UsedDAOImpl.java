package com.idol.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UsedDAOImpl implements UsedDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int getListCount() {
		
		return this.sqlSession.selectOne("used_count");
	}

	@Override
	public List<UsedDTO> getUsedList(PageDTO dto) {

		return this.sqlSession.selectList("used_list", dto);
	}

	@Override
	public int insertUsed(UsedDTO dto) {
		
		return this.sqlSession.insert("used_add", dto);
	}

	@Override
	public void readCount(int no) {
		
		this.sqlSession.update("used_read", no);
	}

	@Override
	public UsedDTO usedCont(int no) {
		
		return this.sqlSession.selectOne("used_content", no);
	}

	@Override
	public int searchBoardCount(String field, String keyword) {
		
		return this.sqlSession.selectOne(field, keyword);
	}

	@Override
	public List<UsedDTO> searchBoardList(PageDTO pdto) {

		return this.sqlSession.selectList(pdto.getField()+"1", pdto);
	}

	//중고 카테고리 리스트 
	@Override
	public List<Used_CategoryDTO> getUsedCategory() {
		return this.sqlSession.selectList("usedCategory");
	}
}
