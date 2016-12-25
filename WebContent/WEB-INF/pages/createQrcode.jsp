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

#my2ma, #tQrcode {
	padding-top: 70px;
	padding-bottom: 70px;
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
					<li><a href="bossServlet?method=checkTrade"> <span
							class="glyphicon glyphicon-list-alt"></span>核对账单
					</a></li>
					<li class="active"><a
						href="foodServlet?method=forwardPage&page=createQrcode"> <span
							class="glyphicon glyphicon-qrcode"></span>桌码生成
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
		<div class="input-group col-sm-4 col-sm-offset-4">
			<span class="input-group-addon">第</span> <input type="text"
				name="tableNum" value="1" class="form-control" id="cQrcode_txt" />
			<span class="input-group-addon">桌二维码</span><span
				class="input-group-btn"> <!-- 
				<button class="btn btn-primary" data-toggle="modal"
					data-target="#tQrcode" id="cQrcode_btn">
					<span class="glyphicon glyphicon-search"></span>开始生成
				</button>
				 -->
				<button class="btn btn-primary" id="cQrcode_btn">
					<span class="glyphicon glyphicon-share"></span>开始生成
				</button>
			</span>
		</div>
	</div>

	<div class="modal fade" id="tQrcode" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content" align="center">
				<img src="" class="img-responsive">
			</div>
		</div>
	</div>

	<div class="modal fade" id="queryWait" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content" align="center">
				<h5>正在生成二维码,请稍等...</h5>
			</div>
		</div>
	</div>
</body>
<script src="script/jquery-3.1.0.min.js"></script>
<script src="script/bootstrap.min.js"></script>
<script>
	$(function() {
		//生成二维码
		$("#cQrcode_btn").click(function() {
			var tN = $.trim($("#cQrcode_txt").val());
			var reg = /^\d+$/g;
			var flag = false;
			var tNum = -1;
			if (reg.test(tN)) {
				tNum = parseInt(tN);
				if (tNum >= 0 && 100 >= tNum)
					flag = true;
			}

			if (!flag) {
				alert("桌号应为小于100的正数!");
				$("#cQrcode_txt").val("1");
				return;
			}

			var url = "bossServlet";
			$("#queryWait").modal("show");
			$.ajax({
				type : 'post',
				url : url,
				data : "method=createQrcode&tableNum=" + tN,
				async : false,
				success : function(msg) {
					$("#queryWait").modal("hide");
				}
			});
			var imgSrc = "images/qrcode/table" + tN + ".png";
			$("#tQrcode").find("img")[0].src = imgSrc;
			$("#tQrcode").modal("show");
		});

		//隐藏显示的二维码
		$("#tQrcode").click(function() {
			$(this).modal("hide");
		});
	});
</script>
</html>