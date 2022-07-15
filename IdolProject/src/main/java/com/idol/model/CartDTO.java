package com.idol.model;

import lombok.Data;

@Data
public class CartDTO {
	private int cart_no;
	private int cart_pno;
	private int cart_userno;
	private String cart_pname;
	private int cart_pqty;
	private int cart_price;
	private String cart_psize;
	private String cart_pcolor;
	private String cart_pimage;
	private int cart_mileage;
}
