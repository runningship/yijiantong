package com.houyi.management.app;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.Page;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.WebMethod;

import com.houyi.management.article.entity.Article;


@Module(name="/app")
public class HomeService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView init(String tel){
		ModelAndView mv = new ModelAndView();
		
		return mv;
	}

	@WebMethod
	public ModelAndView newsList(){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView getNews(int  newId){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView searchProduct(Page<Article> page , String title){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView getProduct(int  pid){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView sendSMSCode(String tel){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
}
