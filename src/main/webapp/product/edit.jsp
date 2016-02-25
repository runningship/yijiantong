<%@page import="com.houyi.management.ThreadSessionHelper"%>
<%@page import="com.houyi.management.cache.ConfigCache"%>
<%@page import="com.houyi.management.biz.entity.Image"%>
<%@page import="com.houyi.management.product.entity.Product"%>
<%@page import="org.bc.sdak.TransactionalServiceHelper"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String productId = request.getParameter("productId");
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	Product po = dao.get(Product.class, Integer.valueOf(productId));
	request.setAttribute("product", po);
	Image image = dao.get(Image.class , po.imgId);
	request.setAttribute("image", image);
	String imageHost = ConfigCache.get("image_host", "localhost");
	request.setAttribute("image_host", imageHost);
%>
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
	
		ue.addListener( 'ready', function( editor ) {
	        ue.setContent('${product.conts}');
	    });
		
		var img=JSON.parse('{}');
		img.path = 'http://${image_host}/article_image_path/${image.path}';
		img.id = '${product.imgId}';
		var arr = [];
		arr.push(img);
		setSelectImg(arr);
	});
	
	function openImagePanel(){
		layer.open({
            type: 2,
            title: '图片库',
            shadeClose: true,
            shade: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['600px', '400px'],
            content: '../image/gallery.jsp'
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
	function save(){
		var conts = ue.getContent();
	    if (conts==null||conts=='') {
	    	alert('内容不能为空');
	    	return;
	    };
	    if(!$('#imgId').val()){
	    	layer.msg('请先选择图片');
	    	return;
	    }
	    if($('#isAd')[0].checked){
	    	$('#isAd').val(1);
	    }else{
	    	$('#isAd').val(0);
	    }
		var a=$('#form').serialize();
		YW.ajax({
		    type: 'POST',
		    url: '/c/product/update',
		    data:a,
		    mysuccess: function(data){
		    	layer.msg('修改成功');
		    }
	    });
	}
	</script>
	
	<style type="text/css">
		.adTip{
			position: absolute;    top: 6px;    left: 83px;    color: #aaa;
		}
	</style>
	</head>
	
	<body>
		
		<!-- Start: Header -->
		<!-- End: Header -->
		
		<!-- Start: Content -->
		<div class="container-fluid content">	
			<div class="row">
			
				<!-- Sidebar -->
				<!-- End Sidebar -->
						
				<!-- Main Page -->
				<div class="sidebar-minified">			
					<!-- Page Header -->
					<!-- End Page Header -->
					<div class="row">
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<form id="form"  class="form-horizontal">
								<input type="hidden"  name="id" value="${product.id }"/>
								<div class="panel panel-default">
									<div class="panel-body">
										<div class="form-group">
											<label class="col-sm-2 control-label">商品名称 <span class="required">*</span></label>
											<div class="col-sm-9">
												<input type="text" name="title" class="form-control" placeholder="" value="${product.title }" required/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">生产商 <span class="required">*</span></label>
											<div class="col-sm-9">
												<input type="text" name="vender" class="form-control" placeholder=""  value="${product.vender }" required/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">产地信息</label>
											<div class="col-sm-9">
												<input type="text" name="verderPlace" class="form-control" placeholder="" value="${product.verderPlace }" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">规格信息 <span class="required">*</span></label>
											<div class="col-sm-9">
												<input type="text" name="spec" class="form-control" placeholder=""  value="${product.spec }" required/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">是否广告</label>
											<div class="col-lg-6 col-md-4 col-sm-4 col-xs-4">
													<span class="adTip">(如果开启广告，则显示在APP广告区)</span>
													<label class="switch switch-success bk-margin-top-5">
													  <input type="checkbox"  value="${product.isAd }"  id="isAd" class="switch-input"  <c:if test="${product.isAd==1 }">checked</c:if>  name="isAd">
													  <span class="switch-label" data-on="On" data-off="Off"></span>
													  <span class="switch-handle"></span>
													</label>
												</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">图片 <span class="required">*</span></label>
											<div class="col-sm-9" >
												<input type="hidden" name="imgId" value="${article.imgId }"  id="imgId" class="form-control" placeholder="" required/>
												<div id="imgContainer"></div>
												<button type="button" class="btn btn-info btn-xs" onclick="openImagePanel()">图片库</button>
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