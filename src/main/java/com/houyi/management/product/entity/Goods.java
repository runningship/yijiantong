package com.houyi.management.product.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * 易商城商品信息表
 */
@Entity
public class Goods {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	// 商品名称
	public String title;
	
	// 生成商
	public String vender;
	
	// 生产商代码
	public String vernderCode;
	
	// 产地
	public String verderPlace;
	
	// 当前价格 
	public Float price;
	
	//原价
	public Float originalPrice;
	
	//规格
	public String spec;
	
	// 添加时间
	public Date addtime;
	
	public String conts;
	
	//主图片id
	public Integer imgId;
	
	//是否上架
	public Integer isAd;
}
