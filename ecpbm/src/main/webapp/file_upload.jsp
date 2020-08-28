<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	if (session.getAttribute("user") == null)
		response.sendRedirect("/ecpbm/login.jsp");
%>
<html>
<head>
<meta charset="UTF-8">
<title>File Upload</title>
</head>
<body>
<!-- 创建一个table -->
	<table id="fileUploadDg" class="easyui-datagrid"></table>
	
	<div id="fileUpLoadDlg" class="easyui-dialog"
		style="left: 550px; top: 200px;width: 800;height: 1200"
		data-options="title:'Platform Login',buttons:'#bb',modal:true">
		<form id="userLoginForm" method="post">
			<table style="margin:20px;font-size: 13;">
				<tr>
					<th >Username:</th>
					<td><input class="easyui-textbox" type="text" id="userName"
						name="userName" data-options="required:false" value=""></input></td>
				</tr>
				<tr>
					<th>Password:</th>
					<td><input class="easyui-textbox" type="password" id="password"
						name="password" data-options="required:false" value=""></input></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>