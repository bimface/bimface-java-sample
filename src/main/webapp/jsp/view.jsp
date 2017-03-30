<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>bimface sample</title>
<link rel="shortcut icon" href="http://static.bimface.com/favicon.ico" type="image/x-icon" />
<link rel="icon" href="http://static.bimface.com/favicon.ico" type="image/x-icon" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/reset.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/sample.css">
<script src="<%=request.getContextPath() %>/static/js/jquery.js"></script>
<script src="https://static.bimface.com/components/js/bimface/bimface-1.0.js"></script>
</head>
  
<body>

<div class="header">
	<div class="logo">
    	<img src="<%=request.getContextPath() %>/static/images/logo.png" alt="BIMFACE">
	</div>
	<div class="head_desc">示例程序</div>
	<div class="home_page">
		<a href="http://bimface.com" target="_blank">访问BIMFACE官网</a>
	</div>
</div>

<div class="nav">
	<ul>
 		<li>1）上传文件并发起转换</li>
 		<li class="nav-cur">2）预览工程文件</li>
	</ul>
</div>

<div class="model">
	<div class="viewer" id="bimface-viewer"></div>
	<div class="property">
		<div id="element-tips">请在左侧视图中点击构件</div>
		<div id="element-property" class="hide"></div>
	</div>
</div>

<script>
$(function() {
	
    var winHeight;
    if (window.innerHeight) {
        winHeight = window.innerHeight;
    } else if ((document.body) && (document.body.clientHeight)) {
        winHeight = document.body.clientHeight;
    }
    var viewHeight = winHeight - 100;
    
    $('#bimface-viewer').css("height", viewHeight);

    bim = new bimFace({
        debug: true,
        renderType: "bimView",
        renderVersion: "1.0",
        element: $("#bimface-viewer"),
        token: '<%=request.getAttribute("viewToken")%>',
    }).ready(function(viewer) {

        viewer.on('click',
        function(data) {

            $.get("<%=request.getContextPath() %>/property", {
                fileId: '<%=request.getAttribute("fileId")%>',
                elementId: data.elementId
            },
            function(pro) {

                var proJson = $.parseJSON(pro);
                var obj = proJson.properties;
                
                if(obj.length > 0) {
	                var _tableStart = '<div class="property-title">构件属性</div><table class="t"><tr><td>elementId</td><td>' + proJson.elementId + '</td></tr><tr><td>name</td><td>' + proJson.name + '</td></tr>';
	                var _tableEnd = '</table>';
	                var _tableAttr = '';
	                $(obj).each(function() {
	                    _tableAttr += "<tr><th colspan=2>" + this.group + "</th></tr>";
	                    $(this.items).each(function() {
	                        if (this.hasOwnProperty("unit")) {
	                            _tableAttr += "<tr><td>" + this.key + "</td><td>" + this.value + "&nbsp" + this.unit + "</td></tr>";
	                        } else {
	                            _tableAttr += "<tr><td>" + this.key + "</td><td>" + this.value + "</td></tr>";
	                        }
	                    })
	                })
					$('#element-property').html(_tableStart + _tableAttr + _tableEnd);
                } else {
                	$('#element-property').html("<div style='text-align:center; padding:5px'>获取属性失败！</div>");
                }
                
                $('#element-tips').hide();
                $('#element-property').show();
            });
        });
    })
})
</script>
</body>
</html>

