package com.houyi.management.product;

import java.util.Date;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;
import org.bc.web.WebMethod;

import com.houyi.management.MyInterceptor;
import com.houyi.management.cache.ConfigCache;
import com.houyi.management.product.entity.Product;
import com.houyi.management.product.entity.ProductItem;
import com.houyi.management.util.QRCodeUtil;


@Module(name="/qr")
public class QRCodeService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	
	@WebMethod
	public ModelAndView generateImg(String qrCode){
		ModelAndView mv = new ModelAndView();
		String tableSuffix = qrCode.split("\\.")[1];
		MyInterceptor.getInstance().tableNameSuffix.set(tableSuffix);
		String appHost = ConfigCache.get("app_host", "h1y6.com");
		String url = "https://"+appHost+"/p/"+qrCode;
		String realLogoPath = ThreadSession.getHttpSession().getServletContext().getRealPath("assets/img/yi.png");
		
		ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "qrCode", qrCode);
		String qrCodeDir = ConfigCache.get("qrcode_image_path", "C:\\inetpub\\wwwroot\\qrcode_image_path");
		String destPath = qrCodeDir+"\\"+item.productId+"\\"+item.batchId+"\\"+item.qrCode+".png";
		QRCodeUtil qrUtil = new QRCodeUtil();
		qrUtil.QRCODE_SIZE=150;
		qrUtil.LOGO_HEIGHT = 25;
		qrUtil.LOGO_WIDTH = 25;
		try {
			qrUtil.encode(url, realLogoPath , destPath , true);
		} catch (Exception ex) {
			throw new GException(PlatformExceptionType.BusinessException,"生成二维码图片失败 ，请联系系统管理员" , ex);
		}
		mv.data.put("status", "success");
		return mv;
	}

	
	@WebMethod
	public ModelAndView packAndDownload(Integer batchId){
		ModelAndView mv = new ModelAndView();
		return mv;
	}
}
