package com.houyi.management.app;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.Page;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.WebMethod;

import com.houyi.management.biz.entity.SearchHistory;
import com.houyi.management.cache.ConfigCache;


@Module(name="/app/mall")
public class MallService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView listGoods(Page<Map> page , String name , Integer uid){
		ModelAndView mv = new ModelAndView();
		StringBuilder sql = new StringBuilder("select goods.id as id , goods.title as title , img.path as img , goods.spec as spec , "
				+ "goods.vender as vender , goods.price as price , goods.originalPrice as originalPrice from Goods goods , Image img  where goods.imgId=img.id and goods.isAd=1 ");
		List<Object> params = new ArrayList<Object>();
		if(StringUtils.isNotEmpty(name)){
			sql.append(" and title like ?");
			params.add("%"+name+"%");
		}
		if(StringUtils.isNotEmpty(name)){
			SearchHistory search = new SearchHistory();
			search.uid = uid;
			search.text = name;
			dao.saveOrUpdate(search);
		}
		
		page.order="desc";
		page.orderBy = "addtime";
		page.setPageSize(10);
		page = dao.findPage(page, sql.toString() , true , params.toArray());
		
		if(StringUtils.isNotEmpty(name)){
			SearchHistory search = new SearchHistory();
			search.uid = uid;
			search.text = name;
			dao.saveOrUpdate(search);
		}
		
		mv.data.put("page", JSONHelper.toJSON(page));
		mv.data.put("imgUrl", "http://"+ConfigCache.get("image_host", "localhost")+"/article_image_path");
		mv.data.put("goodsDetailUrl", "http://"+ConfigCache.get("app_host", "localhost")+"/goods/view.jsp");
		return mv;
	}
}
