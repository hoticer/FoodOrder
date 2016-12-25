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
				<a href="index.jsp?1=1" class="navbar-brand">山水餐厅</a>
			</div>
			<div class="collapse navbar-collapse" id="top-navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a
						href="foodServlet?method=getFoods&pageNo=${param.pageNo }"> <span
							class="glyphicon glyphicon-home"></span>主页
					</a></li>
					<li class="active"><a
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
				</a> <a class="navbar-brand pull-right" data-toggle="modal"
					data-target="#my2ma" href="javascript:void(0)" id="weixin"><span
					class="glyphicon glyphicon-qrcode"></span> 餐馆公众号</a>
			</div>
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
		<div>
			<table class="table table-responsive">
				<caption class="h3 text-center">
					${sessionScope.tradeId }号订单&nbsp; <small> <c:if
							test="${requestScope.orderTrade.pay == 0 }">
						状态: 未接单
					</c:if> <c:if test="${requestScope.orderTrade.pay == 1 }">
						状态: 已接单
					</c:if> <c:if test="${requestScope.orderTrade.pay == 2 }">
						状态: 已上菜
					</c:if> <c:if test="${requestScope.orderTrade.pay == 3 }">
						状态: 已结账
					</c:if>
					</small>
				</caption>
				<thead>
					<tr>
						<th>商品名</th>
						<th>数量</th>
						<th class="text-right">¥单价</th>
					</tr>
				</thead>
				<tbody>
					<c:set value="0" var="sum"></c:set>
					<c:forEach items="${requestScope.orderTrade.items }" var="item">
						<tr>
							<td>${item.food.foodName }</td>
							<td>${item.quantity }</td>
							<td align="right">¥${item.food.price }</td>
							<c:set value="${sum + item.food.price*item.quantity}" var="sum"></c:set>
						</tr>
					</c:forEach>
					<tr class="success">
						<td colspan="3" align="right">总计:¥${sum }</td>
					</tr>

					<tr>
						<td colspan="3" align="center"><a class="btn btn-primary"
							href="index.jsp?1=1"><span class="glyphicon glyphicon-home"></span>返回主页</a></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
<script src="script/jquery-3.1.0.min.js"></script>
<script src="script/bootstrap.min.js"></script>
<%@ include file="/commons/queryCondition.jsp"%>
</html>