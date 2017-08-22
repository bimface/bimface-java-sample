<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>sample</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/static/css/sample.css">
<script src="<%=request.getContextPath() %>/static/js/jquery.js"></script>
<script src="<%=request.getContextPath() %>/static/js/plupload.full.min.js"></script>
</head>
  
<body>
<div class="header">BIMFACE简单示例</div>
<div class="tips">第一步：调用服务端API上传文件，并发起转换</div>
<div class="box">

	<div class="upload-file">
		<div class="upload-button" id="pickfiles">选择文件</div>
		<div class="upload-desc">
			格式：rvt、rfa、dwg、skp、nwc、nwd、ifc、3ds、dwf <br/>
			大小：500M
		</div>
	</div>
	
	<div class="result hide" id="wait-box">
		<img src="<%=request.getContextPath() %>/static/images/timg.gif"><br />
		正在转换，请稍等...
	</div>
	
	<div class="result hide" id="translate-error-box">
		<img src="<%=request.getContextPath() %>/static/images/error.jpg"><br />
		转换失败，请<a href="<%=request.getContextPath() %>/upload">重新上传</a>
	</div>
	
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
function getStatus(fileId) {
	timer = setInterval(function() {
		$.get('<%=request.getContextPath() %>/pull?fileId='+ fileId,function(res){
			var re = $.parseJSON(res);
			if(re.status == 'success') {
				location.href="<%=request.getContextPath() %>/view?fileId="+fileId;
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