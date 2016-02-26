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
<%!

public boolean doGenerate(HttpServletRequest request , String qrCode){
	String tableSuffix = qrCode.split("\\.")[1];
	MyInterceptor.getInstance().tableNameSuffix.set(tableSuffix);
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "qrCode", qrCode);
	request.setAttribute("pi" , item);
	String imageHost = ConfigCache.get("image_host", "houyikeji.com");
	String appHost = ConfigCache.get("app_host", "h1y6.com");
	request.setAttribute("image_host" , imageHost);
	String url = "http://"+appHost+"/p/"+item.qrCode;
	request.setAttribute("url" , url);
	String realLogoPath = request.getServletContext().getRealPath("assets/img/yi.png");
	String qrCodeDir = ConfigCache.get("qrcode_image_path", "C:\\inetpub\\wwwroot\\qrcode_image_path");
	String destPath = qrCodeDir+"\\"+item.productId+"\\"+item.batchId+"\\"+item.qrCode+".png";
	QRCodeUtil qrUtil = new QRCodeUtil();
	qrUtil.QRCODE_SIZE=150;
	qrUtil.HEIGHT = 25;
	qrUtil.WIDTH = 25;
	try{
		qrUtil.encode(url, realLogoPath , destPath , true);
	}catch(Exception ex){
		ex.printStackTrace();
		return false;
	}
	return true;
}

%>
