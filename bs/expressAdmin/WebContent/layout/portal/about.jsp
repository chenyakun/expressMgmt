<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
	$(function() {
		$('#admin_aboutgl_datagrid').datagrid({
			url : '${pageContext.request.contextPath}/aboutController/datagrid.action',
			fit : true,
			fitColumns : true,
			border : false,
			//pagination : true,
			pagination : false,
			idField : 'id',
			pageSize : 10,
			//pageList : [ 10, 20, 30, 40, 50 ],
			sortName : 'createdatetime',
			sortOrder : 'desc',
			checkOnSelect : false,
			selectOnCheck : false,
			nowrap : false,
			
			frozenColumns : [ [
			/*
			{
				title : '编号',
				field : 'id',
				width : 150,
				sortable : true,
				checkbox : true
			}, 
			
			*/
			{
				title : '公告标题',
				field : 'name',
				width : 150,
				sortable : true
			} ] ],
			columns : [ [ {
				title : '添加时间',
				field : 'createdatetime',
				width : 150
			}, {
				title : '公告内容',
				field : 'note',
				width : 150,
				formatter : function(value, row, index) {
					return formatString('<span class="icon-search" style="display:inline-block;vertical-align:middle;width:16px;height:16px;"></span><a href="javascript:void(0);" onclick="admin_buggl_showNoteFun(\'{0}\');">查看详细</a>', index);
				}
			}
			/*
			, {
				field : 'action',
				title : '操作',
				width : 100,
				formatter : function(value, row, index) {
					return formatString('<img onclick="admin_buggl_editFun(\'{0}\');" src="{1}"/>&nbsp;<img onclick="admin_buggl_deleteFun(\'{2}\');" src="{3}"/>', row.id, '${pageContext.request.contextPath}/style/images/extjs_icons/pencil.png', row.id, '${pageContext.request.contextPath}/style/images/extjs_icons/cancel.png');
				}
			}
			*/ ] ]			
			//,
			//toolbar : '#admin_aboutgl_toolbar'
		});
	});

	function admin_buggl_showNoteFun(index) {
		var rows = $('#admin_aboutgl_datagrid').datagrid('getRows');
		var row = rows[index];
		$('<div/>').dialog({
			title : '公告标题[' + row.name + ']',
			modal : true,
			maximizable : true,
			width : 640,
			height : 480,
			content : '<iframe src="${pageContext.request.contextPath}/aboutController/showNote.action?id=' + row.id + '" frameborder="0" style="border:0;width:100%;height:99%;"></iframe>',
			onClose : function() {
				$(this).dialog('destroy');
			}
		});

		$('#admin_aboutgl_datagrid').datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
	}

	
	 
	
</script>
<table id="admin_aboutgl_datagrid"></table>
<!-- <div id="admin_aboutgl_toolbar" style="display: none;">
	<a href="javascript:void(0);" onclick="admin_buggl_appendFun();" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" style="float: left;">增加</a>
	<div class="datagrid-btn-separator"></div>
	<a href="javascript:void(0);" onclick="admin_buggl_removeFun();" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" style="float: left;">批量删除</a>
	<div class="datagrid-btn-separator"></div>
	<input id="admin_buggl_searchbox" class="easyui-searchbox" style="width:150px;" data-options="searcher:function(value,name){$('#admin_aboutgl_datagrid').datagrid('load',{name:value});},prompt:'可模糊查询公司简介'"></input> <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="$('#admin_aboutgl_datagrid').datagrid('load',{});$('#admin_buggl_searchbox').searchbox('setValue','');">清空条件</a>
</div>
 -->