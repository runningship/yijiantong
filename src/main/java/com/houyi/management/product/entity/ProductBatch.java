package com.houyi.management.product.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class ProductBatch {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public Integer productId;

	//批次号
	public String no;

	public String conts;
	
	public Integer count;
	
	//优惠券
	public Integer lottery;
	
	//ProductItem表名后缀
	public String tableOffset;
	
	public Date addtime;
}