该sample包括bimface核心服务中的模型上传、模型转换和模型预览功能。并且可以通过点击构件，查看构件属性。
JDK1.8,Tomcat8.0,Servlet,Maven
使用前提：
在www.bimface.com中注册，获取appkey和appsecret，并且在Config.java这个文件中分别给APP_KEY和 APP_SECRET赋值。
使用方法：
1. 在tomcat中运行
2. 在浏览器中打开http://localhost:8080/bimface-java-sample
3. 上传rfa，rvt等模型文件，上传完成后系统自动进行模型转换。待转换成功后，跳转至模型浏览页面
4. 在模型浏览页面中，单击构件，可以显示构件属性