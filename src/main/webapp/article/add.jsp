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
	});
	
	function openImagePanel(){
		layer.open({
            type: 2,
            title: '图片库',
            shadeClose: true,
            shade: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['893px', '600px'],
            content: '../image/gallery.jsp'
        });
	}
	
	function save(){
		var conts = ue.getContent();
	    if (conts==null||conts=='') {
	    	layer.msg('内容不能为空');
	    	return;
	    };
	    if(!$('#imgId').val()){
	    	layer.msg('请先选择图片');
	    	return;
	    }
	    if($('#publishFlag').attr('checked')){
	    	$('#publishFlag').val(1);
	    }else{
	    	$('#publishFlag').val(0);
	    }
		var a=$('#form').serialize();
		YW.ajax({
		    type: 'POST',
		    url: '/yijiantong/c/article/save',
		    data:a,
		    mysuccess: function(data){
		    	layer.msg('添加商品成功');
		    }
	    });
	}
	var stack_bar_top = {"dir1": "down", "dir2": "right", "push": "top", "spacing1": 0, "spacing2": 0};
	var stack_bar_bottom = {"dir1": "up", "dir2": "right", "spacing1": 0, "spacing2": 0};
	function tishi(){
		var notice = new PNotify({
			title: '消息',
			text: '商品添加成功.',
			type: 'success',
			addclass: 'stack-bar-top',
			stack: stack_bar_top,
			delay:1000,
			width: "100%"
		});
	}
	
	function setSelectImg(arr){
		if(arr.length>0){
			var img = arr[0];
			var html = '<img style="width:200px;" src="'+img.path+'" />';
			$('#imgId').val(img.id);
			$('#imgContainer').empty();
			$('#imgContainer').append(html);
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
					
					<div class="row">
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<form id="form"  class="form-horizontal">
								<div class="panel panel-default">
									<div class="panel-body">
										<div class="form-group">
											<label class="col-sm-2 control-label">标题 <span class="required">*</span></label>
											<div class="col-sm-9">
												<input type="text" name="title" class="form-control" placeholder="" required/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">作者 <span class="required">*</span></label>
											<div class="col-sm-9">
												<input type="text" name="author" value="快易扫" class="form-control" placeholder="" required/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">排序 </label>
											<div class="col-sm-9">
												<input type="text" name="orderx" class="form-control" placeholder="" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">是否发布</label>
											<div class="col-lg-12 col-md-4 col-sm-4 col-xs-4">
													<label class="switch switch-success bk-margin-top-10">
													  <input type="checkbox"  value="1"  id="publishFlag" class="switch-input"  name="publishFlag" checked="">
													  <span class="switch-label" data-on="On" data-off="Off"></span>
													  <span class="switch-handle"></span>
													</label>
												</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">图片 <span class="required">*</span></label>
											<div class="col-sm-9" >
												<input type="hidden" name="imgId"  id="imgId" class="form-control" placeholder="" required/>
												<div id="imgContainer"></div>
												<button type="button" class="btn btn-info btn-xs" onclick="openImagePanel()">图片库</button>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">文章内容</label>
											<div class="col-sm-9">
												<span id="editor" type="text/plain" name="conts" style="height:250px;width:100%;"></span>
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
<!-- 		<script src="/yijiantong/assets/js/pages/form-validation.js"></script> -->
<!-- 		<script src="/yijiantong/assets/js/pages/ui-notifications.js"></script> -->
		<script src="/yijiantong/assets/js/pages/ui-elements.js"></script>
		
		<!-- end: JavaScript-->
		
	</body>
	
</html>