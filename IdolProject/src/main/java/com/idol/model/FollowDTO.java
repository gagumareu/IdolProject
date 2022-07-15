package com.idol.model;

import lombok.Data;

@Data
public class FollowDTO {
	
	private int f_no;
	private String f_type; //GROUP, MEMBER, MUSIC
	private int follow_no;
	private String follow_name;
	private int follower_no;
	private String follower_name;
}
