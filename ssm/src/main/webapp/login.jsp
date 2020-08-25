<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF_8">
<title>Abe</title>
<!-- 引入EasyUI的相关css和js文件 -->
<link href="EasyUI/themes/material/easyui.css" rel="stylesheet"
	type="text/css" />
<link href="EasyUI/themes/icon.css" rel="stylesheet" type="text/css" />
<link href="EasyUI/demo.css" rel="stylesheet" type="text/css" />
<script src="EasyUI/jquery.min.js" type="text/javascript"></script>
<script src="EasyUI/jquery.easyui.min.js" type="text/javascript"></script>
</head>

<body>
	<script type="text/javascript">
		function clearForm() {
			$('#userLoginForm').form('clear');
		}

      function checkUserLogin() {
			$("#userLoginForm").form("submit", {
				// 向控制器类UserInfoController中login方法发送请求
				url : 'userinfo/login', 
				success : function(result) {
					var result = eval('(' + result + ')');
					if (result.success == 'true') {
						window.location.href = 'userIndex.jsp';
						$("#userLoginDlg").dialog("close");
					} else {
						$.messager.show({
							title : "Tipes",
							msg : result.message
						});
					}
				}
			});
		}
	</script>
	<div id="userLoginDlg" class="easyui-dialog"
		style="left: 550px; top: 200px;width: 300;height: 200"
		data-options="title:'Platform Login',buttons:'#bb',modal:true">
		<form id="userLoginForm" method="post">
			<table style="margin:20px;font-size: 13;">
				<tr>
					<th >Username:</th>
					<td><input class="easyui-textbox" type="text" id="name"
						name="userName" data-options="required:true" ></input></td>
				</tr>
				<tr>
					<th>Password:</th>
					<td><input class="easyui-textbox" type="password" id="pwd"
						name="password" data-options="required:true" ></input></td>
				</tr>
			</table>
		</form>
	</div>
	<div id="bb">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			onclick="checkUserLogin()">login</a> <a href="javascript:void(0)"
			class="easyui-linkbutton" onclick="clearForm();">reset</a>
	</div>

</body>
</html>