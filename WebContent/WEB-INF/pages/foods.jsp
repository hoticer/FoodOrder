<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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

.jumbotron {
	background-image: url("images/jumbotron1.jpg");
	background-repeat: no-repeat;
	background-size: cover;
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
		<div class="container" style="color: white">
			<h1>欢迎光临</h1>
			<h4>这里有各种美食等您品尝</h4>
		</div>
	</div>

	<div class="modal" id="my2ma" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content" align="center">
				<img src="images/erweima.jpg" class="img-responsive">
			</div>
		</div>
	</div>

	<div class="container" id="all">
		<div class="row" id="message">
			<div class="text-center">
				<c:if test="${param.foodName != null }">
					<h4>
						您已经将<span class="text-danger">${param.foodName }</span>放入购物车中 <a
							class="btn btn-success"
							href="foodServlet?method=forwardPage&page=cart&pageNo=${foodpage.pageNo }">查看购物车
						</a>
					</h4>
				</c:if>
				<c:if test="${!empty sessionScope.ShoppingCart.foods }">
					<h4 class="text-info">
						您的购物车中有${sessionScope.ShoppingCart.foodNumber } 个食物</h4>
				</c:if>
				<form class="form-group" action="foodServlet?method=getFoods"
					method="post">
					<label class="control-label">价格区间: </label>
					<div style="display: inline">
						<label class="checkbox-inline"> <input type="radio"
							name="priceArea" id="op1" value="0x10">0~10元
						</label> <label class="checkbox-inline"> <input type="radio"
							name="priceArea" id="op2" value="11x20">11~20元
						</label> <label class="checkbox-inline"> <input type="radio"
							name="priceArea" id="op3" value="21x30">21~30元
						</label> <label class="checkbox-inline"> <input type="radio"
							name="priceArea" id="op4" value="31x1000">30元以上
						</label><label class="checkbox-inline"> <input type="radio"
							name="priceArea" id="op5" value="0x1000">ALL
						</label>
					</div>
					<input class="btn btn-danger" type="submit" value="搜索">
				</form>
			</div>
		</div>
		<c:if test="${empty foodpage.list }">
			<div class="row text-center text-danger">
				<h1>该价格区间没有菜品!</h1>
			</div>
		</c:if>
		<c:if test="${!empty foodpage.list }">
			<div class="row">
				<c:forEach items="${foodpage.list }" var="food">
					<div class="col-xs-12 col-sm-6 col-md-3">
						<div class="thumbnail">
							<a
								href="foodServlet?method=getFood&pageNo=${foodpage.pageNo }&foodId=${food.foodId }">
								<img src="images/food/food${food.foodId }.jpg" alt="图片加载失败">
							</a>
							<div class="caption" align="center">
								<h3>${food.foodName }</h3>
								<div class="row">
									<div class="col-xs-6">
										<h4>价格:${food.price }</h4>
									</div>
									<div class="col-xs-6">
										<h4>库存:${food.storeNumber}</h4>
									</div>
								</div>
								<p class="text-right">
									<c:if test="${food.storeNumber > 0}">
										<a
											href="foodServlet?method=addToCart&pageNo=${foodpage.pageNo }&foodId=${food.foodId }&foodName=${food.foodName }"
											class="btn btn-success"> <span
											class="glyphicon glyphicon-shopping-cart"></span> 加入购物车
										</a>
									</c:if>
									<c:if test="${food.storeNumber <= 0}">
										<button class="btn btn-success" disabled>
											<span class="glyphicon glyphicon-remove-sign"></span> 已售完
										</button>
									</c:if>
								</p>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:if>
	</div>
	<c:if test="${!empty foodpage.list }">
		<div align="center">
			<ul class="pagination pagination-lg" id="pageN">
				<c:if test="${foodpage.hasPrev }">
					<li><a href="foodServlet?method=getFoods&pageNo=1">|&laquo;</a></li>
					<li><a
						href="foodServlet?method=getFoods&pageNo=${foodpage.prevPage }">&laquo;</a></li>
				</c:if>
				<c:if test="${!foodpage.hasPrev }">
					<li class="disabled"><a href="javascript:void(0)">|&laquo;</a></li>
					<li class="disabled"><a href="javascript:void(0)">&laquo;</a></li>
				</c:if>
				<c:forEach begin="1" end="5" var="i">
					<c:if
						test="${foodpage.totalPageNumber <= 5 && foodpage.totalPageNumber >= i }">
						<li id="p${i}"><a
							href="foodServlet?method=getFoods&pageNo=${i}">${i }</a></li>

					</c:if>
					<c:if test="${foodpage.totalPageNumber > 5 }">
						<c:if test="${foodpage.totalPageNumber - foodpage.pageNo < 5 }">
							<li id="p${foodpage.totalPageNumber - 5 + i }"><a
								href="foodServlet?method=getFoods&pageNo=${foodpage.totalPageNumber - 5 + i }">${foodpage.totalPageNumber - 5 + i }</a></li>
						</c:if>
						<c:if test="${foodpage.totalPageNumber - foodpage.pageNo >= 5 }">
							<c:if test="${foodpage.pageNo % 5 != 0 }">
								<li id="p${fn:substringBefore(foodpage.pageNo/5,'.')*5 + i}"><a
									href="foodServlet?method=getFoods&pageNo=${fn:substringBefore(foodpage.pageNo/5,'.')*5 + i}">${fn:substringBefore(foodpage.pageNo/5,'.')*5 + i}</a></li>
							</c:if>
							<c:if test="${foodpage.pageNo % 5 == 0 }">
								<li id="p${foodpage.pageNo - 3 + i }"><a
									href="foodServlet?method=getFoods&pageNo=${foodpage.pageNo - 3 + i }">${foodpage.pageNo - 3 + i }</a></li>
							</c:if>
						</c:if>
					</c:if>
				</c:forEach>
				<c:if test="${foodpage.hasNext }">
					<li><a
						href="foodServlet?method=getFoods&pageNo=${foodpage.nextPage }">&raquo;</a></li>
					<li><a
						href="foodServlet?method=getFoods&pageNo=${foodpage.totalPageNumber }">&raquo;|</a></li>
				</c:if>
				<c:if test="${!foodpage.hasNext }">
					<li class="disabled"><a href="javascript:void(0)">&raquo;</a></li>
					<li class="disabled"><a href="javascript:void(0)">&raquo;|</a></li>
				</c:if>
			</ul>
		</div>
	</c:if>
</body>
<script src="script/jquery-3.1.0.min.js"></script>
<script src="script/bootstrap.min.js"></script>
<%@ include file="/commons/queryCondition.jsp"%>
<script>
	$(function() {
		//获取当前页码
		var ppnn = "";
		if (getUrlParam("pageNo") == null)
			ppnn = "#p1";
		else
			ppnn = "#p" + getUrlParam("pageNo");
		$("#pageN").find(ppnn).addClass("active");

		//更改价格区间
		var priceArea = $("input:hidden[name='priceArea']").val();
		if (priceArea != null && priceArea != "") {
			if (priceArea == "0x10")
				$("#op1").prop("checked", true);
			if (priceArea == "11x20")
				$("#op2").prop("checked", true);
			if (priceArea == "21x30")
				$("#op3").prop("checked", true);
			if (priceArea == "31x1000")
				$("#op4").prop("checked", true);
			if (priceArea == "0x1000")
				$("#op5").prop("checked", true);
		}else
			$("#op5").prop("checked", true);

	})

	function getUrlParam(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.search.match(reg); //匹配目标参数
		if (r != null)
			return unescape(r[2]);
		return null; //返回参数值
	}
</script>
</html>