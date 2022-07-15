package com.idol.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminImagesDAOImpl implements AdminImagesDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertImage(ImagesDTO dto) {

		return this.sqlSession.insert("insertImage", dto);
	}

	@Override
	public List<ImagesDTO> imagesList() {
		return this.sqlSession.selectList("imageList");
	}

	@Override
	public ImagesDTO imagesCont(int no) {
		return this.sqlSession.selectOne("imagesCont", no);
	}

	@Override
	public int imageDelete(int no) {
		return this.sqlSession.delete("imageDelete", no);
	}

	@Override
	public void imageNoSequen(int no) {
		this.sqlSession.update("imageDeleteSeq", no);
		
	}

	@Override
	public int imageModifyOk(ImagesDTO dto) {
		return this.sqlSession.update("imageUpdate", dto);
	}
	
	
	

}
