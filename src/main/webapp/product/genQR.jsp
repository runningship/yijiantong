<%@page import="com.houyi.management.product.entity.ProductBatch"%>
<%@page import="com.houyi.management.MyInterceptor"%>
<%@page import="com.houyi.management.product.entity.ProductItem"%>
<%@page import="com.houyi.management.cache.ConfigCache"%>
<%@page import="com.houyi.management.util.QRCodeUtil"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="com.google.zxing.EncodeHintType"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.File"%>
<%@page import="net.glxn.qrgen.core.image.ImageType"%>
<%@page import="net.glxn.qrgen.javase.QRCode"%>
<%@page import="javax.imageio.ImageIO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String qrCode = request.getParameter("code");
String tableSuffix = qrCode.split("\\.")[1];
MyInterceptor.getInstance().tableNameSuffix.set(tableSuffix);//访问ProductItem表的后缀
CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "qrCode", qrCode);
request.setAttribute("pi" , item);
String imageHost = ConfigCache.get("image_host", "houyikeji.com");
String appHost = ConfigCache.get("app_host", "h1y6.com");
request.setAttribute("image_host" , imageHost);
//String url = "http://"+appHost+"/p/"+item.qrCode;
//String verifyUrl = "http://"+appHost+"/p/"+item.verifyCode;
String url = item.qrCode;
String verifyUrl = item.verifyCode;
request.setAttribute("url" , url);
request.setAttribute("verifyUrl" , verifyUrl);

response.setContentType("text/html");
//二维码logo图片地址 
String realLogoPath = request.getServletContext().getRealPath("assets/img/yi.png");
//获取二维码生成目录地址
String qrCodeDir = ConfigCache.get("qrcode_image_path", "C:\\inetpub\\wwwroot\\qrcode_image_path");
//二维码文件名
String destPath = qrCodeDir+"\\"+item.productId+"\\"+item.batchId+"\\"+item.id+"duijiang.png";
//校验码文件名
String verifyDestPath = qrCodeDir+"\\"+item.productId+"\\"+item.batchId+"\\"+item.id+"jiaoyan.png";
//获取产品批次信息
ProductBatch batch = dao.get(ProductBatch.class, Integer.valueOf(item.batchId));

QRCodeUtil qrUtil = new QRCodeUtil();
if(batch.qrCodeWidth!=null){
	qrUtil.QRCODE_SIZE= batch.qrCodeWidth;
	qrUtil.LOGO_HEIGHT = (int)(batch.qrCodeWidth*0.26);
	qrUtil.LOGO_WIDTH = (int)(batch.qrCodeWidth*0.26);
}else{
	qrUtil.QRCODE_SIZE=60;
	qrUtil.LOGO_HEIGHT = 13;
	qrUtil.LOGO_WIDTH = 13;	
}

//qrUtil.QRCODE_SIZE= (int)(qrUtil.QRCODE_SIZE*1.5);
//qrUtil.LOGO_HEIGHT= (int)(qrUtil.LOGO_HEIGHT*1.5);
//qrUtil.LOGO_WIDTH= (int)(qrUtil.LOGO_WIDTH*1.5);
qrUtil.scal = 5f;
qrUtil.encode(url, realLogoPath , destPath , true);
qrUtil.encode(verifyUrl , realLogoPath , verifyDestPath , true);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>生成二维码</title>
</head>
<body>
兑奖码
<img src="http://${image_host }/qrcode_image_path/${pi.productId}/${pi.batchId}/${pi.id}duijiang.png"/>
${url}
<br/><br/><br/><br/><br/>
校验码
<img src="http://${image_host }/qrcode_image_path/${pi.productId}/${pi.batchId}/${pi.id}jiaoyan.png"/>
${verifyUrl }
</body>
</html>