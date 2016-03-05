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
//String url = "http://houyikeji.com/demo.html";
String url = "http://houyikeji.com/comp.html";
//String url = "http://hy.tunnel.qydev.com/ewm/demo.html/";

response.setContentType("text/html");
String realLogoPath = request.getServletContext().getRealPath("assets/img/yi.png");
QRCodeUtil qrUtil = new QRCodeUtil();
qrUtil.QRCODE_SIZE=210;
qrUtil.LOGO_HEIGHT = 42;
qrUtil.LOGO_WIDTH = 42;
qrUtil.encode(url, realLogoPath , "C:\\inetpub\\wwwroot\\qrcode_image_path\\demo2.png" , true);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>生成二维码</title>
</head>
<body>

<img src="http://127.0.0.1/qrcode_image_path/demo2.png"/ >
</body>
</html>