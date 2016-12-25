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
				<a href="foodServlet?method=forwardPage&page=boss"
					class="navbar-brand">山水餐厅</a>
			</div>
			<div class="collapse navbar-collapse" id="top-navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a
						href="bossServlet?method=foodManager"><span
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
		<c:if test="${requestScope.errors!=null }">
			<div class="row">
				<div
					class="col-xs-10 col-xs-offset-1 alert alert-danger alert-dismissable text-center">
					<button type="button" class="close" data-dismiss="alert"
						aria-hidden="true">&times;</button>
					<label class="control-label" for="inputError">${requestScope.errors }</label>
				</div>
			</div>
		</c:if>
		<c:if test="${requestScope.success!=null }">
			<div class="row">
				<div
					class="col-xs-10 col-xs-offset-1 alert alert-success alert-dismissable text-center">
					<button type="button" class="close" data-dismiss="alert"
						aria-hidden="true">&times;</button>
					<label class="control-label" for="inputError">${requestScope.success }</label>
					<a
						href="bossServlet?method=foodManager&pageNo=${param.pageNo }"
						class="btn btn-info">返回查看</a>
				</div>
			</div>
		</c:if>
		<div class="row col-xs-10 col-xs-offset-1">
			<br>
			<form class="form-horizontal" role="form"
				action="bossServlet?method=updateFood&foodId=${requestScope.food.foodId }"
				method="post">
				<div class="form-group">
					<label for="foodName" class="col-sm-2 control-label">菜名</label>
					<div class="col-sm-10 input-group">
						<div class="input-group-addon">
							<span class="glyphicon glyphicon-cutlery"></span>
						</div>
						<input type="text" class="form-control" id="foodName"
							name="foodName" value="${requestScope.food.foodName }">
					</div>
				</div>
				<div class="form-group">
					<label for="price" class="col-sm-2 control-label">价格</label>
					<div class="col-sm-10 input-group">
						<div class="input-group-addon">
							<span class="glyphicon">¥</span>
						</div>
						<input type="text" class="form-control" id="price" name="price"
							value="${requestScope.food.price }">
					</div>
				</div>
				<div class="form-group">
					<label for="storeNumber" class="col-sm-2 control-label">库存</label>
					<div class="col-sm-10 input-group">
						<div class="input-group-addon">
							<span class="glyphicon glyphicon-inbox"></span>
						</div>
						<input type="text" class="form-control" id="storeNumber"
							name="storeNumber" value="${requestScope.food.storeNumber }">
					</div>
				</div>
				<div class="form-group">
					<label for="remark" class="col-sm-2 control-label">简介</label>
					<div class="col-sm-10 input-group">
						<div class="input-group-addon">
							<span class="glyphicon glyphicon-info-sign"></span>
						</div>
						<textarea rows="5" class="form-control" id="details"
							name="details">${requestScope.food.details }</textarea>
					</div>
				</div>
				<div class="form-group col-sm-push-2 col-sm-10">
					<div class="btn-group btn-group-justified">
						<div class="btn-group">
							<button type="submit" class="btn btn-primary">
								<span class="glyphicon glyphicon-pencil"></span>修改
							</button>
						</div>
						<div class="btn-group">
							<button type="reset" class="btn btn-primary">
								<span class="glyphicon glyphicon-refresh"></span>重置
							</button>
						</div>
						<a
							href="bossServlet?method=foodManager&pageNo=${param.pageNo }"
							class="btn btn-primary"><span
							class="glyphicon glyphicon-share-alt"></span>返回</a>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
<script src="script/jquery-3.1.0.min.js"></script>
<script src="script/bootstrap.min.js"></script>
</html>