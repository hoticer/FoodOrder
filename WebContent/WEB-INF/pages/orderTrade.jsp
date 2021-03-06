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
		<div class="table-responsive">
			<table class="table table-striped table-bordered">
				<c:if test="${!empty requestScope.orderTrade }">
					<caption class="h3 text-center">
						${requestScope.orderTrade.tableId }号桌${requestScope.orderTrade.tradeId }号订单
						&nbsp; <small id="pay_stauts"> <c:if
								test="${requestScope.orderTrade.pay == 1 }">
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
							<th class="text-right">价格</th>
						</tr>
					</thead>
					<tbody>
						<c:set value="0" var="sum"></c:set>
						<c:forEach items="${requestScope.orderTrade.items }" var="item">
							<tr>
								<td>${item.food.foodName }</td>
								<td>${item.quantity }</td>
								<td class="text-right">¥${item.food.price }</td>
								<c:set value="${sum + item.food.price*item.quantity}" var="sum"></c:set>
							</tr>
						</c:forEach>
						<c:if test="${sessionScope.access >0}">
							<tr class="warning">
								<c:if test="${requestScope.orderTrade.pay==1 }">
									<td colspan="3" align="right">总计:¥${sum }
										<button name="${requestScope.orderTrade.tradeId }+1"
											class="btn btn-danger fkbtn">未上菜</button>
									</td>
								</c:if>
								<c:if test="${requestScope.orderTrade.pay==2 }">
									<td colspan="3" align="right">总计:¥${sum }
										<button class="btn btn-primary disabled">已上菜</button>
									</td>
								</c:if>
								<c:if test="${requestScope.orderTrade.pay==3 }">
									<td colspan="3" align="right">总计:¥${sum }
										<button class="btn btn-primary disabled">已结账</button>
									</td>
								</c:if>
							</tr>
						</c:if>
						<c:if test="${sessionScope.access <=0}">
							<tr class="warning">
								<c:if test="${requestScope.orderTrade.pay != 3 }">
									<td colspan="3" align="right">总计:¥${sum }
										<button name="${requestScope.orderTrade.tradeId }+2"
											class="btn btn-danger fkbtn">未结账</button>
									</td>
								</c:if>
								<c:if test="${requestScope.orderTrade.pay==3 }">
									<td colspan="3" align="right">总计:¥${sum }
										<button class="btn btn-primary disabled">已结账</button>
									</td>
								</c:if>
							</tr>
						</c:if>
					</tbody>
				</c:if>
			</table>
		</div>
		<div class="row text-center">
			<a href="userServlet?method=getOrder" class="btn btn-primary"><span
				class="glyphicon glyphicon-home"></span>回到主页</a>
		</div>
	</div>
</body>
<script src="script/jquery-3.1.0.min.js"></script>
<script src="script/bootstrap.min.js"></script>
<script>
	$(function() {
		$(".fkbtn").click(
				function() {
					var clickFlag = confirm("确定改变订单状态?");
					if (!clickFlag)
						return false;

					//1.改变按钮样式
					var strs = this.name.split("+");
					var tradeIdVal = strs[0];
					var payFlag = strs[1];
					if (payFlag == "1") {
						$("#pay_stauts").text("状态: 已上菜");
						$(this).text("已上菜").addClass("disabled").removeClass(
								"btn-danger").addClass("btn-primary");
					}
					if (payFlag == "2") {
						$("#pay_stauts").text("状态: 已结账");
						$(this).text("已结账").addClass("disabled").removeClass(
								"btn-danger").addClass("btn-primary");
					}
					$(this).off();
					
					var url = "userServlet";
					var strs = this.name.split("+");
					var tradeIdVal = strs[0];
					var payFlag = strs[1];
					var args = {
						"method" : "updatePay",
						"tradeId" : tradeIdVal,
						"payFlag" : payFlag
					};

					$.post(url, args);
				});
	});
</script>
</html>