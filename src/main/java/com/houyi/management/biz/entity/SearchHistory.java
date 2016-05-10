package com.houyi.management.biz.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * 易商城搜索记录
 */
@Entity
public class SearchHistory {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	//用户id,关联User表 id
	public Integer uid;
	
	// 搜索内容
	public String text;
}
