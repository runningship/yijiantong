package com.houyi.management.biz;

import java.util.Date;
import java.util.List;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.Transactional;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.WebMethod;

import com.houyi.management.MyInterceptor;
import com.houyi.management.biz.entity.ScanRecord;
import com.houyi.management.product.entity.ProductItem;
import com.houyi.management.user.entity.User;
import com.houyi.management.util.SecurityHelper;


@Module(name="/admin/lottery")
public class LotteryService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	@WebMethod
	@Transactional
	public ModelAndView add(String qrCode ,String tel, String smsCode, String device ,  String activeAddr){
		ModelAndView mv = new ModelAndView();
		String[] arr = qrCode.split("\\.");
		MyInterceptor.getInstance().tableNameSuffix.set(arr[1]);
		ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "qrCode" , qrCode);
		if(item==null){
			throw new GException(PlatformExceptionType.BusinessException,"没有找到兑奖信息");
		}
		if(item.lotteryActive==1){
			throw new GException(PlatformExceptionType.BusinessException,"改商品已经兑奖，请联系商户检查");
		}
//		if(StringUtils.isEmpty(verifyCode)){
//			throw new GException(PlatformExceptionType.BusinessException,"请先输入兑奖码");
//		}
//		if(!verifyCode.equals(item.verifyCode)){
//			throw new GException(PlatformExceptionType.BusinessException,"兑奖码不正确，请检查后重新输入");
//		}
		User u = dao.getUniqueByKeyValue(User.class, "tel", tel);
		if(u==null){
			u = new User();
			u.tel = tel;
			u.account = tel;
			u.name=tel;
			u.type=1;
			u.pwd = SecurityHelper.Md5(tel);
			dao.saveOrUpdate(u);
		}
		ScanRecord record = new ScanRecord();
		record.addtime = new Date();
		record.device = device;
		record.uid = u.id;
		record.qrCode = qrCode;
		record.productId = item.productId;
		dao.saveOrUpdate(record);
		
		item.lotteryOwnerId = u.id;
		item.lotteryActive = 1;
		item.activeTime = new Date();
		item.activeAddr = activeAddr;
//		item.activeLat = activeLat;
//		item.activeLng = activeLng;
		dao.saveOrUpdate(item);
		
		//充话费
		mv.data.put("result", 0);
		return mv;
	}
	
	
	@WebMethod
	public ModelAndView list(Integer uid){
		ModelAndView mv = new ModelAndView();
		List<ProductItem> list = dao.listByParams(ProductItem.class, "from ProductItem where buyerId=? ", uid);
		mv.data.put("list", JSONHelper.toJSONArray(list));
		mv.data.put("result", 0);
		return mv;
	}
}
