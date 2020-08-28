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
<title>All Files</title>
</head>
<body>
	<!-- 创建一个table -->
	<table id="fileListDg" class="easyui-datagrid"></table>
	
	
	<!-- 创建搜索栏 -->
	<div id="searchFileListTb" style="padding:4px 3px;">
		<form id="searchFileListForm">
			<div style="padding:3px ">
				File Title:&nbsp;&nbsp;<input class="easyui-textbox" name="search_title"
					id="search_title" style="width:110px" /><a href="javascript:void(0)"
					class="easyui-linkbutton" iconCls="icon-search" plain="true"
					onclick="searchFileInfo();">search</a>
			</div>			
		</form>
	</div>
	<script type="text/javascript">
		$(function() {
			$('#fileListDg').datagrid({
				singleSelect : false,
				url : 'fileinfo/listallfiles',
				queryParams : {}, //查询条件
				pagination : true, //启用分页
				pageSize : 5, //设置初始每页记录数（页大小）
				pageList : [ 5, 10, 15 ], //设置可供选择的页大小
				rownumbers : true, //显示行号
				fit : true, //设置自适应
				toolbar : '#fileListTb', //为datagrid添加工具栏
				header : '#searchFileListTb', //为datagrid标头添加搜索栏
				columns : [ [ { //编辑datagrid的列
					title : 'id',
					field : 'id',
					align : 'center',
					width : 100
				}, {
					field : 'Title',
					title : 'Title',		
					align : 'center',
					width : 400
				}, {
					field : 'desc',
					title : 'describe',
					align : 'center',
					width : 600
				},  {
					field : 'operation',
					title : 'operation',
					align : 'center',
					width : 150
				} ] ]
			});
		});
		
		var urls;
		var data;
		
		function searchFileInfo() {
			var userName = $('#search_title').textbox("getValue");
			$('#fileListDg').datagrid('load', {
				title : title
			});
		}
	</script>
</body>
</html>