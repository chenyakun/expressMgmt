<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<script type="text/javascript">
	$(function() {

		$('#layout_west_tree').tree({
			url : '${pageContext.request.contextPath}/menuController/allTreeNode.action',
			parentField : 'pid',
			lines : true,
			onClick : function(node) {
				var url;
				if (node.attributes.url) {
					url = '${pageContext.request.contextPath}' + node.attributes.url;
				} else {
					url = '${pageContext.request.contextPath}/error/dog.jsp';
				}
				if (url.indexOf('druidController') > -1) {/*要查看连接池监控页面*/
					layout_center_addTabFun({
						title : node.text,
						closable : true,
						iconCls : node.iconCls,
						//content : '<iframe src="' + url + '" frameborder="0" style="border:0;width:100%;height:99%;"></iframe>'
						content : '<iframe src="' + "/admin/map.jsp" + '" frameborder="0" style="border:0;width:100%;height:99%;"></iframe>'
					});
				} else {
					layout_center_addTabFun({
						title : node.text,
						closable : true,
						iconCls : node.iconCls,
						href : url
					});
				}
			}
		});

	});
</script>
<div class="easyui-accordion" data-options="fit:true,border:false">
	<div title="快递业务" data-options="isonCls:'icon-save',tools : [ {
				iconCls : 'icon-reload',
				handler : function() {
					$('#layout_west_tree').tree('reload');
				}
			}, {
				iconCls : 'icon-redo',
				handler : function() {
					var node = $('#layout_west_tree').tree('getSelected');
					if (node) {
						$('#layout_west_tree').tree('expandAll', node.target);
					} else {
						$('#layout_west_tree').tree('expandAll');
					}
				}
			}, {
				iconCls : 'icon-undo',
				handler : function() {
					var node = $('#layout_west_tree').tree('getSelected');
					if (node) {
						$('#layout_west_tree').tree('collapseAll', node.target);
					} else {
						$('#layout_west_tree').tree('collapseAll');
					}
				}
			} ]">
		<ul id="layout_west_tree"></ul>
	</div>
</div>