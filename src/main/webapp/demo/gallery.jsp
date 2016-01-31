<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">

	<head>
		<jsp:include page="../header.jsp"></jsp:include>
	</head>
	
	<body>
	
		<!-- Start: Content -->
		<div class="container-fluid content">	
			<div class="row">
			
				<!-- Main Page -->
				<div class="">
					<div class="media-gallery">
						<div class="mg-main">							
							<div class="row mg-files" data-sort-destination data-sort-id="media-gallery">
								<div class="isotope-item image col-sm-6 col-md-4 col-lg-3">
									<div class="thumbnail">
										<div class="thumb-preview">
											<a class="thumb-image" href="assets/img/gallery/photo8.jpg">
												<img src="assets/img/gallery/photo8.jpg" class="img-responsive" alt="Project">
											</a>
											<div class="mg-thumb-options">
												<div class="mg-zoom"><i class="fa fa-search"></i></div>
												<div class="mg-toolbar">
													<div class="mg-option checkbox-custom checkbox-inline">
														<input type="checkbox" id="file_8" value="1">
														<label for="file_8">SELECT</label>
													</div>
													<div class="mg-group pull-right">
														<a href="#">EDIT</a>
														<button class="dropdown-toggle mg-toggle" type="button" data-toggle="dropdown">
															<i class="fa fa-caret-up"></i>
														</button>
														<ul class="dropdown-menu mg-menu" role="menu">
															<li><a href="#"><i class="fa fa-download"></i> Download</a></li>
															<li><a href="#"><i class="fa fa-trash-o"></i> Delete</a></li>
														</ul>
													</div>
												</div>
											</div>
										</div>
										<h5 class="mg-title bk-fg-danger">Hapiness<small>.png</small></h5>
										<div class="mg-description">
											<small class="pull-left text-muted bk-fg-warning">Websites</small>
											<small class="pull-right text-muted bk-fg-primary">14/10/2014</small>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>		   
				</div>
				<!-- End Main Page -->
			
			
			</div>
		</div><!--/container-->
		
	</body>
	
</html>