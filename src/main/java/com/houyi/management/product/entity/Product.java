package com.houyi.management.product.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * 产品表
 */
@Entity
public class Product {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	// 产品标题
	public String title;
	
	// 生产商
	public String vender;
	
	// 生产商代码
	public String vernderCode;
	
	// 产地
	public String verderPlace;
	
	//规格
	public String spec;
	// 添加时间
	public Date addtime;
	
	// 产品内容描述
	public String conts;
	
	//主图片id
	public Integer imgId;
	
	//是否广告
	public Integer isAd;
}
