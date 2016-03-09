<!DOCTYPE html>
<%@page import="com.houyi.management.cache.ConfigCache"%>
<%@page import="com.houyi.management.ThreadSessionHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setAttribute("user", ThreadSessionHelper.getUser());
	request.setAttribute("imageHost", ConfigCache.get("image_host", "localhost"));
%>
<html lang="en">

	<head>
		<jsp:include page="../header.jsp"></jsp:include>
		
		<style type="text/css">
			.media-gallery .mg-files{padding:5px 20px}
			.media-gallery .mg-files .thumbnail{padding:0px;margin-bottom:0px;}
			.isotope-item{width:150px;padding:3px;display:inline-block;}
			.media-gallery{margin-top:25px;margin-left:20px;}
			.btn-ok{position: absolute;    top: 0px;    right: 30px;}
		</style>
		<script type="text/javascript" src="/assets/js/uploadify/jquery.uploadify.js"></script>
		<script type="text/javascript">
			$(function(){
				Page.Init();
				doSearch();
			});
			
			function doSearch(){
				var a=$('form[name=form1]').serialize();
				YW.ajax({
				    type: 'get',
				    url: '/c/image/list?'+new Date().getTime(),
				    data: a,
				    dataType:'json',
				    mysuccess: function(json){
				        buildHtmlWithJsonArray("repeat",json.page.data);
				        Page.setPageInfo(json.page);
				        /*
				    	Thumbnail: Select
				    	*/
				    	$('.mg-option input[type=checkbox]').on('change', function( ev ) {
				    		var wrapper = $(this).parents('.thumbnail');
				    		if($(this).is(':checked')) {
				    			wrapper.addClass('thumbnail-selected');
				    		} else {
				    			wrapper.removeClass('thumbnail-selected');
				    		}
				    	});
				    }
				 });
			}
			
			function deleteImage(id){
				YW.ajax({
				    type: 'get',
				    url: '/c/image/delete',
				    data: {id : id},
				    dataType:'json',
				    mysuccess: function(json){
				    	layer.msg('删除成功');
				    	doSearch();
				    }
				 });
			}
			
			setTimeout(function(){
				initUploadHouseImage(${user.id});
			},100);
			
			
			function initUploadHouseImage(uid){
				  $('#upload').uploadify({
				      'swf'      : '/assets/js/uploadify/uploadify.swf',
				      'uploader' : '/c/image/upload?uid='+uid,
				      'buttonText': '上传图片',
				      'removeTimeout': 0.1,
				      'fileSizeLimit' : '5MB',
				      'onUploadError' : function(file, errorCode, errorMsg, errorString){
				          //console.log('The file ' + file.name + ' could not be uploaded: ' + errorString);
				      },
				      'onUploadComplete':function(file){
				          //console.log('finish:'+file);
				    	  
				      },
				      'onUploadSuccess' : function(file, data, response) {
				        var json = JSON.parse(data);
				        if(json['result']!=0){
				          $('#' + file.id).find('.data').html('-图片上传失败,'+json['msg']);
				        }else{
				           
				        }
				      },
				      'onQueueComplete' : function(queueData) {
				    	  alert('图片上传成功');
				    	  doSearch();
				      }
				      // Put your options here
				  });
			}
			
			function doSelect(){
				var imgs = $('.thumbnail-selected img');
				var arr = [];
				for(var i=0;i<imgs.length;i++){
					var json = JSON.parse('{}');
					json.id = $(imgs[i]).attr('data-id');
					json.path = $(imgs[i]).attr('src');
					if(json.path.indexOf('$[path]')>-1){
						continue;
					}
					arr.push(json);
				}
				window.parent.setSelectImg(arr);

				var index =parent.layer.getFrameIndex(window.name)
				parent.layer.close(index);
			}
		</script>
		
	</head>
	
	<body>
	
		<!-- Start: Content -->
		<div class="container-fluid content">	
			<div class="row">
			
				<!-- Main Page -->
				<div class="">
					<div class="media-gallery">
						<form name="form1" onsubmit="doSearch();return false;"></form>
						<div class="row">
								<div class="col-sm-12 col-md-6">
									<div id="datatable-default_filter" class="dataTables_filter">
										<input id="upload"  style="display:none;">
										<button onclick="doSelect()" type="button" class="btn-ok bk-margin-5 btn btn-success btn-xs">确定</button>
									</div>
								</div>
						</div>
					
						<div class="mg-main">							
							<div class="row mg-files" data-sort-destination data-sort-id="media-gallery">
								<div class="isotope-item image col-sm-6 col-md-4 col-lg-3  repeat">
									<div class="thumbnail">
										<div class="thumb-preview">
											<a class="thumb-image" href="http://${imageHost }/article_image_path//$[path]">
												<img data-id="$[id]" src="http://${imageHost }/article_image_path/$[path]" class="img-responsive" style="">
											</a>
											<div class="mg-thumb-options">
												<div class="mg-toolbar">
													<div class="mg-option checkbox-custom checkbox-inline">
														<input type="checkbox" id="file_8" value="1">
														<label for="file_8">选择</label>
													</div>
													<div class="mg-group pull-right">
														<a href="#" onclick="deleteImage($[id])">删除</a>
													</div>
													
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div>
								<div class="maxHW mainCont ymx_page foot_page_box"></div>
							</div>
						</div>
					</div>		   
				</div>
				<!-- End Main Page -->
			
			
			</div>
		</div><!--/container-->
		
	</body>
	
</html>