<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

	<head>
	<jsp:include page="../header.jsp"></jsp:include>
	<script type="text/javascript" charset="utf-8" src="../assets/js/ueditor1_4_3/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="../assets/js/ueditor1_4_3/ueditor.all.yw.min.js"> </script>
	<script type="text/javascript" charset="utf-8" src="../assets/js/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
	
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
		
		ue = UE.getEditor('editor',{
	        toolbars: [
	            ['forecolor','source', 'simpleupload','emotion','spechars', 'attachment', '|', 'fontfamily', 'fontsize', 'bold','insertvideo','map',
	             'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'formatmatch', 'pasteplain', '|', 'backcolor', 'insertorderedlist', 'insertunorderedlist', '|','justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', 'indent', 'rowspacingtop', 'rowspacingbottom', 'lineheight',
	            ]
	        ]
	  });
		
		PNotify.prototype.options.styling = "fontawesome";
	});
	
	function save(){
		var conts = ue.getContent();
	    if (conts==null||conts=='') {
	    	alert('内容不能为空');
	    	return;
	    };
	    
		var a=$('#form').serialize();
		YW.ajax({
		    type: 'POST',
		    url: '/yijiantong/c/product/save',
		    data:a,
		    mysuccess: function(data){
		    	
		    }
	    });
	}
	var stack_bar_top = {"dir1": "down", "dir2": "right", "push": "top", "spacing1": 0, "spacing2": 0};
	var stack_bar_bottom = {"dir1": "up", "dir2": "right", "spacing1": 0, "spacing2": 0};
	function tishi(){
		var notice = new PNotify({
			title: 'Notification',
			text: 'Some notification text.',
			type: 'success',
			addclass: 'stack-bar-top',
			stack: stack_bar_top,
			width: "100%"
		});
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
					<!-- Page Header -->
					<div class="page-header">
						<div class="pull-left">
							<ol class="breadcrumb visible-sm visible-md visible-lg">								
								<li><a href="index.html"><i class="icon fa fa-home"></i>首页</a></li>
								<li><a href="#"><i class="fa fa-table"></i>商品管理</a></li>
							</ol>						
						</div>
						<div class="pull-right">
							<h2>添加商品</h2>
						</div>					
					</div>
					<!-- End Page Header -->
					<div class="row">
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<form id="form"  class="form-horizontal">
								<div class="panel panel-default">
									<div class="panel-body">
										<div class="form-group">
											<label class="col-sm-2 control-label">商品名称 <span class="required">*</span></label>
											<div class="col-sm-9">
												<input type="text" name="title" class="form-control" placeholder="" required/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">生产商 <span class="required">*</span></label>
											<div class="col-sm-9">
												<input type="text" name="vender" class="form-control" placeholder="" required/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">产地信息</label>
											<div class="col-sm-9">
												<input type="text" name="verderPlace" class="form-control" placeholder="" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">规格信息 <span class="required">*</span></label>
											<div class="col-sm-9">
												<input type="text" name="spec" class="form-control" placeholder="" required/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">商品详情</label>
											<div class="col-sm-9">
												<span id="editor" type="text/plain" name="conts" style="height:330px;width:100%;"></span>
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
					<button type="reset" class="bk-margin-5 btn btn-default" onclick="tishi();">tishi</button>
				<!-- End Main Page -->	
			</div>
		</div>
		</div>
		<!--/container-->
		
		<div class="clearfix"></div>		
		
		
		<!-- start: JavaScript-->
		
		
		<!-- Pages JS -->
<!-- 		<script src="/yijiantong/assets/js/pages/form-validation.js"></script> -->
		<script src="/yijiantong/assets/js/pages/ui-notifications.js"></script>
		
		<!-- end: JavaScript-->
		
	</body>
	
</html>