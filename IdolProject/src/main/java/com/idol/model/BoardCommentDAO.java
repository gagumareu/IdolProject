package com.idol.model;

import java.util.List;

public interface BoardCommentDAO {
	
	// 댓글등록
	int commentWrite(BoardCommentDTO boardCommentdto);
	
	// 게시물 댓글 리스트
	List<BoardCommentDTO> getCommentList(int bno); 
	
	// 답변글(대댓글) 스텝 증가
	void updateCommentStep(int group,int step);
	
	// 답변글(등록) 
	int replyWrite(BoardCommentDTO boardCommentdto);
	
	// 게시글 댓글 갯수
	int getcommentCount(int bno);
	
	// 댓글 및 대댓글 삭제
	int deleteComment(int cno);
	
	// 커뮤니티 게시글 삭제시 댓글전체삭제
	int deleteBoardComment(int communityNo);
	
	// 댓글 및 대댓글 수정
	int updateComment(BoardCommentDTO boardCommentdto);
	
	// 댓글정보
	BoardCommentDTO getCommentDetail(int cno);
	
	// 댓글 그룹이 속한 스텝 카운트
	int stepCount(int gno);
	

}
