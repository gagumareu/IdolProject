package com.idol.model;

import java.util.List;

public interface UsedCommentDAO {

	public int insertUsedComment(UsedCommDTO dto);

	public List<UsedCommDTO> getUsedCommentList(int no);

	public int usedCommentDelete(int no);

	public List<UsedCommDTO> getAllCommentList();

	
}
