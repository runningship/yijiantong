<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.util.List"%>
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
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!public boolean doGenerate(HttpServletRequest request , ProductBatch batch , String qrCode){
	String tableSuffix = qrCode.split("\\.")[1];
	MyInterceptor.getInstance().tableNameSuffix.set(tableSuffix);
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "qrCode", qrCode);
	String appHost = ConfigCache.get("app_host", "h1y6.com");
	String url = "http://"+appHost+"/p/"+item.qrCode;
	request.setAttribute("url" , url);
	String realLogoPath = request.getServletContext().getRealPath("assets/img/yi.png");
	String qrCodeDir = ConfigCache.get("qrcode_image_path", "C:\\inetpub\\wwwroot\\qrcode_image_path");
	String destPath = qrCodeDir+"\\"+item.productId+"\\"+item.batchId+"\\"+item.id+"-DJ-"+item.qrCode+".png";
	String verifyDestPath = qrCodeDir+"\\"+item.productId+"\\"+item.batchId+"\\"+item.id+"-JY-"+item.verifyCode+".png";
	QRCodeUtil qrUtil = new QRCodeUtil();
	if(batch.qrCodeWidth!=null){
		qrUtil.QRCODE_SIZE=batch.qrCodeWidth;
		qrUtil.LOGO_HEIGHT = (int)(batch.qrCodeWidth*0.21);
		qrUtil.LOGO_WIDTH = (int)(batch.qrCodeWidth*0.21);
	}else{
		qrUtil.QRCODE_SIZE=60;
		qrUtil.LOGO_HEIGHT = 13;
		qrUtil.LOGO_WIDTH = 13;	
	}
	qrUtil.scal = 5f;
	try{
		qrUtil.encode(url, realLogoPath , destPath , true);
		qrUtil.encode(url, realLogoPath , verifyDestPath , true);
	}catch(Exception ex){
		ex.printStackTrace();
		return false;
	}
	return true;
}%>
<%
String batchId = request.getParameter("batchId");
if(StringUtils.isEmpty(batchId)){
	out.println("缺少批次信息");
	return;
}
CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
ProductBatch batch = dao.get(ProductBatch.class, Integer.valueOf(batchId));
if(batch==null){
	out.println("缺少批次信息");
	return;
}
String qrCodeDir = ConfigCache.get("qrcode_image_path", "C:\\inetpub\\wwwroot\\qrcode_image_path");
String destPath = qrCodeDir+"\\"+batch.productId+"\\"+batch.id;
FileUtils.deleteDirectory(new File(destPath));
MyInterceptor.getInstance().tableNameSuffix.set(batch.tableOffset);
StringBuilder sql = new StringBuilder("from ProductItem where productId=? and batchId=? ");
List<ProductItem> items = dao.listByParams(ProductItem.class, sql.toString(), batch.productId , batch.id);
for(ProductItem item : items){
	doGenerate(request ,batch ,  item.qrCode);
}

String imageHost = ConfigCache.get("image_host", "houyikeji.com");
request.setAttribute("image_host" , imageHost);
request.setAttribute("items", items);
request.setAttribute("batchId", batchId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>打包下载二维码</title>
</head>
<body>
<a href="packAndDownload.jsp?batchId=${batchId }">打包下载</a>
<c:forEach items="${items }" var="pi">
	<img src="http://${image_host }/qrcode_image_path/${pi.productId}/${pi.batchId}/${pi.id}-DJ-${pi.qrCode}.png"/>
	<img src="http://${image_host }/qrcode_image_path/${pi.productId}/${pi.batchId}/${pi.id}-JY-${pi.verifyCode }.png"/>
</c:forEach>
</body>
</html>