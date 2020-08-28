<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	if (session.getAttribute("user") == null)
		response.sendRedirect("/ecpbm/login.jsp");
%>

<html>
<head>

<title>Abe File Sharing System</title>

<link href="EasyUI/themes/default/easyui.css" rel="stylesheet"
	type="text/css" />
<link href="EasyUI/themes/icon.css" rel="stylesheet" type="text/css" />
<link href="EasyUI/demo.css" rel="stylesheet" type="text/css" />
<script src="EasyUI/jquery.min.js" type="text/javascript"></script>
<script src="EasyUI/jquery.easyui.min.js" type="text/javascript"></script>
<script src="EasyUI/easyui-lang-zh_CN.js" type="text/javascript"></script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false"
		style="height: 60px; background: #B3DFDA; padding: 10px">
		<div align="left">
			<div style="font-family: Microsoft YaHei; font-size: 16px;">Attribute based File Sharing System</div>
		</div>
		<div align="right">
			Welcome,，<font color="Red">${sessionScope.user.userName}</font>
		</div>
	</div>
	<div data-options="region:'west',split:true,title:'Menu'"
		style="width: 180px">
		<ul id="tt"></ul>
	</div>
	<div data-options="region:'south',border:false"
		style="height: 50px; background: #A9FACD; padding: 10px; text-align: center">powered
		by University of Wollongong</div>
	<div data-options="region:'center'">
		<div id="tabs" data-options="fit:true" class="easyui-tabs"
			style="width: 500px; height: 250px;"></div>
	</div>
	<script type="text/javascript">
		$('#tt').tree({
			url : 'userinfo/getTree?userid=${sessionScope.user.id}'	
		});
		
		$('#tt').tree({
			onClick : function(node) {
				if ("All Files" == node.text){
					if($('#tabs').tabs('exists', 'All Files')){
						$('#tabs').tabs('select', 'All Files')
					} else {
						$('#tabs').tabs('add', {
							title : node.text,
							href : 'all_files.jsp',
							closable : true
						});
					}
				} else if ("File Upload" == node.text){
					if($('#tabs').tabs('exists', 'File Upload')){
						$('#tabs').tabs('select', 'File Upload')
					} else {
						$('#tabs').tabs('add', {
							title : node.text,
							href : 'file_upload.jsp',
							closable : true
						});
					}
				} else if ("My Files" == node.text){
					if($('#tabs').tabs('exists', 'My Files')){
						$('#tabs').tabs('select', 'My Files')
					} else {
						$('#tabs').tabs('add', {
							title : node.text,
							href : 'my_files.jsp',
							closable : true
						});
					}
				} else if ("User List" == node.text){
					if($('#tabs').tabs('exists', 'User List')){
						$('#tabs').tabs('select', 'User List')
					} else {
						$('#tabs').tabs('add', {
							title : node.text,
							href : 'user_list.jsp',
							closable : true
						});
					}
				} else if ("Log out" == node.text){
					$.ajax({
						url : 'userinfo/logout',
						success : function(data) {
							window.location.href = "login.jsp";
						}
					})
				}
			}
		});
		
	</script>
</body>
</html>
