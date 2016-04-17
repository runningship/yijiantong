package com.houyi.management.app;

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
import org.bc.sdak.utils.LogUtil;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.WebMethod;

import com.houyi.management.MyInterceptor;
import com.houyi.management.biz.entity.ScanRecord;
import com.houyi.management.biz.entity.SearchHistory;
import com.houyi.management.cache.ConfigCache;
import com.houyi.management.product.entity.ProductItem;
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
		page = dao.findPage(page, "select art.id as id, art.title as title , art.conts as conts, img.path as img from Article art , Image img where img.id=art.imgId and art.publishFlag=1"
				+ " and art.leibie='news' order by art.setTopTime desc, art.id desc ", true, new Object[]{});
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
		mv.data.put("imgUrl", "http://"+ConfigCache.get("image_host", "localhost")+"/article_image_path");
		mv.data.put("productDetailUrl", "http://"+ConfigCache.get("app_host", "localhost")+"/product/view.jsp");
		mv.data.put("goodsDetailUrl", "http://"+ConfigCache.get("app_host", "localhost")+"/goods/view.jsp");
		mv.data.put("newsDetailUrl", "http://"+ConfigCache.get("app_host", "localhost")+"/article/view.jsp");
		return mv;
	}

	@WebMethod
	public ModelAndView news(){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView tips(Page<Map> page){
		ModelAndView mv = new ModelAndView();
		page.setPageSize(3);
		page = dao.findPage(page, "select art.id as id, art.title as title , art.isAd as isTop, art.conts as conts, img.path as img from Article art , Image img where img.id=art.imgId"
				+ " and art.leibie='tips' and art.publishFlag=1 order by art.setTopTime desc, art.id desc ", true, new Object[]{});
		//make abstract
		for(Map art : page.getResult()){
			String conts = art.get("conts").toString();
			conts = HTMLSpirithHelper.delHTMLTag(conts);
			if(conts.length()>70){
				conts = conts.substring(0,70);
			}
			art.put("conts", conts);
		}
		mv.data.put("tips", JSONHelper.toJSONArray(page.getResult()));
		mv.data.put("imgUrl", "http://"+ConfigCache.get("image_host", "localhost")+"/article_image_path");
		mv.data.put("tipsDetailUrl", "http://"+ConfigCache.get("app_host", "localhost")+"/article/view.jsp");
		return mv;
	}
	
	@WebMethod
	public ModelAndView getProduct(int  pid){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
//	@WebMethod
	public ModelAndView addScanRecord(ScanRecord record){
		//test url http://localhost:8181/c/app/addScanRecord?uid=12&qrCode=1454316150171.11&type=1
		ModelAndView mv = new ModelAndView();
		String[] arr = record.qrCode.split("\\.");
		MyInterceptor.getInstance().tableNameSuffix.set(arr[1]);
		ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "qrCode" , record.qrCode);
		record.productId = item.productId;
		record.addtime = new Date();
		ScanRecord po = dao.getUniqueByParams(ScanRecord.class, new String[]{"uid" , "productId" , "type"}, new Object[]{record.uid , record.productId , record.type});
		if(po==null){
			dao.saveOrUpdate(record);
		}
		mv.data.put("result", 0);
		return mv;
	}
	
	@WebMethod
	public ModelAndView listScanRecord(Page<Map> page ,Integer uid , Integer type , String device){
		ModelAndView mv = new ModelAndView();
		StringBuilder hql = new StringBuilder("select p.id as id, p.title as title , p.vender as vender , p.spec as spec,record.addtime as addtime , img.path as img,record.id as scanId from Product p ,ScanRecord record , Image img where record.productId=p.id and p.imgId=img.id ");
		List<Object> params =new ArrayList<Object>();
		
		hql.append(" and record.type=? ");
		params.add(type);
		
		hql.append(" and (record.device=? ");
		
		params.add(device);
		if(uid!=null){
			hql.append(" or record.uid=? ");
			params.add(uid);
		}
		hql.append(")");
		LogUtil.info("listScanRecord uid="+uid+",device="+device+",type="+type+",hql="+hql);
		page = dao.findPage(page , hql.toString(), true , params.toArray() );
		mv.data.put("page", JSONHelper.toJSON(page));
		mv.data.put("productDetailUrl", "http://"+ConfigCache.get("app_host", "localhost")+"/product/view.jsp");
		mv.data.put("imgUrl", "http://"+ConfigCache.get("image_host", "localhost")+"/article_image_path");
		return mv;
	}
	
	@WebMethod
	public ModelAndView deleteScanRecord(Integer id){
		ModelAndView mv = new ModelAndView();
		ScanRecord po = dao.get(ScanRecord.class, id);
		if(po!=null){
			dao.delete(po);
		}else{
			throw new GException(PlatformExceptionType.BusinessException,"记录不存在或已经删除");
		}
		mv.data.put("result", "success");
		return mv;
	}
	
	@WebMethod
	public ModelAndView deleteBatchScanRecord(String ids){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(ids)){
			throw new GException(PlatformExceptionType.BusinessException,"参数ids不能为空");
		}
		String[] idArr = ids.split(",");
		for(String id : idArr){
			ScanRecord po = dao.get(ScanRecord.class, Integer.valueOf(id));
			if(po!=null){
				dao.delete(po);
			}
		}
		mv.data.put("result", "success");
		return mv;
	}
	
	@WebMethod
	public ModelAndView sendSMSCode(String tel){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView searchGoods(Page<Map> page , String name , Integer uid){
		ModelAndView mv = new ModelAndView();
		StringBuilder sql = new StringBuilder("select goods.id as id , goods.title as title , img.path as img , goods.spec as spec , goods.vender as vender , goods.price as price from Goods goods , Image img  where goods.imgId=img.id ");
		List<Object> params = new ArrayList<Object>();
		if(StringUtils.isNotEmpty(name)){
			System.out.println(name);
			sql.append(" and title like ?");
			params.add("%"+name+"%");
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
	
	@WebMethod
	public ModelAndView listGoods(Page<Map> page , String name , Integer uid){
		ModelAndView mv = new ModelAndView();
		StringBuilder sql = new StringBuilder("select goods.id as id , goods.title as title , img.path as img , goods.spec as spec , goods.vender as vender , goods.price as price from Goods goods , Image img  where goods.isAd=1 and goods.imgId=img.id ");
		List<Object> params = new ArrayList<Object>();
		if(StringUtils.isNotEmpty(name)){
			sql.append(" and title like ?");
			params.add("%"+name+"%");
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
