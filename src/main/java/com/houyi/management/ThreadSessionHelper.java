package com.houyi.management;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.bc.web.ThreadSession;
import org.bc.web.UserOfflineHandler;

import com.houyi.management.user.entity.User;

public class ThreadSessionHelper {

	public static User getUser(){
    	HttpSession session = ThreadSession.getHttpSession();
    	if(session==null){
    		return null;
    	}
    	User u = (User)session.getAttribute("user");
    	if(u==null){
    		UserOfflineHandler handler = new NewHouseUserOfflineHandler();
    		handler.handle(ThreadSession.HttpServletRequest.get(), ThreadSession.getHttpservletresponse());
    	}
    	return u;
    }
	
    public static String getIp(){
    	HttpSession session = ThreadSession.getHttpSession();
    	return (String)session.getAttribute("ip");
    }
}
