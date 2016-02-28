package com.houyi.management.biz;

import java.io.IOException;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.io.IOUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.Page;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.WebMethod;

import com.houyi.management.biz.entity.SysConfig;


@Module(name="/conf")
public class ConfService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	@WebMethod
	public ModelAndView update(SysConfig conf){
		ModelAndView mv = new ModelAndView();
		SysConfig po = dao.get(SysConfig.class, conf.id);
		if(po!=null){
			po.value = conf.value;
			dao.saveOrUpdate(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView list(Page<SysConfig> page){
		ModelAndView mv = new ModelAndView();
		page = dao.findPage(page, "from SysConfig");
		mv.data.put("page", JSONHelper.toJSON(page));
		mv.data.put("result", 0);
		return mv;
	}
	
	@WebMethod
	public ModelAndView initDefault(){
		ModelAndView mv = new ModelAndView();
		dao.execute("delete from SysConfig");
		try {
			String json = IOUtils.toString(this.getClass().getResourceAsStream("conf.json"));
			JSONArray arr = JSONArray.fromObject(json);
			for(int i=0;i<arr.size();i++){
				JSONObject jobj = arr.getJSONObject(i);
				SysConfig conf = new SysConfig();
				conf.name = jobj.getString("name");
				conf.value = jobj.getString("value");
				conf.conts = jobj.getString("conts");
				dao.saveOrUpdate(conf);
			}
		} catch (IOException e) {
			mv.data.put("msg", "");
		}
		return mv;
	}
}
