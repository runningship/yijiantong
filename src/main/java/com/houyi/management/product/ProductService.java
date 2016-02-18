package com.houyi.management.product;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.Page;
import org.bc.sdak.SessionFactoryBuilder;
import org.bc.sdak.Transactional;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.WebMethod;
import org.hibernate.CacheMode;
import org.hibernate.Session;
import org.hibernate.Transaction;

import com.houyi.management.MyInterceptor;
import com.houyi.management.biz.entity.TableInfo;
import com.houyi.management.product.entity.Product;
import com.houyi.management.product.entity.ProductBatch;
import com.houyi.management.product.entity.ProductItem;


@Module(name="/product")
public class ProductService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	public static final int MAX_TABLE_ROWS=1000000;
	
	public static final int DB_BATCH_ADD_SIZE=500;
	
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
		dao.saveOrUpdate(batch);
		return mv;
	}
	
	@WebMethod
	@Transactional
	public ModelAndView deleteBatch(Integer batchId){
		ModelAndView mv = new ModelAndView();
		ProductBatch po = dao.get(ProductBatch.class, batchId);
		dao.delete(po);
		return mv;
	}
	
	@WebMethod
	public ModelAndView generateQRCode(Integer batchId){
		ModelAndView mv = new ModelAndView();
		ProductBatch batch = dao.get(ProductBatch.class, batchId);
		//根据 batch.count找到合适的item表,插入数据并设置batch.tableOffset
		List<TableInfo> list = dao.listByParams(TableInfo.class, "from TableInfo where size<?", MAX_TABLE_ROWS-batch.count);
		if(list.isEmpty()){
			throw new GException(PlatformExceptionType.BusinessException,"没有足够的空间生成二维码, 请联系系统管理员");
		}
		TableInfo table = list.get(0);
		batch.tableOffset=table.suffix;
		batch.active = 1;
		table.size+= batch.count;
		dao.saveOrUpdate(batch);
		dao.saveOrUpdate(table);
		
		MyInterceptor.getInstance().tableNameSuffix.set(batch.tableOffset);
		for(int i=0;i<batch.count/DB_BATCH_ADD_SIZE; i++){
			batchAdd(batch, DB_BATCH_ADD_SIZE);
		}
		batchAdd(batch , batch.count%DB_BATCH_ADD_SIZE);
		return mv;
	}
	
	private void batchAdd(ProductBatch batch ,int count){
		Session session = SessionFactoryBuilder.buildOrGet().getCurrentSession();
		Transaction tran = session.beginTransaction();
		session.setCacheMode(CacheMode.IGNORE);
		Random r = new Random();
		for(int i=0;i<count;i++){
			ProductItem item = new ProductItem();
			item.addtime = new Date();
			item.lotteryActive = 0;
			item.batchId = batch.id;
			item.lottery=batch.lottery;
			item.productId = batch.productId;
			String str = System.currentTimeMillis()+""+count;
			item.qrCode = str + "."+batch.tableOffset;
			item.verifyCode = String.valueOf(r.nextInt(999999));
			session.save(item);
		}
		//将剩余的提交
		session.flush();
        session.clear();
		tran.commit();
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
		ProductBatch table = dao.get(ProductBatch.class, batchId);
		MyInterceptor.getInstance().tableNameSuffix.set(table.tableOffset);
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
