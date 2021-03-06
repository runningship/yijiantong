<%@page import="com.houyi.management.biz.entity.SysConfig"%>
<%@page import="org.bc.sdak.TransactionalServiceHelper"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
String id = request.getParameter("id");
SysConfig po = dao.get(SysConfig.class, Integer.valueOf(id));
request.setAttribute("conf", po);
%>
<!DOCTYPE html>
<html lang="en">

	<head>
	<jsp:include page="../../header.jsp"></jsp:include>
	
	<script type="text/javascript">
	var ue;
	$(function(){
		$("#form").validate({
			highlight: function( label ) {
				$(label).closest('.form-group').removeClass('has-success').addClass('has-error');
			},
			success: function( label ) {
				$(label).closest('.form-group').removeClass('has-error');
				label.remove();
			},
			errorPlacement: function( error, element ) {
				var placement = element.closest('.input-group');
				if (!placement.get(0)) {
					placement = element;
				}
				if (error.text() !== '') {
					placement.after(error);
				}
			},
			submitHandler:function(form ,event){
				save();
			}
		});
	});
	
	function save(){
		var a=$('#form').serialize();
		YW.ajax({
		    type: 'POST',
		    url: '/c/conf/update',
		    data:a,
		    mysuccess: function(data){
		    	layer.msg('修改成功');
		    	window.parent.doSearch();
		    	var index =parent.layer.getFrameIndex(window.name);
				parent.layer.close(index);
		    }
	    });
	}
	
	</script>
	</head>
	
	<body>
		
		<!-- Start: Content -->
		<div class="container-fluid content">	
			<div class="row">
				<!-- Main Page -->
				<div class="sidebar-minified">			
					
					<div class="row">
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<form id="form"  class="form-horizontal">
								<input type="hidden"  name="id" value="${conf.id }" />
								<div class="panel panel-default" style="height:100%;">
									<div class="panel-body">
										<div class="form-group">
											<label class="col-sm-2 control-label">名称</label>
											<div class="col-sm-6">
												<input type="text" name="name"  value="${conf.conts }" disabled="disabled" class="form-control" placeholder="" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">配置值 <span class="required">*</span></label>
											<div class="col-sm-6">
												<input type="text" name="value"  value="${conf.value }" class="form-control" placeholder="" required/>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-6 col-sm-offset-3">
												<button class="bk-margin-5 btn btn-info" >保存</button>
											</div>
										</div>
									</div>									
								</div>
							</form>
						</div>	   
					</div>
				<!-- End Main Page -->	
			</div>
		</div>
		</div>
		<!--/container-->
	</body>
	
</html>