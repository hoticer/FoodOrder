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

.Center-Container {
	position: relative;
}

.Absolute-Center {
	width: 100%;
	height: 50%;
	overflow: auto;
	margin: auto;
	position: absolute;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
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
					<li><a href="bossServlet?method=userManager"> <span
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
		<div class="col-xs-6 btn btn-primary Center-Container"
			style="height: 50%;">
			<div class="Absolute-Center" style="color: white;"
				onclick="window.location.href = 'bossServlet?method=foodManager';">
				<h2 class="Absolute-Center" style="color: white;">
					<span class="glyphicon glyphicon-cutlery"></span>食物管理
				</h2>
			</div>
		</div>
		<div class="col-xs-6 btn btn-info Center-Container"
			style="height: 50%;">
			<div class="Absolute-Center" style="color: white;"
				onclick="window.location.href = 'bossServlet?method=userManager';">
				<h2 class="Absolute-Center" style="color: white;">
					<span class="glyphicon glyphicon-user"></span>用户管理
				</h2>
			</div>
		</div>
		<div class="col-xs-6 btn btn-success Center-Container"
			style="height: 50%;">
			<div class="Absolute-Center" style="color: white;"
				onclick="window.location.href = 'bossServlet?method=checkTrade';">
				<h2 class="Absolute-Center" style="color: white;">
					<span class="glyphicon glyphicon-list-alt"></span>核对账单
				</h2>
			</div>
		</div>
		<div class="col-xs-6 btn btn-warning Center-Container"
			style="height: 50%;">
			<div class="Absolute-Center" style="color: white;"
				onclick="window.location.href = 'foodServlet?method=forwardPage&page=createQrcode';">
				<h2 class="Absolute-Center" style="color: white;">
					<span class="glyphicon glyphicon-log-out"></span>桌码生成
				</h2>
			</div>
		</div>
	</div>
</body>
<script src="script/jquery-3.1.0.min.js"></script>
<script src="script/bootstrap.min.js"></script>
</html>