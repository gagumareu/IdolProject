package com.idol.model;

import lombok.Data;

@Data
public class ImagesDTO {
	private int image_no;
	private String image_path;
	private String image_link;
	private int image_priority;
	private int image_visible;
}