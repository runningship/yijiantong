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
				    url: '/c/article/list',
				    data: a,
				    dataType:'json',
				    mysuccess: function(json){
				        buildHtmlWithJsonArray("repeat",json.page.data);
				        Page.setPageInfo(json.page);
				    }
				  });
			}
			
			function delArticle(id){
				layer.confirm('确定要删除该条记录吗？', {
					  btn: ['确定','取消'] //按钮
					}, function(){
						YW.ajax({
						    type: 'post',
						    url: '/c/article/delete',
						    data: {id : id},
						    dataType:'json',
						    mysuccess: function(json){
						    	alert('删除成功');
						      	doSearch();
						    }
					    });
					}, function(){
				});
				
			}
			function openEdit(id){
				 layer.open({
			            type: 2,
			            title: '编辑新闻',
			            shadeClose: true,
			            shade: false,
			            maxmin: true, //开启最大化最小化按钮
			            area: ['900px', '600px'],
			            content: 'edit.jsp?id='+id
			        });
			}
			
			function getLebie(leibie){
				if('news'==leibie){
					return '行业新闻';
				}else if('tips'==leibie){
					return '生活小贴士';
				}else{
					return '';
				}
			}
			
			function togglePublishFlag(id){
				YW.ajax({
				    type: 'post',
				    url: '/c/article/togglePublishFlag',
				    data: {id : id},
				    dataType:'json',
				    mysuccess: function(json){
				      	doSearch();
				    }
				  });
			}
			
			function getPublishFlag(flag){
				if(flag){
					//已发布
					return '已发布';
				}else{
					return '未发布';
				}
			}
		</script>
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
					<div class="page-header">
						<div class="pull-left">
							<ol class="breadcrumb visible-sm visible-md visible-lg">								
								<li><a href="#"><i class="icon fa fa-home"></i>首页</a></li>
								<li><a href="#"><i class="fa fa-table"></i>新闻管理</a></li>
							</ol>						
						</div>
						<div class="pull-right">
							<h2>新闻列表</h2>
						</div>					
					</div>		
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
												<th>标题</th>
												<th>阅读</th>
												<th>发布时间</th>
												<th>类别</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody>
											<tr class="gradeA repeat" style="display:none;">
												<td>$[title]</td>
												<td>$[readCount]</td>
												<td>$[addtime]</td>
												<td runscript="true">getLebie('$[leibie]')</td>
												<td><a href="#" onclick="openEdit($[id]);">编辑</a> <a href="#" onclick="delArticle($[id]);">删除</a> 
														<a href="#"  runscript="true" onclick="togglePublishFlag($[id]);">getPublishFlag($[publishFlag])</a> 
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