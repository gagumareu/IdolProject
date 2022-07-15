package com.idol.model;

import lombok.Data;

//회원테이블 DTO
@Data
public class MemberDTO {
	
	
	private int member_no;
	private String member_id;
	private String member_nickname;
	private String member_name;
	private String member_pwd;
	private String member_gender;
	private String member_email;
	private String member_phone;
	private String member_dateofbirth;
	private String member_address;
	private String member_join_date;
	private String member_update;
	private String member_image;
	private String member_favorite_celeb;
	private String member_introduction;
	private String member_cover;
	
}
