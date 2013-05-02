/*base.js*/
$(function() {
	buttonToBlur();
	$("input[type=text]").attr("autocomplete", "off");
});

/* 添加到收藏夹 */
function addFavorites(setUrl) {
	var title = "快递下单";
	var url = "http://" + document.domain + "/order/index.jsp";
	if (setUrl != "" && setUrl != null) {
		url = setUrl;
	}
	try {
		window.external.addFavorite(url, title);
	} catch (e1) {
		try {
			window.external.AddToFavoritesBar(url, title);
		} catch (e2) {
			try {
				window.sidebar.addPanel(title, url);
			} catch (e3) {
				alert("收藏失败，此操作被浏览器拒绝！\n请使用“Ctrl+D”进行收藏！");
			}
		}
	}
}

// 去掉按钮边框
function buttonToBlur() {
	$("a").focus(function() {
		this.blur();
	});
	$("input[type=button]").focus(function() {
		this.blur();
	});
	$("button").focus(function() {
		this.blur();
	});
}

// 显示登录窗口
function showEleCenter(EleId) {
	// 计算屏幕正中间的位置
	var browserwidth = $(window).width();
	var browserheight = $(window).height();
	var cwinwidth = $("#" + EleId).width();
	var cwinheight = $("#" + EleId).height();
	// 有滚动条的情况
	var scrollLeft = $(window).scrollLeft();
	var scrollTop = $(window).scrollTop();
	var left = scrollLeft + (browserwidth - cwinwidth) / 2;
	var top = scrollTop + (browserheight - cwinheight) / 2;
	$("#overlay").show();
	$("#" + EleId).css("left", left).css("top", top).show();
}

/* 登录退出 */
function loginOrlogout() {
	if ($("#headerLogin").text() == "登录") {
		showEleCenter("loginIframe");
	} else {
		// 退出
	}
}

// 登录完后关闭登录窗口
function closeLoginIframe() {
	closeNoLogin();
	alert("登录成功！");
}
function closeNoLogin() {
	$("#loginIframe").hide();
	$("#overlay").hide();
}

/* 判断是否登录 */
function isLoginByWeb() {
	if ($("#headerLogin").text() == "登录") {
		showEleCenter("loginIframe");
	} else {
		window.location = "/order/logined/order.do?action=list";
	}
}

/* 生成浮动框 */
function floatbox(fbEle, fbText) {
	var $fb = $("<div class='floatbox'>" + "<div class='fb-left'></div>"
			+ "<div class='fb-center'>" + fbText + "</div>"
			+ "<div class='fb-right'></div>" + "<div class='clear'></div>"
			+ "</div>");
	$("body").append($fb);
	$(fbEle).css("cursor", "pointer");
	$(fbEle).hover(function() {
		var top = $(fbEle).offset().top - 28;
		var left = $(fbEle).offset().left;
		$fb.css("top", top + "px");
		$fb.css("left", left + "px");
		$fb.show();
	}, function() {
		$fb.hide();
	});
}

/* 获取cookies */
function getcookie(cookieName) {
	var cookieValue = "";
	if (document.cookie && document.cookie != '') {
		var cookies = document.cookie.split(';');
		for ( var i = 0; i < cookies.length; i++) {
			var cookie = cookies[i].replace(/(^\s*)|(\s*$)/g, "");
			if (cookie.substring(0, cookieName.length + 1) == (cookieName + '=')) {
				cookieValue = unescape(cookie.substring(cookieName.length + 1));
				break;
			}
		}
	}
	return cookieValue;
}

// 设置永久cookies
function setcookie(cookieName, cookieValue) {
	var expires = new Date();
	var now = parseInt(expires.getTime());
	var et = (86400 - expires.getHours() * 3600 - expires.getMinutes() * 60 - expires
			.getSeconds());
	expires.setTime(now + 1000000 * (et - expires.getTimezoneOffset() * 60));
	document.cookie = escape(cookieName) + "=" + escape(cookieValue)
			+ ";expires=" + expires.toGMTString() + "; path=/";
}

function deleteCookie(name) {
	var exp = new Date();
	exp.setTime(exp.getTime() - 1);
	var cval = getcookie(name);
	document.cookie = escape(name) + "=" + escape(cval) + "; expires="
			+ exp.toGMTString() + "; path=/";
}