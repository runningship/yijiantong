package com.houyi.management.app;

import java.util.Map;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.Page;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.WebMethod;

import com.houyi.management.article.entity.Article;
import com.houyi.management.cache.ConfigCache;
import com.houyi.management.util.HTMLSpirithHelper;


@Module(name="/app")
public class HomeService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView init(String tel){
		//http://localhost:8181/c/app/init
		ModelAndView mv = new ModelAndView();
		//新闻
		Page<Map> page = new Page<Map>();
		page.setPageSize(2);
		page = dao.findPage(page, "select art.id as id, art.title as title , art.conts as conts, img.path as img from Article art , Image img where img.id=art.imgId order by art.orderx ", true, new Object[]{});
		//make abstract
		for(Map art : page.getResult()){
			String conts = art.get("conts").toString();
			conts = HTMLSpirithHelper.delHTMLTag(conts);
			if(conts.length()>70){
				conts = conts.substring(0,70);
			}
			art.put("conts", conts);
		}
		mv.data.put("news", JSONHelper.toJSONArray(page.getResult()));
		
		page = dao.findPage(page, "select product.id as id, product.title as title , img.path as img from Product product , Image img where img.id=product.imgId and product.isAd=1", true, new Object[]{});
		mv.data.put("products", JSONHelper.toJSONArray(page.getResult()));
		mv.data.put("imgUrlPrefix", "http://"+ConfigCache.get("image_host", "localhost")+"/article_image_path");
		mv.data.put("detailUrlPrefix", "http://"+ConfigCache.get("image_host", "localhost")+"/product/view.jsp");
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
