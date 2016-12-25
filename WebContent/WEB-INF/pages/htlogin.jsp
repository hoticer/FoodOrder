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

#all {
	position: absolute;
	top: 50px;
	bottom: 50px;
	width: 100%;
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
				<a href="foodServlet?method=forwardPage&page=htlogin"
					class="navbar-brand">山水餐厅</a>
			</div>
		</div>
	</nav>

	<nav class="navbar navbar-inverse navbar-fixed-bottom"
		role="navigation">
		<div class="container">
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
			<div
				class="col-xs-10 col-xs-offset-1 alert alert-danger alert-dismissable text-center">
				<button type="button" class="close" data-dismiss="alert"
					aria-hidden="true">&times;</button>
				<label class="control-label" for="inputError">${requestScope.errors }</label>
			</div>
		</c:if>
		<div class="row col-xs-8 col-xs-offset-2"
			style="position: absolute; top: 15%">

			<form class="form-horizontal" role="form"
				action="userServlet?method=htlogin" method="post">
				<div class="form-group">
					<label for="username" class="col-sm-2 control-label">用户名</label>
					<div class="col-sm-10 input-group">
						<div class="input-group-addon">
							<span class="glyphicon glyphicon-user"></span>
						</div>
						<input type="text" class="form-control" id="username"
							name="username" placeholder="默认用户名:Tom">
					</div>
				</div>
				<div class="form-group">
					<label for="password" class="col-sm-2 control-label">密码</label>
					<div class="col-sm-10 input-group">
						<div class="input-group-addon">
							<span class="glyphicon glyphicon-lock"></span>
						</div>
						<input type="password" class="form-control" id="password"
							name="password" placeholder="默认密码:123">
					</div>
				</div>
				<div class="form-group col-sm-8 col-sm-push-2">
					<label class="checkbox-inline text-default" style="font-size: 20px">
						<input type="radio" name="people" value="op1" checked><strong>员工</strong>
					</label> <label class="checkbox-inline text-default"
						style="font-size: 20px"> <input type="radio" name="people"
						value="op2"><strong>老板</strong>
					</label>
				</div>
				<div class="form-group col-sm-push-2 col-sm-10">
					<div class="btn-group">
							<button type="submit" class="btn btn-primary">
								<span class="glyphicon glyphicon-tower"></span>登录
							</button>
							<button type="reset" class="btn btn-primary">
								<span class="glyphicon glyphicon-refresh"></span>重置
							</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
<script src="script/jquery-3.1.0.min.js"></script>
<script src="script/bootstrap.min.js"></script>
</html>