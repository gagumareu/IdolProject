package com.idol.model;

import lombok.Data;

@Data
public class BoardCommentDTO {
	private int comment_no;
	private String comment_writer;
	private String comment_cont;
	private String comment_date;
	private String comment_update;
	private int comment_group;
	private int comment_step;
	private int comment_indent;
	private int community_nofk;
	private int category_cnofk;
}
