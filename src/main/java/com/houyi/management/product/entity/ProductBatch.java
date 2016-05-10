package com.houyi.management.product.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * 产品批次信息
 */
@Entity
public class ProductBatch {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	// 产品id 关联 Product id字段
	public Integer productId;

	//批次号
	public String no;

	public String conts;
	
	// 当前批次酒数量(瓶)
	public Integer count;
	
	//优惠券
	public Integer lottery;
	
	//ProductItem表名后缀
	public String tableOffset;
	
	// 添加时间
	public Date addtime;
	
	//是否已生成二维码
	public Integer active;
	
	//过期时间
	public String expireDate;
	
	// 生产日期
	public String productionDate;
	
	// 二维码宽度
	public Integer qrCodeWidth;
	
	//是否自动兑奖 0,不自动兑奖 1,自动兑奖
	public Integer autoCashLottery;
	
	// 是否自动校验  0,不自动校验 1,自动校验
	public Integer autoVerifyLottery;
	
	//是否开放兑奖功能
	public Integer openForLottery;
}
