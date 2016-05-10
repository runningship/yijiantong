package com.houyi.management.biz.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

//不做为兑奖记录
/**
 * 扫描记录
 */
@Entity
public class ScanRecord {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	//用户id
	public Integer uid;
	
	public Integer productId;
	
	//兑奖码
	public String qrCode;
	
	//扫描设备
	public String device;
	
	//扫码时间
	public Date addtime;
	
	public String city;
	
	//1 查真伪，2 查兑奖
	public Integer type;
}
