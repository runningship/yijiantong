package com.houyi.management.biz.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Record {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	public Integer uid;
	
	public Integer productId;
	
	public String qrCode;
	
	//扫码地理位置
	public Float lat;
	
	public Float lng;
	
	//扫描设备
	public String device;
	
	public Date addtime;
}
