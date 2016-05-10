package com.houyi.management.product.entity;

/**
 * 产品项信息，一条ProductItem记录对应一瓶酒
 */
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class ProductItem {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	// 二维码
	public String qrCode;
	
	//防伪码
	public String verifyCode;
	
	public Integer productId;
	
	//兑奖券金额
	public Integer lottery;
	
	public Date addtime;
	
	//是否已兑奖
	public int lotteryActive;
	
	//优惠券拥有者
	public Integer lotteryOwnerId;
	
	//批次号
	public Integer batchId;
	
	// 兑奖时间
	public Date activeTime;
	
	// 兑奖地址
	public String activeAddr;
	
	// 兑奖地址的经度
	public Float activeLat;
	
	// 兑奖地址的维度
	public Float activeLng;
	
}
