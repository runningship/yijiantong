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
MyInterceptor.getInstance().tableNameSuffix.set(tableSuffix);
CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "qrCode", qrCode);
request.setAttribute("pi" , item);
String host = ConfigCache.get("host", "houyikeji.com");
request.setAttribute("host" , host);
String url = "http://"+host+":8181/p/"+item.qrCode;

response.setContentType("text/html");
String realLogoPath = request.getServletContext().getRealPath("assets/img/yi.png");
String qrCodeDir = ConfigCache.get("qrcode_image_path", "C:\\inetpub\\wwwroot\\qrcode_image_path");
String destPath = qrCodeDir+"\\"+item.productId+"\\"+item.batchId+"\\"+item.qrCode+".png";
QRCodeUtil qrUtil = new QRCodeUtil();
qrUtil.QRCODE_SIZE=150;
qrUtil.HEIGHT = 25;
qrUtil.WIDTH = 25;
qrUtil.encode(url, realLogoPath , destPath , true);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>生成二维码</title>
</head>
<body>

<img src="http://${host }/qrcode_image_path/${pi.productId}/${pi.batchId}/${pi.qrCode}.png"/>
</body>
</html>