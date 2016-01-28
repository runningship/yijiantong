package com.houyi.management;

import java.io.IOException;

import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bc.web.UserOfflineHandler;

public class NewHouseUserOfflineHandler implements UserOfflineHandler{


	@Override
	public void handle(HttpServletRequest req, ServletResponse response) {
		try {
			HttpServletResponse resp = (HttpServletResponse)response;
			resp.setHeader("userOffline", "true");
			if(req.getRequestURI().contains("admin")){
//				resp.sendRedirect(req.getServletContext().getContextPath()+"/admin/login.jsp");
				response.getWriter().write("<script type='text/javascript'>window.top.location='"+req.getServletContext().getContextPath()+"/admin/login.jsp'</script>");
			}else if(req.getRequestURI().contains("/m/")){
//				resp.sendRedirect(req.getServletContext().getContextPath()+"/m/login.jsp");
				response.getWriter().write("<script type='text/javascript'>window.top.location='"+req.getServletContext().getContextPath()+"/m/login.jsp'</script>");
			}else{
//				resp.sendRedirect(req.getServletContext().getContextPath()+"/login.jsp");
				response.getWriter().write("<script type='text/javascript'>window.top.location='"+req.getServletContext().getContextPath()+"/login.jsp'</script>");
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
