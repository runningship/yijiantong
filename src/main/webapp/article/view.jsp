<%@page import="com.houyi.management.article.entity.Article"%>
<%@page import="org.bc.sdak.TransactionalServiceHelper"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String id =request.getParameter("id");
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	Article po = dao.get(Article.class, Integer.valueOf(id));
	request.setAttribute("article", po);
%>
<!DOCTYPE html>
<html lang="en">

	<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<script type="text/javascript">
	
	</script>
	<style type="text/css">
		.title{font-size: 14pt;    color: #666;    font-weight: bold;    margin: 10pt 0; text-align:center;}
		.desc{text-align:center;}
		.desc .date{font-size: 12pt;    color: #888;}
		.conts img{width:100% !important;}
	</style>
	</head>
	
	<body>
		<div class="title">${article.title }</div>
		<div class="desc">
			<span class="date">时间: ${article.addtime }</span> <span class="src"></span>
		</div>
		<div class="conts">
			${article.conts }
		</div>
	</body>
	
</html>