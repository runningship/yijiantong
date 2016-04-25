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
String width = request.getParameter("width");
request.setAttribute("width", width);
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
//String tel = request.getHeader("tel");
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
ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "qrCode", qrCode);
if(item==null){
	//404
	out.println("没有找到商品信息");
	return;
}
ProductBatch batch = dao.get(ProductBatch.class, item.batchId);
if(batch.openForLottery!=Integer.valueOf(1)){
	out.println("<div style='font-size:25px;text-align:center;'>安徽厚易科技公司未开放该二维码兑奖功能<div>");
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
	}else{
		LogUtil.info("信息不全，无法添加扫描记录");
	}
}catch(Exception ex){
	ex.printStackTrace();
	LogUtil.info("添加扫描记录失败,qrCode="+qrCode);
}
request.setAttribute("item", item);

request.setAttribute("batch", batch);
Product product = dao.get(Product.class, item.productId);
request.setAttribute("product", product);
request.setAttribute("qrCode", qrCode);

//request.setAttribute("client", "kuaiyisao");
//request.setAttribute("tel", "15856985122");
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
.lottery_value{font-size: 83pt;   color: #D94D3E;    font-weight: bold;    text-align:center;    height: 82pt;}
.duijiang .unit{font-size:30pt;}
.duijiang .tips{    text-align: center;    color: #C95D5D;height: 23pt;    line-height: 23pt; font-size:11pt;}
.duijiang .jingxi{    text-align: center; color: #BB0322;    font-weight: bold;position:relative;    font-size: 13pt;}
.duijiang .download{    position: absolute;    margin-left: 3%;    color: white;    padding: 4pt 5pt;    background: #D94D3E;    font-size: 10pt;    border-radius: 3pt;    bottom: 0pt;}

.yiduijiang{background:url('../assets/img/bj.png') ;  position:relative;   height: 110pt;     background-repeat: no-repeat;background-size: 100%;border-radius: 4pt;    margin-bottom: 10pt;    margin-left: 0.5%;    width: 99%;}
.yiduijiang .info{margin-left:auto;margin-right:auto;}
.yiduijiang .wrap{position: absolute;    left: 30%;}
.yiduijiang .warn{position: absolute;   width: 45pt ; top:37pt; right:72%;}
.yiduijiang .tips{ color: #c60000;    height: 23pt;    line-height: 23pt;    font-size: 15pt;    font-weight: bold;    padding-top: 32pt;}
.yiduijiang .activeTime{color:#c60000}
.yiduijiang .activeAddr{color:#c60000 ; margin-top:3pt;}
.yiduijiang .addrLabel{float:left;}
.yiduijiang .addrConts{    width: 69%;    display: inline}
.yiduijiang .jingxi{ margin-top:5pt;   text-align: center; color: #BB0322;    font-weight: bold;position:relative;    font-size: 13pt;}
.yiduijiang .download{    position: absolute;    margin-left: 3%;    color: white;    padding: 4pt 5pt;    background: #D94D3E;    font-size: 10pt;    border-radius: 3pt;    bottom: 0pt;}

 .field{    border: 1px solid #D09D98;    margin-bottom: 10pt;}
.field p{margin:1pt;  font-size: 11pt;}
.field .value{color:#7f7f7f;}
.field .odd{background:#f2f2f2;width:73%; display: inline-block;padding: 5pt 0pt;margin-left:3pt;}
.field .even{width:73%; display: inline-block;padding: 5pt 0pt;margin-left:3pt;}
.field .key{width: 23%;    display: inline-block;    color: #7f7f7f;    font-weight: bold;    background: #ebebeb;    padding: 5pt 0pt;padding-left:1.5%;   }
.tel{ line-height: 30pt;    width: 98%;    border-radius: 2pt;    border: 1px solid #ddd;    font-size: 12pt; font-weight:bold;height: 30pt;}
.btn-ok{    height: 30pt;    background: #D94D3E;    line-height: 30pt;    width: 98%;    display: inline-block;    margin-top: 5pt;    border-radius: 4pt;    color: white;    font-weight: bold;    margin-bottom: 10pt;}
.yzm{    width: 200px;    float: left;    margin-left: 0.5%;margin-top:3pt;}
.getYzm{    float: right;    height: 33pt;    margin-right: 2pt; margin-top:3pt;border: none;    color: white;    background: purple;    width: 70pt;}
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

function duijiang(){
	var tel = $('.tel').val();
	if(!isMobile(tel)){
		return ;
	}
	var smsCode = $('#smsCode').val();
	YW.ajax({
	    type: 'POST',
	    url: '/c/admin/lottery/add',
	    data:{qrCode : '${qrCode}' , tel : tel , smsCode: smsCode , activeAddr:'${address}' , uid : '${uid}'},
	    mysuccess: function(data){
	    	layer.msg('兑奖成功');
	    	setTimeout(function(){
	    		window.location="/success.jsp?productId=${product.id}&client=${client}";
	    	}, 1000);
	    }
    });
}

function sendSMSCode(tel){
	YW.ajax({
	    type: 'POST',
	    url: '/c/admin/user/sendVerifyCode',
	    data:{tel : tel},
	    mysuccess: function(data){
	    	layer.msg('验证码已发送');
	    }
    });
}
var timer=0;
function getYzm(){
	if(timer>0){
		return;
	}
	var tel = $('.tel').val();
	if(!isMobile(tel)){
		return ;
	}
	//send sms code
	sendSMSCode(tel);
	timer=60;
	tickDown();
}
function tickDown(){
	if(timer<=0){
		$('.getYzm').text('获取验证码');
		return;
	}
	$('.getYzm').text(timer+'( 秒 )');
	setTimeout(function(){
		timer--;
		tickDown();
	} , 1000);
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
<!-- 			<p><span class="key">经销商</span><span class="value odd " >厚易黄山路总店</span></p> -->
<%-- 			<p style="word-break: break-all;"><span class="key">产品编号</span><span class="value even " >${item.qrCode }</span></p> --%>
		</div>
		<c:if test="${item.lotteryActive eq 1}">
			<div>
				<div>
					<div class="yiduijiang">
						<img class="warn" alt="" src="../assets/img/warn.png">
						<div class="wrap">
							<div class="tips">该二维码已兑奖</div>
							<div class="info">
								<div class="activeTime"><span>兑奖时间: </span><span><fmt:formatDate value="${item.activeTime }" pattern="yyyy-MM-dd HH:mm"/></span></div>
								<div class="activeAddr"><span class="addrLabel">兑奖地点: </span><span class="addrConts">${item.activeAddr }</span></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${item.lotteryActive ne 1}">
			<div>
				<div class="duijiang">
					<div class="lottery_value">10<span class="unit">元</span></div>
					<div class="tips">(手机费或流量包)</div>
					<c:if test="${client ne 'kuaiyisao' }">
						<div class="jingxi"><span>下载快易扫更多惊喜</span><span onclick="window.location='../download.html'" class="download">下载APP</span></div>
					</c:if>
					<c:if test="${client eq 'kuaiyisao' }">
						<div class="jingxi"><span>天天快易扫，天天有红包</span></div>
					</c:if>
				</div>
				<c:if test="${(client eq 'kuaiyisao' || weixin) && (scanType eq '2') }">
					<div id="btn-area" style="text-align:center;">
						<c:if test="${not empty uid }">
							<input class="tel" readonly="readonly" placeholder="请输入你的手机号码" value="${tel }"/>
							<div class="btn-ok" onclick="duijiang();">立即领取</div>
						</c:if>
						<c:if test="${empty uid }">
							<input class="tel"  placeholder="请输入你的手机号码"  />
							<input id="smsCode" class="tel yzm"  placeholder="请输入短信验证码"  /><button class="getYzm" onclick="getYzm();">获取验证码</button>
							<div class="btn-ok" onclick="duijiang();">一键领取</div>
						</c:if>
					</div>
				</c:if>
			</div>
		</c:if>
</div>
</body></html>