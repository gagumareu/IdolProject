package com.idol.model;

import java.util.List;

import lombok.Data;

@Data
public class EventDTO {
	
	private int notice_no;
	private String admin_no;
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

	//event_cont.do에 들어갈 image들
	//notice_image를 split을 통해 문자열을 자른 후 notice_images에 add함.(나누는 기준 "|")
	private List<String> notice_images;

}