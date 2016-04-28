<%@page import="com.houyi.management.product.entity.ProductBatch"%>
<%@page import="com.houyi.management.MyInterceptor"%>
<%@page import="com.houyi.management.product.entity.Product"%>
<%@page import="com.houyi.management.product.entity.ProductItem"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
String id = request.getParameter("productId");
Product product = dao.get(Product.class, Integer.valueOf(id));
request.setAttribute("product", product);
String client = request.getParameter("client");
request.setAttribute("client", client);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="maximum-scale=1.0,minimum-scale=1.0,user-scalable=0,width=device-width,initial-scale=1.0"/>
<title>兑奖成功</title>
<style type="text/css">
body{font-family: 微软雅黑; margin:1pt;}
.title{text-align:center;    font-size: 17pt;    font-weight: bold;    height: 32pt;    line-height: 32pt;    background: #D94D3E;    color: white;}
.duijiang{background:url('../assets/img/bj.png') ;     height: 140pt;     background-repeat: no-repeat;background-size: 100%;border-radius: 4pt;    margin-bottom: 10pt;    margin-left: 0.5%;    width: 99%;}
.lottery_value{font-size: 43pt;   color: #BB0222;    font-weight: bold;    font-family: -webkit-pictograph;text-align:center;    height: 102pt; line-height:126pt;}
.duijiang .unit{font-size:30pt;}
.duijiang .tips{    text-align: center;    color: #C95D5D;height: 23pt;    line-height: 23pt; font-size:11pt;}
.duijiang .jingxi{    text-align: center; color: #BB0322;    font-weight: bold;position:relative;    font-size: 13pt;}
.duijiang .download{    position: absolute;    margin-left: 3%;    color: white;    padding: 4pt 5pt;    background: #D94D3E;    font-size: 10pt;    border-radius: 3pt;    bottom: 0pt;}
.content p{    text-indent: 25pt;color:gray;}
</style>
<script type="text/javascript">
$(function(){
	if(window.navigator.appVersion.indexOf('SM-G9198')>-1){
		$('.lottery_value').css('font-size','20pt');
	}
});
</script>
</head>

<body class="product">
	<div class="bodyer">
		<div>
			<div class="duijiang">
				<div class="lottery_value">兑奖成功</div>
				<c:if test="${client ne 'kuaiyisao' }">
					<div class="jingxi"><span>下载快易扫更多惊喜</span><span class="download">下载APP</span></div>
				</c:if>
				<c:if test="${client eq 'kuaiyisao' }">
					<div class="jingxi"><span>天天快易扫，天天有红包</span></div>
				</c:if>
			</div>
			<div class="content">
				${product.conts }
			</div>
		</div>
</div>
</body></html>