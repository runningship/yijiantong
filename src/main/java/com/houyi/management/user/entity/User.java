package com.houyi.management.user.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 用户表
 */
@Entity
@Table(name="uc_user") // 数据库表名为uc_user
public class User {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;

	// 用户手机号码
	public String tel;
	
	// 登录账号
	public String account;
	
	public String name;
	
	public String pwd;
	
	public Date addtime;
	
	// 最后登录时间
	public Date lasttime;
	
	public Integer jifen;
	//1买家 , 2卖家 , 3系统管理员(厚易系统账号)
	public Integer type;
	
	public Date birth;
	
	// 1男 2女
	public Integer gender;
	
	public String qq;
	
	public String weixin;
	
	public String email;
	
	// 签名
	public String sign;
}
