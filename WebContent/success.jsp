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
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#top-navbar-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a href="index.jsp?1=1" class="navbar-brand">山水餐厅</a>
			</div>
			<div class="collapse navbar-collapse" id="top-navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a
						href="foodServlet?method=getFoods&pageNo=${param.pageNo }"> <span
							class="glyphicon glyphicon-home"></span>主页
					</a></li>
					<li><a
						href="foodServlet?method=queryTrade&tradeId=${sessionScope.tradeId }">
							<span class="glyphicon glyphicon-list-alt"></span>查询订单
					</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<nav class="navbar navbar-inverse navbar-fixed-bottom"
		role="navigation">
		<div class="container-fluid">
			<div class="navbar-header" style="width: 100%">
				<a class="navbar-brand"
					href="foodServlet?method=goToCart&pageNo=${param.pageNo }"> <span
					class="glyphicon glyphicon-shopping-cart"></span>购物车
				</a><a class="navbar-brand pull-right" data-toggle="modal"
					data-target="#my2ma" href="javascript:void(0)" id="weixin"><span
					class="glyphicon glyphicon-qrcode"></span> 餐馆公众号</a>
			</div>
		</div>
	</nav>
	<div class="jumbotron text-center">
		<div class="container text-danger">
			<h1>下单成功!</h1>
			<h2>订单号:${sessionScope.tradeId } 请牢记!</h2>
			<p>
				<a class="btn btn-info btn-lg"
					href="foodServlet?method=queryTrade&tradeId=${sessionScope.tradeId }"><span
					class="glyphicon glyphicon-list-alt"></span>查看订单</a> <a
					class="btn btn-info btn-lg" href="index.jsp?1=1"><span
					class="glyphicon glyphicon-home"></span>返回主页 </a>
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