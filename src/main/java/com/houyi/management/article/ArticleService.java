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
		if(article.isAd==Integer.valueOf(1)){
			article.setTopTime=new Date();
		}
		dao.saveOrUpdate(article);
		return mv;
	}

	@WebMethod
	public ModelAndView setToTop(Integer id){
		ModelAndView mv = new ModelAndView();
		Article po = dao.get(Article.class, id);
		if(po!=null){
			po.isAd = 1;
			po.setTopTime = new Date();
			dao.saveOrUpdate(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView revokeSetTop(Integer id){
		ModelAndView mv = new ModelAndView();
		Article po = dao.get(Article.class, id);
		if(po!=null){
			po.isAd = 0;
			po.setTopTime = null;
			dao.saveOrUpdate(po);
		}
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
			po.leibie = article.leibie;
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
	public ModelAndView togglePublishFlag(int  id){
		ModelAndView mv = new ModelAndView();
		Article po = dao.get(Article.class, id);
		if(po!=null){
			if(po.publishFlag==null || po.publishFlag!=1){
				po.publishFlag = 1;
			}else{
				po.publishFlag = 0;
			}
			dao.saveOrUpdate(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView list(Page<Article> page , String title , String leibie){
		ModelAndView mv = new ModelAndView();
		StringBuilder sql = new StringBuilder("from Article where 1=1 ");
		List<Object> params = new ArrayList<Object>();
		if(StringUtils.isNotEmpty(title)){
			sql.append(" and title like ?");
			params.add("%"+title+"%");
		}
		if(StringUtils.isNotEmpty(leibie)){
			sql.append(" and leibie = ?");
			params.add(leibie);
		}
		sql.append(" order by setTopTime desc , id desc");
		page = dao.findPage(page, sql.toString() , params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page));
		return mv;
	}
}
