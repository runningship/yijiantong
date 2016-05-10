package com.houyi.management.biz.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
/**
 * ProductItem表分表信息表,就像记录了磁盘的分区信息一样。
 */
@Entity
public class TableInfo {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	//后缀
	public String suffix;
	
	// 表当前容量，即记录条数。
	public Integer size;
	
}
