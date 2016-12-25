<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/common.jsp"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>山水餐厅</title>
<style type="text/css">
body {
	background-image: url("images/bg.jpg");
	background-repeat: no-repeat;
	background-size: cover;
	padding-top: 50px;
	padding-bottom: 50px;
}

#my2ma {
	top: 20%;
}
</style>
</head>
<body>
	<nav class="navbar navbar-fixed-top navbar-inverse" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#top-navbar-collapse">

					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a href="foodServlet?method=forwardPage&page=boss"
					class="navbar-brand">山水餐厅</a>
			</div>
			<div class="collapse navbar-collapse" id="top-navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="bossServlet?method=foodManager"><span
							class="glyphicon glyphicon-cutlery"></span>食物管理</a></li>
					<li class="active"><a href="bossServlet?method=userManager"> <span
							class="glyphicon glyphicon-user"></span>用户管理
					</a></li>
					<li><a href="bossServlet?method=checkTrade"> <span
							class="glyphicon glyphicon-list-alt"></span>核对账单
					</a></li>
					<li><a href="foodServlet?method=forwardPage&page=createQrcode">
							<span class="glyphicon glyphicon-qrcode"></span>桌码生成
					</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a
						href="foodServlet?method=forwardPage&page=htlogin"><span
							class="glyphicon glyphicon-log-out">注销</span></a></li>
				</ul>
			</div>
		</div>
	</nav>

	<nav class="navbar navbar-inverse navbar-fixed-bottom"
		role="navigation">
		<div class="container-fluid">
			<a class="navbar-brand pull-right" data-toggle="modal"
				data-target="#my2ma" href="javascript:void(0)" id="weixin"><span
				class="glyphicon glyphicon-qrcode"></span> 餐馆公众号</a>
		</div>
	</nav>

	<div class="modal fade" id="my2ma" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content" align="center">
				<img src="images/erweima.jpg" class="img-responsive">
			</div>
		</div>
	</div>

	<div class="container" id="all">
		<div class="row col-sm-offset-3 col-sm-6">
			<table
				class="table table-striped table-bordered table-condensed table-hover table-responsive">
				<caption class="h3 text-center">
					用户列表<a href="foodServlet?method=forwardPage&page=insertUser"
						class="btn btn-primary btn-lg pull-right btn-sm"><span
						class="glyphicon glyphicon-plus"></span>添加</a>
				</caption>
				<thead>
					<tr>
						<th>用户名</th>
						<th>密码</th>
						<th>权限</th>
						<th>&nbsp;</th>
						<th>&nbsp;</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${users }" var="user">
						<tr>
							<td>${user.username }</td>
							<td>${user.password }</td>
							<c:if test="${user.access == 0}">
								<td>老板</td>
							</c:if>
							<c:if test="${user.access == -1}">
								<td>收银员</td>
							</c:if>
							<c:if test="${user.access > 0}">
								<td>服务员</td>
							</c:if>
							<td><a
								href="bossServlet?method=toUpdateUser&userId=${user.userId }"><span
									class="glyphicon glyphicon-edit"></span></a></td>
							<td><a
								href="bossServlet?method=deleteUser&userId=${user.userId }"
								class="delete"><span class="glyphicon glyphicon-trash"></span></a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
<script src="script/jquery-3.1.0.min.js"></script>
<script src="script/bootstrap.min.js"></script>
<script>
	$(function() {
		//启用popover
		$(".delete").click(function() {
			var $tr = $(this).parent().parent();
			var foodName = $.trim($tr.find("td:first").text());
			var flag = confirm("确定要删除" + foodName + "的信息吗?");

			if (flag)
				return true;
			window.location.href = window.location.href;
			return false;
		});
	});
</script>
</html>