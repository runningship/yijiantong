package com.houyi.management.product.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Goods {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public String title;
	
	public String vender;
	
	public String vernderCode;
	
	public String verderPlace;
	
	public Float price;
	
	//原价
	public Float originalPrice;
	
	//规格
	public String spec;
	//
	public Date addtime;
	
	public String conts;
	
	//主图片id
	public Integer imgId;
	
	//是否广告
	public Integer isAd;
}
