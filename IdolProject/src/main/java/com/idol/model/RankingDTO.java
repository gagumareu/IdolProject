package com.idol.model;

import lombok.Data;

@Data
public class RankingDTO {

	private int member_no;
	private String member_id;
	private String member_introduction;
	private String member_nickname;
	private String member_image;
	private int score;
}
