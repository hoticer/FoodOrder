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
					<li class="active"><a href="bossServlet?method=foodManager"><span
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
		<c:if test="${empty foodpage.list }">
			<div class="row text-center text-danger">
				<h1>什么菜都没有,赶快添加吧!</h1>
			</div>
		</c:if>
		<div class="row col-sm-offset-3 col-sm-6">
			<table
				class="table table-striped table-bordered table-condensed table-hover table-responsive">
				<caption class="h3 text-center">
					食物列表<a href="foodServlet?method=forwardPage&page=insertFood"
						class="btn btn-primary btn-lg pull-right btn-sm"><span
						class="glyphicon glyphicon-plus"></span>添加</a>
				</caption>
				<c:if test="${!empty foodpage.list }">
					<thead>
						<tr>
							<th>食物名</th>
							<th>¥价格</th>
							<th>销量</th>
							<th>库存</th>
							<th>简介</th>
							<th>&nbsp;</th>
							<th>&nbsp;</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${foodpage.list }" var="food">
							<tr>
								<td>${food.foodName}</td>
								<td>${food.price}</td>
								<td>${food.salesAmount}</td>
								<td>${food.storeNumber}</td>
								<td><button type="button" class="btn btn-default btn-sm"
										id="popover-show" title="美食详情" data-container="body"
										data-toggle="popover" data-placement="auto left"
										data-trigger="focus" data-content="${food.details }">
										<span class="glyphicon glyphicon-eye-open"></span>
									</button></td>
								<td><a
									href="bossServlet?method=toUpdateFood&foodId=${food.foodId }&pageNo=${param.pageNo }"><span
										class="glyphicon glyphicon-edit"></span></a></td>
								<td><a
									href="bossServlet?method=deleteFood&foodId=${food.foodId }&pageNo=${param.pageNo }"
									class="delete"><span class="glyphicon glyphicon-trash"></span></a></td>
							</tr>
						</c:forEach>
					</tbody>
				</c:if>
			</table>
		</div>
	</div>
	<c:if test="${!empty foodpage.list }">
			<div align="center">
				<ul class="pagination pagination-lg" id="pageN">
					<c:if test="${foodpage.hasPrev }">
						<li><a href="bossServlet?method=foodManager&pageNo=1">|&laquo;</a></li>
						<li><a
							href="bossServlet?method=foodManager&pageNo=${foodpage.prevPage }">&laquo;</a></li>
					</c:if>
					<c:if test="${!foodpage.hasPrev }">
						<li class="disabled"><a href="javascript:void(0)">|&laquo;</a></li>
						<li class="disabled"><a href="javascript:void(0)">&laquo;</a></li>
					</c:if>
					<c:forEach begin="1" end="5" var="i">
						<c:if
							test="${foodpage.totalPageNumber <= 5 && foodpage.totalPageNumber >= i }">
							<li id="p${i}"><a
								href="bossServlet?method=foodManager&pageNo=${i}">${i }</a></li>

						</c:if>
						<c:if test="${foodpage.totalPageNumber > 5 }">
							<c:if test="${foodpage.totalPageNumber - foodpage.pageNo < 5 }">
								<li id="p${foodpage.totalPageNumber - 5 + i }"><a
									href="bossServlet?method=foodManager&pageNo=${foodpage.totalPageNumber - 5 + i }">${foodpage.totalPageNumber - 5 + i }</a></li>
							</c:if>
							<c:if test="${foodpage.totalPageNumber - foodpage.pageNo >= 5 }">
								<c:if test="${foodpage.pageNo % 5 != 0 }">
									<li id="p${fn:substringBefore(foodpage.pageNo/5,'.')*5 + i}"><a
										href="bossServlet?method=foodManager&pageNo=${fn:substringBefore(foodpage.pageNo/5,'.')*5 + i}">${fn:substringBefore(foodpage.pageNo/5,'.')*5 + i}</a></li>
								</c:if>
								<c:if test="${foodpage.pageNo % 5 == 0 }">
									<li id="p${foodpage.pageNo - 3 + i }"><a
										href="bossServlet?method=foodManager&pageNo=${foodpage.pageNo - 3 + i }">${foodpage.pageNo - 3 + i }</a></li>
								</c:if>
							</c:if>
						</c:if>
					</c:forEach>
					<c:if test="${foodpage.hasNext }">
						<li><a
							href="bossServlet?method=foodManager&pageNo=${foodpage.nextPage }">&raquo;</a></li>
						<li><a
							href="bossServlet?method=foodManager&pageNo=${foodpage.totalPageNumber }">&raquo;|</a></li>
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
<script>
	$(function() {
		//启用popover
		$("[data-toggle='popover']").popover();

		var ppnn = "";
		if (getUrlParam("pageNo") == null)
			ppnn = "#p1";
		else
			ppnn = "#p" + getUrlParam("pageNo");
		$("#pageN").find(ppnn).addClass("active");

		$(".delete").click(function() {
			var $tr = $(this).parent().parent();
			var foodName = $.trim($tr.find("td:first").text());
			var flag = confirm("确定要删除" + foodName + "的信息吗?");

			if (flag)
				return true;
			window.location.href = window.location.href;
			return false;
		});
	});
	function getUrlParam(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
		var r = window.location.search.substr(1).match(reg); //匹配目标参数
		if (r != null)
			return unescape(r[2]);
		return null; //返回参数值
	}
</script>
</html>