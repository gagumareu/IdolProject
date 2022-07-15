package com.idol.model;

import java.util.List;

public interface AdminImagesDAO {

	//메인 이미지 등록 하기
	public int insertImage(ImagesDTO dto);
	// 이미지 전체 리스트 불러오기 
	public List<ImagesDTO> imagesList();
	// 이미지 상세 정보 불러오기
	public ImagesDTO imagesCont(int no);
	// 이미지 삭제하기 
	public int imageDelete(int no);
	// 삭제 후 넘버링 재정의
	public void imageNoSequen(int no);
	// 이미지 정보 수정하기
	public int imageModifyOk(ImagesDTO dto);
	
	
}
