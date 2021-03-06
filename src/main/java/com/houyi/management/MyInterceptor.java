package com.houyi.management;

import java.io.Serializable;
import java.util.Iterator;

import org.hibernate.CallbackException;
import org.hibernate.EmptyInterceptor;
import org.hibernate.EntityMode;
import org.hibernate.Interceptor;
import org.hibernate.Transaction;
import org.hibernate.type.Type;

import com.houyi.management.product.entity.ProductItem;

public class MyInterceptor extends EmptyInterceptor{

	private static MyInterceptor instance = new MyInterceptor();
	
	//需要动态设置的表名前缀
	public String tableNamePrefix = ProductItem.class.getSimpleName();
	
	//需要动态设置的表名后缀
	//public int tableNameSuffix = 1;
	
	public ThreadLocal<String> tableNameSuffix = new ThreadLocal<String>();
	
	private MyInterceptor(){
		tableNameSuffix.set("");
	}
	public static MyInterceptor getInstance(){
		return instance;
	}

	@Override
	public String onPrepareStatement(String sql) {
		String target= "";
		if(this.tableNameSuffix.get()==null){
			 target = tableNamePrefix;
		}else{
			 target = tableNamePrefix+"_"+this.tableNameSuffix.get();
		}
		
		if(!sql.contains("sysobjects")){
			sql = sql.replace(tableNamePrefix, target);
		}
		System.out.println("---------"+sql);
		return sql;
	}

}
