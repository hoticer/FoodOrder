<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/common.jsp"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="UTF-8">
<meta http-equiv="refresh"
	content="5; url=userServlet?method=getOrder" />
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<link rel="stylesheet" href="css/bootstrap.min.css">
<title>山水餐厅</title>
<style type="text/css">
body {
	background-image: url("images/bg.jpg");
	background-repeat: no-repeat;
	background-size: cover;
	padding-top: 70px;
	padding-bottom: 70px;
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
			<div class="navbar-header" style="width: 100%">
				<a href="userServlet?method=getOrder" class="navbar-brand">山水餐厅</a>
				<a class="navbar-brand pull-right"
					href="foodServlet?method=forwardPage&page=htlogin"><span
					class="glyphicon glyphicon-log-out"></span>注销</a>
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

		<form class="form-horizontal" role="form"
			action="userServlet?method=queryTrade" method="post">
			<div class="input-group col-sm-4 col-sm-offset-4">
				<span class="input-group-addon">订单号：</span> <input type="text"
					class="form-control" id="tradeId" name="tradeId"><span
					class="input-group-btn">
					<button type="submit" class="btn btn-primary">
						<span class="glyphicon glyphicon-search"></span>查询
					</button>
				</span>
			</div>
		</form>
		<c:if test="${sessionScope.access <= 0}">
			<form class="form-horizontal" role="form"
				action="userServlet?method=getTradeWithTableId" method="post">
				<div class="input-group col-sm-4 col-sm-offset-4">
					<span class="input-group-addon">桌号：</span><input type="text"
						class="form-control" id="tableId" name="tableId"><span
						class="input-group-btn">
						<button type="submit" class="btn btn-primary">
							<span class="glyphicon glyphicon-search"></span>查询
						</button>
					</span>
				</div>
			</form>
		</c:if>
		<c:if test="${sessionScope.access > 0}">
			<c:forEach begin="${sessionScope.access * 4 - 3}"
				end="${sessionScope.access * 4}" var="i">
				<div class="col-xs-3 btn btn-primary Center-Container"
					style="height: 20%;">
					<div class="Absolute-Center" style="color: white;"
						onclick="window.location.href = 'userServlet?method=getTradeWithTableId&tableId=${i }';">
						<h5 class="Absolute-Center" style="color: white;"><span class="glyphicon glyphicon-leaf"></span>${i}号桌</h5>
					</div>
				</div>
			</c:forEach>
		</c:if>
		<c:forEach items="${sessionScope.newInfos }" var="newInfo">
			<div class="col-xs-6 col-sm-3">
				<div class="alert alert-danger alert-dismissable text-center">
					<button type="button" class="close" data-dismiss="alert"
						aria-hidden="true">&times;</button>
					<label class="control-label" for="inputError">${newInfo.value }</label>
					<a
						href="userServlet?method=queryTrade&tradeId=${newInfo.key }"
						class="btn btn-danger"><span class="glyphicon glyphicon-file"></span>接单</a>
				</div>
			</div>
		</c:forEach>
	</div>
</body>
<script src="script/jquery-3.1.0.min.js"></script>
<script src="script/bootstrap.min.js"></script>
</html>