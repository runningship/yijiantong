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
	
	public String tel;
	
	public String activeAddr;
	
	public Integer activeUid;
	
	public String verifyCode;
	
	public Date addtime;
	
	public Integer status;
}
