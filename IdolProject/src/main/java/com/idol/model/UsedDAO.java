package com.idol.model;

import java.util.List;

public interface UsedDAO {

	public int getListCount();

	public List<UsedDTO> getUsedList(PageDTO dto);

	public int insertUsed(UsedDTO dto);

	public void readCount(int no);

	public UsedDTO usedCont(int no);

	public int searchBoardCount(String field, String keyword);

	public List<UsedDTO> searchBoardList(PageDTO pdto);
	
	public List<Used_CategoryDTO> getUsedCategory();


}
