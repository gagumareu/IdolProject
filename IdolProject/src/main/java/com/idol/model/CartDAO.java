package com.idol.model;

import java.util.List;

public interface CartDAO {
	
	int addCart(CartDTO cartdto);
	int deleteCart(int cno);
	List<CartDTO> getCartList(int userno);
	CartDTO getcartDetail(int cno);
	int UpdateCart(int cno, int cqty);
	int checkCart(int memno,int pno);
	
}
