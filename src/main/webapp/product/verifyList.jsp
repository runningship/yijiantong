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
				    url: '/c/admin/lottery/listVerify',
				    data: a,
				    dataType:'json',
				    mysuccess: function(json){
				        buildHtmlWithJsonArray("repeat",json.page.data);
				        Page.setPageInfo(json.page);
				    }
				  });
			}
			
			function setStatus(id , status){
				YW.ajax({
				    type: 'post',
				    url: '/c/admin/lottery/setStatus',
				    data: {id:id , status : status},
				    dataType:'json',
				    mysuccess: function(json){
				    	layer.msg('操作成功');
				        doSearch();
				    }
				  });
			}
			
			function getStatuText(status){
				if(status==0){
					return "待审核";
				}else if(status==1){
					return "已通过";
				}else if(status==2){
					return "不通过";
				}
			}
		</script>
		
		<style type="text/css">
			.search{    width: 120px;    display: inline-block;}
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
							<h2>校验列表</h2>
						</div>					
					</div>
					<!-- End Page Header -->
					<div class="row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="panel panel-default bk-bg-white">
								<div class="panel-body">
									<div class="row">
											<form name="form1" onsubmit="doSearch();return false;">
											<div style="margin-bottom: 10px; margin-left: 15px;">
												校验码 <input type="search" name="code" class="form-control search"  aria-controls="datatable-default">
												手机号码 <input type="search" name="tel" class="form-control search"  aria-controls="datatable-default">
												批次号 <input type="search" name="batchNo" class="form-control search"  aria-controls="datatable-default">
												状态 <select class="form-control select search" name="status">
													<option value="">所有</option>
													<option value="0">待审核</option>
													<option value="1">已兑奖</option>
													<option value="2">无效码</option>
												</select>
												<button type="button" class="bk-margin-5 btn btn-primary btn-sm"  onclick="doSearch()">搜索</button>
											</div>
											
											</form>
									</div>
									<table class="table table-bordered table-striped mb-none" id="datatable-editable">
										<thead>
											<tr>
												<th>产品名称</th>
												<th>批次号</th>
												<th>产品规格</th>
												<th>兑奖号码</th>
												<th>兑奖地址</th>
												<th>兑奖码</th>
												<th>校验码</th>
												<th>提交时间</th>
												<th></th>
											</tr>
										</thead>
										<tbody>
											<tr class="gradeA repeat" style="display:none;">
												<td>$[title]</td>
												<td>$[batchNo]</td>
												<td>$[spec]</td>
												<td>$[tel]</td>
												<td>$[activeAddr]</td>
												<td>$[qrCode]</td>
												<td>$[verifyCode]</td>
												<td>$[addtime]</td>
												<td>
													<span show="$[status]==0">
														<a class="batch" href="#" onclick="setStatus($[id] , 1)">通过</a>
														<a class="batch" href="#" onclick="setStatus($[id] , 2)">不通过</a>
													</span>
													<span show="$[status]!=0" runscript="true">getStatuText($[status])</span>
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