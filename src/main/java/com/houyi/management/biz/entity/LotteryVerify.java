package com.houyi.management.biz.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class LotteryVerify {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public Integer productId;
	
	public String batchNo;
	
	public String tel;
	
	public String activeAddr;
	
	public Integer activeUid;
	
	public String qrCode;
	
	public String verifyCode;
	
	public Date addtime;
	
	//0 待审核，1已兑奖 2，无效码
	public Integer status;
}
