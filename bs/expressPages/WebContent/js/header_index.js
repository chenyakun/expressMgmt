//<!--header-begin -->

document.writeln("<input type=\"hidden\" id=\"headerMenu\" value=\"kuaidiQuery kuaijianQuery\" />" +
		"<input type=\"hidden\" id=\"loginAccount\" value=\"\" />" +
		"<input type=\"hidden\" id=\"loginStatus\" value=\"\" />" +
		"<div class=\"header w960\">" +
		"	<div class=\"menu-top\">" +
		"		<div class=\"fr\" id=\"weiboLink\"  style=\"display:none;\">" +
		"			<a href=\"network/distribution.shtml\" target=\"_blank\">免费发布网点电话</a>" +
		"		</div>" +
		"		<div class=\"fr tabSpan\" id=\"freeDiv\">" +
		"			<a class=\"service-link02\" href=\"javascript:void(0)\">快递网点专区</a>" +
		"			<ul id=\"serviceList02\" style=\"display:none\">" +
		"				<li>" +
		"					<a href=\"claim/clmReg.shtml\" target=\"_blank\">网点注册</a>" +
		"				</li><!--<li><a target=\"_blank\" href=\"network/applyJoin.shtml\">网点发布申请</a></li><li><a href=\"network/invite.shtml\" target=\"_blank\">网点激活</a></li>-->" +
		"				<li>" +
		"					<a target=\"_blank\" href=\"claim/loginNet.shtml\">网点登录</a>" +
		"				</li>" +
		"			</ul>" +
		"		</div>" +
		"		<div class=\"fr tabSpan tabSpan-w\" style=\"margin-right:25px\">" +
		"			<a class=\"more-link\" href=\"login.html\" onclick=\"historyPageLink();return false;\">我的快递单<span id=\"cookieTips2\" style=\"display:none;color:#f26100\"></span></a>" +
		"			<ul id=\"moreList\" style=\"display:none\">" +
		"				<li>" +
		"					<a href=\"login.html\" onclick=\"historyPageLink();return false;\">我的查询记录</a><span id=\"uncheckTips2\" style=\"display:none;color:#f26100\"></span>" +
		"				</li>" +
		"				<li>" +
		"					<a href=\"login.html\" onclick=\"orderPageLink();return false;\">我的订单</a>" +
		"				</li>" +
		"			</ul>" +
		"		</div>" +
		"		<div class=\"fr mr10px\">" +
		"			<span id=\"welcome\">[&nbsp;<a href=\"login.html\">登录</a>&nbsp;|&nbsp;<a href=\"regByTel.shtml\">注册</a>&nbsp;]</span>" +
		"		</div>" +
		"	</div><!-- menu-top -->" +
		"	<div class=\"logo\">" +
		"		<a href=\"index.html\"><img src=\"images/logo.jpg\" alt=\"\" /></a>" +
		"	</div>" +
		"	<div id=\"afficheTips\" style=\"display:none;\"></div>" +
		"	<div class=\"top-float-tips1\" id=\"cookieTips\" style=\"display:none\"></div>" +
		"	<div class=\"top-float-tips2\" id=\"uncheckTips\" style=\"display:none\"></div>" +
		"	</div><!--header w960-->" +

		"<iframe width=\"0\" height=\"0\" id=\"frame_logout\" name=\"frame_logout\" src=\"\"></iframe>" +
		"	<div class=\"wfull\" id=\"menu\">" +
		"	<div class=\"nav wfull\">" +
		"		<div class=\"nav-box w960\">" +
		"			<a id=\"kuaidiQuery\" href=\"index.html\" class=\"fl\">快递查询</a>" +
		"			<a id=\"networkQuery\" href=\"network.html\" class=\"fl\">网点查询</a>" +
		"			<a id=\"orderIndex\" href=\"dev.html\" class=\"fl\">包裹邮寄</a>" +
		"			<a id=\"historyQuery\" href=\"history.html\" class=\"fl\" onclick=\"historyPageLink();return false;\">我的快递单</a>" +
		"		</div>" +
		"	</div>" +
		"</div>");

// <!--header end-->
