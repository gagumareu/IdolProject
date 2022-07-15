package com.idol.model;

import lombok.Data;

@Data
public class BoardRecommendDTO {
	private int recommend_no;
	private int member_no;
	private int community_no;
	private String recommend_date;
}
