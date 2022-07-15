package com.idol.model;

import lombok.Data;

@Data
public class NoticeDTO {

	private int notice_no;
	private String admin_id;
	private String group_name;
	private String celeb_name;
	private String notice_type;
	private String notice_title;
	private String notice_image;
	private String notice_cont;
	private int notice_hit;
	private String notice_date;
	private String notice_update;
	private String notice_enddate;
}
