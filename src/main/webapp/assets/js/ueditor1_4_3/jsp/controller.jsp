<%@page import="com.houyi.management.cache.ConfigCache"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="com.baidu.ueditor.ActionEnter"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%

    request.setCharacterEncoding( "utf-8" );
	response.setHeader("Content-Type" , "text/html");
	
	String rootPath = application.getRealPath( "/" );
	request.setAttribute("ueditor_upload_path", ConfigCache.get("ueditor_upload_path", ""));
	request.setAttribute("download_prefix", ConfigCache.get("download_prefix", ""));
	//request.setAttribute("serverName", DataHelper.getServerName(request));
	out.write( new ActionEnter( request, rootPath ).exec() );
	
%>