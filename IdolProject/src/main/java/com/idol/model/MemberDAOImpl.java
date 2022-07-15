package com.idol.model;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Repository
public class MemberDAOImpl implements MemberDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	
	//회원가입시 아이디 중복체크 확인 메서드
	@Override
	public int idcheck(String id) {
		return this.sqlSession.selectOne("idcheck", id);
	}
	
	
	//MEMBER테이블에 데이터 저장하는 메서드 
	@Override
	public int insertMember(MemberDTO dto) {
		
		return this.sqlSession.insert("join",dto);
	}

	
	//로그인을 위해 입력한 아이디,비밀번호 체크하는 메서드
	@Override
	public int login(MemberDTO dto) {
		int result = 0;
		
		String id= this.sqlSession.selectOne("loginIdCheck", dto);
		System.out.println("id:"+id);
		if(id != null) {
			String pwd = this.sqlSession.selectOne("loginPwdCheck", dto);

			if(dto.getMember_pwd().equals(pwd)) {
				result = 1;
			}else {
				result = -1;
			}
		
		}else {//정환님코드 추가
			System.out.println("admin_start");
			
			String adminId = this.sqlSession.selectOne("adminIdCheck", dto);
			
			System.out.println("adminId >>>>> " + adminId);
			
			
			if(adminId != null) {
				
				String adminPwd = this.sqlSession.selectOne("adminPwdCheck", dto);
				
				System.out.println("adminPwd >>>>> " + adminPwd);
				
				if(dto.getMember_pwd().equals(adminPwd)) {
					result = 99;
				}else {
					result = 88;
				}
				
				
			}else {
				
			}
			
		}
		
		return result;
	}

	//아이디,비밀번호찾기 메서드 
	@Override
	public String findIdPwd(HashMap<String, String> params, String find) {
		
		return this.sqlSession.selectOne("find"+find, params);
		
	}

	//회원 정보 찾는 메서드
	@Override
	public MemberDTO getMemInfo(String id) {
		
		return this.sqlSession.selectOne("memInfo", id);
	}

	//회원정보 수정 메서드
	@Override
	public int updateMember(MemberDTO dto) {
		return this.sqlSession.update("memUpdate", dto);
	}

	//프로필사진 수정하는 메서드
	@Override
	public int profileUpload(MemberDTO dto) {
		return this.sqlSession.update("profileUpload",dto);
	}


	@Override
	public int coverUpload(MemberDTO dto) {
		return this.sqlSession.update("coverUpload",dto);
	}
	
	
	//원석
	@Override
	public MemberDTO getMemberCont(int mno) {
		return sqlSession.selectOne("mCont", mno);
	}

	// 전체 회원 리스트 출력 메서드
	@Override
	public List<MemberDTO> getMemeberList() {
		return sqlSession.selectList("MemAllList");
	}

	


	
	
}
