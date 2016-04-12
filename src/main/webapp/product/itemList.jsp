<%@page import="com.houyi.management.product.entity.ProductBatch"%>
<%@page import="org.bc.sdak.TransactionalServiceHelper"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String productId = request.getParameter("productId");
request.setAttribute("productId", productId);
String batchId = request.getParameter("batchId");
CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
ProductBatch batch = dao.get(ProductBatch.class, Integer.valueOf(batchId));
request.setAttribute("batch", batch);
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<jsp:include page="../header.jsp"></jsp:include>
		<script type="text/javascript">
			$(function(){
				Page.Init();
				doSearch();
			});
			
			function doSearch(){
				var a=$('form[name=form1]').serialize();
				YW.ajax({
				    type: 'get',
				    url: '/c/product/listItem?'+new Date().getTime(),
				    data: a,
				    dataType:'json',
				    mysuccess: function(json){
				        buildHtmlWithJsonArray("repeat",json.page.data);
				        Page.setPageInfo(json.page);
				    }
				  });
			}
			
			function getLotteryActiveText(status , qrCode){
				if(status==0){
					return "未兑奖";
				}else{
					return '<a onclick="getLotteryInfo(\''+qrCode+'\');" href="#" >已兑奖</a>';
				}
			}
			
			function getLotteryInfo(qrCode){
				var a=$('form[name=form1]').serialize();
				YW.ajax({
				    type: 'get',
				    url: '/c/product/getLotteryInfo?'+new Date().getTime(),
				    data:'qrCode='+qrCode,
				    dataType:'json',
				    mysuccess: function(json){
				    	$('#lotteryInfo .tel').text(json.activeTel);
				    	$('#lotteryInfo .addr').text(json.activeAddr);
				    	$('#lotteryInfo .time').text(json.activeTime);
				    	showLotterInfo();
				    }
				  });
			}
			
			function showLotterInfo(){
				layer.open({
					  type: 1,
					  shade: false,
					  title: false, //不显示标题
					  content: $('#lotteryInfo'), //捕获的元素
					  cancel: function(index){
					    layer.close(index);
					  }
					});
			}
			
			function goBack(){
				window.location='listBatch.jsp?productId='+'${productId}';
			}
		</script>
		
		<style type="text/css">
			#lotteryInfo div{height: 30px;    line-height: 30px;    font-size: 14px; }
			.search{    width: 200px;    display: inline-block;}
		</style>
	</head>
	
	<body>
	
		<!-- Start: Header -->
		<!-- End: Header -->
		
		<!-- Start: Content -->
		<div class="container-fluid content">	
			<div class="row">
			
				<!-- Sidebar -->
				<!-- End Sidebar -->
						
				<!-- Main Page -->
				<div class="sidebar-minified">			
					<div class="row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="panel panel-default bk-bg-white">
								<div class="panel-body">
									<div class="row">
											<form name="form1" onsubmit="doSearch();return false;">
											<input type="hidden" name="productId" value="${productId}"/>
											<input type="hidden" name="batchId" value="${batch.id}"/>
											<div class="col-sm-12col-md-6">
												<div id="datatable-default_filter" class="dataTables_filter">
													<a type="button" class="bk-margin-5 btn btn-primary btn-sm"  href="genBatchQR.jsp?batchId=${batch.id }"  target="_blank">生成所有二维码图片</a>
													<a type="button" class="bk-margin-5 btn btn-primary btn-sm"  href="packAndDownload.jsp?batchId=${batch.id }"  target="_blank">导出所有二维码</a>
													<button type="button" class="bk-margin-5 btn btn-primary btn-sm"  style="float:right;" onclick="goBack()">返回</button>
												</div>
												<div style="margin-bottom: 10px; margin-left: 15px;">
													兑奖码 <input type="search" name="qrCode" class="form-control search" placeholder="" aria-controls="datatable-default">
													校验码 <input type="search" name="verifyCode" class="form-control search" placeholder="" aria-controls="datatable-default">
													状态 <select class="form-control select search" name="lotteryActive">
															<option value="">所有</option>
															<option value="0">未兑奖</option>
															<option value="1">已兑奖</option>
														</select>
													<button type="button" class="bk-margin-5 btn btn-primary btn-sm" style="float:right;"  onclick="doSearch()">搜索</button>
												</div>
											</div>
											</form>
									</div>
									<table class="table table-bordered table-striped mb-none" id="datatable-editable">
										<thead>
											<tr>
<!-- 												<th><a href="#">导出选中</a></th> -->
												<th>兑奖码</th>
												<th>校验码</th>
												<th>奖券</th>
												<th>是否兑奖</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody>
											<tr class="gradeA repeat" style="display:none;">
<!-- 												<td><input type="checkbox" /></td> -->
												<td>$[qrCode]</td>
												<td>$[verifyCode]</td>
												<td>$[lottery]</td>
												<td runscript="true">getLotteryActiveText($[lotteryActive] , '$[qrCode]')</td>
												<td><a href="genQR.jsp?code=$[qrCode]"  target="_blank">查看</a></td>
											</tr>
										</tbody>
									</table>
									<label></label>
									<div>
											<div class="maxHW mainCont ymx_page foot_page_box"></div>
									</div>
							</div>
						</div>
					</div>					   
				</div>
				<!-- End Main Page -->	
		
			
			</div>
		</div>
		</div>
		<!--/container-->
		
		
		<div class="clearfix"></div>		
		
		<div id="lotteryInfo" style="width: 250px;background: lightblue; display:none;">
			<div>兑奖时间: <span class="time"></span></div>
			<div>兑奖地址: <span class="addr"></span></div>
			<div>兑奖号码: <span class="tel"></span></div>
		</div>
		
		<!-- start: JavaScript-->
		
		<!-- Pages JS -->
		<!-- end: JavaScript-->
	</body>
	
</html>