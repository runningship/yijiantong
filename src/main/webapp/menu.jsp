<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
.mm-panel{height:100%;}
</style>
<!-- Sidebar -->
<div class="sidebar">
	<div class="sidebar-collapse">
		<!-- Sidebar Header Logo-->
		<div class="sidebar-header" style="display:none;">
			<img src="/yijiantong/assets/img/logo3.1.png" class="img-responsive" alt="" />
		</div>
		<!-- Sidebar Menu-->
		<div class="sidebar-menu">						
			<nav id="menu" class="nav-main" role="navigation">
				<ul class="nav nav-sidebar">
					<div class="panel-body text-center">								
						<div class="bk-avatar">
							<img src="/yijiantong/assets/img/avatar.jpg" class="img-circle bk-img-60" alt="" />
						</div>
						<div class="bk-padding-top-10">
							<i class="fa fa-circle text-success"></i> <small>管理员</small>
						</div>
					</div>
					<div class="divider2"></div>
					<li class="">
						<a href="/yijiantong/index.jsp">
							<i class="fa fa-laptop" aria-hidden="true"></i><span>首页</span>
						</a>
					</li>
					<li class="nav-parent">
						<a>
							<i class="fa fa-copy" aria-hidden="true"></i><span>信息管理</span>
						</a>
						<ul class="nav nav-children">
							<li><a href="/yijiantong/article/add.jsp"><span class="text"> 发布文章</span></a></li>
							<li><a href="/yijiantong/article/list.jsp"><span class="text"> 文章列表</span></a></li>										
						</ul>
					</li>
					<li class="nav-parent">
						<a>
							<i class="fa fa-list-alt" aria-hidden="true"></i><span>用户管理</span>
						</a>
						<ul class="nav nav-children">
							<li><a href="form-elements.html"><span class="text"> 商家列表</span></a></li>
							<li><a href="form-wizard.html"><span class="text"> 买家列表</span></a></li>
							<li><a href="form-dropzone.html"><span class="text">个人信息</span></a></li>
						</ul>
					</li>
					<li class="nav-parent">
						<a>
							<i class="fa fa-list-alt" aria-hidden="true"></i><span>商品管理</span>
						</a>
						<ul class="nav nav-children">
							<li><a href="/yijiantong/product/add.jsp"><span class="text"> 添加商品</span></a></li>
							<li><a href="/yijiantong/product/list.jsp"><span class="text"> 商品列表</span></a></li>
						</ul>
					</li>
					<li>
						<a>
							<i class="fa fa-random" aria-hidden="true"></i><span>兑奖统计</span>
						</a>
					</li>
					<li>
						<a href="typography.html">
							<i class="fa fa-font" aria-hidden="true"></i><span>二维码管理</span>
						</a>
					</li>
					<li>
						<a href="typography.html">
							<i class="fa fa-font" aria-hidden="true"></i><span>城市配置</span>
						</a>
					</li>
				</ul>
			</nav>
		</div>
		<!-- End Sidebar Menu-->
	</div>
	<!-- Sidebar Footer-->
	<div class="">	
	</div>
	<!-- End Sidebar Footer-->
</div>
<!-- End Sidebar -->