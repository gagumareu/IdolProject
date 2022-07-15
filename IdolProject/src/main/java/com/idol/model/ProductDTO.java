package com.idol.model;

import lombok.Data;

@Data
public class ProductDTO {
	
	private int product_no;
	private String product_name;
	private int celeb_no;
	private String product_image;
	private int product_qty;
	private int product_price;
	private String product_size;
	private String product_color;
	private String product_detail;
	private int product_mileage;
	private String product_input;
	private int category_pnofk;

}
