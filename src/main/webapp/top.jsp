<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="navbar" role="navigation">
	<div class="container-fluid container-nav">				
		<!-- Navbar Action -->
		<ul class="nav navbar-nav navbar-actions navbar-left">
			<li class="visible-md visible-lg"><a href="index.html#" id="main-menu-toggle"><i class="fa fa-th-large"></i></a></li>
			<li class="visible-xs visible-sm"><a href="index.html#" id="sidebar-menu"><i class="fa fa-navicon"></i></a></li>			
		</ul>
		<!-- Navbar Right -->
		<div class="navbar-right">
			<!-- Notifications -->
			<ul class="notifications hidden-sm hidden-xs">
				<li>
					<a href="#" class="dropdown-toggle notification-icon" data-toggle="dropdown">
						<i class="fa fa-bell"></i>
						<span class="badge">3</span>
					</a>
					<ul class="dropdown-menu list-group">
						<li class="dropdown-menu-header">
							<strong>Notifications</strong>
							<div class="progress progress-xs  progress-striped active">
								<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;">
									60%
								</div>
							</div>
						</li>
						<li class="list-item">
							<a href="page-inbox.html">
								<div class="pull-left">
								   <i class="fa fa-envelope-o bk-fg-primary"></i>
								</div>
								<div class="media-body clearfix">
									<div>Unread Message</div>
									<h6>You have 10 unread message</h6>
								</div>								
							</a>
						</li>
						<li class="list-item">
							<a href="#">
								<div class="pull-left">
								   <i class="fa fa-cogs bk-fg-primary"></i>
								</div>
								<div class="media-body clearfix">
									<div>New Settings</div>
									<h6>There are new settings available</h6>
								</div>								
							</a>
						</li>
						<li class="list-item">
							<a href="#">
								<div class="pull-left">
								   <i class="fa fa-fire bk-fg-primary"></i>
								</div>
								<div class="media-body clearfix">
									<div>Update</div>
									<h6>There are new updates available</h6>
								</div>								
							</a>
						</li>
						<li class="list-item-last">
							<a href="#">
							  <h6>Unread notifications</h6>
							  <span class="badge">15</span>
						   </a>
						</li>
					</ul>
				</li>
			</ul>
			<!-- End Notifications -->
			<!-- Userbox -->
			<div class="userbox">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">
					<div class="profile-info">
						<span class="name">欢迎您, 叶新舟</span>
					</div>			
					<i class="fa custom-caret"></i>
				</a>
				<div class="dropdown-menu">
					<ul class="list-unstyled">
						<li>
							<a href="page-profile.html"><i class="fa fa-user"></i> 用户资料</a>
						</li>
						<li>
							<a href="#"><i class="fa fa-wrench"></i> 设置</a>
						</li>
						<li>
							<a href="page-login.html"><i class="fa fa-power-off"></i> 退出</a>
						</li>
					</ul>
				</div>						
			</div>
			<!-- End Userbox -->
		</div>
		<!-- End Navbar Right -->
		
		<!-- 这里放内容 -->
	</div>		
</div>