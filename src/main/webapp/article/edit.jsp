<%@page import="com.houyi.management.cache.ConfigCache"%>
<%@page import="com.houyi.management.ThreadSessionHelper"%>
<%@page import="com.houyi.management.biz.entity.Image"%>
<%@page import="com.houyi.management.article.entity.Article"%>
<%@page import="org.bc.sdak.TransactionalServiceHelper"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	String id = request.getParameter("id");
	Article article  = dao.get(Article.class, Integer.valueOf(id));
	request.setAttribute("article", article);
	Image image = dao.get(Image.class , article.imgId);
	request.setAttribute("image", image);
	request.setAttribute("imageHost", ConfigCache.get("image_host", "localhost"));
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
	        ue.setContent('${article.conts}');
	    });
		var img=JSON.parse('{}');
		img.path = 'http://${imageHost}/article_image_path/${image.path}';
		img.id = '${article.imgId}';
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
	    	layer.msg('内容不能为空');
	    	return;
	    };
	    if(!$('#imgId').val()){
	    	layer.msg('请先选择图片');
	    	return;
	    }
	    if($('#publishFlag')[0].checked){
	    	$('#publishFlag').val(1);
	    }else{
	    	$('#publishFlag').val(0);
	    }
	    if($('#isAd')[0].checked){
	    	$('#isAd').val(1);
	    }else{
	    	$('#isAd').val(0);
	    }
		var a=$('#form').serialize();
		YW.ajax({
		    type: 'POST',
		    url: '/c/article/update',
		    data:a,
		    mysuccess: function(data){
		    	layer.msg('保存成功');
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
								<input type="hidden" name="id" value="${article.id }"/>
								<div class="panel panel-default">
									<div class="panel-body">
										<div class="form-group">
											<label class="col-sm-2 control-label">标题 <span class="required">*</span></label>
											<div class="col-sm-9">
												<input type="text" name="title"  value="${article.title }" class="form-control" placeholder="" required/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">作者 <span class="required">*</span></label>
											<div class="col-sm-9">
												<input type="text" name="author"   value="${article.author }" class="form-control" placeholder="" required/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">类别 <span class="required">*</span></label>
											<div class="col-sm-9">
												<select class="form-control select" name="leibie" >
													<option <c:if test="${article.leibie eq 'news' }">selected="selected" </c:if> value="news">行业新闻</option>
													<option <c:if test="${article.leibie eq 'tips' }">selected="selected" </c:if> value="tips">生活小贴士</option>
												</select>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">排序 </label>
											<div class="col-sm-9">
												<input type="text" name="orderx"  value="${article.orderx }" class="form-control" placeholder="" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">是否发布</label>
											<div class="col-lg-6 col-md-4 col-sm-4 col-xs-4">
													<label class="switch switch-success bk-margin-top-5">
													  <input type="checkbox"  value="${article.publishFlag }"  <c:if test="${article.publishFlag==1 }">checked</c:if>  id="publishFlag" class="switch-input"  name="publishFlag" >
													  <span class="switch-label" data-on="On" data-off="Off"></span>
													  <span class="switch-handle"></span>
													</label>
												</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">是否广告</label>
											<div class="col-lg-6 col-md-4 col-sm-4 col-xs-4">
													<span class="adTip">(如果开启广告，则显示在APP广告区)</span>
													<label class="switch switch-success bk-margin-top-5">
													  <input type="checkbox"  value="${article.isAd }"  <c:if test="${article.isAd==1 }">checked</c:if>  id="isAd" class="switch-input"  name="isAd">
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
<!-- 		<script src="/assets/js/pages/form-validation.js"></script> -->
<!-- 		<script src="/assets/js/pages/ui-notifications.js"></script> -->
		<script src="/assets/js/pages/ui-elements.js"></script>
		
		<!-- end: JavaScript-->
		
	</body>
	
</html>