package com.houyi.management.app;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.WebMethod;

import com.houyi.management.user.entity.User;


@Module(name="/app/u/")
public class UserService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView login(User user){
		ModelAndView mv = new ModelAndView();
		
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
