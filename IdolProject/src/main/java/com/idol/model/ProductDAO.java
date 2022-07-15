package com.idol.model;

import java.util.HashMap;
import java.util.List;

public interface ProductDAO {

	List<ProductDTO> getProductListAll();
	List<ProductDTO> getProductList(int cno,String kind);
	ProductDTO getProductDetail(int pno);
	int productTotalRecord(HashMap<String, Object> maps);
	List<InquiryDTO> productListPage(HashMap<String, Object> maps);
	ProductDTO getProductDetail(String order_pname);
	
	//main용 list입니다
	List<ProductDTO> mainProductList();
}
