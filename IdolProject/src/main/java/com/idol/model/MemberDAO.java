package com.idol.model;

import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

public interface MemberDAO {

	int idcheck(String id);
	int insertMember(MemberDTO dto);
	int updateMember(MemberDTO dto);
	int login(MemberDTO dto);
	String findIdPwd(HashMap<String, String> params, String find);
	MemberDTO getMemInfo(String id);
	int profileUpload(MemberDTO dto);
	int coverUpload(MemberDTO dto);
	
	//원석
	MemberDTO getMemberCont(int mno);
	List<MemberDTO> getMemeberList();
	
}
