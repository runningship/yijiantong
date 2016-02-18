package com.houyi.management.article;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.Page;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.WebMethod;

import com.houyi.management.article.entity.Article;


@Module(name="/article")
public class ArticleService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView save(Article article){
		ModelAndView mv = new ModelAndView();
		article.addtime = new Date();
		dao.saveOrUpdate(article);
		return mv;
	}

	@WebMethod
	public ModelAndView update(Article article){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(article.title)){
			throw new GException(PlatformExceptionType.BusinessException,"标题不能为空");
		}
		Article po = dao.get(Article.class, article.id);
		if(po!=null){
			po.author = article.author;
			po.conts = article.conts;
			po.imgId = article.imgId;
			po.isAd = article.isAd;
			po.orderx = article.orderx;
			po.title = article.title;
			po.publishFlag = article.publishFlag;
			dao.saveOrUpdate(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(int  id){
		ModelAndView mv = new ModelAndView();
		Article po = dao.get(Article.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView list(Page<Article> page , String title){
		ModelAndView mv = new ModelAndView();
		StringBuilder sql = new StringBuilder("from Article where 1=1 ");
		List<Object> params = new ArrayList<Object>();
		if(StringUtils.isNotEmpty(title)){
			sql.append(" and title like ?");
			params.add("%"+title+"%");
		}
		page = dao.findPage(page, sql.toString() , params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page));
		return mv;
	}
}
