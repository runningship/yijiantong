<%@page import="com.houyi.management.product.entity.Goods"%>
<%@page import="com.houyi.management.product.entity.Product"%>
<%@page import="org.bc.sdak.TransactionalServiceHelper"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String id =request.getParameter("id");
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	Goods po = dao.get(Goods.class, Integer.valueOf(id));
	request.setAttribute("product", po);
%>
<!DOCTYPE html>
<html lang="en">

	<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<script type="text/javascript">
	
	</script>
	<style type="text/css">
		body{margin:0px;}
		.title{font-size: 14pt;    color: #666;    font-weight: bold;    margin: 8pt 0; text-align:center;}
		.desc{text-align:center;}
		.desc .date{font-size: 10pt;    color: #888;}
		.conts img{width:100% !important; height: 100%;}
	</style>
	</head>
	
	<body>
		<div class="title">${goods.title }</div>
		<div class="desc">
			<span class="date">时间: <fmt:formatDate value="${goods.addtime }" pattern="yyyy-MM-dd HH:mm"/></span> <span class="src"></span>
		</div>
		<div class="conts">
			${goods.conts }
		</div>
	</body>
	
</html>