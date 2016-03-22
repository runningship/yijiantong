<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

	<head>
		<jsp:include page="../../header.jsp"></jsp:include>
		<script type="text/javascript">
			$(function(){
				Page.Init();
				doSearch();
			});
			
			function doSearch(){
				var a=$('form[name=form1]').serialize();
				YW.ajax({
				    type: 'get',
				    url: '/c/conf/list',
				    data: a,
				    dataType:'json',
				    mysuccess: function(json){
				        buildHtmlWithJsonArray("repeat",json.page.data);
				        Page.setPageInfo(json.page);
				    }
				  });
			}
			
			function openEdit(id){
				 layer.open({
			            type: 2,
			            title: '修改系统参数',
			            shadeClose: true,
			            shade: false,
			            maxmin: true, //开启最大化最小化按钮
			            area: ['400px', '300px'],
			            content: 'edit.jsp?id='+id
			        });
			}
			
			function initDefault(){
				YW.ajax({
				    type: 'get',
				    url: '/c/conf/initDefault',
				    dataType:'json',
				    mysuccess: function(json){
				    	alert('恢复初始化设置成功');
				    	doSearch();
				    }
				  });
			}
		</script>
	</head>
	
	<body>
	
		<!-- Start: Header -->
			<jsp:include page="../../top.jsp"></jsp:include>
		<!-- End: Header -->
		
		<!-- Start: Content -->
		<div class="container-fluid content">	
			<div class="row">
			
				<!-- Sidebar -->
				<jsp:include page="../../menu.jsp"></jsp:include>
				<!-- End Sidebar -->
						
				<!-- Main Page -->
				<div class="main sidebar-minified">			
					<!-- Page Header -->
					<div class="page-header">
						<div class="pull-left">
							<ol class="breadcrumb visible-sm visible-md visible-lg">								
								<li><a href="#"><i class="icon fa fa-home"></i>首页</a></li>
								<li><a href="#"><i class="fa fa-table"></i>设置</a></li>
							</ol>						
						</div>
						<div class="pull-right">
							<h2>系统参数配置</h2>
						</div>					
					</div>
					<!-- End Page Header -->
					<div class="row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="panel panel-default bk-bg-white">
								<div class="panel-body">
									<div class="row">
											<div class="col-sm-12 col-md-6">
												<button type="button" class="bk-margin-5 btn btn-primary btn-sm"  onclick="initDefault()">初始化</button>
											</div>
									</div>
									<table class="table table-bordered table-striped mb-none" id="datatable-editable">
										<thead>
											<tr>
												<th>参数名称</th>
												<th>参数值</th>
												<th></th>
											</tr>
										</thead>
										<tbody>
											<tr class="gradeA repeat" style="display:none;">
												<td>$[conts]</td>
												<td>$[value]</td>
												<td><a href="#" onclick="openEdit($[id])">编辑</a></td>
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
