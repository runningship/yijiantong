<%@page import="com.houyi.management.user.entity.User"%>
<%@page import="com.houyi.management.cache.ConfigCache"%>
<%@page import="com.houyi.management.ThreadSessionHelper"%>
<%@page import="org.bc.sdak.TransactionalServiceHelper"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	String id = request.getParameter("id");
	User user  = dao.get(User.class, Integer.valueOf(id));
	request.setAttribute("user", user);
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
		    url: '/c/admin/user/update',
		    data:a,
		    mysuccess: function(data){
		    	layer.msg('保存成功');
		    }
	    });
	}
	
	
	</script>
	<style type="text/css">
	</style>
	</head>
	
	<body>
		
		<!-- Start: Header -->
		<!-- End: Header -->
		
		<!-- Start: Content -->
		<div class="container-fluid content">	
			<div class="row">
				<!-- Main Page -->
				<div class="sidebar-minified">			
					<div class="row">
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<form id="form"  class="form-horizontal">
								<input type="hidden" name="id" value="${user.id }"/>
								<div class="panel panel-default">
									<div class="panel-body">
										<div class="form-group">
											<label class="col-sm-2 control-label">账号 <span class="required">*</span></label>
											<div class="col-sm-9">
												<input type="text" name="account"  value="${user.account }"  readonly="readonly"  class="form-control" placeholder="" required/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"> 姓名 <span class="required">*</span></label>
											<div class="col-sm-9">
												<input type="text" name="name"   value="${user.name }" class="form-control" placeholder="" required/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"> 手机号码 <span class="required">*</span></label>
											<div class="col-sm-9">
												<input type="text" name="tel"   value="${user.tel }" class="form-control" placeholder="" required/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"> 个性签名 </label>
											<div class="col-sm-9">
												<input type="text" name="sign"   value="${user.sign }" class="form-control"  readonly="readonly" placeholder="" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"> QQ </label>
											<div class="col-sm-9">
												<input type="text" name="qq"   value="${user.qq }" class="form-control" placeholder="" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"> 生日 </label>
											<div class="col-sm-9">
												<input type="text" name="birth"   value="${user.birth }" class="form-control" placeholder="" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"> 性别 </label>
											<div class="col-sm-9">
												<input type="text" name="gender"   value="${user.gender }" class="form-control" placeholder="" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label"> 微信 </label>
											<div class="col-sm-9">
												<input type="text" name="weixin"   value="${user.weixin }" class="form-control" placeholder="" />
											</div>
										</div>
										<div class="row">
											<div class="col-sm-9 col-sm-offset-3">
												<button class="bk-margin-5 btn btn-info" >保存</button>
												<button type="reset" class="bk-margin-5 btn btn-default">清空</button>
												
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
		
		<div class="clearfix"></div>		
		
		
		<!-- start: JavaScript-->
		
		
		<!-- Pages JS -->
<!-- 		<script src="/assets/js/pages/form-validation.js"></script> -->
<!-- 		<script src="/assets/js/pages/ui-notifications.js"></script> -->
		<script src="/assets/js/pages/ui-elements.js"></script>
		
		<!-- end: JavaScript-->
		
	</body>
	
</html>