package com.houyi.management.biz;

import java.util.List;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.Page;
import org.bc.sdak.Transactional;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.WebMethod;

import com.houyi.management.biz.entity.TableInfo;
import com.houyi.management.product.entity.ProductItem;


@Module(name="/table")
public class TableInfoService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	public static final int MAX_TABLE_ROWS=1000000;
	
	@WebMethod
	@Transactional
	public ModelAndView save(String suffix){
		ModelAndView mv = new ModelAndView();
		TableInfo po = dao.getUniqueByKeyValue(TableInfo.class, "suffix", suffix);
		if(po!=null){
			throw new GException(PlatformExceptionType.BusinessException,"编号重复");
		}
		TableInfo table = new TableInfo();
		table.size=0;
		table.suffix = suffix;
		String sql = "if not exists (select * from sysobjects where name='ProductItem_"+suffix+"' and xtype='U') CREATE TABLE  [dbo].[ProductItem_"+suffix+"] ([id] int NOT NULL IDENTITY(1,1) "
				+ ",[qrCode] nvarchar(50) NOT NULL "
				+ ",[verifyCode] nvarchar(50) NULL "
				+ ",[productId] int NOT NULL"
				+ ",[batchId] int NOT NULL "
				+ ",[lottery] int NULL "
				+ ",[lotteryActive] int NULL "
				+",[activeAddr] nvarchar(100) NULL"
				+"[activeLat] float NULL"
				+"[activeLng] float NULL"
				+ ",[lotteryOwnerId] int NULL "
				+ ", [addtime] datetime NULL)";
		dao.executeSQL(sql);
		dao.saveOrUpdate(table);
		return mv;
	}
	
	@WebMethod
	public ModelAndView list(Page<TableInfo> page){
		ModelAndView mv = new ModelAndView();
		page = dao.findPage(page, "from TableInfo");
		mv.data.put("page", JSONHelper.toJSON(page));
		mv.data.put("result", 0);
		return mv;
	}
}
