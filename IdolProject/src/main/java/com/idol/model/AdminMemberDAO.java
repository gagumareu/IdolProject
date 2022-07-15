package com.idol.model;

import java.util.List;

public interface AdminMemberDAO {
	
	
	// 멤버 리스트 불러오기
	public List<MemberDTO> getMemberList();
	// 1:1 문의 리스트 불러오기
	public List<InquiryDTO> getInquirList();
	// inquiry category 불러오기 
	public List<Inquiry_CategoryDTO> getInquiryCategoryList();
	// 문의 게시글 상세 정보 불러오기
	public InquiryDTO getmemberInquiryCont(int no);
	// order_no 정보 불러오기 (test)
	public OrderDTO getOrderContByNo(int no);
	// 문의 답변 작성시 step +1 시켜주는 메서드
	public void updateReplyStep(InquiryDTO dto);
	// 1:1 문의 답변 작성
	public int insertInquiryReply(InquiryDTO dto);
	// 단변 완료 게시판 status 1로 변환 시키지
	public void updateReplyStatus(InquiryDTO dto);
	// 문의게시판 상세 페이지에서 답변글 불러오기 by group_no 
	public List<InquiryDTO> getInquiryReplyList(int no);
	// 답변글 수정하기 by inquiry_no
	public int updateReply(InquiryDTO dto);
	// 답글 정보 가져오기 by inquiry_no
	public InquiryDTO getReplyCont(int no);
	// 답글 삭제 후 넘버링 재정의
	public void updateInquirySequen(int no);
	// 답글 삭제 하기
	public int deleteInquiry(int no);

//////////// 맴버 아이디로 검색해서 각 테이블 리스트 불러오기 (맴버 상세 페이지로 이동 )///////////
	// 맵버 상세 정보 가져오기 by member_no
	public MemberDTO getMemberCont(int no);
	
	
	// 맴버 아이디 검색 으로 오더리스트 불러오기 by order_userid
	public List<OrderDTO> getMemberOrderListByID(String id);
	
	
	
	// 맴버 아이디 검색해서 중고게시판 리스트 불러오기 by used_userid
	public List<UsedDTO> getUsedListById(String id);
	// 맴버 아이디 검색해서 중고게시판 답변 게시물 리스트 불러오기
	public List<UsedCommDTO> getUsedCommByid(String id);
	// 중고 게시판 카테고리 가져오기
	public List<Used_CategoryDTO> getUsedCategory();
	
	
	
	// 맴버 아이디 검색해서 커뮤니티 리스트 불러오기 by comment_writer
	public List<CommunityDTO> getCommunityListById(String id);
	// 맴버 아이디로 검색해서 커뮤니티 답변 가져오기 
	public List<Comm_CommentDTO> getCommunityCommById(String id);
	// 커뮤니티 게시판 카테고리 가져오기
	public List<Comm_CategoryDTO> getCommunityCategory();
	
	
	
	// 맴버 아이디 검색해서 문의 게시판 리스트 불러오기 by inquiry_id
	public List<InquiryDTO> getinquiryListById(String id);
	
	// 셀럽리스트 불러오기
	public List<CelebDTO> getCelebList();
	// 그룹 리스트 불러오기
	public List<GroupDTO> getGroupList();

//////////////////////////////////////////////////////////////////////	
	
	
	// 문의 게시판 카테고리별 게시판 가져오기 
	public List<InquiryDTO> getInquiryListByCategory(int no);
	//완료  문의 게시판 리스트 가져오기
	public List<InquiryDTO> getInquiryOkList();
	
	// 생일 및 가입일이 00/01/01인 경우 리스트 불러오기 (회원 정지 리스트)
	public List<MemberDTO> getKilledMemberList();
	
	// 회원 검색
	public List<MemberDTO> getSearchMemberList(String id);
	
	
}
