<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	if (session.getAttribute("user") == null)
		response.sendRedirect("/ecpbm/login.jsp");
%>
//<script src="js/jquery-2.1.0.js" type="text/javascript"></script>
//<script src="js/ajaxfileupload.js" type="text/javascript"></script>
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
	
	<!-- 添加信息对话框 -->
	<div id="dlg_addFile" class="easyui-dialog" title="File Information"
		closed="true" style="width: 500px;">
		<div style="padding: 10px 60px 20px 60px">
			<form id="ff_addfileinfo" method="POST" action=""
				enctype="multipart/form-data">
				<table cellpadding="5">
					<tr>
						<td>Title</td>
						<td><input class="easyui-textbox" type="text" id="file_title"
							name="file_title" data-options="required:true"></input></td>
					</tr>
					<tr>
						<td>Describe:</td>
						<td><textarea id="file_describe" name="file_describe" style="width:173px; height:100px;"></textarea>
						</td>
					</tr>
					<tr>
						<td>College:</td>
						<td><select id="category_new" 
							name="category_id" style="width: 173px;" 
							>
							<option>please select</option></select>
							</td>
					</tr>
					<tr style="display:none">
						<td>User Id:</td>
						<td><input type="text" id="user_id" name="user_id" value="${sessionScope.user.id}" ></input>
						</td>
					</tr>
					<tr>
						<td>Subject:</td>
						<td><select id="attribute_new"
							name="attribute_id" style="width: 173px;"
							>
							<option>select college first</option></select></td>
					</tr>
					<tr>
						<td>File path</td>
						<td><input class="easyui-filebox" id="file"
							name="file" value="uploadfile"></input></td>
							<!-- <td><a href="javascript:uploadFile2Server()" class="easyui-linkbutton">Upload</a></td> -->
					</tr>					
				</table>
			</form>
			<div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton"
					onclick="saveFileInfo();">save</a> <a href="javascript:void(0)"
					class="easyui-linkbutton" onclick="clearForm();">clear</a>
			</div>
		</div>
	</div>
	
	<!-- 修改信息对话框 -->
	<div id="dlg_updateFile" class="easyui-dialog" title="File Information"
		closed="true" style="width: 500px;">
		<div style="padding: 10px 60px 20px 60px">
			<form id="ff_updatefileinfo" method="POST" action=""
				enctype="multipart/form-data">
				<table cellpadding="5">
					<tr style="display:none">
						<td>File id</td>
						<td><input class="easyui-textbox" type="text" id="file_id"
							name="file_id" data-options="required:true"></input></td>
					</tr>
					<tr>
						<td>Title</td>
						<td><input class="easyui-textbox" type="text" id="file_title"
							name="file_title" data-options="required:true"></input></td>
					</tr>
					<tr>
						<td>Describe:</td>
						<td><textarea id="file_describe" name="file_describe" style="width:173px; height:100px;"></textarea>
						</td>
					</tr>
					<tr>
						<td>College:</td>
						<td><select id="category" 
							name="category_id" style="width: 173px;" 
							>
							<option>please select</option></select>
							</td>
					</tr>
					<tr style="display:none">
						<td>User Id:</td>
						<td><input type="text" id="user_id" name="user_id" value="${sessionScope.user.id}" ></input>
						</td>
					</tr>
					<tr>
						<td>Subject:</td>
						<td><select id="attribute"
							name="attribute_id" style="width: 173px;"
							>
							<option>select college first</option></select></td>
					</tr>
					<tr>
						<td>File path</td>
						<td><input class="easyui-textbox" type="text" id="file_path"
							name="file_path" data-options="required:true"></input></td>
					</tr>					
				</table>
			</form>
			<div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton"
					onclick="updateFileInfo();">save</a> <a href="javascript:void(0)"
					class="easyui-linkbutton" onclick="clearForm();">clear</a>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			$('#myfileDg').datagrid({
				singleSelect : false,
				url : 'fileinfo/listmyfiles?userid=${sessionScope.user.id}',
				queryParams : {}, //查询条件
				pagination : true, //启用分页
				pageSize : 5, //设置初始每页记录数（页大小）
				pageList : [ 5, 10, 15 ], //设置可供选择的页大小
				rownumbers : true, //显示行号
				fit : true, //设置自适应
				toolbar : '#myFileListTb', //为datagrid添加工具栏
				header : '#searchMyFileTb', //为datagrid标头添加搜索栏
				onLoadSuccess: function () {
					  $('.download').linkbutton({ text: 'Download', plain: true, iconCls: 'icon-save' });
					  $('.detail').linkbutton({ text: 'Detail', plain: true, iconCls: 'icon-edit' }),
			          $('.delete').linkbutton({ text: 'Delete', plain: true, iconCls: 'icon-no' });
			       },
				columns : [ [ { //编辑datagrid的列
					title : 'id',
					field : 'file_id',
					align : 'center',
					width : 50
				}, {
					field : 'file_title',
					title : 'Title',		
					align : 'center',
					width : 300
				}, {
					field : 'file_describe',
					title : 'describe',
					align : 'center',
					width : 503
				}, {
					field : 'userName',
					title : 'UpLoader',
					align : 'center',
					width : 150
				}, {
					field : 'category_name',
					title : 'college',
					align : 'center',
					width : 200
				}, {
					field : 'attribute_name',
					title : 'subject',
					align : 'center',
					width : 200
				},  {
					field : 'operation',
					title : 'operation',
					align : 'center',
					width : 300,
					formatter : function(value, row, index) {						
						var str = "";
						
						var dloadFileBtnObj = '<a class="download" onclick="FileTabUtil.dloadFileInfo('+ row.file_id +','+${sessionScope.user.id}+')"></a>';
			            var fileInfoDetail = '<a class="detail" onclick="FileTabUtil.fileInfoDetail('+ row.file_id +','+index+')"></a>';
			            var delFileBtnObj = '<a class="delete" onclick="FileTabUtil.deleteFileInfo('+ row.file_id +')"></a>';
			                    		                    
			            str += fileInfoDetail;
			            str += delFileBtnObj;			            
			            return str;
					}
				} ] ]
			});
		});
		
		FileTabUtil = {
				// download file
				dloadFileInfo : function (id, userid)
				{
					//console.log("clicked download button:", id);
					//console.log(filename);
					window.location.href = "fileinfo/downloadFileinfo?id=" +id + "&userid=" + userid;
					$.messager.show({
						title : 'Tips',
						msg : result.message
					})
					
				},
				// delete user information by user id
				deleteFileInfo : function (id) {
					$.messager.confirm('Confirm', 'Are you sure deleting this file?', function(r) {
						if (r) {
							$.post('fileinfo/deleteFileinfo', {id:id},function(result) {
								if (result.success == 'true') {
									$("#myfileDg").datagrid('reload');
									$.messager.show({
										title : 'Tips',
										msg : result.message
									});
								} else {
									$.messager.show({
										title : 'Tips',
										msg : result.message
									});
								}
							}, 'json');
						}
					});
                    },
                    
                 // update file information
              		fileInfoDetail :function(id,index){
              			//get row data
              			var row = $("#myfileDg").datagrid('getData').rows[index];
    					//url = 'userinfo/updateUserinfo';
    					document.getElementById("category").options.length=0;  //clear select
    					document.getElementById("attribute").options.length=0;  //clear select
              			$("#dlg_updateFile").dialog("open").dialog('setTitle',
    					'Update File Information');
    					$("#ff_updatefileinfo").form("load", {
    						"file_id"	   : row.file_id,
    						"file_title" : row.file_title,
    						"file_describe" : row.file_describe,
    						"user_id" : row.user_id,
    						"file_path" : row.file_path,
    					});

    					//selectd category
    					$.ajax({
    	                contentType : "application/json;charset=utf-8",
    	                type : "POST",
    	                url : "category/getcategory",
    	                dataType : "json",
    	                success : function(data) {

    	                    $.each(data, function(i, categoryList) {
    	                        $('#category').append(
    	                                $('<option>').text(categoryList.category_name).attr('value',
    	                                        categoryList.category_id));
    	                    });
    	                    //设置默认选项
    						$("#category option[value='"+row.category_id+"']").attr("selected","selected"); 
    	                }
    	            });
    				
    					//selectd attribute
    					$.ajax({
    		                contentType : "application/json;charset=utf-8",
    		                type : "POST",
    		                url : "attribute/getattribute?categoryId="+row.category_id,
    		                dataType : "json",
    		                success : function(data) {

    		                    $.each(data, function(i, attributeList) {
    		                        $('#attribute').append(
    		                                $('<option>').text(attributeList.attribute_name).attr('value',
    		                                		attributeList.attribute_id));
    		                    });
    		                    //设置默认选项
    		                    $("#attribute option[value='"+row.attribute_id+"']").attr("selected","selected");
    		                }
    		            }); 
    					
    					//将select改变项目赋值
    					document.getElementById("category").onchange =function(){
    						//console.log(this.options[this.selectedIndex].value);
    						document.getElementById("category").value=this.options[this.selectedIndex].value;	
    					}
    					document.getElementById("attribute").onchange =function(){
    						//console.log(this.options[this.selectedIndex].value);
    						document.getElementById("attribute").value=this.options[this.selectedIndex].value;
    					}
                         }     
		};
		
		function updateFileInfo() {
			$("#ff_updatefileinfo").form("submit", {
				url : 'fileinfo/updateFileinfo', //使用参数				
				success : function(result) {
					var result = eval('(' + result + ')');
					if (result.success == 'true') {
						$("#myfileDg").datagrid("reload"); //refresh user list
						$('#ff_updatefileinfo').form('clear'); //clear the user information form
						$("#dlg_updateFile").dialog("close"); //close the user information panel
					}
					$.messager.show({
						title : "tips",
						msg : result.message
					});
				}
			});
		}
		
		function saveFileInfo() {
			$("#ff_addfileinfo").form("submit", {
				url : 'fileinfo/addFileinfo', //使用参数				
				success : function(result) {
					var result = eval('(' + result + ')');
					if (result.success == 'true') {
						$("#myfileDg").datagrid("reload"); //refresh user list
						$('#ff_addfileinfo').form('clear'); //clear the user information form
						$("#dlg_addFile").dialog("close"); //close the user information panel
					}
					$.messager.show({
						title : "tips",
						msg : result.message
					});
				}
			});
		}
		
		function searchFileInfo() {
			var title = $('#search_title').textbox("getValue");
			$('#fileListDg').datagrid('load', {
				file_title : title
			});
		}
		
		function upLoadFile(){
			$("#dlg_addFile").dialog("open").dialog('setTitle',
			'Add File');
			//get category list
			$(document).ready(function(){
		            $.ajax({
		                contentType : "application/json;charset=utf-8",
		                type : "POST",
		                url : "category/getcategory",
		                dataType : "json",
		                success : function(data) {

		                    $.each(data, function(i, categoryList) {
		                        $('#category_new').append(
		                                $('<option>').text(categoryList.category_name).attr('value',
		                                        categoryList.category_id));
		                    });
		                }
		            });
		       	}); 
			document.getElementById("category_new").options.length=0;  //clear select
			//get attribute list by category
			document.getElementById("category_new").onchange =function(){
				document.getElementById("attribute_new").options.length=0;  //clear select
				//console.log(this.options[this.selectedIndex].value);
				var categoryid = this.options[this.selectedIndex].value;
				$.ajax({
	                contentType : "application/json;charset=utf-8",
	                type : "POST",
	                url : "attribute/getattribute?categoryId="+categoryid,
	                dataType : "json",
	                success : function(data) {

	                    $.each(data, function(i, attributeList) {
	                        $('#attribute_new').append(
	                                $('<option>').text(attributeList.attribute_name).attr('value',
	                                		attributeList.attribute_id));
	                    });
	                }
	            });
			}
	   	}
		
		
		function clearForm() {
			$('#ff_addfileinfo').form('clear');
		}
	</script>
</body>
</html>