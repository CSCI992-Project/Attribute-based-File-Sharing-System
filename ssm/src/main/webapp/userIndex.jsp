<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	if (session.getAttribute("user") == null)
		response.sendRedirect("/ssm/login.jsp");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Attribute based File Sharing System</title>
<link href="EasyUI/themes/material/easyui.css" rel="stylesheet" type="text/css" />
<link href="EasyUI/themes/icon.css" rel="stylesheet" type="text/css" />
<link href="EasyUI/demo.css" rel="stylesheet" type="text/css" />
<script src="EasyUI/jquery.min.js" type="text/javascript"></script>
<script src="EasyUI/jquery.easyui.min.js" type="text/javascript"></script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false"
		style="height: 60px; background: #B3DFDA; padding: 10px">
		<div align="left">
			<div style="font=family: Microsoft YaHei; font-size: 16px;">
			 Attribute based File Sharing System
			</div>
		</div>
		<div align="right">
			Welcome, <font color="Red">${requestScope.user.userName}</font>
		</div>
	</div>
</body>

</html>