package com.houyi.management.biz.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Image {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	//图片保存路径
	public String path;
	
	//图片上传人
	public Integer uid;
	
	//分类
	public String leibie;
}
