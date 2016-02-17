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
String qrCode = request.getParameter("qrCode");
if(StringUtils.isEmpty(qrCode)){
	qrCode = (String)request.getAttribute("qrCode");
}
if(StringUtils.isEmpty(qrCode)){
	qrCode = (String)request.getAttribute("qrCode");
	out.println("没有找到商品信息");
	return;
}
String tableSuffix = qrCode.split("\\.")[1];
MyInterceptor.getInstance().tableNameSuffix.set(tableSuffix);
ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "qrCode", qrCode);
if(item==null){
	//404
	out.println("没有找到商品信息");
	return;
}
request.setAttribute("item", item);
ProductBatch batch = dao.get(ProductBatch.class, item.batchId);
request.setAttribute("batch", batch);
Product product = dao.get(Product.class, item.productId);
request.setAttribute("product", product);
request.setAttribute("qrCode", qrCode);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="maximum-scale=1.0,minimum-scale=1.0,user-scalable=0,width=device-width,initial-scale=1.0"/>
<title>产品信息</title>
<style type="text/css">
body{font-family: 微软雅黑; margin:1pt;}
.title{text-align:center;    font-size: 17pt;    font-weight: bold;    height: 32pt;    line-height: 32pt;    background: #D94D3E;    color: white;}
.duijiang{background:url('../assets/img/bj.png') ;     height: 140pt;     background-repeat: no-repeat;background-size: 100%;border-radius: 4pt;    margin-bottom: 10pt;    margin-left: 0.5%;    width: 99%;}
.lottery_value{font-size: 83pt;   color: #D94D3E;    font-weight: bold;    font-family: -webkit-pictograph;text-align:center;    height: 82pt;}
.duijiang .unit{font-size:30pt;}
.duijiang .tips{    text-align: center;    color: #C95D5D;height: 23pt;    line-height: 23pt; font-size:11pt;}
.duijiang .jingxi{    text-align: center; color: #BB0322;    font-weight: bold;position:relative;    font-size: 13pt;}
.duijiang .download{    position: absolute;    margin-left: 3%;    color: white;    padding: 4pt 5pt;    background: #D94D3E;    font-size: 10pt;    border-radius: 3pt;    bottom: 0pt;}
 .field{    border: 1px solid #D09D98;    margin-bottom: 10pt;}
.field p{margin:1pt;  font-size: 11pt;}
.field .value{color:#7f7f7f;}
.field .odd{background:#f2f2f2;width:73%; display: inline-block;padding: 5pt 0pt;margin-left:1%}
.field .even{width:73%; display: inline-block;padding: 5pt 0pt;margin-left:1%}
.field .key{width: 23%;    display: inline-block;    color: #7f7f7f;    font-weight: bold;    background: #ebebeb;    padding: 5pt 0pt;padding-left:1.5%;   }
.tel{ line-height: 30pt;    width: 98%;    border-radius: 2pt;    border: 1px solid #ddd;    font-size: 12pt; font-weight:bold;height: 30pt;}
.btn-ok{    height: 30pt;    background: #D94D3E;    line-height: 30pt;    width: 98%;    display: inline-block;    margin-top: 5pt;    border-radius: 4pt;    color: white;    font-weight: bold;    margin-bottom: 10pt;}
</style>
<script src="/assets/vendor/js/jquery-2.1.1.min.js"></script>
<script src="/assets/js/houyi/buildHtml.js"></script>
<script src="/assets/js/layer/layer.js"></script>

<script type="text/javascript">
window.onload=function(){
	//document.getElementById('qrCode').innerText=qrCode;
	//document.getElementById('lottery').innerText=lottery+'元';
}

function duijiang(){
	var tel = $('.tel').val();
	if(!isMobile(tel)){
		return ;
	}
	YW.ajax({
	    type: 'POST',
	    url: '/c/admin/lottery/add',
	    data:{qrCode : '${qrCode}' , tel : tel , verifyCode:'3123'},
	    mysuccess: function(data){
	    	layer.msg('兑奖成功');
	    }
    });
}
</script>
</head>

<body class="product">
	<div class="bodyer">
		<div class="title"  id="title">厚易演示酒</div>
		<div class="field">
			<p><span class="key">生产商</span> <span class="value odd"  style="margin-left: 0;">安徽厚易酒业股份有限公司</span></p>
			<p><span class="key">产地信息</span><span class="value even " >安徽省合肥市蜀山区</span></p>
			<p><span class="key">规格信息</span><span class="value odd "  >460ml 40.8%Vol</span></p>
			<p><span class="key">批 次 号</span><span class="value even ">${batch.no }</span></p>
<!-- 			<p><span class="key">经销商</span><span class="value odd " >厚易黄山路总店</span></p> -->
<%-- 			<p style="word-break: break-all;"><span class="key">产品编号</span><span class="value even " >${item.qrCode }</span></p> --%>
		</div>
		<div>
			<div class="duijiang">
				<div class="lottery_value">10<span class="unit">元</span></div>
				<div class="tips">(手机费或流量包)</div>
				<div class="jingxi"><span>下载快易扫更多惊喜</span><span class="download">下载APP</span></div>
			</div>
			<div style="text-align:center;">
				<input class="tel"   placeholder="请输入你的手机号码" value="${tel }"/>
				<div class="btn-ok" onclick="duijiang();">立即领取</div>
			</div>
		</div>
</div>
</body></html>