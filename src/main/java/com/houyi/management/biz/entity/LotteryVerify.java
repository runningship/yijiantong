package com.houyi.management.biz.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * 验证码兑奖记录表,扫描校验码，提交后，在该表中产生一条记录
 */
@Entity
public class LotteryVerify {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public Integer productId;
	
	//批次号
	public String batchNo;
	
	//提交验证码的用户电话号码
	public String tel;
	
	//兑奖地址
	public String activeAddr;
	
	//兑奖人id
	public Integer activeUid;
	
	//兑奖码
	public String qrCode;
	
	//验证码
	public String verifyCode;
	
	public Date addtime;
	
	//0 待审核，1已兑奖 2，无效码
	public Integer status;
}
