package com.houyi.management;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.SimpDaoTool;

import com.google.zxing.common.GlobalHistogramBinarizer;
import com.houyi.management.product.entity.ProductItem;

public class RestServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		super.doPut(req, resp);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if(req.getPathInfo()==null){
			super.doGet(req, resp);
			return;
		}
		String data = req.getPathInfo().replace("/", "");
		req.setAttribute("qrCode", data);
		try{
			CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
			String tableSuffix = data.split("\\.")[1];
			MyInterceptor.getInstance().tableNameSuffix.set(tableSuffix);
			ProductItem item = dao.getUniqueByKeyValue(ProductItem.class, "qrCode", data);
			
			if(item==null){
				RequestDispatcher rd = req.getRequestDispatcher("/product/invalidCode.jsp");
				rd.forward(req, resp);
			}else{
				RequestDispatcher rd = req.getRequestDispatcher("/product/getLottery.jsp");
				rd.forward(req, resp);
			}
		}catch(Exception ex){
			RequestDispatcher rd = req.getRequestDispatcher("/product/invalidCode.jsp");
			rd.forward(req, resp);
		}
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(req, resp);
	}

	
}
