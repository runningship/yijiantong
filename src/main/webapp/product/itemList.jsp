<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
				    url: '/c/article/listItem',
				    data: a,
				    dataType:'json',
				    mysuccess: function(json){
				        buildHtmlWithJsonArray("repeat",json.page.data);
				        Page.setPageInfo(json.page);
				    }
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
				<div class="main sidebar-minified">			
					<div class="row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="panel panel-default bk-bg-white">
								<div class="panel-body">
									<div class="row">
											<form name="form1" onsubmit="doSearch();return false;">
											<div class="col-sm-6 col-md-6">
												<div id="datatable-default_filter" class="dataTables_filter">
													<input type="search" name="title" class="form-control" placeholder="二维码编号" aria-controls="datatable-default">
													<button type="button" class="bk-margin-5 btn btn-primary btn-sm"  onclick="">导出二维码</button>
													<label></label>
												</div>
											</div>
											</form>
									</div>
									<table class="table table-bordered table-striped mb-none" id="datatable-editable">
										<thead>
											<tr>
												<th><a href="#">导出选中</a></th>
												<th>标题</th>
												<th>阅读</th>
												<th>发布时间</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody>
											<tr class="gradeA repeat" style="display:none;">
												<td><input type="checkbox" /></td>
												<td>$[title]</td>
												<td>$[readCount]</td>
												<td>$[addtime]</td>
												<td><a href="#" onclick="openPici();">查看二维码</a></td>
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