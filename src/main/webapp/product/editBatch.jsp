<%@page import="com.houyi.management.product.entity.ProductBatch"%>
<%@page import="org.bc.sdak.SimpDaoTool"%>
<%@page import="org.bc.sdak.CommonDaoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String id = request.getParameter("id");
	CommonDaoService dao = SimpDaoTool.getGlobalCommonDaoService();
	ProductBatch batch = dao.get(ProductBatch.class, Integer.valueOf(id));
	request.setAttribute("batch", batch);
%>
<!DOCTYPE html>
<html lang="en">

	<head>
	<jsp:include page="../header.jsp"></jsp:include>
	
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
		    url: '/c/product/updateBatch',
		    data:a,
		    mysuccess: function(data){
		    	layer.msg('修改批次信息成功');
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
								<input type="hidden" name="id" value="${batch.id }"/>
								<div class="panel panel-default" style="height:100%;">
									<div class="panel-body">
										<div class="form-group">
											<label class="col-sm-2 control-label">批次号 <span class="required">*</span></label>
											<div class="col-sm-6">
												<input type="text" name="no"   readonly="readonly" value="${batch.no }" class="form-control" placeholder="" required/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">数量 <span class="required">*</span></label>
											<div class="col-sm-6">
												<input type="text" name="count"  value="${batch.count }"  readonly="readonly" desc="数量" class="form-control" placeholder="" required/>
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">奖券 <span class="required">*</span></label>
											<div class="col-sm-6">
												<input type="text" name="lottery"  readonly="readonly" value="${batch.lottery }" desc="奖券" class="form-control" placeholder="" required/>元
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">是否开放兑奖 </label>
											<select class="form-control select search" name="openForLottery">
												<option <c:if test="${batch.openForLottery ==1 }">selected="selected"</c:if> value="1">是</option>
												<option <c:if test="${batch.openForLottery !=1 }">selected="selected"</c:if> value="0">否</option>
											</select>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">是否自动兑奖 </label>
											<select class="form-control select search" name="autoCashLottery">
												<option <c:if test="${batch.autoCashLottery ==1 }">selected="selected"</c:if> value="1">是</option>
												<option <c:if test="${batch.autoCashLottery !=1 }">selected="selected"</c:if> value="0">否</option>
											</select>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">是否自动校验 </label>
											<select class="form-control select search" name="autoVerifyLottery">
												<option <c:if test="${batch.autoVerifyLottery ==1 }">selected="selected"</c:if>  value="1">是</option>
												<option <c:if test="${batch.autoVerifyLottery !=1 }">selected="selected"</c:if> value="0">否</option>
											</select>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">二维码大小 </label>
											<div class="col-sm-6">
												<input type="text"  value="${batch.qrCodeWidth }" name="qrCodeWidth" desc="二维码大小" class="form-control" placeholder="" />px
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-2 control-label">描述 <span class="required">*</span></label>
											<div class="col-sm-6">
												<input type="text" name="conts" value="${batch.conts }" class="form-control" placeholder="" required/>
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