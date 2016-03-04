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
window.onload=function(){
	//document.getElementById('qrCode').innerText=qrCode;
	//document.getElementById('lottery').innerText=lottery+'元';
}
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
				<div class="title"  id="title">金种子酒</div>
				<p>安徽金种子集团有限公司始建于1949年，是全国重点骨干酿酒企业，金种子股票于1998年在上交所上市，现年创利税13亿元，员工5000人。近年来，先后荣获“全国绿色食品示范企业”、“中国上市公司资本品牌溢价百强”和“全国十佳新锐上市公司”、全国轻工系统工业化、信息化“两化融合示范企业”等100多项荣誉称号。</p>
				<p>金种子酒业地处黄淮名酒带，这里自古就是名酒之乡，金种子酿酒古窖池被批准为安徽省文物保护单位，“金种子”牌、“种子”牌、“醉三秋”牌、“颍州”牌系列白酒荣获国家地理标志保护产品， “金种子”、“醉三秋”两个品牌荣获“中国驰名商标”，颍州佳酿被国家商务部授予“中华老字号”。金种子坚持聚集资源做强主业白酒，努力打造中国大众名酒实力品牌，“金种子”连续四次上榜“中国最具价值品牌500强”，“金种子”品牌价值高达105.33亿元。公司经营业绩自2005年以来连续七年保持高速增长，2009、2010年，金种子酒股票市价值连续两年涨幅位居全国食品饮料行业第一。</p>
			</div>
		</div>
</div>
</body></html>