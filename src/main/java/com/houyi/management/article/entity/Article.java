package com.houyi.management.article.entity;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/**
 * 新闻表
 */
@Entity
public class Article {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	public Integer id;
	
	//发布人
	public Integer uid;
	
	//标题
	public String title;

	//阅读次数
	public Integer readCount;
	
	public Integer orderx;
	
	public Date addtime;
	
	//文章内容
	public String conts;
	
	//是否发布 1 发布
	public Integer publishFlag;
	
	// 当作是否置顶 
	public Integer isAd;
	
	//作者
	public String author;
	
	//文章主图片id ,  如果为空文章不能被查询到
	public Integer imgId;
	
	//类别。行业新闻(news)，生活小贴士(tips)
	public String leibie;
	
	//设置置顶时间
	public Date setTopTime;
}
