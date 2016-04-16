package com.houyi.management.article.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Article {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	//发布人
	public Integer uid;
	
	public String title;

	public Integer readCount;
	
	public Integer orderx;
	
	public Date addtime;
	
	public String conts;
	
	public Integer publishFlag;
	
	// 当作是否置顶 
	public Integer isAd;
	
	public String author;
	
	public Integer imgId;
	
	public String leibie;
	
	public Date setTopTime;
}
