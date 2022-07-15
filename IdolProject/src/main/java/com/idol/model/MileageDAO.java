package com.idol.model;

import java.util.List;

public interface MileageDAO {
	
	/* **********************원석님 *************************/
	int getreamining(int mno);
	MileageDTO getMileageDetail(int mno);
	int insertMileageInfo(MileageDTO mdto);
	

	List<MileageDTO> getMileageList(int member_no);
	
}