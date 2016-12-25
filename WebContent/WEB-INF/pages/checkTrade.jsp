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
	padding-top: 70px;
	padding-bottom: 70px;
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
					<li><a href="bossServlet?method=userManager"> <span
							class="glyphicon glyphicon-user"></span>用户管理
					</a></li>
					<li class="active"><a
						href="bossServlet?method=checkTrade"> <span
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

	<a id="top"></a>
	<div class="container" id="all">
		<form role="form" action="bossServlet?method=checkTrade"
			method="post">
			<div class="input-group col-sm-4 col-sm-offset-4">
				<span class="input-group-addon"><span
					class="glyphicon glyphicon-calendar"></span></span> <input id="queryDate"
					type="date" name="queryDate" value="${showDate }"
					class="form-control" /> <span class="input-group-btn">
					<button type="submit" class="btn btn-primary">
						<span class="glyphicon glyphicon-search"></span>查看
					</button>
				</span>
			</div>
		</form>
		<table class="table table-condensed table-responsive">
			<c:set value="0" var="daySum"></c:set>
			<caption id="tcaption" class="text-info text-center">${showDate }的订单记录&nbsp;&nbsp;</caption>
			<tbody>
				<c:forEach items="${trades }" var="trade">
					<tr class="info">
						<c:if test="${!empty trade.items }">
							<td>
								<table class="table table-bordered">
									<tr class="active">
										<th>订单号: ${trade.tradeId }</th>
										<th>下单时间: ${trade.tradeTime }</th>
										<c:if test="${trade.pay == 0 }">
											<th>状态: 未接单</th>
										</c:if>
										<c:if test="${trade.pay == 1 }">
											<th>状态: 已接单</th>
										</c:if>
										<c:if test="${trade.pay == 2 }">
											<th>状态: 已上菜</th>
										</c:if>
										<c:if test="${trade.pay == 3 }">
											<th>状态: 已结账</th>
										</c:if>
									</tr>
									<tr>
										<th>菜名</th>
										<th>价格</th>
										<th>数量</th>
									</tr>
									<c:set value="0" var="sum"></c:set>
									<c:forEach items="${trade.items }" var="item">
										<tr>
											<td>${item.food.foodName }</td>
											<td>¥${item.food.price }</td>
											<td>${item.quantity }份</td>
										</tr>
										<c:set value="${sum + item.food.price*item.quantity}"
											var="sum"></c:set>
									</c:forEach>
									<tr class="warning">
										<c:set value="${sum + daySum}" var="daySum"></c:set>
										<td colspan="3" align="right">总计:¥${sum }</td>
									</tr>
								</table>
							</td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<p id="daySum">当天收入:¥${daySum }</p>
		<c:if test="${!empty trades }">
			<div class="row text-center">
				<a href="bossServlet?method=checkTrade#top"
					class="btn btn-primary"><span
					class="glyphicon glyphicon-circle-arrow-up"></span>返回顶部</a>
			</div>
		</c:if>
	</div>
</body>
<script src="script/jquery-3.1.0.min.js"></script>
<script src="script/bootstrap.min.js"></script>
<script>
	$(function() {
		var ds = $("#daySum").text();
		$("#daySum").text("");
		var ts = $("#tcaption").text();
		ts = ts + ds;
		$("#tcaption").text(ts);
	});
</script>
</html>