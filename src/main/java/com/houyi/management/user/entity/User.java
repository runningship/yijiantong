package com.houyi.management.user.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="uc_user")
public class User {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;

	public String tel;
	
	public String account;
	
	public String name;
	
	public String pwd;
	
	public Date addtime;
	
	public Date lasttime;
	
	public Integer jifen;
	//1买家 , 2卖家
	public Integer type;
}
