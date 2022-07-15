package com.idol.model;


import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MileageDAOImpl implements MileageDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	/* **********************원석님 *************************/
	
	// 멤버번호를 파라메터 값으로 받아 현제 마일리지 정보를 조회하는 메서드
	@Override
	public MileageDTO getMileageDetail(int mno) {
		return sqlSession.selectOne("getDetail", mno);
	}
	
	
	//멤버번호를 파라메터 값으로 받아 남아있는 마일리지를 조회하는 메서드
	@Override
	public int getreamining(int mno) {
		
		return sqlSession.selectOne("reamining", mno);
	}

	// 마일리지 dto에 정보를 담아 마일리지 정보를 추가하는 메서드
	@Override
	public int insertMileageInfo(MileageDTO mdto) {
		return sqlSession.insert("inserMInfo", mdto);
	}


	

	

	//마일리지 리스트 가져오기
	@Override
	public List<MileageDTO> getMileageList(int member_no) {
		return this.sqlSession.selectList("mileageList",member_no);
	}

	

}
