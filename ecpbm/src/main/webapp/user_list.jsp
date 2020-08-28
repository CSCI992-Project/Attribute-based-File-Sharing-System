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
<title>User List</title>
</head>
<body>
	<!-- 创建一个table -->
	<table id="userListDg" class="easyui-datagrid"></table>
	
	
	<!-- 创建搜索栏 -->
	<div id="searchUserListTb" style="padding:4px 3px;">
		<form id="searchUserListForm">
			<div style="padding:3px ">
				Username:&nbsp;&nbsp;<input class="easyui-textbox" name="search_userName"
					id="search_userName" style="width:110px" /><a href="javascript:void(0)"
					class="easyui-linkbutton" iconCls="icon-search" plain="true"
					onclick="searchUserInfo();">search</a>
			</div>			
		</form>
	</div>
	<script type="text/javascript">
		$(function() {
			$('#userListDg').datagrid({
				singleSelect : false,
				url : 'userinfo/list',
				queryParams : {}, //查询条件
				pagination : true, //启用分页
				pageSize : 5, //设置初始每页记录数（页大小）
				pageList : [ 5, 10, 15 ], //设置可供选择的页大小
				rownumbers : true, //显示行号
				fit : true, //设置自适应
				toolbar : '#userListTb', //为datagrid添加工具栏
				header : '#searchUserListTb', //为datagrid标头添加搜索栏
				columns : [ [ { //编辑datagrid的列
					title : 'id',
					field : 'id',
					align : 'center',
					width : 100
				}, {
					field : 'userName',
					title : 'username',		
					align : 'center',
					width : 100
				}, {
					field : 'userType',
					title : 'usertype',
					align : 'center',
					width : 80
				}, {
					field : 'email',
					title : 'email',
					align : 'center',
					width : 200
				}, {
					field : 'phone',
					title : 'phone',
					align : 'center',
					width : 150
				} , {
					field : 'catagory',
					title : 'catagory',
					align : 'center',
					width : 200
				} , {
					field : 'attribute',
					title : 'attribute',
					align : 'center',
					width : 200
				} , {
					field : 'operation',
					title : 'operation',
					align : 'center',
					width : 150
				} ] ]
			});
		});
		
		var urls;
		var data;
		
		function searchUserInfo() {
			var userName = $('#search_userName').textbox("getValue");
			$('#userListDg').datagrid('load', {
				userName : userName
			});
		}
	</script>
</body>
</html>