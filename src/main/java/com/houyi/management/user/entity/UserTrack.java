package com.houyi.management.user.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * 用户轨迹表，用户切换城市时候用
 */
@Entity
public class UserTrack {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;

	public Float lat;
	
	public Float lng;
	
	public String city;
	
	public String pinyin;
	
	public String cityCode;
	
	public String device;
	
	public String deviceToken;
	
	public Integer uid;
	
	public String tel;
	
	public Date addtime;
	
}