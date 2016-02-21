<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

	<head>
	<jsp:include page="header.jsp"></jsp:include>
	<link href="assets/css/style-black.css" rel="stylesheet" />
	<script src="/assets/js/pages/ui-elements.js"></script>
		<script type="text/javascript">
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
						login();
					}
				});
			});
			
			function login(){
				var a=$('#form').serialize();
				YW.ajax({
				    type: 'POST',
				    url: '/c/admin/user/login',
				    data:a,
				    mysuccess: function(data){
				    	window.location='/product/list.jsp';
				    }
			    });
			}
		</script>
		<style type="text/css">
			.panel-title-login{    background: #435D78;    height: 70px;    line-height: 60px;    text-align: center;}
			.btn-login{width:80px;}
			.input-group input{height: 48px;    line-height: 48px;    font-size: 20px !important;}
		</style>
	</head>
	<body>
		<!-- Start: Content -->
		<div class="container-fluid content">
			<div class="row">
				<!-- Main Page -->
				<div class="body-login">
					<div class="center-login">
						<div class="panel panel-login">
							<div class="panel-title-login">
								<img src="assets/img/houyi/login.png" />
							</div>
							<div class="panel-body">
								<form id="form" class="form-horizontal"">
									<div class="form-group">
										<label>账号: </label>
										<div class="input-group input-group-icon">
											<input name="account" type="text" class="form-control bk-noradius" required/>
											<span class="input-group-addon">
												<span class="icon">
													<i class="fa fa-user"></i>
												</span>
											</span>
										</div>
									</div>

									<div class="form-group">
										<label>密码: </label>									
										<div class="input-group input-group-icon">
											<input name="pwd" type="password" class="form-control bk-noradius" required/>
											<span class="input-group-addon">
												<span class="icon">
													<i class="fa fa-lock"></i>
												</span>
											</span>
										</div>
									</div>
									<br />
									<div class="row">
										<div class="col-sm-8">
											<div class="checkbox-custom checkbox-default bk-margin-bottom-10">
												<input id="RememberMe" name="rememberme" type="checkbox"/>
												<label for="RememberMe">记住密码</label>
											</div>
										</div>
										<div class="col-sm-4 text-right">
											<button href="#" type="submit" class="btn btn-primary hidden-xs btn-login">登录</button>
										</div>
									</div>
									<br />
								</form>
							</div>
						</div>
					</div>
				</div>
				<!-- End Main Page -->
			</div>
		</div><!--/container-->
		
		
		<!-- start: JavaScript-->
		
		<!-- end: JavaScript-->
		
	</body>
	
</html>