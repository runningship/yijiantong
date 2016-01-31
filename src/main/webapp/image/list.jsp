<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<jsp:include page="../header.jsp"></jsp:include>
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
				    url: '/c/image/list',
				    data: a,
				    dataType:'json',
				    mysuccess: function(json){
				        buildHtmlWithJsonArray("repeat",json.page.data);
				        Page.setPageInfo(json.page);
				    }
				  });
			}
			
			setTimeout(function(){
				initUploadHouseImage(1212);
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
				           alert('图片上传成功');
				           doSearch();
				        }
				      },
				      'onQueueComplete' : function(queueData) {
				        //console.log(queueData);
				      }
				      // Put your options here
				  });
			}
		</script>
		
		<style type="text/css">
			.img_item{width:150px;margin:0 12px;cursor:pointer;}
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
				<div class="main sidebar-minified">			
					<!-- Page Header -->
					<!-- End Page Header -->
					<div class="row">
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<div class="panel panel-default bk-bg-white">
								<div class="panel-body">
									<div class="row">
											<div class="col-sm-12 col-md-6">
												<div id="datatable-default_filter" class="dataTables_filter">
													<input id="upload"  style="display:none;">
												</div>
											</div>
									</div>
									<div>
										<img class="img_item repeat" src="http://127.0.0.1/article_image_path/$[uid]/$[path].t.jpg">
									</div>
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
		
	</body>
	
</html>