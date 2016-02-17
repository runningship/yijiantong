package com.houyi.management.biz;

import java.util.Date;
import java.util.List;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.WebMethod;

import com.houyi.management.MyInterceptor;
import com.houyi.management.biz.entity.ScanRecord;
import com.houyi.management.product.entity.ProductItem;


@Module(name="/scan")
public class ScanService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	@WebMethod
	public ModelAndView add(ScanRecord record){
		//test url http://localhost:8181/c/scan/add?uid=12&qrCode=1454316150171.11&type=1
		ModelAndView mv = new ModelAndView();
		String[] arr = record.qrCode.split("\\.");
		MyInterceptor.getInstance().tableNameSuffix.set(arr[1]);
		ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "qrCode" , record.qrCode);
		record.productId = item.productId;
		record.addtime = new Date();
		ScanRecord po = dao.getUniqueByParams(ScanRecord.class, new String[]{"uid" , "productId"}, new Object[]{record.uid , record.productId});
		if(po==null){
			dao.saveOrUpdate(record);
		}
		mv.data.put("result", 0);
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(Integer id){
		ModelAndView mv = new ModelAndView();
		ScanRecord po = dao.get(ScanRecord.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView list(Integer uid){
		//test url http://localhost:8181/c/scan/list?uid=12&type=1
		ModelAndView mv = new ModelAndView();
		List<ScanRecord> list = dao.listByParams(ScanRecord.class, "from ScanRecord where uid=?", uid);
		mv.data.put("list", JSONHelper.toJSONArray(list));
		mv.data.put("result", 0);
		return mv;
	}
}
