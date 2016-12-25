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
				<a href="foodServlet?method=forwardPage&page=boss&ht=ht"
					class="navbar-brand">山水餐厅</a>
			</div>
			<div class="collapse navbar-collapse" id="top-navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="bossServlet?method=foodManager&ht=ht"><span
							class="glyphicon glyphicon-cutlery"></span>食物管理</a></li>
					<li class="active"><a
						href="bossServlet?method=userManager&ht=ht"> <span
							class="glyphicon glyphicon-user"></span>用户管理
					</a></li>
					<li><a href="bossServlet?method=checkTrade&ht=ht"> <span
							class="glyphicon glyphicon-list-alt"></span>核对账单
					</a></li>
					<li><a href="foodServlet?method=forwardPage&page=createQrcode">
							<span class="glyphicon glyphicon-qrcode"></span>桌码生成
					</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a
						href="foodServlet?method=forwardPage&page=htlogin&ht=ht"><span
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
		<c:if test="${requestScope.errors!=null }">
			<div class="row">
				<div
					class="col-xs-10 col-xs-offset-1 alert alert-danger alert-dismissable text-center">
					<button type="button" class="close" data-dismiss="alert"
						aria-hidden="true">&times;</button>
					<label class="control-label" for="inputError">${requestScope.errors }</label>
				</div>
			</div>
		</c:if>
		<c:if test="${requestScope.success!=null }">
			<div class="row">
				<div
					class="col-xs-10 col-xs-offset-1 alert alert-success alert-dismissable text-center">
					<button type="button" class="close" data-dismiss="alert"
						aria-hidden="true">&times;</button>
					<label class="control-label" for="inputError">${requestScope.success }</label>
					<a href="bossServlet?method=userManager&ht=ht" class="btn btn-info">返回查看</a>
				</div>
			</div>
		</c:if>
		<div class="row col-xs-10 col-xs-offset-1">
			<br>
			<form class="form-horizontal" role="form"
				action="bossServlet?method=updateUser&ht=ht&userId=${requestScope.user.userId }"
				method="post">
				<div class="form-group">
					<label for="foodName" class="col-sm-2 control-label">用户名</label>
					<div class="col-sm-10 input-group">
						<div class="input-group-addon">
							<span class="glyphicon glyphicon-user"></span>
						</div>
						<input type="text" class="form-control" id="username"
							name="username" value="${requestScope.user.username }">
					</div>
				</div>
				<div class="form-group">
					<label for="price" class="col-sm-2 control-label">密码</label>
					<div class="col-sm-10 input-group">
						<div class="input-group-addon">
							<span class="glyphicon glyphicon-lock"></span>
						</div>
						<input type="text" class="form-control" id="password"
							name="password" value="${requestScope.user.password }">
					</div>
				</div>
				<div class="form-group">
					<label for="price" class="col-sm-2 control-label">身份</label>
					<div class="col-sm-10 input-group">
						<div class="input-group-addon">
							<span class="glyphicon glyphicon-star"></span>
						</div>
						<select class="form-control" id="access" name="access"
							role="${requestScope.user.access }">
							<option class="form-control" value="0">老板</option>
							<option class="form-control" value="-1">收银员</option>
							<option class="form-control" value="1">服务员</option>
						</select>
					</div>
				</div>
				<div class="form-group" id="fuze" hidden="true">
					<label for="price" class="col-sm-2 control-label">辖区</label>
					<div class="col-sm-10 input-group">
						<div class="input-group-addon">
							<span class="glyphicon glyphicon-flag"></span>
						</div>
						<input type="text" class="form-control" id="access2"
							name="access2" value="${requestScope.user.access }">
						<div class="input-group-addon">
							<span id="accessSpan">组: ${requestScope.user.access*4 - 3 }-${requestScope.user.access*4 }号桌</span>
						</div>
					</div>
				</div>
				<div class="form-group col-sm-push-2 col-sm-10">
					<div class="btn-group btn-group-justified">
						<div class="btn-group">
							<button type="submit" class="btn btn-primary">
								<span class="glyphicon glyphicon-pencil"></span>修改
							</button>
						</div>
						<div class="btn-group">
							<button type="reset" class="btn btn-primary">
								<span class="glyphicon glyphicon-refresh"></span>重置
							</button>
						</div>
						<a href="bossServlet?method=userManager&ht=ht"
							class="btn btn-primary"><span
							class="glyphicon glyphicon-share-alt"></span>返回</a>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
<script src="script/jquery-3.1.0.min.js"></script>
<script src="script/bootstrap.min.js"></script>
<script>
	$(function() {
		var ac = $("#access").attr("role");
		if (ac > 0) {
			$("#access").val(1);
			$("#fuze").show();
		} else if (ac == -1) {
			$("#access2").val(1)
			$("#access").val(-1);
		} else {
			$("#access2").val(1)
			$("#access").val(0);
		}

		$("#access")
				.change(
						function() {
							if ($("#access").val() > 0) {
								var acv = $("#access2").val();
								$("#accessSpan").text(
										"组: " + (acv * 4 - 3) + "-" + (acv * 4)
												+ "号桌");
								$("#fuze").show();
							} else
								$("#fuze").hide();
						});
		$("#access2")
				.change(
						function() {
							var acv = $("#access2").val();
							if (acv > 0) {
								$("#accessSpan").text(
										"组: " + (acv * 4 - 3) + "-" + (acv * 4)
												+ "号桌");
							}
						});
	});
</script>
</html>