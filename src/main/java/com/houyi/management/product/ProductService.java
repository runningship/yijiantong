package com.houyi.management.product;

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

import com.houyi.management.MyInterceptor;
import com.houyi.management.biz.entity.TableInfo;
import com.houyi.management.product.entity.Product;
import com.houyi.management.product.entity.ProductBatch;
import com.houyi.management.product.entity.ProductItem;


@Module(name="/product")
public class ProductService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	public static final int MAX_TABLE_ROWS=1000000;
	
	@WebMethod
	public ModelAndView save(Product product){
		ModelAndView mv = new ModelAndView();
		product.addtime = new Date();
		dao.saveOrUpdate(product);
		return mv;
	}

	@WebMethod
	public ModelAndView update(Product product){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(product.title)){
			throw new GException(PlatformExceptionType.BusinessException,"标题不能为空");
		}
		product.addtime = new Date();
		dao.saveOrUpdate(product);
		return mv;
	}
	
	@WebMethod
	public ModelAndView saveBatch(ProductBatch batch){
		ModelAndView mv = new ModelAndView();
		batch.addtime = new Date();
		//根据 batch.count找到合适的item表,插入数据并设置batch.tableOffset
		batch.tableOffset="12";
		long count = dao.countHql("select count (*) from ProductItem");
		if(count>MAX_TABLE_ROWS){
			
		}
		dao.saveOrUpdate(batch);
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(int  id){
		ModelAndView mv = new ModelAndView();
		Product po = dao.get(Product.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView listProduct(Page<Product> page , String title){
		ModelAndView mv = new ModelAndView();
		StringBuilder sql = new StringBuilder("from Product where 1=1 ");
		List<Object> params = new ArrayList<Object>();
		if(StringUtils.isNotEmpty(title)){
			sql.append(" and title like ?");
			params.add("%"+title+"%");
		}
		page = dao.findPage(page, sql.toString() , params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page));
		return mv;
	}
	
	@WebMethod
	public ModelAndView listBatch(Page<ProductBatch> page , Integer productId){
		ModelAndView mv = new ModelAndView();
		StringBuilder sql = new StringBuilder("from ProductBatch where productId=? ");
		List<Object> params = new ArrayList<Object>();
		params.add(productId);
		page.pageSize=10;
		page.order="desc";
		page.orderBy="addtime";
		page = dao.findPage(page, sql.toString() , params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page));
		return mv;
	}
	
	@WebMethod
	public ModelAndView listItem(Page<ProductItem> page , Integer productId , Integer batchId){
		ModelAndView mv = new ModelAndView();
		TableInfo table = dao.get(TableInfo.class, batchId);
		MyInterceptor.getInstance().tableNameSuffix.set(table.suffix);
		StringBuilder sql = new StringBuilder("from ProductItem where productId=? and batchId=? ");
		List<Object> params = new ArrayList<Object>();
		params.add(productId);
		params.add(batchId);
		page = dao.findPage(page, sql.toString() , params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page));
		return mv;
	}
	
	@WebMethod
	public ModelAndView getItem(String code){
		ModelAndView mv = new ModelAndView();
		ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "qrCode", code);
		if(item==null){
			throw new GException(PlatformExceptionType.BusinessException,"没有找到商品信息");
		}
		mv.data.put("item", JSONHelper.toJSON(item));

		Product product = dao.get(Product.class, item.productId);
		mv.data.put("product", JSONHelper.toJSON(product));
		mv.data.put("result", 0);
		return mv;
	}
}
