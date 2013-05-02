var gStartPlaceTip = "选择发件地";
var gEndPlaceTip = "选择收件地";
/* 图片切换轮播 */
function pictureOn(picId) {
	$("#second-right-4").find("a").removeClass("cur");
	$("#second-right-4-" + picId).addClass("cur");
	$("#second-right-1").fadeOut("slow");
	$("#second-right-2").fadeOut("slow");
	$("#second-right-3").fadeOut("slow");
	$("#second-right-" + picId).fadeIn("slow");
}
var t = setInterval("showPicAuto()", 5000);
var n = 2;
function showPicAuto() {
	pictureOn(n);
	if (n < 3) {
		n = n + 1;
	} else {
		n = 1;
	}
}
$("#second-right-4 a").hover(function() {
	clearInterval(t);
	n = parseInt($(this).text());
	pictureOn($(this).text());
}, function() {
	t = setInterval("showPicAuto()", 5000);
});

// 重量水印
var gWeightSug = "未填时默认1公斤";
$("#weight").val(gWeightSug);
$("#weight").addClass("watermark");
$("#weight").focus(function() {
	if ($("#weight").val() == gWeightSug) {
		$("#weight").removeClass("watermark");
		$("#weight").val("");
	}
});
$("#weight").blur(function() {
	if ($.trim($("#weight").val()) == "") {
		$("#weight").addClass("watermark");
		$("#weight").val(gWeightSug);
	}
});
/* init初始化执行 */
initStartPlaceInput();
initEndPlaceInput();
selectStartPlace();
selectEndPlace();

/* cms页签切换 */
function showGonggao() {
	$("#gonggaoli").removeClass("notselect");
	$("#gonggaoli").addClass("select");
	$("#jiaoliuli").removeClass("select");
	$("#jiaoliuli").addClass("notselect");
	$("#jiaoliu").hide();
	$("#gonggao").show();
}

function showJiaoliu() {
	$("#jiaoliuli").removeClass("notselect");
	$("#jiaoliuli").addClass("select");
	$("#gonggaoli").removeClass("select");
	$("#gonggaoli").addClass("notselect");
	$("#gonggao").hide();
	$("#jiaoliu").show();
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
		$("#endPlaceDiv").hide();
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
	var startPlace_inputVal = getcookie("startPlace_input");
	var startPlaceVal = getcookie("startPlace");
	if (startPlace_inputVal != null && startPlace_inputVal != ""
			&& startPlaceVal != null && startPlaceVal != "") {
		$("#startPlace_input").val(startPlace_inputVal);
		$("#startPlace").val(startPlaceVal);
		startPlaceInput.css("color", "#333333");
	}
}

function initEndPlaceInput() {
	var endPlaceInput = $("#endPlace_input");
	if (endPlaceInput.val() == "") {
		endPlaceInput.css("color", "#B2B2B2");
		endPlaceInput.val(gEndPlaceTip);
	}
	if (endPlaceInput.val() == gEndPlaceTip) {
		endPlaceInput.css("color", "#B2B2B2");
	} else {
		endPlaceInput.css("color", "#333333");
	}
	endPlaceInput.click(function() {
		$("#endPlaceDiv").show();
		$("#startPlaceDiv").hide();
	});
	endPlaceInput.blur(function() {
		if ($(this).val() == "") {
			$(this).css("color", "#B2B2B2");
			$(this).val(gEndPlaceTip);
		}
	});
	endPlaceInput.click(function() {
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
$("#endPlace_input").keydown(function(event) {
	var keyCode = event.keyCode;
	if (keyCode == 8 || keyCode == 46) {
		$("#endPlace_input").css("color", "#B2B2B2");
		$("#endPlace_input").val(gEndPlaceTip);
		$("#endPlace").val("");
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

							$.ajax({
										type : "POST",
										contentType : "application/x-www-form-urlencoded;charset=utf-8",
										url : "CountyServlet",
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

						$.ajax({
									type : "POST",
									contentType : "application/x-www-form-urlencoded;charset=utf-8",
//									url : "/order/unlogin/price.do?action=getCounty",
									url : "CountyServlet",
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
			$("#endPlaceDiv").hide();
		}
	});
}

function selectEndPlace() {
	$("html").click(function(e) {
		if (!$("#endPlaceDiv").is(':hidden')) {
			$("#endPlaceDiv").hide();
		}
	});
	$("#endPlaceDiv").click(function(e) {
		return false;
	});
	$("#endPlaceDiv .tab-list").delegate("#endPlaceDiv li.tab", "click",
			function() {
				var n = $(this).attr("index");
				$("#endPlaceDiv .tab-box").hide();
				$("#endPlaceDiv .tab-box:eq(" + n + ")").show();
				$("#endPlaceDiv .tab").removeClass("select");
				$("#endPlaceDiv .select-tab").animate({
					left : n * 70 - 1 + "px"
				}, 200, function() {
					$("#endPlaceDiv .tab:eq(" + n + ")").addClass("select");
				});
				return false;
			});

	$("#endPlaceDiv .place-list").delegate("#endPlaceDiv li", "click",
			function() {
				var n = $(this).attr("index");
				$("#endPlaceDiv .province-box2").animate({
					left : -280 * n + 10 + "px"
				});
				return false;
			});

	$("#endPlaceDiv.location-box")
			.delegate(
					"#endPlaceDiv a.province",
					"click",
					function() {
						$("#endPlaceDiv a.select").removeClass("select");
						$(this).addClass("select");
						var provinceId = $(this).attr("code");
						if (provinceId == "11" || provinceId == "12"
								|| provinceId == "31" || provinceId == "50") {
							var endPlaceInput = $("#endPlace_input");
							var endPlace = $("#endPlace");
							endPlaceInput.val($(this).html() + "-"
									+ $(this).html() + "市");
							endPlaceInput.css("color", "#333333");
							// endPlace.val(provinceId+"0000");
							endPlace.val("");

							$.ajax({
										type : "POST",
										contentType : "application/x-www-form-urlencoded;charset=utf-8",
//										url : "/order/unlogin/price.do?action=getCounty",
										url : "CountyServlet",
										data : "city=" + $(this).attr("code"),
										success : function(responseText) {
											$("#endPlaceDiv .tab-box:eq(3)")
													.html('');
											var res = $.parseJSON(responseText);
											if (res.length > 0) {
												for ( var i = 0; i < res.length; i++) {
													$(
															"#endPlaceDiv .tab-box:eq(3)")
															.append(
																	"<a class='place county' href='#' code='"
																			+ res[i].number
																			+ "'>"
																			+ res[i].name
																			+ "</a>");
												}
												$("#endPlaceDiv .li-county")
														.click();
											} else {
												$("#endPlaceDiv").hide();
											}
										}
									});
							return false;
						}

						$("#endPlaceDiv .li-city").click();
						$("#endPlace_input").css("color", "#333333");
						$("#endPlace_input").val($(this).html());
						$("#endPlace").val("");
						var cityJson = area.city;
						$("#endPlaceDiv .tab-box:eq(2)").html('');
						$("#endPlaceDiv .tab-box:eq(3)").html('');
						for ( var i = 0; i < cityJson.length; i++) {
							if (cityJson[i].code.substring(0, 2) == provinceId) {
								$("#endPlaceDiv .tab-box:eq(2)").append(
										"<a class='place city' href='#' code='"
												+ cityJson[i].code + "'>"
												+ cityJson[i].name + "</a>");
							}
						}
						return false;
					});

	$("#endPlaceDiv.location-box")
			.delegate(
					"#endPlaceDiv a.city",
					"click",
					function() {
						$("#endPlaceDiv a.select").removeClass("select");
						$(this).addClass("select");
						var endPlaceInput = $("#endPlace_input");
						var endPlace = $("#endPlace");
						var provinceJson = area.province;
						for ( var i = 0; i < provinceJson.length; i++) {
							if (provinceJson[i].code.substring(0, 2) == $(this)
									.attr("code").substring(0, 2)) {
								endPlaceInput.val(provinceJson[i].name + "-"
										+ $(this).html());
								break;
							}
						}
						endPlaceInput.css("color", "#333333");
						// endPlace.val($(this).attr("code"));
						endPlace.val("");

						$.ajax({
									type : "POST",
									contentType : "application/x-www-form-urlencoded;charset=utf-8",
//									url : "/order/unlogin/price.do?action=getCounty",
									url : "CountyServlet",
									data : "city=" + $(this).attr("code"),
									success : function(responseText) {
										$("#endPlaceDiv .tab-box:eq(3)").html(
												'');
										var res = $.parseJSON(responseText);
										if (res.length > 0) {
											for ( var i = 0; i < res.length; i++) {
												$("#endPlaceDiv .tab-box:eq(3)")
														.append(
																"<a class='place county' href='#' code='"
																		+ res[i].number
																		+ "'>"
																		+ res[i].name
																		+ "</a>");
											}
											$("#endPlaceDiv .li-county")
													.click();
										} else {
											$("#endPlaceDiv").hide();
										}
									}
								});

						return false;
					});

	$("#endPlaceDiv.location-box").delegate(
			"#endPlaceDiv a.county",
			"click",
			function() {
				$("#endPlaceDiv a.select").removeClass("select");
				$(this).addClass("select");
				var endPlaceInput = $("#endPlace_input");
				var endPlace = $("#endPlace");
				var provinceJson = area.province;
				var endPlaceName = "";
				for ( var i = 0; i < provinceJson.length; i++) {
					if (provinceJson[i].code.substring(0, 2) == $(this).attr(
							"code").substring(0, 2)) {
						endPlaceName = provinceJson[i].name;
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
							endPlaceInput.val(endPlaceName + "-"
									+ cityJson[i].name + "-" + $(this).html());
							break;
						}
					} else {
						if (cityJson[i].code.substring(0, 4) == $(this).attr(
								"code").substring(0, 4)) {
							endPlaceInput.val(endPlaceName + "-"
									+ cityJson[i].name + "-" + $(this).html());
							break;
						}
					}
				}
				endPlaceInput.css("color", "#333333");
				endPlace.val($(this).attr("code"));
				$("#endPlaceDiv").hide();

				return false;
			});

	$("#endPlaceSelect").click(function(e) {
		e.stopPropagation();
		if ($("#endPlaceDiv").css("display") != "none") {
			$("#endPlaceDiv").hide();
		} else {
			$("#endPlaceDiv").show();
			$("#startPlaceDiv").hide();
		}
	});
}

/* 查价格 */
function queryPrice() {

	if ($("#startPlace_input").val() == gStartPlaceTip
			|| $("#startPlace_input").val() == "") {
		alert("请选择出发地");
		$("#startPlace_input").focus();
		return false;
	} else if ($("#startPlace").val() == "") {
		alert("请选择出发地的城市、县区");
		$("#startPlace_input").focus();
		return false;
	}
	if ($("#endPlace_input").val() == gEndPlaceTip
			|| $("#endPlace_input").val() == "") {
		alert("请选择到达地");
		$("#endPlace_input").focus();
		return false;
	} else if ($("#endPlace").val() == "") {
		alert("请选择到达地的城市、县区");
		$("#endPlace_input").focus();
		return false;
	}
	if ($.trim($("#weight").val()) == gWeightSug) {
		$("#weight").val("1");
	}
	if ($.trim($("#weight").val()).indexOf("。") > -1) {
		alert("重量需要输入正确的小数点");
		$("#weight").select();
		return false;
	}
	if ($.trim($("#weight").val()) != "" && !isNumber($("#weight").val())) {
		alert("重量需要输入正数");
		$("#weight").select();
		return false;
	}
	var orderSource = GetQueryString("orderSource");
	if (orderSource == "") {
		orderSource = "none";
	}

	setcookie("startPlace_input", $("#startPlace_input").val());
	setcookie("startPlace", $("#startPlace").val());

	var queryHref = "trans.html?orderSource="
			+ orderSource + "&headerMenu=orderIndex&startPlace_input="
			+ encodeURIComponent($("#startPlace_input").val()) + "&startPlace="
			+ $("#startPlace").val() + "&endPlace_input="
			+ encodeURIComponent($("#endPlace_input").val()) + "&endPlace="
			+ $("#endPlace").val() + "&weight=" + $.trim($("#weight").val());
	$("#queryPriceHref").attr("href", queryHref);
	return true;
}

/* 查找订单 */
function toOrderList(thiz) {
	var loginStatus = $("#loginStatus").val();
	if (loginStatus != "") { // 已登录
		$(thiz).attr("href", "/user/orderList.shtml");
	} else {
		$(thiz).attr("href", "/login.html");
	}
}

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
