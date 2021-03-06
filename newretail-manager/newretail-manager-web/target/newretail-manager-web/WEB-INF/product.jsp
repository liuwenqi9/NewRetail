<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>商品管理</title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<!-- basic styles -->
	<link href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome.min.css" />
	
		<!--[if IE 7]>
		  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/font-awesome-ie7.min.css" />
		  <![endif]-->
		  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/ui.jqgrid.css" />
		  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/datepicker.css" />
		  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/ace.min.css" />
		<!--[if lte IE 8]>
		  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/ace-ie.min.css" />
		  <![endif]-->
		  <!-- ace settings handler -->
		  <script src="${pageContext.request.contextPath}/assets/js/ace-extra.min.js"></script>
		<!--[if lt IE 9]>
		<script src="${pageContext.request.contextPath}/assets/js/html5shiv.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/respond.min.js"></script>
		<![endif]-->
		<style type="text/css">
			.form-control{height: 28px !important;}
			.addForm{position: relative;display: none;}
			.addForm .tab-content{position: absolute;width: 100%;left: 0;top: 40px;border: 0px;}
			 #myModal .modal-body{padding-bottom: 0;}
			 #myModal .modal-footer{padding:5px 20px;}
			.modal-search{margin-top:-10px;padding-bottom: 10px;}
			.modal-search button{display: inline-block;margin-top:-2px;}
		</style>
	</head>

	<body>
		<!--顶部NAV-->
		<div class="navbar navbar-default" id="navbar">
			<div class="navbar-container" id="navbar-container">
				<!--左侧logo-->
				<div class="navbar-header pull-left">
					<a href="${pageContext.request.contextPath}/#" class="navbar-brand">
						<small>
							<i class="icon-leaf"></i>
							DREAM ABOUT IT
						</small>
					</a>
				</div>
				<!--右侧-->
				<div class="navbar-header pull-right" role="navigation">
					<ul class="nav ace-nav">
						<li class="purple">
							<a data-toggle="dropdown" class="dropdown-toggle" href="${pageContext.request.contextPath}/#">
								<i class="icon-bell-alt icon-animated-bell"></i>
								<span class="badge badge-important">8</span>
							</a>

							<ul class="pull-right dropdown-navbar navbar-pink dropdown-menu dropdown-caret dropdown-close">
								<li class="dropdown-header">
									<i class="icon-warning-sign"></i>
									8 消息
								</li>

								<li>
									<a href="${pageContext.request.contextPath}/#">
										<div class="clearfix">
											<span class="pull-left">
												<i class="btn btn-xs no-hover btn-pink icon-comment"></i>
												未读消息
											</span>
											<span class="pull-right badge badge-info">+12</span>
										</div>
									</a>
								</li>
							</ul>
						</li>

						<li class="light-blue">
							<a data-toggle="dropdown" href="${pageContext.request.contextPath}/#" class="dropdown-toggle">
								<img class="nav-user-photo" src="${pageContext.request.contextPath}/assets/avatars/user.jpg" alt="Jason's Photo" />
								<span class="user-info">
									<small>Welcome</small>
									宋灿
								</span>

								<i class="icon-caret-down"></i>
							</a>

							<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
								<li>
									<a href="${pageContext.request.contextPath}/#">
										<i class="icon-cog"></i>
										系统参数
									</a>
								</li>

								<li>
									<a href="${pageContext.request.contextPath}/#">
										<i class="icon-user"></i>
										个人中心
									</a>
								</li>

								<li class="divider"></li>

								<li>
									<a href="${pageContext.request.contextPath}/#">
										<i class="icon-off"></i>
										登出
									</a>
								</li>
							</ul>
						</li>
					</ul><!-- /.ace-nav -->
				</div>

			</div>
		</div>
		<!--顶部NAV END-->

		<div class="main-container" id="main-container">

			<div class="main-container-inner">
				<a class="menu-toggler" id="menu-toggler" href="${pageContext.request.contextPath}/#">
					<span class="menu-text"></span>
				</a>
				<!--左侧导航-->
				<div class="sidebar" id="sidebar">
					<!--快捷功能区-->
					<div class="sidebar-shortcuts" id="sidebar-shortcuts">
						<div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
							<button class="btn btn-success">
								<i class="icon-signal"></i>
							</button>

							<button class="btn btn-info">
								<i class="icon-pencil"></i>
							</button>

							<button class="btn btn-warning">
								<i class="icon-group"></i>
							</button>

							<button class="btn btn-danger">
								<i class="icon-cogs"></i>
							</button>
						</div>

						<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
							<span class="btn btn-success"></span>

							<span class="btn btn-info"></span>

							<span class="btn btn-warning"></span>

							<span class="btn btn-danger"></span>
						</div>
					</div>
					<!--主菜单-->
					<ul class="nav nav-list">
						<li>
							<a href="${pageContext.request.contextPath}/#" class="dropdown-toggle">
								<i class="icon-desktop"></i>
								<span class="menu-text"> 用户管理 </span>

								<b class="arrow icon-angle-down"></b>
							</a>

							<ul class="submenu">
								<li>
									<a href="${pageContext.request.contextPath}/user_normal">
										<i class="icon-double-angle-right"></i>
										普通用户
									</a>
								</li>

								<li>
									<a href="${pageContext.request.contextPath}/user_business">
										<i class="icon-double-angle-right"></i>
										商家管理
									</a>
								</li>

								<li>
									<a href="${pageContext.request.contextPath}/user_delivery">
										<i class="icon-double-angle-right"></i>
										配送员管理
									</a>
								</li>

								<li>
									<a href="${pageContext.request.contextPath}/user_admin">
										<i class="icon-double-angle-right"></i>
										管理员管理
									</a>
								</li>
							</ul>
						</li>

						<li>
							<a href="${pageContext.request.contextPath}/#" class="dropdown-toggle">
								<i class="icon-desktop"></i>
								<span class="menu-text"> 配送管理 </span>
								<b class="arrow icon-angle-down"></b>
							</a>
							<ul class="submenu">
								<li>
									<a href="${pageContext.request.contextPath}/delivery">
										<i class="icon-double-angle-right"></i>
										配送情况
									</a>
								</li>

								<li>
									<a href="${pageContext.request.contextPath}/deliveryer">
										<i class="icon-double-angle-right"></i>
										配送员
									</a>
								</li>
							</ul>
						</li>

						<li>
							<a href="${pageContext.request.contextPath}/order">
								<i class="icon-text-width"></i>
								<span class="menu-text"> 订单管理 </span>
							</a>
						</li>

						<li class="active">
							<a href="${pageContext.request.contextPath}/product">
								<i class="icon-text-width"></i>
								<span class="menu-text"> 商品管理 </span>
							</a>
						</li>

					</ul>
					<!--收缩键-->
					<div class="sidebar-collapse" id="sidebar-collapse">
						<i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
					</div>
				</div>
				<!--左侧导航 end-->
				<!--主页面-->
				<div class="main-content">
					<!--页面路径-->
					<div class="breadcrumbs" id="breadcrumbs">

						<ul class="breadcrumb">
							<li>
								<i class="icon-home home-icon"></i>
								<a href="${pageContext.request.contextPath}/#">首页</a>
							</li>
							<li class="active">商品管理</li>
						</ul><!-- .breadcrumb -->

						<div class="nav-search" id="nav-search">
							<form class="form-search">
								<span class="input-icon">
									<input type="text" placeholder="Search ..." class="nav-search-input" id="nav-search-input" autocomplete="off" />
									<i class="icon-search nav-search-icon"></i>
								</span>
							</form>
						</div>
					</div>
					<!--页面路径-->
					<!--主页面内容-->
					<div class="page-content">
						<div class="page-header" style="border: 0px;">
							<div style="border-bottom: 1px dotted #e2e2e2;padding: 4px 0;">
							<!--基础按钮-->
								<button class="btn btn-xs btn-info" onclick="page.onTapAdd()">新增</button>
								<button class="btn btn-xs btn-info btn-save" onclick="page.onTapSave()">保存</button>
								<button class="btn btn-xs btn-info" onclick="page.onTapBack()">返回</button>
								<button class="btn btn-xs btn-info" onclick="page.onTapEdit()">编辑</button>
								<button class="btn btn-xs btn-info" onclick="page.onTapDel()">删除</button>
								<button class="btn btn-xs btn-info" onclick="page.onTapSearch()">查询</button>
								<!--page btn-->
								<button class="btn btn-xs btn-info" onclick="page.toPutOn()">上架</button>
								<button class="btn btn-xs btn-info" onclick="page.toPutDown()">下架</button>
							</div>
							<!--新增区-->
							<div class="addForm" id="addForm">
								<ul id="myTab" class="nav nav-tabs">
									<li class="active">
										<a href="${pageContext.request.contextPath}/#home" data-toggle="tab">
											基本信息
										</a>
									</li>
									<li><a href="${pageContext.request.contextPath}/#other" data-toggle="tab">其它信息</a></li>
								</ul>
								<div id="myTabContent" class="tab-content">
									<div class="tab-pane fade in active" id="home">
										<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 ">
											<div class="form-group">
												<label class="col-lg-2 col-md-3 col-sm-3 control-label no-padding-right" for="form-field-1"> 商品名称</label>
												<div class="col-lg-10 col-md-9 col-sm-9">
													<input type="text" id="goods_name" placeholder="请输入商品名称" class="form-control">
												</div>
											</div>
										</div>

										<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 ">
											<div class="form-group">
												<label class="col-lg-2 col-md-3 col-sm-3 control-label no-padding-right" for="form-field-1"> 商品类别</label>
												<div class="col-lg-10 col-md-9 col-sm-9">
													<input type="text" id="goods_type" placeholder="请输入商品类别" class="form-control">
												</div>
											</div>
										</div>
								
										<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 ">
											<div class="form-group">
												<label class="col-lg-2 col-md-3 col-sm-3 control-label no-padding-right" for="form-field-1"> 单价</label>
												<div class="col-lg-10 col-md-9 col-sm-9">
													<input type="text" id="goods_price" placeholder="请输入单价" class="form-control">
												</div>
											</div>
										</div>

										<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 ">
											<div class="form-group">
												<label class="col-lg-2 col-md-3 col-sm-3 control-label no-padding-right" for="form-field-1"> 折扣</label>
												<div class="col-lg-10 col-md-9 col-sm-9">
													<input type="text" id="discount" placeholder="输入折扣" class="form-control">
												</div>
											</div>
										</div>

										<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 ">
											<div class="form-group">
												<label class="col-lg-2 col-md-3 col-sm-3 control-label no-padding-right" for="form-field-1"> 库存</label>
												<div class="col-lg-10 col-md-9 col-sm-9">
													<input type="text" id="stock" placeholder="请输入库存量" class="form-control">
												</div>
											</div>
										</div>
										<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 ">
											<div class="form-group">
												<label class="col-lg-2 col-md-3 col-sm-3 control-label no-padding-right" for="form-field-1"> 商品图片</label>
												<div class="col-lg-10 col-md-9 col-sm-9">
														<div id="preview1">
															<img id="imghead1" border="0" src="assets/css/images/photo_icon.png" width="90" height="90" onclick="$('#preview1Img').click();">
														</div>
														<input type="file" onchange="preview1Image(this)" style="display: none;" id="preview1Img">
												</div>
											</div>
										</div>
									</div>
									<div class="tab-pane fade" id="other">
										
									</div>
								</div>
							</div>
							<!---->
							<div class="searchForm" style="padding: 4px 0;" id="searchForm">
								
								<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 ">
									<div class="form-group">
										<label class="col-lg-4 col-md-4 col-sm-4 control-label no-padding-right" for="form-field-1"> 商品名称</label>
										<div class="col-lg-8 col-md-8 col-sm-8">
											<span class="block input-icon input-icon-right">
												<input type="text" name="ebcuNameCn" class="form-control">
											</span>
										</div>
									</div>
								</div>
								<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12 ">
									<div class="form-group">
										<label class="col-lg-4 col-md-4 col-sm-4 control-label no-padding-right" for="form-field-1"> 单价</label>
										<div class="col-lg-8 col-md-8 col-sm-8">
											<span class="block input-icon input-icon-right">
												<input type="text" name="ebcuNameCn" class="form-control">
											</span>
										</div>
									</div>
								</div>
							
								<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
									<div class="form-group">
										<label class="col-lg-4 col-md-4 col-sm-4 control-label no-padding-right" for="form-field-1"> 类别</label>
										<div class="col-lg-8 col-md-8 col-sm-8">
											<select class="form-control" id="form-field-select-1">
												<option value="">&nbsp;</option>
												<option value="AL">已下单</option>
												<option value="AK">已配送</option>
											</select>
										</div>
									</div>
								</div>

							</div>
						</div><!-- /.page-header -->
						<div class="row" id="mainCon">
							<div class="col-xs-12">
								<table id="grid-table"></table>
								<div id="grid-pager"></div>

							</div>
						</div>
					</div>
					<!--主页面内容 end-->
				</div>

			</div>
			<!--回到顶部-->
			<a href="${pageContext.request.contextPath}/#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
				<i class="icon-double-angle-up icon-only bigger-110"></i>
			</a>
			<!--回到顶部 end-->
		</div><!-- /.main-container -->

		<!--选择弹窗-->
		<!-- 模态框（Modal） -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">
							选择弹窗
						</h4>
					</div>
					<div class="modal-body">
						<div class="modal-search">
							<select class="select-sm">
								<option value="AL">编码</option>
								<option value="AK">名称</option>
							</select>
							<input class="input-sm" type="text"  placeholder="请输入">
							<button class="btn btn-xs btn-info">查询</button>
							<button class="btn btn-xs btn-info">重置</button>
						</div>
						<table id="pop-grid-table" style="width: auto;"></table>
						<div id="pop-grid-pager"></div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消
						</button>
						<button type="button" class="btn btn-primary" onclick="allHandler.onTapChoseRow()">
							确定
						</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal -->
		</div>

		<!-- 详情弹窗 -->
		<div class="modal fade" id="myModalDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
							&times;
						</button>
						<h4 class="modal-title" id="myModalLabel">
							查看详情
						</h4>
					</div>
					<div class="modal-body clearfix">
						<div class="col-lg-6 col-md-6 col-sm-6 align-left" style="padding: 5px 0">
							订单号：<span>e56465</span>
						</div>
						<div class="col-lg-6 col-md-6 col-sm-6 align-right" style="padding: 5px 0">
							订单时间：<span>2017/09/08 12:00</span>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-4 " style="padding: 5px 0">
							支付状态：<span>已支付</span>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-4 " style="padding: 5px 0">
							配送状态：<span>待配送</span>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-4 " style="padding: 5px 0">
							订单状态：<span>待配送</span>
						</div>
						<div class="col-lg-6 col-md-6 col-sm-6 " style="padding: 5px 0">
							收款人：<span>小明</span>
						</div>
						<div class="col-lg-6 col-md-6 col-sm-6" style="padding: 5px 0">
							联系方式：<span>13640568956</span>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12" style="padding: 5px 0">
							收货地址：<span>dsfdfdsdddddddddd</span>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12" style="padding: 5px 0">
							<table class="table table-bordered table-striped" >
								<thead class="thin-border-bottom">
									<tr>
										<th>
											<i class="icon-caret-right blue"></i>
											商品名称
										</th>

										<th>
											<i class="icon-caret-right blue"></i>
											价格
										</th>

										<th>
											<i class="icon-caret-right blue"></i>
											购买数量
										</th>

										<th>
											<i class="icon-caret-right blue"></i>
											总价
										</th>
									</tr>
								</thead>

								<tbody>
									<tr>
										<td>internet.com</td>
										<td>
											<small>
												<s class="red">$29.99</s>
											</small>
											<b class="green">$19.99</b>
										</td>
										<td>
											5
										</td>
										<td>
											100
										</td>
									</tr>

									<tr>
										<td>internet.com</td>
										<td>
											<small>
												<s class="red">$29.99</s>
											</small>
											<b class="green">$19.99</b>
										</td>
										<td>
											5
										</td>
										<td>
											100
										</td>
									</tr>
									<tr>
										<td colspan="4"><span>订单总金额：250</span></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消
						</button>
						<button type="button" class="btn btn-primary" onclick="page.toConfirm(this)">
							确认
						</button>
						<!-- <button type="button" class="btn btn-primary" onclick="page.toEdit()">
							编辑
						</button> -->
						<!-- <button type="button" class="btn btn-primary" onclick="page.save()">
							保存
						</button> -->
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal -->
		</div>

	</body>
	<!-- basic scripts -->
	<script type="text/javascript">
		window.jQuery || document.write("<script src='assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
	</script>

	<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->

<script src="https://www.promisejs.org/polyfills/promise-6.1.0.js"></script>
<script type="text/javascript" src="http://gosspublic.alicdn.com/aliyun-oss-sdk.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/user/imgdisplay.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/layer/layer.js"></script>
<!-- page specific plugin scripts -->
<script src="${pageContext.request.contextPath}/assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jqGrid/jquery.jqGrid.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jqGrid/i18n/grid.locale-en.js"></script>
<!-- ace scripts -->
<script src="${pageContext.request.contextPath}/assets/js/ace.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/allHandler.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/product/product.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/product/product_from.js"></script>
<script type="text/javascript">
	var goods_name =$("#goods_name").val();;
	var goods_photo = document.getElementById('preview1Img').files[0];;
	var goods_discount =$("#discount").val();
	var goods_type = $("#goods_type").val();
	var stock = $("#stock").value;
	var goods_price = $("#goods_type").val();
	$(".btn-save").click(function(){
		saveFrom();
	});
	//用于添加商品提交表单
	function saveFrom(){
		 goods_name =$("#goods_name").val();;
		 goods_photo = document.getElementById('preview1Img').files[0];;
		 goods_discount =$("#discount").val();
		 goods_type = $("#goods_type").val();
		 stock = $("#stock").value;
		 goods_price = $("#goods_price").val();
		 if(goods_name!=''&&goods_photo!=''&&goods_discount!=''&&goods_type!=''&&stock!=''&&goods_price!=''){
			//上传商品图片及提交表单，在product_from.js里面
			applyTokenDo(uploadFile);
			console.log("------提交表单中-----");
		}else{
			console.log("------数据为空-----");
		}	
	}
</script>
</html>

