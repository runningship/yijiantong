<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String productId = request.getParameter("productId");
	request.setAttribute("productId", productId);
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
				    url: '/c/product/listBatch',
				    data: {productId: ${productId}},
				    dataType:'json',
				    mysuccess: function(json){
				        buildHtmlWithJsonArray("repeat",json.page.data);
				        Page.setPageInfo(json.page);
				    }
				  });
			}
			
			function addBatch(){
				 layer.open({
			            type: 2,
			            title: '增加批次',
			            shadeClose: true,
			            shade: false,
			            maxmin: true, //开启最大化最小化按钮
			            area: ['400px', '460px'],
			            content: 'addBatch.jsp?productId=${productId}'
			        });
			}
			
			function openItems(batchId){
				 layer.open({
			            type: 2,
			            title: '二维码信息',
			            shadeClose: true,
			            shade: false,
			            maxmin: true, //开启最大化最小化按钮
			            area: ['400px', '460px'],
			            content: 'itemList.jsp?productId=${productId}&batchId='+batchId
			        });
			}
		</script>
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
					<!-- Page Header -->
					<!-- End Page Header -->
					<div class="row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="panel panel-default bk-bg-white" style="height:100%;">
								<div class="panel-body">
									<div class="row">
											<div class="col-sm-12 col-md-6">
												<button type="button" class="bk-margin-5 btn btn-primary btn-sm"  onclick="addBatch()">添加</button>
											</div>
									</div>
									<table class="table table-bordered table-striped mb-none" id="datatable-editable">
										<thead>
											<tr>
												<th>编号</th>
												<th>数量</th>
												<th>奖券</th>
												<th>描述</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody>
											<tr class="gradeA repeat" style="display:none;">
												<td>$[no]</td>
												<td>$[count]</td>
												<td>$[lottery]</td>
												<td>$[conts]</td>
												<td><a href="#" onclick="openItems($[id]);">二维码</a> <a href="#" onclick="openPici();">编辑</a></td>
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
		
		
		<!-- start: JavaScript-->
		
		<!-- Pages JS -->
		<!-- end: JavaScript-->
		
	</body>
	
</html>