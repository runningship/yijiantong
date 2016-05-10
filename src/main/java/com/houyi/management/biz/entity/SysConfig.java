package com.houyi.management.biz.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * 参数配置表
 */
@Entity
public class SysConfig {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	//参数名
	public String name;
	
	// 参数值
	public String value;
	
	// 描述信息
	public String conts;
}
