package com.houyi.management.biz;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
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

import com.houyi.management.MyInterceptor;
import com.houyi.management.biz.entity.LotteryVerify;
import com.houyi.management.biz.entity.ScanRecord;
import com.houyi.management.product.entity.ProductItem;
import com.houyi.management.user.entity.TelVerifyCode;
import com.houyi.management.user.entity.User;
import com.houyi.management.util.SecurityHelper;
import com.houyi.management.util.VerifyCodeHelper;


@Module(name="/admin/lottery")
public class LotteryService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	@WebMethod
	@Transactional
	public ModelAndView add(String qrCode ,String tel, String smsCode,  String activeAddr , String uid){
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
		if(StringUtils.isEmpty(uid)){
			TelVerifyCode tvc = VerifyCodeHelper.verifySMSCode(tel, smsCode);
			tvc.verifyTime = new Date();
			dao.saveOrUpdate(tvc);
		}
		User u = dao.getUniqueByKeyValue(User.class, "tel", tel);
		if(u==null){
			u = new User();
			u.tel = tel;
			u.account = tel;
			u.name=tel;
			u.type=1;
			u.addtime = new Date();
			u.pwd = SecurityHelper.Md5(smsCode);
			dao.saveOrUpdate(u);
		}
		
		item.lotteryOwnerId = u.id;
		item.lotteryActive = 1;
		item.activeTime = new Date();
		item.activeAddr = activeAddr;
		dao.saveOrUpdate(item);
		
		LotteryVerify lv = dao.getUniqueByKeyValue(LotteryVerify.class, "qrCode", qrCode);
		if(lv!=null){
			lv.status = 1;
			dao.saveOrUpdate(lv);
		}
		//充话费
		mv.data.put("result", 0);
		return mv;
	}
	
	@WebMethod
	public ModelAndView addVerify(String qrCode , String verifyCode , String tel , Integer uid , String activeAddr , Integer productId){
		ModelAndView mv = new ModelAndView();
		LotteryVerify lv = new LotteryVerify();
		lv.activeAddr = activeAddr;
		lv.productId = productId;
		lv.activeUid = uid;
		lv.tel = tel;
		lv.verifyCode = verifyCode;
		lv.addtime = new Date();
		lv.qrCode = qrCode;
		lv.status = 0;
		dao.saveOrUpdate(lv);
		mv.data.put("result", 0);
		return mv;
	}
	
	@WebMethod
	public ModelAndView listVerify(Page<Map> page , String code , String tel , Integer status){
		ModelAndView mv = new ModelAndView();
		StringBuilder hql = new StringBuilder("select lv.id as id , lv.status as status, pro.title as title , pro.spec as spec, lv.tel as tel , lv.activeAddr as activeAddr, "
				+ "lv.verifyCode as verifyCode,lv.qrCode as qrCode, lv.addtime as addtime from LotteryVerify lv , Product pro  where lv.productId=pro.id");
		List<Object> params = new ArrayList<Object>();
		if(StringUtils.isNotEmpty(code)){
			hql.append(" and lv.verifyCode like ? ");
			params.add("%"+code+"%");
		}
		
		if(StringUtils.isNotEmpty(tel)){
			hql.append(" and lv.tel like ? ");
			params.add("%"+tel+"%");
		}
		if(status!=null){
			hql.append(" and status=? ");
			params.add(status);
		}
		page = dao.findPage(page, hql.toString() ,true , params.toArray());
		mv.data.put("page",JSONHelper.toJSON(page));
		mv.data.put("result", 0);
		return mv;
	}
	
	@WebMethod
	public ModelAndView setStatus(Integer id , Integer status){
		ModelAndView mv = new ModelAndView();
		LotteryVerify po = dao.get(LotteryVerify.class, id);
		if(po!=null){
			po.status = status;
			if(status==1){
				//自动兑奖
				String[] arr = po.verifyCode.split("\\.");
				MyInterceptor.getInstance().tableNameSuffix.set(arr[1]);
				ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "verifyCode" , po.verifyCode);
				add(item.qrCode , po.tel , "" , po.activeAddr , po.activeUid==null ? null : po.activeUid.toString());
			}
			dao.saveOrUpdate(po);
		}
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
