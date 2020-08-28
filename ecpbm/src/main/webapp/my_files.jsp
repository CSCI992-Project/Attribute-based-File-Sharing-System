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
<title>My Files</title>
</head>
<body>
	<!-- 创建一个table -->
	<table id="myfileDg" class="easyui-datagrid"></table>
	
	
	<!-- 创建搜索栏 -->
	<div id="searchMyFileTb" style="padding:4px 3px;">
		<form id="searchMyFileForm">
			<div style="padding:3px ">
				File Title:&nbsp;&nbsp;<input class="easyui-textbox" name="search_title"
					id="search_title" style="width:110px" /><a href="javascript:void(0)"
					class="easyui-linkbutton" iconCls="icon-search" plain="true"
					onclick="searchMyFileInfo();">search</a>
			</div>			
		</form>
		
		<a href="javascript:void(0)"
					class="easyui-linkbutton" iconCls="icon-redo" plain="true"
					onclick="upLoadFile();">Upload File</a>
	</div>
	
	<div hidden ="true">
		<div id="fileUpload">
			<form id="fileUploadFm" class="easyui-form" method="POST">
				<div class="table-responsive" padding-left: 20%>
					<tr>
						<br/>
						<td style="border:none; padding-left:50;">
						Title:
						<input type="text" name="title">
						</td>
						<br/><br/>
						
						<td style="border:none; padding-left:10;">
						Description:
						<input type="text" name="desc">
						</td>
						<br/><br/>
						<td style="border:none; padding-left:10;">
						Set file property:
						</td>
						<br/><br/>
						
						<td style="border:none; padding-left:10;">
						Region:
						<input type="text" name="region">
						</td>
						<br/><br/>
						
						<td style="border:none; padding-left:10;">
						Position:
						<input type="text" name="position">
						</td>
						<br/><br/>
						
						<td style="border:none; padding-left:10;">
						Grade:
						<input type="text" name="grade">
						</td>
						<br/><br/>
						
						<td style="border:none; padding-left:10;">
						Major:
						<input type="text" name="major">
						</td>
						<br/><br/>
						
						<td style="border:none; padding-left:10;">
						Subject Code:
						<input type="text" name="subjectCode">
						</td>
						<br/><br/>
						
						<td style="border:none; padding-left:10;">
						File Path:
						<input type="text" name="filePath">
						</td>
						<br/><br/>
					</tr>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			$('#myfileDg').datagrid({
				singleSelect : false,
				url : 'fileinfo/listmyfile',
				queryParams : {}, //查询条件
				pagination : true, //启用分页
				pageSize : 5, //设置初始每页记录数（页大小）
				pageList : [ 5, 10, 15 ], //设置可供选择的页大小
				rownumbers : true, //显示行号
				fit : true, //设置自适应
				toolbar : '#myFileListTb', //为datagrid添加工具栏
				header : '#searchMyFileTb', //为datagrid标头添加搜索栏
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
		
		function searchMyFileInfo() {
			var title = $('#search_title').textbox("getValue");
			$('#myfileDg').datagrid('load', {
				title : title
			});
		}
		
		function upLoadFile(){

	        $('#fileUpload').dialog({
	            title:'Upload File',
	            width: 550,
	            height: 900,
	            cache: false,
	            modal:true,
	            closed:true,
	            buttons:[{
	                text : 'submit',
	                handler : function(){
	                    //$('#fileUpload').dialog('close');
	                }
	            }],
	            });
	            $('#fileUpload').dialog('open');
	   	}
	</script>
</body>
</html>