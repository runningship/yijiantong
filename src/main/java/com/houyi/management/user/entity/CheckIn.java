package com.houyi.management.user.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class CheckIn {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;

	public Integer uid;
	
	public Date addtime;
	
	public Long addtimeInLong;
	
}