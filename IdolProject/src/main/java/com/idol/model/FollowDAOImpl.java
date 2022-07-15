package com.idol.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FollowDAOImpl implements FollowDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<FollowDTO> getFollowList(String id) {
		return this.sqlSession.selectList("followList", id);
	}

	@Override
	public List<FollowDTO> getFollowerList(String id) {
		return this.sqlSession.selectList("followerList", id);
	}

	//언팔 메서드
	@Override
	public int deleteFollow(HashMap<String, String> param) {
		return this.sqlSession.delete("deleteFollow", param);
	}

	@Override
	public int insertFollow(MemberDTO login, MemberDTO id) {
		
		HashMap<String, Object> maps = new HashMap<String, Object>();
		maps.put("login_no", (int)login.getMember_no());
		maps.put("login_id", (String)login.getMember_id());
		maps.put("id_no", (int)id.getMember_no());
		maps.put("id_id", (String)id.getMember_id());
		
		return this.sqlSession.insert("insertFollow", maps);
	}

	@Override
	public List<FollowDTO> getMusicLike(String id) {
		return this.sqlSession.selectList("getMusicLike", id);
	}
	
	
	//좋아요 취소
	@Override
	public int deleteLike(HashMap<String, Object> param) {
		return this.sqlSession.delete("delLike", param);
	}

	@Override
	public int countFollowMusic(int no) {
		
		return this.sqlSession.selectOne("countFollowMusic", no);
	}

	@Override
	public int insertFollowMusic(HashMap<String, Object> param) {
		
		return this.sqlSession.insert("insertFollowMusic", param);
	}

	@Override
	public List<FollowDTO> followerListMusic(int no) {
		
		return this.sqlSession.selectList("followerListMusic", no);
	}

	@Override
	public int unFollowMusic(HashMap<String, Object> param) {
		
		return this.sqlSession.delete("unFollowMusic", param);
	}


}
