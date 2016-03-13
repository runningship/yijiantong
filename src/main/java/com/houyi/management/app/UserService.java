package com.houyi.management.app;

import java.util.Date;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;
import org.bc.web.WebMethod;

import com.houyi.management.SysConstants;
import com.houyi.management.user.entity.User;
import com.houyi.management.util.SecurityHelper;


@Module(name="/app/u/")
public class UserService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView login(User user){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(user.account)){
			throw new GException(PlatformExceptionType.BusinessException,"请先填写登录账号");
		}
		if(StringUtils.isEmpty(user.pwd)){
			throw new GException(PlatformExceptionType.BusinessException,"请先填写登录密码");
		}
		User po = dao.getUniqueByParams(User.class, new String[]{"account" , "type"},  new Object[]{user.account , 1});
		if(po==null){
			throw new GException(PlatformExceptionType.BusinessException,"账号不存在");
		}
		if(po.pwd==null){
			po.pwd="";
		}
		if(!po.pwd.equals(SecurityHelper.Md5(user.pwd)) && !po.pwd.equals(user.pwd) ){
			throw new GException(PlatformExceptionType.BusinessException,"密码不正确");
		}
		ThreadSession.getHttpSession().setAttribute(SysConstants.Session_Attr_User, po);
		JSONObject userJson = JSONHelper.toJSON(po);
		userJson.remove("pwd");
		mv.data.put("user", userJson);
		mv.data.put("result", "success");
		return mv;
	}
	
	@WebMethod
	public ModelAndView logou(User user){
		ModelAndView mv = new ModelAndView();
		return mv;
	}

	@WebMethod
	public ModelAndView reg(User user , String smsCode){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(user.account)){
			throw new GException(PlatformExceptionType.BusinessException,"请先填写登录账号");
		}
		if(StringUtils.isEmpty(user.pwd)){
			throw new GException(PlatformExceptionType.BusinessException,"请先填写登录密码");
		}
		User po  = dao.getUniqueByKeyValue(User.class, "account", user.account);
		if(po!=null){
			throw new GException(PlatformExceptionType.BusinessException,"账号已经被注册");
		}
		user.pwd = SecurityHelper.Md5(user.pwd);
		user.type = 1;
		user.name = user.account;
		user.tel = user.account;
		user.addtime = new Date();
		dao.saveOrUpdate(user);
		mv.data.put("result", "success");
		mv.data.put("uid", user.id);
		return mv;
	}
	
	@WebMethod
	public ModelAndView getUserProfile(Integer uid){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
	
	@WebMethod
	public ModelAndView updateUserProfile(User user){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
}
