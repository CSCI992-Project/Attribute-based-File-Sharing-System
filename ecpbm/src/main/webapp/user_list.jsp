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
		
		<a href="javascript:void(0)"
					class="easyui-linkbutton" iconCls="icon-add" plain="true"
					onclick="addUser();">Add User</a>
	</div>
	
	<!-- 修改用户信息对话框 -->
	<div id="dlg_userinfodetail" class="easyui-dialog" title="User Information"
		closed="true" style="width: 500px;">
		<div style="padding: 10px 60px 20px 60px">
			<form id="ff_userinfo" method="POST" action=""
				enctype="multipart/form-data">
				<table cellpadding="5">
					<tr id="userId">
						<td>User Id</td>
						<td><input class="easyui-textbox" type="text" id="id"
							name="id" data-options="required:true"></input></td>
					</tr>
					<tr>
						<td>User Name</td>
						<td><input class="easyui-textbox" type="text" id="userName"
							name="userName" data-options="required:true"></input></td>
					</tr>
					<tr>
						<td>User Password:</td>
						<td><input class="easyui-textbox" type="text" id="password"
							name="password" data-options="required:true"></input></td>
					</tr>
					<tr>
						<td>User Type:</td>
						<td><select id="userType" class="easyui-combobox" name="userType"
							style="width: 173px;">
								<option value="1">Administrator</option>
								<option value="2">User</option>
						</select></td>
					</tr>
					<tr>
						<td>Email:</td>
						<td><input class="easyui-textbox" type="text" id="email"
							name="email"></input></td>
					</tr>
					<tr>
						<td>Phone:</td>
						<td><input class="easyui-textbox" type="text" id="phone"
							name="phone"></input></td>
					</tr>
					<tr>
						<td>Category:</td>
						<td><select id="category" 
							name="category_id" style="width: 173px;" 
							>
							<option>please select</option></select>
							</td>
					</tr>
					<tr>
						<td>Attribute:</td>
						<td><select id="attribute"
							name="attribute_id" style="width: 173px;"
							>
							<option>select category first</option></select></td>
					</tr>					
				</table>
			</form>
			<div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton"
					onclick="updateUserInfo();">save</a> <a href="javascript:void(0)"
					class="easyui-linkbutton" onclick="clearForm();">clear</a>
			</div>
		</div>
	</div>
	
	<!-- 添加信息对话框 -->
	<div id="dlg_addUser" class="easyui-dialog" title="User Information"
		closed="true" style="width: 500px;">
		<div style="padding: 10px 60px 20px 60px">
			<form id="ff_adduserinfo" method="POST" action=""
				enctype="multipart/form-data">
				<table cellpadding="5">
					<tr>
						<td>User Name</td>
						<td><input class="easyui-textbox" type="text" id="userName"
							name="userName" data-options="required:true"></input></td>
					</tr>
					<tr>
						<td>User Password:</td>
						<td><input class="easyui-textbox" type="text" id="password"
							name="password" data-options="required:true"></input></td>
					</tr>
					<tr>
						<td>User Type:</td>
						<td><select id="userType" class="easyui-combobox" name="userType"
							style="width: 173px;">
								<option value="1">Administrator</option>
								<option value="2">User</option>
						</select></td>
					</tr>
					<tr>
						<td>Email:</td>
						<td><input class="easyui-textbox" type="text" id="email"
							name="email"></input></td>
					</tr>
					<tr>
						<td>Phone:</td>
						<td><input class="easyui-textbox" type="text" id="phone"
							name="phone"></input></td>
					</tr>
					<tr>
						<td>Category:</td>
						<td><select id="category_new" 
							name="category_id" style="width: 173px;" 
							>
							<option>please select</option></select>
							</td>
					</tr>
					<tr>
						<td>Attribute:</td>
						<td><select id="attribute_new"
							name="attribute_id" style="width: 173px;"
							>
							<option>select category first</option></select></td>
					</tr>					
				</table>
			</form>
			<div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton"
					onclick="saveUserInfo();">save</a> <a href="javascript:void(0)"
					class="easyui-linkbutton" onclick="clearForm();">clear</a>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		$(function() {
			$("#userId").hide(); // hide the user id 'tr'
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
				onLoadSuccess: function () {
					  $('.detail').linkbutton({ text: 'Detail', plain: true, iconCls: 'icon-edit' }),
			          $('.delete').linkbutton({ text: 'Delete', plain: true, iconCls: 'icon-no' });
			       },
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
					width : 120,
					formatter : function(value, row, index) {
						if (row.userType==1) {
							return "Administrator";
						} else {
							return "User";
						}
					}
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
					field : 'category',
					title : 'category',
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
					width : 300,
					formatter : function(value, row, index) {						
						var str = "";
			
			            var userInfoDetail = '<a class="detail" onclick="UserTabUtil.userInfoDetail('+ row.id +','+index+')"></a>';
			            var delBtnObj = '<a class="delete" onclick="UserTabUtil.deleteUserInfo('+ row.id +')"></a>';
			                    		                    
			            str += userInfoDetail;
			            str += delBtnObj;			            
			            return str;
					}
				} ] ]
			});
		});
		
		var url;
		
		UserTabUtil = {
				// delete user information by user id
				deleteUserInfo : function (id) {
					$.messager.confirm('Confirm', 'Are you sure deleting this user infomation?', function(r) {
						if (r) {
							$.post('userinfo/deleteUserInfo', {id:id},function(result) {
								if (result.success == 'true') {
									$("#userListDg").datagrid('reload');
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
                    
              	// update user information
          		userInfoDetail :function(id,index){
          			//get row data
          			var row = $("#userListDg").datagrid('getData').rows[index];
					url = 'userinfo/updateUserinfo';
					document.getElementById("category").options.length=0;  //clear select
					document.getElementById("attribute").options.length=0;  //clear select
          			$("#dlg_userinfodetail").dialog("open").dialog('setTitle',
					'Update User Information');
					$("#ff_userinfo").form("load", {
						"id"	   : row.id,
						"userName" : row.userName,
						"password" : row.password,
						"userType" : row.userType,
						"email" : row.email,
						"phone" : row.phone,
						"category" : row.category_id,
						"attribute" : row.attribute_id,
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
						document.getElementById("attribute").options.length=0;  //clear select
						//console.log(this.options[this.selectedIndex].value);
						var categoryid = this.options[this.selectedIndex].value;
						$.ajax({
			                contentType : "application/json;charset=utf-8",
			                type : "POST",
			                url : "attribute/getattribute?categoryId="+categoryid,
			                dataType : "json",
			                success : function(data) {

			                    $.each(data, function(i, attributeList) {
			                        $('#attribute').append(
			                                $('<option>').text(attributeList.attribute_name).attr('value',
			                                		attributeList.attribute_id));
			                    });
			                }
			            });
					}
					document.getElementById("attribute").onchange =function(){
						//console.log(this.options[this.selectedIndex].value);
						document.getElementById("attribute").value=this.options[this.selectedIndex].value;
					} 
          		}		 
                     
        };
		
		//update user information
		function updateUserInfo() {
			$("#ff_userinfo").form("submit", {
				url : url, //使用参数				
				success : function(result) {
					var result = eval('(' + result + ')');
					if (result.success == 'true') {
						$("#userListDg").datagrid("reload"); //refresh user list
						$('#ff_userinfo').form('clear'); //clear the user information form
						$("#dlg_userinfodetail").dialog("close"); //close the user information panel
					}
					$.messager.show({
						title : "tips",
						msg : result.message
					});
				}
			});
		}
		
		function saveUserInfo() {
			$("#ff_adduserinfo").form("submit", {
				url : 'userinfo/addUserinfo', //使用参数				
				success : function(result) {
					var result = eval('(' + result + ')');
					if (result.success == 'true') {
						$("#userListDg").datagrid("reload"); //refresh user list
						$('#ff_adduserinfo').form('clear'); //clear the user information form
						$("#dlg_addUser").dialog("close"); //close the user information panel
					}
					$.messager.show({
						title : "tips",
						msg : result.message
					});
				}
			});
		}
	
		//function add user
		function addUser() {
			$("#dlg_addUser").dialog("open").dialog('setTitle',
			'Add User');
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
		
		function searchUserInfo() {
			var userName = $('#search_userName').textbox("getValue");
			$('#userListDg').datagrid('load', {
				userName : userName
			});
		}
		
		function clearForm() {
			$('#ff_userinfo').form('clear');
		}
	</script>
</body>
</html>