package com.houyi.management.biz.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

//不做为兑奖记录
@Entity
public class ScanRecord {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public Integer uid;
	
	public Integer productId;
	
	public String qrCode;
	
	//扫描设备
	public String device;
	
	public Date addtime;
	
	public String city;
	
	//1 查真伪，2 查兑奖
	public Integer type;
}
