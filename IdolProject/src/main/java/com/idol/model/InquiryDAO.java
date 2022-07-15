package com.idol.model;

import java.util.HashMap;
import java.util.List;

public interface InquiryDAO {

	List<InquiryDTO> getInquiryList(String member_id);
	List<InquiryDTO> getInquiryList(HashMap<String, Object> map);
	List<Inquiry_CategoryDTO> getInquiryCategory();
	int insertInquiry(InquiryDTO dto);
	int getBoardCount(String id);
	int getBoardCount(HashMap<String, Object> map);
	int watingReply(String id);
	void updateHit(int no);
	InquiryDTO getInquirycont(int no);
	int deleteInquiry(int no);
	void adjustIno(int no);
	InquiryDTO getReplyCont(int no);
	int updateInquiry(InquiryDTO dto);
	
	

}
