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
				    type: 'post',
				    url: '/c/admin/user/listSysUser',
				    data: a,
				    dataType:'json',
				    mysuccess: function(json){
				        buildHtmlWithJsonArray("repeat",json.page.data);
				        Page.setPageInfo(json.page);
				    }
				  });
			}
			
			function openAdd(id){
				 layer.open({
			            type: 2,
			            title: '新增系统用户',
			            shadeClose: true,
			            shade: false,
			            maxmin: true, //开启最大化最小化按钮
			            area: ['800px', '530px'],//宽高
			            content: 'add.jsp'
			        });
			}
			
			function openEdit(id){
				 layer.open({
			            type: 2,
			            title: '编辑用户信息',
			            shadeClose: true,
			            shade: false,
			            maxmin: true, //开启最大化最小化按钮
			            area: ['800px', '530px'],//宽高
			            content: 'edit.jsp?id='+id
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
					<div class="page-header">
						<div class="pull-left">
							<ol class="breadcrumb visible-sm visible-md visible-lg">								
								<li><a href="#"><i class="icon fa fa-home"></i>首页</a></li>
								<li><a href="#"><i class="fa fa-table"></i>用户管理</a></li>
							</ol>						
						</div>
						<div class="pull-right">
							<h2>系统用户</h2>
						</div>					
					</div>		
					<div class="row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="panel panel-default bk-bg-white">
								<div class="panel-body">
									<div class="row">
											<div class="col-sm-12 col-md-6">
												<button type="button" class="bk-margin-5 btn btn-primary btn-sm"  onclick="openAdd()">添加</button>
											</div>
									</div>
									<div class="row">
											<form name="form1" onsubmit="doSearch();return false;">
											<div class="col-sm-12 col-md-6">
												<div id="datatable-default_filter" class="dataTables_filter">
													<input type="search" name="search" class="form-control" placeholder="姓名  账号  电话" aria-controls="datatable-default"><label></label>
												</div>
											</div>
											</form>
									</div>
									<table class="table table-bordered table-striped mb-none" id="datatable-editable">
										<thead>
											<tr>
												<th>账号</th>
												<th>姓名</th>
												<th>电话</th>
												<th>邮件</th>
												<th>最后登录时间</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody>
											<tr class="gradeA repeat" style="display:none;">
												<td>$[account]</td>
												<td>$[name]</td>
												<td>$[tel]</td>
												<td>$[email]</td>
												<td>$[lasttime]</td>
												<td>
													<a href="#" onclick="openEdit($[id]);">编辑</a> <a href="#" onclick="delArticle($[id]);">删除</a> 
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