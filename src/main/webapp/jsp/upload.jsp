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
<script src="<%=request.getContextPath() %>/static/js/plupload.full.min.js"></script>
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
 		<li class="nav-cur">1）上传文件并发起转换</li>
 		<li>2）预览工程文件</li>
	</ul>
</div>

<div class="upload-file ">
	<div class="upload-button" id="pickfiles">选择文件</div>
	<div class="upload-desc">
		格式：rvt、rfa、dwg、skp、nwc、nwd、ifc、3ds、dwf <br/>
		大小：500M
	</div>
	<div id="progress"></div>
</div>

<div class="result hide" id="wait-box">
	<img src="<%=request.getContextPath() %>/static/images/timg.gif"><br />
	正在转换，请稍等...
</div>

<div class="result hide" id="translate-error-box">
	<img src="<%=request.getContextPath() %>/static/images/error.jpg"><br />
	转换失败，请<a href="<%=request.getContextPath() %>/upload">重新上传</a>
</div>

<script>
var uploader = new plupload.Uploader({
	
    runtimes : 'html5,flash,silverlight,html4',
    browse_button : 'pickfiles', 
    url : '<%=request.getContextPath() %>/upload',
     
    filters : {
        max_file_size : '500mb',
        mime_types: [
            {title : "files", extensions : "rvt,rfa,dwg,skp,nwc,nwd,ifc,3ds,dwf"}
        ]
    },
 
    flash_swf_url : '<%=request.getContextPath() %>/static/js/Moxie.swf',
    silverlight_xap_url : '<%=request.getContextPath() %>/static/js/Moxie.xap',
 
    init: {
    	
        FilesAdded: function(up, files) {
        	uploader.start();
            return false;
        },
 
        UploadProgress: function(up, file) {
        	$("#pickfiles").html(file.percent-1 + '%');
        },
        
        FileUploaded : function(up, file, info) {
        	var fileId = $.parseJSON(info.response).fileId;
        	getStatus(fileId);
        	
        	$('.upload-file').hide();
        	$('#wait-box').show();
		}, 
 
        Error: function(up, err) {
        }
    }
});
uploader.init();

var timer;
function getStatus(val) {
	timer = setInterval(function() {
		$.get('<%=request.getContextPath() %>/pull?fileId='+ val,function(res){
			var re = $.parseJSON(res);
			if(re.status == 'success') {
				location.href="<%=request.getContextPath() %>/view?fileId="+val;
	  			clearInterval(timer);
	  		} else if(re.status == 'failed'){
	        	$('#wait-box').hide();
	        	$('#translate-error-box').show();
	  			clearInterval(timer);
	  		}
		})
	}, 1000);
}
</script>
</body>
</html>