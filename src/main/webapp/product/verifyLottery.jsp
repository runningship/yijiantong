<%@page import="com.houyi.management.biz.entity.LotteryVerify"%>
<%@page import="com.houyi.management.user.entity.User"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Date"%>
<%@page import="com.houyi.management.biz.entity.ScanRecord"%>
<%@page import="com.houyi.management.biz.ScanService"%>
<%@page import="org.bc.sdak.utils.LogUtil"%>
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
String agent = request.getHeader("User-Agent");
if(agent.contains("MicroMessenger")){
	request.setAttribute("weixin", true);
}
LogUtil.info("agent="+agent);
ScanService scanService = new ScanService();
String client = request.getHeader("client");
String scanType = request.getHeader("type");
request.setAttribute("scanType", scanType);
String uidStr = request.getHeader("uid");
String device = request.getHeader("device");
String tel = request.getHeader("tel");
request.setCharacterEncoding("utf8");
String address = request.getHeader("address");
if(StringUtils.isNotEmpty(address)){
	address = URLDecoder.decode(address, "utf8");	
}
request.setAttribute("address", address);
LogUtil.info("address="+address);
request.setAttribute("client", client);
LogUtil.info("client="+client);
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
ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "verifyCode", qrCode);
if(item==null){
	//404
	out.println("没有找到商品信息");
	return;
}

try{
	ScanRecord record = new ScanRecord();
	record.productId = item.productId;
	record.addtime = new Date();
	record.type = Integer.valueOf(scanType);
	record.qrCode = qrCode;
	record.device = device;
	if(StringUtils.isNotEmpty(uidStr)){
		record.uid = Integer.valueOf(uidStr);
		User user = dao.get(User.class, Integer.valueOf(uidStr));
		request.setAttribute("tel", user.tel);
		request.setAttribute("uid", uidStr);
	}
	if(StringUtils.isNotEmpty(record.device) || record.uid!=null){
		ScanRecord po = dao.getUniqueByParams(ScanRecord.class, new String[]{"device" , "productId" , "type"}, new Object[]{record.device , record.productId , record.type});
		if(po==null){
			dao.saveOrUpdate(record);
		}	
	}
}catch(Exception ex){
	LogUtil.info("添加扫描记录失败,qrCode="+qrCode);
}
request.setAttribute("item", item);
ProductBatch batch = dao.get(ProductBatch.class, item.batchId);
request.setAttribute("batch", batch);
Product product = dao.get(Product.class, item.productId);
request.setAttribute("product", product);
request.setAttribute("verifyCode", qrCode);

LotteryVerify lv = dao.getUniqueByKeyValue(LotteryVerify.class, "verifyCode", qrCode);
if(lv!=null){
	request.setAttribute("lv", lv);
}
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

.yiduijiang{
/* background:url('../assets/img/bj.png') ;   height: 110pt;  */
position:relative;      background-repeat: no-repeat;background-size: 100%;border-radius: 4pt;    margin-bottom: 10pt;    margin-left: 0.5%; }
.yiduijiang .info{margin-left:auto;margin-right:auto;}
.yiduijiang .tips{ color: #c60000;    height: 23pt;    line-height: 23pt;    font-size: 18pt; text-align:center;   font-weight: bold;    padding-top: 46pt;}

 .field{    border: 1px solid #D09D98;    margin-bottom: 10pt;}
.field p{margin:1pt;  font-size: 11pt;}
.field .value{color:#7f7f7f;}
.field .odd{background:#f2f2f2;width:73%; display: inline-block;padding: 5pt 0pt;margin-left:3pt;}
.field .even{width:73%; display: inline-block;padding: 5pt 0pt;margin-left:3pt;}
.field .key{width: 23%;    display: inline-block;    color: #7f7f7f;    font-weight: bold;    background: #ebebeb;    padding: 5pt 0pt;padding-left:1.5%;   }
.tel{ line-height: 30pt;    width: 98%;    border-radius: 2pt;    border: 1px solid #ddd;    font-size: 12pt; font-weight:bold;height: 30pt;}
.btn-ok{    height: 30pt;    background: #D94D3E;    line-height: 30pt;    width: 98%;    display: inline-block;    margin-top: 5pt;    border-radius: 4pt;    color: white;    font-weight: bold;    margin-bottom: 10pt;}
</style>
<script src="/assets/vendor/js/jquery-2.1.1.min.js"></script>
<script src="/assets/js/houyi/buildHtml.js"></script>
<script src="/assets/js/layer/layer.js"></script>
<script type="text/javascript">
$(function(){
	if(window.navigator.appVersion.indexOf('SM-G9198')>-1){
		$('.title').css('height','42pt');
		$('.btn-ok').css('height','40pt');
		$('.tel').css('height','40pt');
		$('.lottery_value').css('font-size','60pt');
		$('.duijiang .jingxi').css('margin-top','8pt');
	}
	
	//微信和快易扫可以兑奖
});

function jiaoyan(){
	
	var tel = '${tel}';
	//var tel='15856985558';
	if(!tel){
		alert('请先登录');
		return;
	}
	YW.ajax({
	    type: 'POST',
	    url: '/c/admin/lottery/addVerify',
	    data:{tel : tel , batchNo: '${batch.no}', verifyCode: '${verifyCode}' , uid: '${uid}' , activeAddr: '${address}' , productId: ${product.id} , qrCode:'${item.qrCode}'},
	    mysuccess: function(data){
	    	layer.msg('提交验证成功');
	    	setTimeout(function(){
	    		window.location.reload();
	    	}, 1000);
	    }
    });
}
</script>
</head>

<body class="product">
	<div class="bodyer">
		<div class="title"  id="title">${product.title }</div>
		<div class="field">
			<p><span class="key">生产商</span> <span class="value odd"  style="margin-left: 0;">${product.vender }</span></p>
			<p><span class="key">产地信息</span><span class="value even " >${product.verderPlace }</span></p>
			<p><span class="key">规格信息</span><span class="value odd "  >${product.spec }</span></p>
			<p><span class="key">批 次 号</span><span class="value even ">${batch.no }</span></p>
		</div>
		<div class="yiduijiang">
<%-- 			<div class="tips">校验码 : ${item.verifyCode }</div> --%>
			<c:if test="${lv ne null && lv.status==0 }">
				<div style="text-align:center;">
					<div >审核中</div>
				</div>
			</c:if>
			<c:if test="${item.lotteryActive ==1}">
				<div style="text-align:center;">
					<div >已兑奖</div>
				</div>
			</c:if>
			<c:if test="${lv ne null && lv.status==2 }">
				<div style="text-align:center;">
					<div >无效码</div>
				</div>
			</c:if>
		</div>
		<c:if test="${lv eq null && item.lotteryActive==0}">
			<div id="btn-area" style="text-align:center;">
				<div class="btn-ok" onclick="jiaoyan();">提交校验</div>
			</div>
		</c:if>
		
</div>
</body></html>