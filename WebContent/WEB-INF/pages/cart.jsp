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
			<table class="table">
				<caption class="h3 text-center">购物车${sessionScope.tableNum }</caption>
				<thead>
					<tr>
						<th>商品名</th>
						<th>数量</th>
						<th>单价</th>
						<th>&nbsp;</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${sessionScope.ShoppingCart.items }" var="item">
						<tr>
							<td>${item.food.foodName }</td>
							<td>
								<button class="subN btn btn-info btn-sm">-</button> <input
								class="${item.quantity }+${item.food.storeNumber }" type="text"
								size="1" name="${item.food.foodId }" value="${item.quantity }">
								<button class="addN btn btn-info btn-sm">+</button>
							</td>
							<td>¥${item.food.price }</td>
							<td><a
								href="foodServlet?method=remove&pageNo=${param.pageNo }&foodId=${item.food.foodId }"
								class="delete"><span class="glyphicon glyphicon-trash"></span></a></td>
						</tr>
					</c:forEach>
					<tr class="success">
						<td>总计:</td>
						<td id="foodNumber">${sessionScope.ShoppingCart.foodNumber }</td>
						<td id="totalMoney">¥${sessionScope.ShoppingCart.totalMoney }</td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						<td colspan="4" align="center"><a class="btn btn-primary"
							href="foodServlet?method=getFoods&pageNo=${param.pageNo }"><span
								class="glyphicon glyphicon-share-alt"></span>继续购物</a> &nbsp;&nbsp; <a
							class="btn btn-primary" href="foodServlet?method=clear"><span
								class="glyphicon glyphicon-remove"></span>清空购物车</a> &nbsp;&nbsp;
							<a class="btn btn-primary"
							href="foodServlet?method=order&tableNum=${sessionScope.tableNum }"><span
								class="glyphicon glyphicon-arrow-down"></span>下单</a></td>
					</tr>

				</tbody>
			</table>
		</div>
	</div>
</body>
<script src="script/jquery-3.1.0.min.js"></script>
<script src="script/bootstrap.min.js"></script>
<%@ include file="/commons/queryCondition.jsp"%>
<script>
	$(function() {
		//删除食物
		$(".delete").click(function() {
			var $tr = $(this).parent().parent();
			var foodName = $.trim($tr.find("td:first").text());
			var flag = confirm("确定要删除" + foodName + "的信息吗?");

			if (flag)
				return true;
			window.location.href = window.location.href;
			return false;
		});

		//食物数量-1
		$(".subN").click(function() {
			var inp = $(this).siblings(":text");
			var quantityVal = $.trim(inp[0].value);
			var fl = false;
			var quantity = parseInt(quantityVal) - 1;
			var strs = inp.attr("class").split("+");
			var stN = parseInt(strs[1]);
			if (quantity >= 0) {
				fl = true;
				inp.val(quantity);
			}
			if (!fl) {
				return;
			}

			var $tr = $(this).parent().parent();
			var foodName = $.trim($tr.find("td:first").text());
			if (quantity == 0) {
				var flag2 = confirm("确定要删除" + foodName + "吗?");
				if (flag2) {
					//得到了 a 节点
					var $a = $tr.find("td:last").find("a");
					//执行 a 节点的 onclick 响应函数. 
					$a[0].onclick();

					return;
				}
				inp.val(strs[0]);
				return;
			}

			$(this).siblings(".addN").removeClass("disabled");

			var url = "foodServlet";
			var idVal = $.trim(inp[0].name);
			var args = {
				"method" : "updateItemQuantity",
				"foodId" : idVal,
				"quantity" : quantity
			};

			//更新当前页面的foodNumber和totalMoney
			$.post(url, args, function(data) {
				var foodNumber = data.foodNumber;
				var totalMoney = data.totalMoney;

				$("#totalMoney").text("¥" + totalMoney);
				$("#foodNumber").text(foodNumber);
			}, "JSON");
			var clstr = quantity + "+" + stN;
			inp.attr("class", clstr);
		});

		//食物数量+1
		$(".addN").click(function() {
			var inp = $(this).siblings(":text");
			var quantityVal = $.trim(inp[0].value);
			var fl = false;
			var quantity = parseInt(quantityVal) + 1;
			var strs = inp.attr("class").split("+");
			var stN = parseInt(strs[1]);
			if (stN >= quantity) {
				fl = true;
				inp.val(quantity);
			}
			if (stN == quantity)
				$(this).addClass("disabled");
			if (!fl) {
				return;
			}

			var url = "foodServlet";
			var idVal = $.trim(inp[0].name);
			var args = {
				"method" : "updateItemQuantity",
				"foodId" : idVal,
				"quantity" : quantity
			};

			//更新当前页面的foodNumber和totalMoney
			$.post(url, args, function(data) {
				var foodNumber = data.foodNumber;
				var totalMoney = data.totalMoney;

				$("#totalMoney").text("¥" + totalMoney);
				$("#foodNumber").text(foodNumber);
			}, "JSON");
			var clstr = quantity + "+" + stN;
			inp.attr("class", clstr);
		});

		//修改数量
		$(":text").change(function() {
			var quantityVal = $.trim(this.value);

			var fl = false;
			var reg = /^\d+$/g;
			var quantity = -1;
			var strs = $(this).attr("class").split("+");
			var stN = parseInt(strs[1]);
			if (reg.test(quantityVal)) {
				quantity = parseInt(quantityVal);
				if (quantity >= 0 && stN >= quantity) {
					fl = true;
				}
			}
			if (!fl) {
				alert("输入的数量不合法或者超出库存!");
				$(this).val(strs[0]);
				return;
			}

			var $tr = $(this).parent().parent();
			var foodName = $.trim($tr.find("td:first").text());

			if (quantity == 0) {
				var flag2 = confirm("确定要删除" + foodName + "吗?");
				if (flag2) {
					//得到了 a 节点
					var $a = $tr.find("td:last").find("a");
					//执行 a 节点的 onclick 响应函数. 
					$a[0].onclick();

					return;
				}
				$(this).val(strs[0]);
				return;
			}

			var flag = confirm("确定要修改" + foodName + "的数量吗?");

			if (!flag) {
				$(this).val($(this).attr("class"));
				return;
			}

			if (stN > quantity)
				$(this).siblings(".addN").removeClass("disabled");

			var url = "foodServlet";
			var idVal = $.trim(this.name);
			var args = {
				"method" : "updateItemQuantity",
				"foodId" : idVal,
				"quantity" : quantityVal
			};

			//更新当前页面的foodNumber和totalMoney
			$.post(url, args, function(data) {
				var foodNumber = data.foodNumber;
				var totalMoney = data.totalMoney;

				$("#totalMoney").text("¥" + totalMoney);
				$("#foodNumber").text(foodNumber);
			}, "JSON");
			var clstr = quantity + "+" + stN;
			$(this).attr("class", clstr);
		});
	})
</script>
</html>