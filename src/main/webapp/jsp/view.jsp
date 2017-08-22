<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>sample</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/sample.css">
<!-- 引用BIMFACE的JavaScript显示组件库 -->
<script src="https://static.bimface.com/api/BimfaceSDKLoader/BimfaceSDKLoader@latest-release.js" charset="utf-8"></script>
</head>
  
<body>
<div class="header">BIMFACE简单示例</div>
<div class="tips">第二步：调用服务端API获取ViewToken，并对接JS显示组件打开模型</div>
<div class="box">
	<div class="viewer" id="domId"></div>
</div>
<div class="tips"><a href="<%=request.getContextPath() %>/upload">重新上传</a></div>
<script type="text/javascript">

	// 指定待显示的模型或图纸（viewToken从服务端获取）
	var viewToken = '<%=request.getAttribute("viewToken")%>';
	
	// 初始化显示组件
	var options = new BimfaceSDKLoaderConfig();
	options.viewToken = viewToken;
	BimfaceSDKLoader.load(options, successCallback, failureCallback);
	
	function successCallback(viewMetaData) {
		// 创建WebApplication，直接显示模型或图纸
		var dom4Show = document.getElementById('domId');
		new Glodon.Bimface.Application.WebApplicationDemo(viewMetaData, dom4Show); 
	}
	
	function failureCallback(error) {
		console.log(error);
	};
</script>
</body>
</html>


