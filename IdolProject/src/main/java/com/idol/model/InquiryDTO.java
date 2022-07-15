package com.idol.model;

import lombok.Data;

@Data
public class InquiryDTO {

	private int inquiry_no;
	private String inquiry_userid;
	private String inquiry_title;
	private String inquiry_cont;
	private String inquiry_image;
	private int inquiry_hit;
	private String inquiry_date;
	private String inquiry_update;
	private int product_no;
	private int order_no;
	private int inquiry_status;
	private int inquiry_group;
	private int inquiry_step;
	private int inquiry_indent;
	private int category_inofk;
	
}
