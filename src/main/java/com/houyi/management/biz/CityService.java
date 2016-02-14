package com.houyi.management.biz;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.Page;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.WebMethod;

import com.houyi.management.biz.entity.City;
import com.houyi.management.util.DataHelper;


@Module(name="/city")
public class CityService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	@WebMethod
	public ModelAndView save(City city){
		ModelAndView mv = new ModelAndView();
		city.pinyin = DataHelper.toPinyin(city.name);
		city.pyShort = DataHelper.toPinyinShort(city.name);
		dao.saveOrUpdate(city);
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(Integer id){
		ModelAndView mv = new ModelAndView();
		City po = dao.get(City.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView list(Page<City> page){
		ModelAndView mv = new ModelAndView();
		page = dao.findPage(page,  "from City");
		mv.data.put("page", JSONHelper.toJSON(page));
		mv.data.put("result", 0);
		return mv;
	}
}
