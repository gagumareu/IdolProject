package com.idol.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminMemberDAOImpl implements AdminMemberDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	// 맴버 리스트 불러오기
	@Override
	public List<MemberDTO> getMemberList() {
		return this.sqlSession.selectList("getMemberLsit");
	}
	
	// 문의 리스트 불러오기
	@Override
	public List<InquiryDTO> getInquirList() {
		return this.sqlSession.selectList("getInquirList");
	}
	
	// 문의 카테고리 불러오기
	@Override
	public List<Inquiry_CategoryDTO> getInquiryCategoryList() {
		return this.sqlSession.selectList("getInquiryCategoryList");
	}
	
	// 문의 게시글 상세 정보 불러오괴 by no
	@Override
	public InquiryDTO getmemberInquiryCont(int no) {
		return this.sqlSession.selectOne("getInquiryCont", no);
	}
	
	// test : 주문 상세 내역 가져오기 by order_no (중복로직 나중에 정리해야 됌 *일단 사용중* (productImple쪽이랑 중복 ))
	@Override
	public OrderDTO getOrderContByNo(int no) {
		return this.sqlSession.selectOne("getOrderInfoByNo", no);
	}
	
	// 문의 게시글 답글 작성 
	@Override
	public int insertInquiryReply(InquiryDTO dto) {
		return this.sqlSession.insert("insertInquiryReply", dto);
		
	}
	
	// 문의 게시글 답글 작성시 step +1 시켜주는 메서드
	@Override
	public void updateReplyStep(InquiryDTO dto) {
		this.sqlSession.update("updateReplyStep", dto);
		
	}
	
	// 답변 완료 후 status 1로 바꿔주기
	@Override
	public void updateReplyStatus(InquiryDTO dto) {
		this.sqlSession.update("updateReplyStatus", dto);
		
	}
	
	// 답변글 그룹 리스트 불러오기 by inquiry_group
	@Override
	public List<InquiryDTO> getInquiryReplyList(int no) {
		return this.sqlSession.selectList("getInquiryReplyList", no);
	}

	// 답변글 수정하기 by inquiry_no
	@Override
	public int updateReply(InquiryDTO dto) {
		return this.sqlSession.update("updateReplyOk", dto);
	}
	
	// 답변글 정보 불러오기 
	@Override
	public InquiryDTO getReplyCont(int no) {
		return this.sqlSession.selectOne("getReplyCont", no);
	}
	
	// 답글 삭제 후 넘버링 재정의
	@Override
	public void updateInquirySequen(int no) {
		this.sqlSession.update("updateInquirySequen", no);
		
	}
	
	// 답글 삭제하기
	@Override
	public int deleteInquiry(int no) {
		return this.sqlSession.delete("deleteInquiry", no);
	}


	//////////////////////////////////////////////////////////////
	
	// 맴버 상세 정보 불러오기
	@Override
	public MemberDTO getMemberCont(int no) {
		return this.sqlSession.selectOne("getMemberCont", no);
	}

	// 맴버 주문 리스트 불러오기 by order_userid
	@Override
	public List<OrderDTO> getMemberOrderListByID(String id) {
		return this.sqlSession.selectList("getMemberOrderList", id);
	}

	
	
	// 맴버 중고거래 리스트 불러오기 by used_userid
	@Override
	public List<UsedDTO> getUsedListById(String id) {
		return this.sqlSession.selectList("getMemberUsedList", id);
	}
	// 맴버 중고거래 게시글 불러오기 
	@Override
	public List<UsedCommDTO> getUsedCommByid(String id) {
		return this.sqlSession.selectList("getMemberUsedCommList", id);
	}
	// 중고거래 카테고리 가져오기 
	@Override
	public List<Used_CategoryDTO> getUsedCategory() {
		return this.sqlSession.selectList("getUsedCategoryList");
	}

	
	
	
	// 맴버 아이디로 조회 하여 커뮤니티 게시글 리스트 불러오기
	@Override
	public List<CommunityDTO> getCommunityListById(String id) {
		return this.sqlSession.selectList("getMemberCommList", id);
	}
	// 맴버 아이디로 조회하여 커뮤니티 답글 불러오기
	@Override
	public List<Comm_CommentDTO> getCommunityCommById(String id) {
		return this.sqlSession.selectList("getMemberCommCommList", id);
	}
	// 커뮤니티 카테고리 가져오기
	@Override
	public List<Comm_CategoryDTO> getCommunityCategory() {
		return this.sqlSession.selectList("getCommunityCommList");
		
	}
	
	
	
	
	// 문의 게시판 리스트 가져오기 
	@Override
	public List<InquiryDTO> getinquiryListById(String id) {
		return this.sqlSession.selectList("getMemberInquiryLsit", id);
	}

	
	
	
	// 셀럽 리스트 가져오기
	@Override
	public List<CelebDTO> getCelebList() {
		return this.sqlSession.selectList("getCelebListFromMember");
	}

	@Override
	public List<GroupDTO> getGroupList() {
		return this.sqlSession.selectList("getGroupListFromMember");
	}

	@Override
	public List<InquiryDTO> getInquiryListByCategory(int no) {
		return this.sqlSession.selectList("inquiryListByCate", no);
	}

	@Override
	public List<InquiryDTO> getInquiryOkList() {
		return this.sqlSession.selectList("inquiryOkList");
	}

	@Override
	public List<MemberDTO> getKilledMemberList() {
		return this.sqlSession.selectList("killed");
	}

	@Override
	public List<MemberDTO> getSearchMemberList(String id) {
		return this.sqlSession.selectList("searchMemberList", id);
	}
	
		
	
	
	
	
	
	
	
	
	
	
}
