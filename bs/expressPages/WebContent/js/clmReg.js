var gStartPlaceTip = "请选择您网点的收派地区";

/* init初始化执行 */
initStartPlaceInput();
selectStartPlace();

claimLoad();
fillYourCookie();
refreshTelCode();

function claimLoad() {
	$("#norQues").click(function() {
		$("#norQuesList").show()
	});
	$("#norQcha").click(function() {
		$("#norQuesList").hide()
	}); // 常见问题

	/* 注册第一步 选快递公司下拉菜单 */
	$("#gratuitous").html("请选择快递品牌名称").css("color", "#A9A9A9");

	$("html").click(function(e) {
		if (!$("#wra_downstairs").is(':hidden')) {
			$("#wra_downstairs").hide();
		}
	});
	$("#gratuitous").click(function(e) {
		$("#wra_downstairs").toggle();
		e.stopPropagation();
	});
	$("#wra_downstairs").click(function() {
		return false;
	});

	$("#wra_downstairs").find(".occur .tingly .specifically span a").click(
			function() {
				var frisky = $(this).text();
				$("#gratuitous").html(frisky).css("color", "#333");
				var jerk = $(this).attr("code");
				$("#expressName").val(frisky);
				$("#expressCode").val(jerk);
				$("#wra_downstairs").hide();
			});
	/* 注册第一步 选快递公司下拉菜单 */

	$("#keepFit").val("请与快递官网名称保持一致").css("color", "#A9A9A9");
	$("#keepFit").focus(function() {
		if ($(this).val() == "请与快递官网名称保持一致") {
			$(this).val("").css("color", "#333");
		}
	});

	$("#keepFit").blur(function() {
		if ($(this).val() == "") {
			$(this).val("请与快递官网名称保持一致").css("color", "#A9A9A9");
		}
	});

	$("#headName").keydown(function(e) {
		var keycode = e.keyCode ? e.keyCode : e.which;
		if (keycode == "13") {
			$("#mobNum").select();
		}
	});

	$("#mobNum").keydown(function(e) {
		var keycode = e.keyCode ? e.keyCode : e.which;
		if (keycode == "13") {
			$("#logPwd01").select();
		}
	});

	$("#logPwd01").keydown(function(e) {
		var keycode = e.keyCode ? e.keyCode : e.which;
		if (keycode == "13") {
			$("#logPwd02").select();
		}
	});

	$("#logPwd02").keydown(function(e) {
		var keycode = e.keyCode ? e.keyCode : e.which;
		if (keycode == "13") {
			$("#yzCode").select();
		}
	});

	$("#yzCode").keydown(function(e) {
		var keycode = e.keyCode ? e.keyCode : e.which;
		if (keycode == "13") {
			confirmDing();
		}
	});

	$("#logPwd01").val(""); // 每次载入清空密码及验证码
	$("#logPwd02").val("");
	$("#yzCode").val("");
}

function yanZmaLoad02() {
	$("#yanZma").click(); // 看不清验证码
}

/* 取出cookie */
function fillYourCookie() { // expressCodeCookie
	var before = GetQueryString("before");
	var netRegBeforePage = getCookie("netRegBeforePage");
	if (before == "true" && netRegBeforePage == "true") {
		if (!!getCookie("expressNameCookie")) {
			$("#gratuitous").html(getCookie("expressNameCookie")).css("color",
					"#333");
			$("#expressName").val(getCookie("expressNameCookie"));
			$("#expressCode").val(getCookie("expressCodeCookie"));
		}
		if (!!getCookie("keepFitCookie")) {
			$("#keepFit").val(getCookie("keepFitCookie")).css("color", "#333");
		}
		if (!!getCookie("startPlaceCookie")) {
			$("#startPlace").val(getCookie("startPlaceCookie")).css("color",
					"#333");
			$("#startPlace_input").val(getCookie("startPlace_inputCookie"))
					.css("color", "#333");
		}
		if (!!getCookie("headNameCookie")) {
			$("#headName").val(getCookie("headNameCookie"))
					.css("color", "#333");
		}
		if (!!getCookie("mobNumCookie")) {
			$("#mobNum").val(getCookie("mobNumCookie")).css("color", "#333");
		}
		setCookie("netRegBeforePage", "false");
	}
}

/* 初始化出发地 */
function initStartPlaceInput() {
	var startPlaceInput = $("#startPlace_input");
	if (startPlaceInput.val() == "") {
		startPlaceInput.css("color", "#B2B2B2");
		startPlaceInput.val(gStartPlaceTip);
	}
	if (startPlaceInput.val() == gStartPlaceTip) {
		startPlaceInput.css("color", "#B2B2B2");
	} else {
		startPlaceInput.css("color", "#333333");
	}
	startPlaceInput.click(function() {
		$("#startPlaceDiv").show();
	});
	startPlaceInput.blur(function() {
		if ($(this).val() == "") {
			$(this).css("color", "#B2B2B2");
			$(this).val(gStartPlaceTip);
		}
	});
	startPlaceInput.click(function() {
		return false;
	});
}

// 删除地址
$("#startPlace_input").keydown(function(event) {
	var keyCode = event.keyCode;
	if (keyCode == 8 || keyCode == 46) {
		$("#startPlace_input").css("color", "#B2B2B2");
		$("#startPlace_input").val(gStartPlaceTip);
		$("#startPlace").val("");
		event.preventDefault();
	}
});

/* 选择城市 */
function selectStartPlace() {
	$("html").click(function(e) {
		if (!$("#startPlaceDiv").is(':hidden')) {
			$("#startPlaceDiv").hide();
		}
	});
	$("#startPlaceDiv").click(function(e) {
		return false;
	});
	$("#startPlaceDiv .tab-list").delegate("#startPlaceDiv li.tab", "click",
			function() {
				var n = $(this).attr("index");
				$("#startPlaceDiv .tab-box").hide();
				$("#startPlaceDiv .tab-box:eq(" + n + ")").show();
				$("#startPlaceDiv .tab").removeClass("select");
				$("#startPlaceDiv .select-tab").animate({
					left : n * 70 - 1 + "px"
				}, 200, function() {
					$("#startPlaceDiv .tab:eq(" + n + ")").addClass("select");
				});
				return false;
			});

	$("#startPlaceDiv .place-list").delegate("#startPlaceDiv li", "click",
			function() {
				var n = $(this).attr("index");
				$("#startPlaceDiv .province-box2").animate({
					left : -280 * n + 10 + "px"
				});
				return false;
			});

	$("#startPlaceDiv.location-box")
			.delegate(
					"#startPlaceDiv a.province",
					"click",
					function() {
						$("#startPlaceDiv a.select").removeClass("select");
						$(this).addClass("select");
						var provinceId = $(this).attr("code");
						if (provinceId == "11" || provinceId == "12"
								|| provinceId == "31" || provinceId == "50") {
							var startPlaceInput = $("#startPlace_input");
							var startPlace = $("#startPlace");
							startPlaceInput.val($(this).html() + "-"
									+ $(this).html() + "市");
							startPlaceInput.css("color", "#333333");
							// startPlace.val(provinceId+"0000");
							startPlace.val("");

							$
									.ajax({
										type : "POST",
										contentType : "application/x-www-form-urlencoded;charset=utf-8",
//										url : "/order/unlogin/price.do?action=getCounty",
										url : "../CountyServlet",
										data : "city=" + $(this).attr("code"),
										success : function(responseText) {
											$("#startPlaceDiv .tab-box:eq(3)")
													.html('');
											var res = $.parseJSON(responseText);
											if (res.length > 0) {
												for ( var i = 0; i < res.length; i++) {
													$(
															"#startPlaceDiv .tab-box:eq(3)")
															.append(
																	"<a class='place county' href='#' code='"
																			+ res[i].number
																			+ "'>"
																			+ res[i].name
																			+ "</a>");
												}
												$("#startPlaceDiv .li-county")
														.click();
											} else {
												$("#startPlaceDiv").hide();
											}
										}
									});
							return false;
						}

						$("#startPlaceDiv .li-city").click();
						$("#startPlace_input").css("color", "#333333");
						$("#startPlace_input").val($(this).html());
						$("#startPlace").val("");
						var cityJson = area.city;
						$("#startPlaceDiv .tab-box:eq(2)").html('');
						$("#startPlaceDiv .tab-box:eq(3)").html('');
						for ( var i = 0; i < cityJson.length; i++) {
							if (cityJson[i].code.substring(0, 2) == provinceId) {
								$("#startPlaceDiv .tab-box:eq(2)").append(
										"<a class='place city' href='#' code='"
												+ cityJson[i].code + "'>"
												+ cityJson[i].name + "</a>");
							}
						}
						return false;
					});

	$("#startPlaceDiv.location-box")
			.delegate(
					"#startPlaceDiv a.city",
					"click",
					function() {
						$("#startPlaceDiv a.select").removeClass("select");
						$(this).addClass("select");
						var startPlaceInput = $("#startPlace_input");
						var startPlace = $("#startPlace");
						var provinceJson = area.province;
						for ( var i = 0; i < provinceJson.length; i++) {
							if (provinceJson[i].code.substring(0, 2) == $(this)
									.attr("code").substring(0, 2)) {
								startPlaceInput.val(provinceJson[i].name + "-"
										+ $(this).html());
								break;
							}
						}
						startPlaceInput.css("color", "#333333");
						// startPlace.val($(this).attr("code"));
						startPlace.val("");

						$
								.ajax({
									type : "POST",
									contentType : "application/x-www-form-urlencoded;charset=utf-8",
//									url : "/order/unlogin/price.do?action=getCounty",
									url : "../CountyServlet",
									data : "city=" + $(this).attr("code"),
									success : function(responseText) {
										$("#startPlaceDiv .tab-box:eq(3)")
												.html('');
										var res = $.parseJSON(responseText);
										if (res.length > 0) {
											for ( var i = 0; i < res.length; i++) {
												$(
														"#startPlaceDiv .tab-box:eq(3)")
														.append(
																"<a class='place county' href='#' code='"
																		+ res[i].number
																		+ "'>"
																		+ res[i].name
																		+ "</a>");
											}
											$("#startPlaceDiv .li-county")
													.click();
										} else {
											$("#startPlaceDiv").hide();
										}
									}
								});

						return false;
					});

	$("#startPlaceDiv.location-box").delegate(
			"#startPlaceDiv a.county",
			"click",
			function() {
				$("#startPlaceDiv a.select").removeClass("select");
				$(this).addClass("select");
				var startPlaceInput = $("#startPlace_input");
				var startPlace = $("#startPlace");
				var provinceJson = area.province;
				var startPlaceName = "";
				for ( var i = 0; i < provinceJson.length; i++) {
					if (provinceJson[i].code.substring(0, 2) == $(this).attr(
							"code").substring(0, 2)) {
						startPlaceName = provinceJson[i].name;
						break;
					}
				}
				var cityJson = area.city;
				for ( var i = 0; i < cityJson.length; i++) {
					var provinceId = $(this).attr("code").substring(0, 2);
					if (provinceId == "11" || provinceId == "12"
							|| provinceId == "31" || provinceId == "50") {
						if (cityJson[i].code.substring(0, 2) == $(this).attr(
								"code").substring(0, 2)) {
							startPlaceInput.val(startPlaceName + "-"
									+ cityJson[i].name + "-" + $(this).html());
							break;
						}
					} else {
						if (cityJson[i].code.substring(0, 4) == $(this).attr(
								"code").substring(0, 4)) {
							startPlaceInput.val(startPlaceName + "-"
									+ cityJson[i].name + "-" + $(this).html());
							break;
						}
					}
				}
				startPlaceInput.css("color", "#333333");
				startPlace.val($(this).attr("code"));
				$("#startPlaceDiv").hide();

				return false;
			});

	$("#startPlaceSelect").click(function(e) {
		e.stopPropagation();
		if ($("#startPlaceDiv").css("display") != "none") {
			$("#startPlaceDiv").hide();
		} else {
			$("#startPlaceDiv").show();
		}
	});
}

// 提交注册
function confirmDing() {
	var keepFit = trim($("#keepFit").val());
	var startPlace = $("#startPlace").val();
	var headName = trim($("#headName").val());
	var mobNum = trim($("#mobNum").val());
	var logPwd01 = trim($("#logPwd01").val());
	var logPwd02 = trim($("#logPwd02").val());
	var yzCode = trim($("#yzCode").val());

	/*
	if ($("#gratuitous").html() == "请选择快递品牌名称") {
		$("#warningSign").html("请选择快递品牌名称！");
		$("#warningSign").show();
		return false;
	} else if ($("#expressCode").val() == "") {
		$("#gratuitous").text("");
		$("#warningSign").html("请选择快递品牌名称！");
		$("#warningSign").show();
		return false;
	} else {
		$("#expressName").val($("#gratuitous").text());
		setCookie("expressNameCookie", $("#gratuitous").text());
		setCookie("expressCodeCookie", $("#expressCode").val());
	}
	;

	if ((keepFit == "请与快递官网名称保持一致") || (keepFit == "")) {
		$("#warningSign").html("请输入快递网点名称！");
		$("#warningSign").show();
		$("#keepFit").select();
		return false;
	} else {
		setCookie("keepFitCookie", keepFit)
	}
	;

	if (startPlace == gStartPlaceTip) {
		$("#warningSign").html("请选择您网点的收派地区！");
		$("#warningSign").show();
		return false;
	} else if (startPlace == "") {
		$("#warningSign").html("请选择您网点的收派地区！");
		$("#warningSign").show();
		return false;
	} else {
		setCookie("startPlace_inputCookie", $("#startPlace_input").val());
		setCookie("startPlaceCookie", startPlace);
	}
	;

	if (headName == "") {
		$("#warningSign").html("请输入您的姓名！");
		$("#warningSign").show();
		$("#headName").select();
		return false;
	}

	if (securityValid(headName)) {
		$("#warningSign").html("姓名输入有误，请您重新输入！");
		$("#warningSign").show();
		$("#headName").select();
		return false;
	} else {
		setCookie("headNameCookie", headName)
	}
	;

	if (mobNum == "") {
		$("#warningSign").html("请输入您的手机号！");
		$("#warningSign").show();
		$("#mobNum").val("");
		$("#mobNum").select();
		return false;
	} else if (!(/^1\d{10}$/.test(mobNum))) {
		$("#warningSign").html("手机号输入不正确，请您重新输入！");
		$("#warningSign").show();
		$("#mobNum").select();
		return false;
	} else if (securityValid(mobNum)) {
		$("#warningSign").html("手机号输入不正确，请您重新输入！");
		$("#warningSign").show();
		return false;
	} else {
		setCookie("mobNumCookie", mobNum)
	}

	if (logPwd01 == "") {
		$("#warningSign").html("请您输入登录密码！");
		$("#warningSign").show();
		$("#logPwd01").select();
		return false;
	} else if (logPwd01.length < 6) {
		$("#warningSign").html("您输入的密码不能少于6位！");
		$("#warningSign").show();
		$("#logPwd01").select();
		return false;
	} else if (logPwd02 == "") {
		$("#warningSign").html("请您再次输入登录密码！");
		$("#warningSign").show();
		$("#logPwd02").select();
		return false;
	} else if (logPwd02.length < 6) {
		$("#warningSign").html("您输入的密码不能少于6位！");
		$("#warningSign").show();
		$("#logPwd02").select();
		return false;
	} else if (!isNumberLetterFuhao(logPwd01)) {
		$("#warningSign").html("您输入的密码不合法！");
		$("#warningSign").show();
		$("#logPwd01").select();
		return false;
	} else if (!isNumberLetterFuhao(logPwd02)) {
		$("#warningSign").html("您输入的密码不合法！");
		$("#warningSign").show();
		$("#logPwd02").select();
		return false;
	} else if (logPwd01 != logPwd02) {
		$("#warningSign").html("您两次输入的密码不相同！");
		$("#warningSign").show();
		return false;
	}

	if (yzCode == "" || yzCode == null) {
		$("#warningSign").html("请输入验证码！");
		$("#warningSign").show();
		$("#yzCode").select();
		return false;
	}

	if (securityValid(yzCode)) {
		$("#warningSign").html("验证码输入不正确，请您重新输入！");
		$("#warningSign").show();
		return false;
	}

	
	
	*/
	
	
	$.ajax({
		type : "POST",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : "../ApplyJoin",
		data : $("#clmLoginForm").serializeArray(),
		success : function(responseText) {

			var resultJson = $.parseJSON(responseText); // $.parseJSON
														// 把字符串转为json对象

			if (resultJson.status == "Y") {
				setCookie("logPwd01Cookie", logPwd01); // 成功了才存密码cookie
				window.location.href = "../joinok.html";
				//TODO: 这里加入申请之后的提示
			}
//			else if (resultJson.status == "errorCode") {
//				$("#warningSign").html("验证码错误，请重新输入！");
//				$("#warningSign").show();
//				$("#yzCode").val("");
//				refreshTelCode();
//			}
			else if (resultJson.status == "errorMobile") {
				$("#warningSign").html("您输入的手机号码已经被注册！");
				$("#warningSign").show();
				$("#mobNum").select();
				$("#yzCode").val("");
				refreshTelCode();
			} else {
				$("#warningSign").html("错误，请刷新后重试！");
				$("#warningSign").show();
				$("#yzCode").val("");
				refreshTelCode();
			}

		}
	});

}

/* 刷新验证码 */
function refreshTelCode() {
	$("#yanZma").attr(
			"src",
			"./ApplyJoin"
					+ new Date().getTime());
}

// 通用函数

// 判断是否是数字
function isNumber(s) {
	var regu = "^[0-9\.]+$";
	var re = new RegExp(regu);
	if (re.test(s)) {
		return true;
	} else {
		return false;
	}
}

/* 从 js/page/order/orderIndex.js中copy过来的 start */

/* 过滤空格 */
function trim(inputString) {
	if (typeof inputString != "string") {
		return inputString;
	}
	var retValue = inputString;
	var ch = retValue.substring(0, 1);
	while (ch == " ") {
		// 检查字符串开始部分的空格
		retValue = retValue.substring(1, retValue.length);
		ch = retValue.substring(0, 1);
	}
	ch = retValue.substring(retValue.length - 1, retValue.length);
	while (ch == " ") {
		// 检查字符串结束部分的空格
		retValue = retValue.substring(0, retValue.length - 1);
		ch = retValue.substring(retValue.length - 1, retValue.length);
	}
	while (retValue.indexOf("  ") != -1) {
		// 将文字中间多个相连的空格变为一个空格
		retValue = retValue.substring(0, retValue.indexOf("  "))
				+ retValue.substring(retValue.indexOf("  ") + 1,
						retValue.length);
	}
	return retValue;
}

/* 密码验证 */
function isNumberLetterFuhao(str) {
	var regStr = "^[0-9a-zA-Z\@\#\$\-\]+$";
	var reg = new RegExp(regStr);
	if (reg.test(str)) {
		return true;
	} else {
		return false;
	}
}

/* 设置和读取cookie */
function setCookie(cookieName, cookieValue) {
	document.cookie = cookieName + "=" + encodeURI(cookieValue) + "; ";
}
function getCookie(cookieName) {
	var cookieArray = document.cookie.split(';');
	for ( var i = 0; i < cookieArray.length; i++) {
		var seekof = cookieArray[i].indexOf(cookieName);
		if (seekof != -1) {
			var beynum = cookieArray[i].indexOf("=");
			var youwant = cookieArray[i].substring(beynum + 1);
			youwant = decodeURI(youwant);
			return youwant;
		}
	}
}

/* 获取参数 */
function GetQueryString(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
	var r = window.location.search.substr(1).match(reg);
	if (r != null)
		return unescape(r[2]);
	return null;
}
