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
	
	//是否已生成二维码
	public Integer active;
	
	//过期时间
	public Date expireDate;
	
	public Integer qrCodeWidth;
	
	//是否自动兑奖 0,不自动兑奖 1,自动兑奖
	public Integer autoCashLottery;
	
	// 是否自动校验  0,不自动校验 1,自动校验
	public Integer autoVerifyLottery;
}
