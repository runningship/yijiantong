package com.houyi.management.goods;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

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

import com.houyi.management.product.entity.Goods;

@Module(name="/goods")
public class GoodsService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView save(Goods goods){
		ModelAndView mv = new ModelAndView();
		goods.addtime = new Date();
		dao.saveOrUpdate(goods);
		return mv;
	}

	@WebMethod
	public ModelAndView update(Goods goods){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(goods.title)){
			throw new GException(PlatformExceptionType.BusinessException,"标题不能为空");
		}
		goods.addtime = new Date();
		dao.saveOrUpdate(goods);
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(int  id){
		ModelAndView mv = new ModelAndView();
		Goods po = dao.get(Goods.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView list(Page<Map> page , String title){
		ModelAndView mv = new ModelAndView();
		StringBuilder sql = new StringBuilder("select id as id , title as title , imgId as imgId , spec as spec ,vender as vender , price as price , addtime as addtime from Goods where 1=1 ");
		List<Object> params = new ArrayList<Object>();
		if(StringUtils.isNotEmpty(title)){
			sql.append(" and title like ?");
			params.add("%"+title+"%");
		}
		page.order="desc";
		page.orderBy = "addtime";
		page = dao.findPage(page, sql.toString() , true , params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page));
		return mv;
	}
	
}
