<%@page import="java.util.Date"%>
<%@page import="com.houyi.management.util.ZipUtils"%>
<%@page import="java.util.zip.ZipOutputStream"%>
<%@page import="java.text.SimpleDateFormat"%>
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
 <%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
File dir = new File(destPath);
File[] files = dir.listFiles();
if(files==null || files.length<batch.count){
	out.println("请先生成二维码图片");
	return;
}
response.resetBuffer();
response.setContentType("application/x-download");
response.setHeader("Content-disposition","attachment;filename=pici"+batch.no+".zip");
ZipOutputStream zos = new ZipOutputStream(response.getOutputStream());  

ZipUtils zipUtil = new ZipUtils();  
zipUtil.zipFile(files,"", zos);
zos.flush();
zos.close();
%>
