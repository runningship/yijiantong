package com.houyi.management.user;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.Page;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.sdak.utils.JSONHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;
import org.bc.web.WebMethod;

import com.houyi.management.SysConstants;
import com.houyi.management.ThreadSessionHelper;
import com.houyi.management.user.entity.User;
import com.houyi.management.user.entity.UserTrack;
import com.houyi.management.util.DataHelper;
import com.houyi.management.util.SecurityHelper;
import com.houyi.management.util.ShortMessageHelper;
import com.houyi.management.util.VerifyCodeHelper;
//
//import com.sun.image.codec.jpeg.JPEGCodec;
//import com.sun.image.codec.jpeg.JPEGImageEncoder;
@Module(name="/admin/user")
public class UserService {
	
	public static Map<String,Integer> onlineUserCountMap = new HashMap<String , Integer>();
	
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView save(User user  ,  String roleIds){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(user.account)){
			throw new GException(PlatformExceptionType.BusinessException,"用户账号不能为空");
		}
		if(StringUtils.isEmpty(user.name)){
			throw new GException(PlatformExceptionType.BusinessException,"用户姓名不能为空");
		}
		if(StringUtils.isEmpty(user.pwd)){
			throw new GException(PlatformExceptionType.BusinessException,"请先设置密码");
		}
		User po = dao.getUniqueByParams(User.class, new String[]{"account" , "type"}, new Object[]{ user.account , 3});
		if(po!=null){
			throw new GException(PlatformExceptionType.BusinessException,"账号已经存在");
		}
		user.addtime = new Date();
		user.pwd = SecurityHelper.Md5(user.pwd);
		user.type = 3;
		dao.saveOrUpdate(user);
		return mv;
	}

	private ModelAndView adminLogin(User user){
		ModelAndView mv = new ModelAndView();
		String pwd = SecurityHelper.Md5(user.pwd);
		User po = dao.getUniqueByParams(User.class, new String[]{"account" , "pwd"}, new Object[]{user.account  , pwd});
		if(po==null){
			throw new GException(PlatformExceptionType.BusinessException,"用户名或密码不正确。");
		}
		po.lasttime = new Date();
		dao.saveOrUpdate(po);
		ThreadSession.getHttpSession().setAttribute(SysConstants.Session_Attr_User, po);
		List<Map> result = dao.listAsMap("select ra.authId as authId from UserRole ur ,RoleAuth ra where ur.roleId=ra.roleId and ur.uid=?", po.id);
		StringBuilder authList= new StringBuilder("");
		for(Map map : result){
			authList.append(map.get("authId").toString());
		}
		ThreadSession.getHttpSession().setAttribute(SysConstants.Session_Auth_List, authList.toString());
		String text;
		try {
			text = FileUtils.readFileToString(new File(ThreadSession.HttpServletRequest.get().getServletContext().getRealPath("/")+File.separator+"auths.json"), "utf8");
			JSONArray jarr = JSONArray.fromObject(text);
			List<String> urlList = new ArrayList<String>();
			for(int i=0;i<jarr.size();i++){
				JSONObject jobj = jarr.getJSONObject(i);
				if(authList.toString().contains(jobj.getString("id"))){
					continue;
				}
				String urls = jobj.getString("urls");
				for(String url : urls.split(",")){
					urlList.add(url);
				}
			}
			ThreadSession.getHttpSession().setAttribute(SysConstants.Session_Auth_Urls, urlList);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	private ModelAndView adminLogout(){
		ModelAndView mv = new ModelAndView();
		ThreadSession.getHttpSession().removeAttribute("user");
		ThreadSession.getHttpSession().removeAttribute(SysConstants.Session_Auth_List);
		mv.redirect=ThreadSession.HttpServletRequest.get().getServletContext().getContextPath()+"/login/login.jsp";
		return mv;
	}
	
	@WebMethod
	public ModelAndView update(User user  ,  String roleIds ){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(user.name)){
			throw new GException(PlatformExceptionType.BusinessException,"用户名不能为空");
		}
		User po = dao.get(User.class, user.id);
		po.account = user.account;
		po.name = user.name;
		if(StringUtils.isNotEmpty(user.pwd)){
			po.pwd = SecurityHelper.Md5(user.pwd);
		}
		po.tel = user.tel;
		po.qq = user.qq;
		po.birth = user.birth;
		po.weixin = user.weixin;
		po.gender = user.gender;
		dao.saveOrUpdate(po);
		ThreadSession.getHttpSession().setAttribute(SysConstants.Session_Attr_User, po);
		return mv;
	}

	@WebMethod
	public ModelAndView modifyPwd(int  uid , String oldPwd , String newPwd){
		ModelAndView mv = new ModelAndView();
		User po = dao.get(User.class, uid);
		if(po!=null){
			if(!po.pwd.equals(SecurityHelper.Md5(oldPwd))){
				throw new GException(PlatformExceptionType.BusinessException,"原密码不正确,请重新输入后重试");
			}
			po.pwd = SecurityHelper.Md5(newPwd);
			dao.saveOrUpdate(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(int  id){
		ModelAndView mv = new ModelAndView();
		User po = dao.get(User.class, id);
		if(po!=null){
			dao.delete(po);
			dao.execute("delete from UserGroup where uid=?", id);
			dao.execute("delete from UserRole where uid=?", id);
			mv.data.put("msg", "删除用户成功");
		}
		
		return mv;
	}
	
	
	@WebMethod
	public ModelAndView sendVerifyCode(String tel){
		ModelAndView mv = new ModelAndView();
		TelVerifyCode tvc = new TelVerifyCode();
		if(StringUtils.isEmpty(tel)){
			throw new GException(PlatformExceptionType.BusinessException,"电话号码不能为空");
		}
		tvc.tel = tel;
        int max=9999;
        int min=1000;
        Random random = new Random();
        int s = random.nextInt(max)%(max-min+1) + min;
        String code = String.valueOf(s);
        tvc.code = code ;
      //send code to tel
        boolean result = ShortMessageHelper.sendRongLianMsg(tel, tvc.code);
        if(!result){
        	throw new GException(PlatformExceptionType.BusinessException,"发送短信失败，请稍后重试");
        }
        tvc.sendtime =  new Date();
		dao.saveOrUpdate(tvc);
		mv.data.put("result", 0);
		return mv;
	}
	
	@WebMethod
	public ModelAndView reg(String tel , String account, String verifyCode , String pwd){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(account)){
			throw new GException(PlatformExceptionType.BusinessException,"请先填写登录账号");
		}
		if(StringUtils.isEmpty(pwd)){
			throw new GException(PlatformExceptionType.BusinessException,"密码不能为空");
		}
		TelVerifyCode tvc = VerifyCodeHelper.verifySMSCode(tel, verifyCode);
		User po = dao.getUniqueByKeyValue(User.class, "account", account);
		if(po!=null){
			throw new GException(PlatformExceptionType.BusinessException,"账号 "+account+" 已经被注册");
		}
		User user = new User();
		user.type = 1;
		user.tel = tel;
		user.pwd =	SecurityHelper.Md5(pwd);
		user.addtime = new Date();
		user.account = account;
		user.name="";
		dao.saveOrUpdate(user);
		tvc.verifyTime = new Date();
		dao.saveOrUpdate(tvc);
		
		mv.data.put("result", 0);
		return mv;
	}
	
	@WebMethod
	public ModelAndView login(String account, String pwd){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(account)){
			throw new GException(PlatformExceptionType.BusinessException,"请先填写登录账号");
		}
		if(StringUtils.isEmpty(pwd)){
			throw new GException(PlatformExceptionType.BusinessException,"请先填写登录密码");
		}
		User po = dao.getUniqueByKeyValue(User.class, "account", account);
		if(po==null){
			throw new GException(PlatformExceptionType.BusinessException,"账号不存在");
		}
		if(po.pwd==null){
			po.pwd="";
		}
		if(!po.pwd.equals(SecurityHelper.Md5(pwd)) && !po.pwd.equals(pwd) ){
			throw new GException(PlatformExceptionType.BusinessException,"密码不正确");
		}
		ThreadSession.getHttpSession().setAttribute(SysConstants.Session_Attr_User, po);
		mv.data.put("user", JSONHelper.toJSON(po));
		mv.data.put("result", 0);
		return mv;
	}
	
	@WebMethod
	public ModelAndView updateLocation(UserTrack track){
		ModelAndView mv = new ModelAndView();
		track.addtime = new Date();
		dao.saveOrUpdate(track);
		return mv;
	}
	
	@WebMethod
	public ModelAndView listSysUser(Page<User> page , String search){
		ModelAndView mv = new ModelAndView();
		StringBuilder hql = new StringBuilder("from User where type=? ");
		List<Object> params = new ArrayList<Object>();
		params.add(3);
		if(StringUtils.isNotEmpty(search)){
			hql.append(" and (name like ? or tel like ? or account like ?)");
			params.add("%"+search+"%");
			params.add("%"+search+"%");
			params.add("%"+search+"%");
		}
		page = dao.findPage(page, hql.toString() , params.toArray());
		mv.data.put("page", JSONHelper.toJSON(page));
		return mv;
	}
}
