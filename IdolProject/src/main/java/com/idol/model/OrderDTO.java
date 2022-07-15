package com.idol.model;

import lombok.Data;

@Data
public class OrderDTO {
	private int order_no;
	private String order_userid;
	private String order_pimage;
	private String order_pname;
	private int order_qty;
	private int order_total;
	private int order_tcost;
	private int order_mileage;
	private int order_type;
	private int order_group;
	private String order_date;
	private String order_receivername;
	private String order_receiveraddress;
	private String order_receiverphone;
	private int order_pprice; 
}