package com.houyi.management.user.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * 签到表
 */
@Entity
public class CheckIn {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;

	public Integer uid;
	
	// 签到时间
	public Date addtime;
	
	// 签到时间long 时间格式
	public Long addtimeInLong;
	
}