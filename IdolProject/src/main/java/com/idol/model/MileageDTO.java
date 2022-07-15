package com.idol.model;

import lombok.Data;

@Data
public class MileageDTO {
	
	private int mileage_mno;
	private int mileage_memno;
	private int mileage_remaining;
	private int mileage_earn;
	private int mileage_deduction;
	private int mileage_accumulated;
	private String mileage_type;
	private String mileage_date; 
	

}
