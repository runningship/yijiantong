<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
.mm-panel{height:100%;}
.avatar{width:100px;}
</style>
<!-- Sidebar -->
<div class="sidebar">
	<div class="sidebar-collapse">
		<!-- Sidebar Header Logo-->
		<div class="sidebar-header" style="display:none;">
			<img src="/assets/img/logo3.1.png" class="img-responsive" alt="" />
		</div>
		<!-- Sidebar Menu-->
		<div class="sidebar-menu">						
			<nav id="menu" class="nav-main" role="navigation">
				<ul class="nav nav-sidebar">
					<div class="panel-body text-center">								
						<div class="bk-avatar">
							<img src="/assets/img/avatar.jpg" class="img-circle avatar bk-img-60" alt="" />
						</div>
						<div class="bk-padding-top-10">
							<i class="fa fa-circle text-success"></i> <small>管理员</small>
						</div>
					</div>
					<div class="divider2"></div>
					<li class="nav-parent">
						<a>
							<i class="fa fa-list-alt" aria-hidden="true"></i><span>新闻管理</span>
						</a>
						<ul class="nav nav-children">
							<li><a href="/article/add.jsp"><span class="text"> 发布新闻</span></a></li>
							<li><a href="/article/list.jsp"><span class="text"> 新闻列表</span></a></li>										
						</ul>
					</li>
					<li class="nav-parent">
						<a>
							<i class="fa fa-user" aria-hidden="true"></i><span>用户管理</span>
						</a>
						<ul class="nav nav-children">
							<li><a href="form-elements.html"><span class="text"> 商家列表</span></a></li>
							<li><a href="form-wizard.html"><span class="text"> 买家列表</span></a></li>
							<li><a href="/user/sys/list.jsp"><span class="text"> 系统用户</span></a></li>
							<li><a href="form-dropzone.html"><span class="text">个人信息</span></a></li>
						</ul>
					</li>
					<li class="nav-parent">
						<a>
							<i class="fa fa-glass" aria-hidden="true"></i><span>产品管理</span>
						</a>
						<ul class="nav nav-children">
							<li><a href="/product/add.jsp"><span class="text"> 添加产品</span></a></li>
							<li><a href="/product/list.jsp"><span class="text"> 产品列表</span></a></li>
							<li><a href="/product/verifyList.jsp"><span class="text"> 校验审核列表</span></a></li>
						</ul>
					</li>
					<li class="nav-parent">
						<a>
							<i class="fa fa-shopping-cart" aria-hidden="true"></i><span>易商城</span>
						</a>
						<ul class="nav nav-children">
							<li><a href="/goods/add.jsp"><span class="text"> 添加商品</span></a></li>
							<li><a href="/goods/list.jsp"><span class="text"> 商品列表</span></a></li>
						</ul>
					</li>
					<li>
						<a>
							<i class="fa fa-align-left" aria-hidden="true"></i><span>兑奖统计</span>
						</a>
					</li>
					
					<li class="nav-parent">
						<a>
							<i class="fa fa-cog" aria-hidden="true"></i><span>系统设置</span>
						</a>
						<ul class="nav nav-children">
							<li><a href="/sys/table/list.jsp"><span class="text"> 表空间管理</span></a></li>
							<li><a href="/sys/conf/list.jsp"><span class="text"> 参数配置</span></a></li>
						</ul>
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