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
				    type: 'post',
				    url: '/c/goods/list',
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
			            title: '编辑',
			            shadeClose: true,
			            shade: false,
			            maxmin: true, //开启最大化最小化按钮
			            area: ['793px', '600px'],
			            content: 'edit.jsp?id='+id
			        });
			}
			
			function delGoods(id){
				YW.ajax({
				    type: 'get',
				    url: '/c/goods/delete',
				    data: {id : id},
				    dataType:'json',
				    mysuccess: function(json){
				        doSearch();
				    }
				  });
			}
			
			function getStatus(code){
				if(!code){
					return '已下架';
				}else if(code==0){
					return '已下架';
				}else{
					return '已上架';
				}
			}
		</script>
		
		<style type="text/css">
			.status_1{color:blue;}
		</style>
	</head>
	
	<body>
	
		<!-- Start: Header -->
			<jsp:include page="../top.jsp"></jsp:include>
		<!-- End: Header -->
		
		<!-- Start: Content -->
		<div class="container-fluid content">	
			<div class="row">
			
				<!-- Sidebar -->
				<jsp:include page="../menu.jsp"></jsp:include>
				<!-- End Sidebar -->
						
				<!-- Main Page -->
				<div class="main sidebar-minified">			
					<!-- Page Header -->
					<div class="page-header">
						<div class="pull-left">
							<ol class="breadcrumb visible-sm visible-md visible-lg">								
								<li><a href="#"><i class="icon fa fa-home"></i>首页</a></li>
								<li><a href="#"><i class="fa fa-table"></i>产品管理</a></li>
							</ol>						
						</div>
						<div class="pull-right">
							<h2>产品列表</h2>
						</div>					
					</div>
					<!-- End Page Header -->
					<div class="row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="panel panel-default bk-bg-white">
								<div class="panel-body">
									<div class="row">
											<form name="form1" onsubmit="doSearch();return false;">
											<div class="col-sm-12 col-md-6">
												<div id="datatable-default_filter" class="dataTables_filter">
													<input type="search" name="title" class="form-control" placeholder="产品名称" aria-controls="datatable-default"><label></label>
												</div>
											</div>
											</form>
									</div>
									<table class="table table-bordered table-striped mb-none" id="datatable-editable">
										<thead>
											<tr>
												<th>产品名称</th>
												<th>产品规格</th>
												<th>状态</th>
												<th>上架时间</th>
												<th></th>
											</tr>
										</thead>
										<tbody>
											<tr class="gradeA repeat" style="display:none;">
												<td>$[title]</td>
												<td>$[spec]</td>
												<td runscript="true" class="status_$[isAd]">getStatus($[isAd])</td>
												<td>$[addtime]</td>
												<td>
														<a class="edit" href="#" onclick="openEdit($[id]);">编辑</a>
														<a class="del" href="#" onclick="delGoods($[id]);">删除</a>
												</td>
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