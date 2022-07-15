package com.idol.model;

import lombok.Data;

@Data
public class BoardDTO {
	private int community_no;
	private String community_userid;
	private String community_title;
	private String community_cont;
	private int community_hit;
	private String community_date;
	private String community_update;
	private int community_recommend;
	private int category_cnofk;
	private String community_image;
}
