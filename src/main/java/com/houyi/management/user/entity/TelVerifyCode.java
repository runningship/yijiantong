package com.houyi.management.user.entity;

import java.util.Date;

import javax.persistence.Cacheable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * 手机验证码码
 */
@Entity
@Cacheable
public class TelVerifyCode {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	// 验证码
	public String code;
	
	public String tel;
	
	// 验证码发送时间
	public Date sendtime;
	
	// 验证码验证时间
	public Date verifyTime;
}
