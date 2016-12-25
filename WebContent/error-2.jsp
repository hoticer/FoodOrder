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
}

#my2ma {
	top: 20%;
}
</style>
</head>
<body style="padding: 50px 0px">
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

	<div class="jumbotron text-center">
		<div class="container text-danger">
			<h1>您请求的页面不存在或操作错误!</h1>
			<p>
				<a class="btn btn-info btn-lg"
					href="foodServlet?method=forwardPage&page=htlogin"><span
					class="glyphicon glyphicon-tower"></span>请重新登录 </a>
			</p>
		</div>
	</div>


	<div class="modal fade" id="my2ma" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content" align="center">
				<img src="images/erweima.jpg" class="img-responsive">
			</div>
		</div>
	</div>
</body>
<script src="script/jquery-3.1.0.min.js"></script>
<script src="script/bootstrap.min.js"></script>
</html>