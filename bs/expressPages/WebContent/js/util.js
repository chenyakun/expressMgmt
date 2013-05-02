var gCompanyCode = "";
var gCompanyName = "";
var gCompanyUrl = "";
var gKuaidiNumber = "";
var gValiCode = "";
var gHasVali = "";
var gCheckStr = "";
var gCheckInfo = "";
var gTimeout = 30000;
var gQueryTipText = "请输入您要查询的单号";
var gIsReAddQuery = false;
var gAjaxGet;
var gQueryResult;
var gIsCheck;
var gIsRss = 0;
var gRssId = 0;
var gQueryId = 0;
var gResultJson;
var gResultData;
var gSortStatus = 0;
$(document).ready(function() {
	document.onkeydown = keyDown;
	initPostid()
});
function initPostid() {
	var a = $("#postid");
	if (a.val() == "") {
		a.css("font-size", "14px");
		a.css("color", "#B2B2B2");
		a.css("line-height", a.css("height"));
		a.val(gQueryTipText)
	} else {
		a.css("font-size", "24px");
		a.css("color", "black");
		a.css("line-height", a.css("height"))
	}
	a.focus(postidFocus).blur(postidBlur).focus();
	a.keydown(function(b) {
		$("#errorTips").hide()
	})
}

function postidFocus() {
	var a = $("#postid");
	if (a.val() == gQueryTipText) {
		a.val("")
	}
	a.css("font-size", "24px");
	a.css("color", "black");
	$("#postid").select()
}

function postidBlur() {
	var a = $("#postid");
	if (a.val() == "") {
		a.val(gQueryTipText);
		a.css("font-size", "14px");
		a.css("color", "#B2B2B2")
	}
}

function keyDown(a) {
	a = (a) ? a : ((window.event) ? window.event : "");
	var c = a.keyCode ? a.keyCode : a.which;
	var b = a.srcElement ? a.srcElement : a.target;
	if (a.keyCode == 13) {
		if (b.name == "postid") {
			if (document.getElementById("valideBox").style.display != "none") {
				document.getElementById("valicode").focus();
				return

			} else {
				if (document.getElementById("telBox").style.display != "none") {
					document.getElementById("valicodetel").focus();
					return

				} else {
					query();
					return

				}
			}
		} else {
			if (b.name == "valicode") {
				query();
				return

			} else {
				if (b.name == "valicodetel") {
					query();
					return

				}
			}
		}
	} else {
		if (a.keyCode == 9) {
			if (b.id == "postid") {
				if (document.getElementById("valideBox").style.display != "none") {
					document.getElementById("valicode").focus();
					return false
				} else {
					if (document.getElementById("telBox").style.display != "none") {
						document.getElementById("valicodetel").focus();
						return false
					} else {
						document.getElementById("query").focus();
						return false
					}
				}
			} else {
				if (b.id == "valicode") {
					document.getElementById("query").focus();
					return false
				} else {
					if (b.id == "valicodetel") {
						document.getElementById("query").focus();
						return false
					} else {
						if (b.id == "query") {
							return false
						}
					}
				}
			}
		}
	}
}
/*
 * function selectCompanyByCode(m) {
 * 
 * 
 * //TODO:// gCompanyCode = m;
 * 
 * gCompanyCode = 'yunda';
 * 
 * if (gCompanyCode == "shentong" || gCompanyCode == "yuantong" || gCompanyCode ==
 * "shunfeng" || gCompanyCode == "ems" || gCompanyCode == "yunda" ||
 * gCompanyCode == "zhongtong") { $("#queryContext .tagBox").show() } else {
 * $("#queryContext .tagBox").hide() } var k = jsoncom.company; for (var f = 0;
 * f < k.length; f++) { if (gCompanyCode == k[f].code) { var j =
 * k[f].companyname; gCompanyName = j; var d = k[f].shortname; var e = k[f].tel;
 * var c = k[f].hasvali; var a = k[f].url; var h = k[f].isavailable; var b =
 * k[f].promptinfo; var g = k[f].comurl; var l = k[f].testnu; gCheckStr =
 * k[f].freg; gCheckInfo = k[f].freginfo; gCompanyUrl = g; queryurl =
 * k[f].queryurl; isavailable = k[f].isavailable; if (queryurl != "" &&
 * isavailable == 1) { c = 0 } if (l != null && l != "") {
 * $("#inputTips").find("a").html(l); $("#inputTips").show() } if (h != null &&
 * h == "1" && queryurl == "") { if (b != null && b != "") {
 * $("#errorTips").show(); b = b.replace("官网试试", "<a href='" + g + "'
 * target='_blank'>官网试试</a>"); $("#errorMessage").html(b) } else {
 * $("#errorMessage").html(j + "网站不稳定，请稍后尝试查询.") } $("#errorTips").show() } else {
 * $("#errorTips").hide() } if (c == "1") { gHasVali = c;
 * $("#valideBox").show(); $("#telBox").hide(); refreshCode() } else { if (c ==
 * "2") { gHasVali = c; $("#valideBox").hide(); $("#telBox").hide() } else {
 * gHasVali = c; $("#valideBox").hide(); $("#telBox").hide() } } if (a != null &&
 * a != "") { if ( typeof (frameflag) == "undefined") {
 * $("#companyinfobox").hide(); $("#companyName").html("<a href='/all/" + a +
 * ".shtml'>" + j + "</a>") } else { if (frameflag != null && frameflag) {
 * $("#companyinfobox").show(); $("#companyName").html("<a href='/all/" + a +
 * ".shtml' target='_blank' >" + j + "</a>") } else {
 * $("#companyinfobox").hide(); $("#companyName").html("<a href='/all/" + a +
 * ".shtml'>" + j + "</a>") } } } else { $("#companyinfobox").hide();
 * $("#companyName").html(j) } if (g != null && g != "") {
 * $("#companyinfobox").show(); $("#companyUrl").html("<a href='" + g + "'
 * target='_blank'>官网地址</a>") } $("#companyTel").html("查询电话：" + e);
 * $("#queryCompany").html(d); $(".ico_newtag").show(); break } } }
 */
function addQuery() {
	var loginAccount = getcookie("loginAccount");
	if (loginAccount && loginAccount != "") {
		var addQueryUrl = "/userquery/add";
		var kuaidicom = gCompanyCode;
		var kuaidinum = gKuaidiNumber;
		$.post(addQueryUrl, {
			kuaidicom : kuaidicom,
			kuaidinum : kuaidinum,
			ffirststatus : 200
		}, function(responseText) {
			var resultJson = eval("(" + responseText + ")");
			if (resultJson.status == "440") {
				gIsReAddQuery = true;
				login()
			}
		})
	} else {
		ToolBoxAdd()
	}
}

function queryFromUrl() {
	var a = $("<form></form>");
	a.attr("action", queryurl + gKuaidiNumber);
	a.attr("method", "post");
	a.attr("target", "_blank");
	a.appendTo("body");
	a.css("display", "none");
	a.submit();
	$.ajax({
		type : "post",
		url : "/userquery/add",
		data : "kuaidicom=" + gCompanyCode + "&kuaidinum=" + gKuaidiNumber
				+ "&ffirststatus=0",
		success : function(b) {
		}
	})
}

function notFindTipsCtrl() {
	var a = gKuaidiNumber.split("");
	for ( var b = 4; b < a.length; b += 5) {
		a.splice(b, 0, "&nbsp;&nbsp;")
	}
	$("#tips-com-name").html(gCompanyName);
	$("#tips-com-name").attr("title", gCompanyName);
	$("#tips-kuaidi-num").html(a.join(""))
}

function getResult(d, a) {
	var c = "./PackageQueryServlet";
	if (gHasVali == "1" || gHasVali == "2") {
		c = "/queryvalid"
	}
	gCompanyCode = d;
	gKuaidiNumber = a;

	/*
	 * if (queryurl != "" && isavailable == 1) { queryFromUrl(); return false }
	 */
	var b = "type=" + gCompanyCode + "&postid=" + gKuaidiNumber + "&id="
			+ gQueryType + "&valicode=" + gValiCode + "&temp=" + Math.random();
	c = c + "?" + b;
	$("#queryWait").show();
	if (gCompanyUrl != null && gCompanyUrl != "") {
		$("#gocompanyUrl").html(
				"<a href='" + gCompanyUrl
						+ "'  target='_blank'>官网查询试试&gt;&gt;</a>");
		$("#gocompanyUrl2").html(
				"<a href='" + gCompanyUrl
						+ "'  target='_blank'>官网查询试试&gt;&gt;</a>");
		$("#gocompanyUrl3").html(
				"<a href='" + gCompanyUrl
						+ "'  target='_blank'>官网查询试试&gt;&gt;</a>");
		$("#gocompanyUrl4").html(
				"<a href='" + gCompanyUrl
						+ "'  target='_blank'>官网查询试试&gt;&gt;</a>");
		$("#gocompanyUrl5").attr("href", gCompanyUrl)
	} else {
		$("#gocompanyUrl").html(gCompanyName);
		$("#gocompanyUrl2").html(gCompanyName);
		$("#gocompanyUrl3").html(gCompanyName);
		$("#gocompanyUrl4").html(gCompanyName)
	}
	gAjaxGet = $
			.ajax({
				type : "GET",
				url : c,
				timeout : gTimeout,
				success : function(j) {
					notFindTipsCtrl();
					$("#friendTip").attr("className", "tips font14px");
					$("#queryWait").hide();
					$("#sendHistory").hide();
					$("#rss-div").hide();
					$("#sendHistoryBtn").show();
					gIsCheck = 0;
					if (j.length == 0) {
						$("#companyWebTips").hide();
						$("#notFindTip2").show();
						if (gCompanyCode == "ems" && gHasVali == 1) {
							$("#notFindTipForEMS").show()
						} else {
							if (gCompanyCode == "shunfeng" && gHasVali == 1) {
								$("#notFindTipForSF").show()
							} else {
								$("#notFindErro").show();
								$("#timeOutErro").hide();
								$("#notFindTip").show();
								if ($("#loginStatus").val() != "1") {
									$("#voteTips")
											.html(
													'·输入邮箱即可永久保存历史单号，方便下次查询，<a href="/login.html"><strong>马上试试&gt;&gt;</strong></a>')
								} else {
									$("#voteTips")
											.html(
													'·您输入的单号已保存在"我的查询记录"中，<a href="/user/history.shtml"><strong>去看看吧&gt;&gt;</strong></a>')
								}
							}
						}
						return

					}
					console.log(j);
					var e = eval("(" + j + ")");
					gResultJson = e;
					gQueryResult = e.status;
					if (e.status == 200) {
						var f = e.data;
						gResultData = f;
						gIsCheck = e.ischeck;
						var k = $("#queryResult2");
						k.empty();
						for ( var g = f.length - 1; g >= 0; g--) {
							var h = "";
							if (f.length == 1 && gIsCheck == 0) {
								h = "status status-wait"
							} else {
								if (f.length == 1 && gIsCheck == 1) {
									h = "status status-check"
								} else {
									if (g == 0 && gIsCheck == 0) {
										h = "status status-wait"
									} else {
										if (g == 0 && gIsCheck == 1) {
											h = "status status-check"
										} else {
											if (g == f.length - 1) {
												h = "status status-first"
											} else {
												h = "status"
											}
										}
									}
								}
							}
							if (g == 0) {
								k.append('<tr class="last"><td class="row1">'
										+ f[g].ftime + '</td><td class="' + h
										+ '">&nbsp;</td><td>' + f[g].context
										+ "</td></tr>")
							} else {
								k.append('<tr><td class="row1">' + f[g].ftime
										+ '</td><td class="' + h
										+ '">&nbsp;</td><td>' + f[g].context
										+ "</td></tr>")
							}
						}
						$("#adDiv").show();
						$("#queryContext").show();
						$("#selectedTag").hide();
						$("#kdNameNum").html(
								gCompanyName + "单号：<strong>" + gKuaidiNumber
										+ "</strong>");
						$("#GoogleAD").show()
					} else {
						if (e.status == 408) {
							$("#errorTips").show();
							if (gQueryType == 2) {
								$("#errorMessage").html(
										"需要验证码，请到快递查询页面输入验证码查询！")
							} else {
								$("#errorMessage").html("您输入的验证码错误，请重新输入！")
							}
							if ($("#valideBox").is(":visible")) {
								$("#valicode").focus()
							}
						} else {
							if (e.status == 201) {
								$("#companyWebTips").show();
								$("#notFindTip2").show();
								if (typeof (showCopyNotfind) != "undefined") {
									showCopyNotfind()
								}
								if (gCompanyCode == "ems" && gHasVali == 1) {
									$("#notFindTipForEMS").show()
								} else {
									if (gCompanyCode == "shunfeng"
											&& gHasVali == 1) {
										$("#notFindTipForSF").show()
									} else {
										$("#notFindErro").show();
										$("#timeOutErro").hide();
										$("#notFindTip").show();
										if ($("#loginStatus").val() != "1") {
											$("#voteTips")
													.html(
															'·输入邮箱即可永久保存历史单号，方便下次查询，<a href="/login.html"><strong>马上试试&gt;&gt;</strong></a>')
										} else {
											$("#voteTips")
													.html(
															'·您输入的单号已保存在"我的查询记录"中，<a href="/user/history.shtml"><strong>去看看吧&gt;&gt;</strong></a>')
										}
									}
								}
							} else {
								if (e.status == 700) {
									queryFromUrl()
								} else {
									$("#companyWebTips").hide();
									$("#notFindTip2").show();
									if (typeof (showCopyNotfind) != "undefined") {
										showCopyNotfind()
									}
									if (gCompanyCode == "ems" && gHasVali == 1) {
										$("#notFindTipForEMS").show()
									} else {
										if (gCompanyCode == "shunfeng"
												&& gHasVali == 1) {
											$("#notFindTipForSF").show()
										} else {
											$("#notFindErro").hide();
											$("#timeOutErro").show();
											$("#notFindTip").show();
											if ($("#loginStatus").val() != "1") {
												$("#voteTips")
														.html(
																'·输入邮箱即可永久保存历史单号，方便下次查询，<a href="/login.html"><strong>马上试试&gt;&gt;</strong></a>')
											} else {
												$("#voteTips")
														.html(
																'·您输入的单号已保存在"我的查询记录"中，<a href="/user/history.shtml"><strong>去看看吧&gt;&gt;</strong></a>')
											}
										}
									}
								}
							}
						}
					}
					if (gHasVali == "1") {
						refreshCode()
					}
					if ($("#loginStatus").val() != "1") {
						ToolBoxAdd();
						countHis()
					}
				},
				error : function(f, e) {
					if (e == "timeout") {
						onTimeout()
					}
				}
			})
}

function sortToggle() {
	if (gSortStatus == 1) {
		sortup();
		gSortStatus = 0
	} else {
		sortdown();
		gSortStatus = 1
	}
}

function sortup() {
	var b = $("#queryResult");
	var a = gResultData;
	b.empty();
	b
			.append('<tr><th class="width-01" onclick="sortToggle()"><span class="b-btn"><b class="b-up b-up-active"></b><b class="b-down"></b></span>时间</th><th class="width-02">地点和跟踪进度</th></tr>');
	for ( var c = 0; c < a.length; c++) {
		if (c == 0) {
			b.append('<tr class="row1"><td>' + a[c].time + "</td><td>"
					+ a[c].context + "<span class='lastTag'></span></td></tr>")
		} else {
			b.append('<tr><td class="row">' + a[c].time + "</td><td>"
					+ a[c].context + "</td></tr>")
		}
	}
	b.show()
}

function sortdown() {
	var b = $("#queryResult");
	var a = gResultData;
	b.empty();
	b
			.append('<tr><th class="width-01" onclick="sortToggle()"><span class="b-btn"><b class="b-up"></b><b class="b-down b-down-active"></b></span>时间</th><th class="width-02">地点和跟踪进度</th></tr>');
	for ( var c = a.length - 1; c >= 0; c--) {
		if (c == 0) {
			b.append('<tr class="row1"><td>' + a[c].time + "</td><td>"
					+ a[c].context + "<span class='lastTag'></span></td></tr>")
		} else {
			b.append('<tr><td class="row">' + a[c].time + "</td><td>"
					+ a[c].context + "</td></tr>")
		}
	}
	b.show()
}

function setComment(a) {
	$.ajax({
		type : "POST",
		url : "/userquery/update",
		data : "kuaidicom=" + gCompanyCode + "&kuaidinum=" + gKuaidiNumber
				+ "&fcomment=" + encodeURIComponent(encodeURIComponent(a))
	})
}

function showTips(a) {
	$(".tips-green").html(a);
	clearInterval(t);
	$(".tips-green").fadeIn("normal");
	t = setInterval("$('.tips-green').fadeOut('normal')", 5000)
}

function hideTips() {
	$("#inputTips").hide();
	$("#friendTip").hide();
	$("#queryWait").hide();
	$("#errorTips").hide();
	$("#adDiv").hide();
	$("#queryContext").hide();
	$("#baiduMap").hide();
	$("#notFindTip").hide();
	$("#notFindTip2").hide();
	$("#notFindTipForEMS").hide();
	$("#notFindTipForSF").hide();
	if (gAjaxGet) {
		gAjaxGet.abort()
	}
}

function validateKuaidiNumber() {
	if ($("#queryWait").is(":visible")) {
		return false
	}
	gKuaidiNumber = $.trim($("#postid").val());
	if (gCompanyCode == "rufengda"
			&& checkRegOfcompany(gKuaidiNumber, "^\\d{16}$")) {
		gKuaidiNumber = "DD" + gKuaidiNumber
	}
	$("#postid").val(gKuaidiNumber);
	gValiCode = $.trim($("#valicode").val());
	hideTips();
	var a = "";
	if ($("#companyListType").val() != null
			&& $("#companyListType").val() == "wuliuCompanyList") {
		a = "物流"
	} else {
		a = "快递"
	}
	if (gCompanyCode == "") {
		$("#errorTips").show();
		if (gQueryType == 13 || gQueryType == 14) {
			$("#errorMessage").html("请您在上方选择一家" + a + "公司")
		} else {
			$("#errorMessage").html("请您在左侧列表中选择一家" + a + "公司")
		}
		return false
	}
	if (gKuaidiNumber == "" || gKuaidiNumber == gQueryTipText) {
		$("#errorTips").show();
		$("#errorMessage").html("请您填写" + a + "单号。");
		$("#postid").focus();
		return false
	}
	if (!isNumberLetterFuhao(gKuaidiNumber)) {
		$("#errorTips").show();
		$("#errorMessage").html("单号仅能由数字、字母和特殊符号组合，请您查证。");
		$("#postid").focus();
		return false
	}
	if (gKuaidiNumber.length < 5) {
		$("#errorTips").show();
		$("#errorMessage").html("单号不能小于5个字符，请您查证。");
		$("#postid").focus();
		return false
	}
	if (gKuaidiNumber.length > 30) {
		$("#errorTips").show();
		$("#errorMessage").html("单号不能超过30个字符，请您查证。");
		$("#postid").focus();
		return false
	}
	if ((gKuaidiNumber.slice(0, 2)).toLowerCase() == "lp") {
		$("#errorTips").show();
		$("#errorMessage").html("以[LP]开头的是淘宝内部单号，用运单号码才可查询。");
		$("#postid").focus();
		return false
	}
	if (gCheckStr != "" && gCheckStr != null) {
		if (!checkRegOfcompany(gKuaidiNumber, gCheckStr)) {
			$("#errorTips").show();
			$("#errorMessage").html(gCheckInfo);
			$("#postid").focus();
			return false
		}
	}
	if (gHasVali == "1" && gValiCode == "") {
		$("#errorTips").show();
		$("#errorMessage").html("请您填写验证码。");
		$("#valicode").focus();
		return false
	}
	if (gHasVali == "1" && !isNumberLetterFuhao(gValiCode)) {
		$("#errorTips").show();
		$("#errorMessage").html("验证码仅能由数字、字母和特殊符号组合，请您查证。");
		$("#valicode").focus();
		return false
	}
	return true
}

function refreshCode() {
	$("#valicode").val("");
	$("#valiimages").attr("src", "http://cdn.kuaidi100.com/images/clear.gif");
	$("#valiimages").width(1);
	$("#valiimages").height(1);
	var a = "/images?type=" + gCompanyCode + "&temp=" + Math.random();
	$("#valiimages").attr("src", a);
	$("#valiimages").width(100);
	$("#valiimages").height(34);
	$("#valicode").focus()
}

function isNumberOrLetter(c) {
	var a = "^[0-9a-zA-Z]+$";
	var b = new RegExp(a);
	if (b.test(c)) {
		return true
	} else {
		return false
	}
}

function isNumberLetterFuhao(c) {
	var a = "^[0-9a-zA-Z@#$-]+$";
	var b = new RegExp(a);
	if (b.test(c)) {
		return true
	} else {
		return false
	}
}

function checkRegOfcompany(c, a) {
	c = c.toUpperCase();
	var b = new RegExp(a);
	if (b.test(c)) {
		return true
	} else {
		return false
	}
}

function onTimeout() {
	if ($("#queryWait").is(":visible")) {
		$("#queryWait").hide();
		$("#errorTips").show();
		$("#errorMessage").html("查询时间过长，请您稍后查询。")
	}
}

function gotofeedback() {
	window.open("/help/feedback.shtml?mscomcode=" + gCompanyCode + "&mscomnu="
			+ gKuaidiNumber + "&msrandommath=" + Math.random())
}
String.prototype.isTel = function() {
	return (/^([0-9]{3,4}\-[0-9]{3,8}$)|(^[0-9]{3,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^[0-9]{3,12}$)|(^((\(\d{3}\))|(\d{3}\-))?1[358]\d{9})$/
			.test(this.Trim()))
};
String.prototype.isMobile = function() {
	return (/^(?:13\d|14\d|15\d|18\d)-?\d{5}(\d{3}|\*{3})$/.test(this.Trim()))
};
String.prototype.Trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, "")
};
var ZeroClipboard = {
	version : "1.0.7",
	clients : {},
	moviePath : "ZeroClipboard.swf",
	nextId : 1,
	$ : function(a) {
		if (typeof (a) == "string") {
			a = document.getElementById(a)
		}
		if (!a.addClass) {
			a.hide = function() {
				this.style.display = "none"
			};
			a.show = function() {
				this.style.display = ""
			};
			a.addClass = function(b) {
				this.removeClass(b);
				this.className += " " + b
			};
			a.removeClass = function(d) {
				var e = this.className.split(/\s+/);
				var b = -1;
				for ( var c = 0; c < e.length; c++) {
					if (e[c] == d) {
						b = c;
						c = e.length
					}
				}
				if (b > -1) {
					e.splice(b, 1);
					this.className = e.join(" ")
				}
				return this
			};
			a.hasClass = function(b) {
				return !!this.className.match(new RegExp("\\s*" + b + "\\s*"))
			}
		}
		return a
	},
	setMoviePath : function(a) {
		this.moviePath = a
	},
	dispatch : function(d, b, c) {
		var a = this.clients[d];
		if (a) {
			a.receiveEvent(b, c)
		}
	},
	register : function(b, a) {
		this.clients[b] = a
	},
	getDOMObjectPosition : function(c, a) {
		var b = {
			left : 0,
			top : 0,
			width : c.width ? c.width : c.offsetWidth,
			height : c.height ? c.height : c.offsetHeight
		};
		while (c && (c != a)) {
			b.left += c.offsetLeft;
			b.top += c.offsetTop;
			c = c.offsetParent
		}
		return b
	},
	Client : function(a) {
		this.handlers = {};
		this.id = ZeroClipboard.nextId++;
		this.movieId = "ZeroClipboardMovie_" + this.id;
		ZeroClipboard.register(this.id, this);
		if (a) {
			this.glue(a)
		}
	}
};
ZeroClipboard.Client.prototype = {
	id : 0,
	ready : false,
	movie : null,
	clipText : "",
	handCursorEnabled : true,
	cssEffects : true,
	handlers : null,
	glue : function(d, b, e) {
		this.domElement = ZeroClipboard.$(d);
		var f = 99;
		if (this.domElement.style.zIndex) {
			f = parseInt(this.domElement.style.zIndex, 10) + 1
		}
		if (typeof (b) == "string") {
			b = ZeroClipboard.$(b)
		} else {
			if (typeof (b) == "undefined") {
				b = document.getElementsByTagName("body")[0]
			}
		}
		var c = ZeroClipboard.getDOMObjectPosition(this.domElement, b);
		this.div = document.createElement("div");
		var a = this.div.style;
		a.position = "absolute";
		a.left = "" + c.left + "px";
		a.top = "" + c.top + "px";
		a.width = "" + c.width + "px";
		a.height = "" + c.height + "px";
		a.zIndex = f;
		if (typeof (e) == "object") {
			for (addedStyle in e) {
				a[addedStyle] = e[addedStyle]
			}
		}
		b.appendChild(this.div);
		this.div.innerHTML = this.getHTML(c.width, c.height)
	},
	getHTML : function(d, a) {
		var c = "";
		var b = "id=" + this.id + "&width=" + d + "&height=" + a;
		if (navigator.userAgent.match(/MSIE/)) {
			var e = location.href.match(/^https/i) ? "https://" : "http://";
			c += '<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="'
					+ e
					+ 'download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0" width="'
					+ d
					+ '" height="'
					+ a
					+ '" id="'
					+ this.movieId
					+ '" align="middle"><param name="allowScriptAccess" value="always" /><param name="allowFullScreen" value="false" /><param name="movie" value="'
					+ ZeroClipboard.moviePath
					+ '" /><param name="loop" value="false" /><param name="menu" value="false" /><param name="quality" value="best" /><param name="bgcolor" value="#ffffff" /><param name="flashvars" value="'
					+ b
					+ '"/><param name="wmode" value="transparent"/></object>'
		} else {
			c += '<embed id="'
					+ this.movieId
					+ '" src="'
					+ ZeroClipboard.moviePath
					+ '" loop="false" menu="false" quality="best" bgcolor="#ffffff" width="'
					+ d
					+ '" height="'
					+ a
					+ '" name="'
					+ this.movieId
					+ '" align="middle" allowScriptAccess="always" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" flashvars="'
					+ b + '" wmode="transparent" />'
		}
		return c
	},
	hide : function() {
		if (this.div) {
			this.div.style.left = "-2000px"
		}
	},
	show : function() {
		this.reposition()
	},
	destroy : function() {
		if (this.domElement && this.div) {
			this.hide();
			this.div.innerHTML = "";
			var a = document.getElementsByTagName("body")[0];
			try {
				a.removeChild(this.div)
			} catch (b) {
			}
			this.domElement = null;
			this.div = null
		}
	},
	reposition : function(d, b) {
		if (d) {
			this.domElement = ZeroClipboard.$(d);
			if (!this.domElement) {
				this.hide()
			}
		}
		if (typeof (b) == "string") {
			b = ZeroClipboard.$(b)
		} else {
			if (typeof (b) == "undefined") {
				b = document.getElementsByTagName("body")[0]
			}
		}
		if (this.domElement && this.div) {
			var c = ZeroClipboard.getDOMObjectPosition(this.domElement, b);
			var a = this.div.style;
			a.left = "" + c.left + "px";
			a.top = "" + c.top + "px"
		}
	},
	setText : function(a) {
		this.clipText = a;
		if (this.ready) {
			this.movie.setText(a)
		}
	},
	addEventListener : function(a, b) {
		a = a.toString().toLowerCase().replace(/^on/, "");
		if (!this.handlers[a]) {
			this.handlers[a] = []
		}
		this.handlers[a].push(b)
	},
	setHandCursor : function(a) {
		this.handCursorEnabled = a;
		if (this.ready) {
			this.movie.setHandCursor(a)
		}
	},
	setCSSEffects : function(a) {
		this.cssEffects = !!a
	},
	receiveEvent : function(d, e) {
		d = d.toString().toLowerCase().replace(/^on/, "");
		switch (d) {
		case "load":
			this.movie = document.getElementById(this.movieId);
			if (!this.movie) {
				var c = this;
				setTimeout(function() {
					c.receiveEvent("load", null)
				}, 1);
				return

			}
			if (!this.ready && navigator.userAgent.match(/Firefox/)
					&& navigator.userAgent.match(/Windows/)) {
				var c = this;
				setTimeout(function() {
					c.receiveEvent("load", null)
				}, 100);
				this.ready = true;
				return

			}
			this.ready = true;
			this.movie.setText(this.clipText);
			this.movie.setHandCursor(this.handCursorEnabled);
			break;
		case "mouseover":
			if (this.domElement && this.cssEffects) {
				this.domElement.addClass("hover");
				if (this.recoverActive) {
					this.domElement.addClass("active")
				}
			}
			break;
		case "mouseout":
			if (this.domElement && this.cssEffects) {
				this.recoverActive = false;
				if (this.domElement.hasClass("active")) {
					this.domElement.removeClass("active");
					this.recoverActive = true
				}
				this.domElement.removeClass("hover")
			}
			break;
		case "mousedown":
			if (this.domElement && this.cssEffects) {
				this.domElement.addClass("active")
			}
			break;
		case "mouseup":
			if (this.domElement && this.cssEffects) {
				this.domElement.removeClass("active");
				this.recoverActive = false
			}
			break
		}
		if (this.handlers[d]) {
			for ( var b = 0, a = this.handlers[d].length; b < a; b++) {
				var f = this.handlers[d][b];
				if (typeof (f) == "function") {
					f(this, e)
				} else {
					if ((typeof (f) == "object") && (f.length == 2)) {
						f[0][f[1]](this, e)
					} else {
						if (typeof (f) == "string") {
							window[f](this, e)
						}
					}
				}
			}
		}
	}
};
var jsoncookie;
function __getIE() {
	if (window.ActiveXObject) {
		var a = navigator.userAgent.match(/MSIE([^;]+)/)[1];
		return parseFloat(a.substring(0, a.indexOf(".")))
	}
	return false
}
Array.prototype.foreach = function(b) {
	if (b && this.length > 0) {
		for ( var a = 0; a < this.length; a++) {
			b(this[a])
		}
	}
};
String.format = function() {
	if (arguments.length == 0) {
		return null
	}
	var c = arguments[0];
	for ( var b = 1; b < arguments.length; b++) {
		var a = new RegExp("\\{" + (b - 1) + "\\}", "gm");
		c = c.replace(a, arguments[b])
	}
	return c
};
String.prototype.startWith = function(a) {
	return this.indexOf(a) == 0
};
String.prototype.startWith = function(a) {
	var b = this.length - a.length;
	return (b >= 0 && this.lastIndexOf(a) === b)
};
String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, "")
};
function getid(a) {
	return (typeof a == "string") ? document.getElementById(a) : a
}
document.getElementsByClassName = function(c) {
	var b = document.getElementsByTagName("*") || document.all;
	var e = [];
	for ( var d = 0; d < b.length; d++) {
		if (b[d].className) {
			var f = b[d].className.split(" ");
			for ( var a = 0; a < f.length; a++) {
				if (c == f[a]) {
					e.push(b[d]);
					break
				}
			}
		}
	}
	return e
};
function getOffsetTop(a, c) {
	var b = a.offsetTop;
	while (a = a.offsetParent) {
		if (a == c) {
			break
		}
		b += a.offsetTop
	}
	return b
}

function getOffsetLeft(b, c) {
	var a = b.offsetLeft;
	while (b = b.offsetParent) {
		if (b == c) {
			break
		}
		a += b.offsetLeft
	}
	return a
}

function attach(c, b, a) {
	if (document.attachEvent) {
		c.attachEvent("on" + b, a)
	} else {
		if (document.addEventListener) {
			c.addEventListener(b, a, false)
		}
	}
}

var currentInput = null;
function BoxShowUrls() {
	var a = getid("postid");
	var b = getid("ToolBox");
	currentInput = a;
	FillUrls();
	b.style.left = getOffsetLeft(a) + "px";
	b.style.top = (getOffsetTop(a) + (a.offsetHeight - 1)) + "px";
	b.style.width = (a.offsetWidth - 2) + "px";
	b.style.display = "block"
}

function InputSetValue(d) {
	var f = jsoncookie.history;
	var e = jsoncookie.history;
	var c = e[d].code;
	var b = e[d].nu;
	setCookie("comcode", c);
	setCookie("inputpostid", b);
	ischoose = false;
	clear();
	var a = document.getElementById("postid");
	a.value = b
}

function ToolBoxAdd(q, g, e) {
	jsoncookie = getCookieTojson();
	var k = "";
	var c = "";
	var a = "";
	if (q != null && q != "") {
		c = q
	} else {
		c = gCompanyCode
	}
	if (g != null && g != "") {
		k = g
	} else {
		k = gKuaidiNumber
	}
	if (e != null && e != "") {
		a = e
	} else {
		a = gIsCheck
	}
	var j = "";
	/*
	 var m = jsoncom.company;
	for ( var f = 0; f < m.length; f++) {
		if (c == m[f].code) {
			j = m[f].shortname;
			break
		}
	}	
	*/
	if (k == "") {
		return

	}
	var o = hasJson(c, k);
	var h = null;
	var l = new Date();
	if (o == -3) {
		var d = new historyinfo(0, j, c, k, l.toString(), a);
		d = _ToJSON(d);
		jsoncookie.name = "kuaidicookie";
		jsoncookie.creatdate = l.toDateString();
		jsoncookie.history = [];
		jsoncookie.history.push(d)
	} else {
		if (o == -2) {
		} else {
			if (o == -1) {
				var n = jsoncookie.history;
				if (n.length >= 10) {
					ToolBoxDeleteValue("0");
					jsoncookie = getCookieTojson();
					n = jsoncookie.history
				}
				jsoncookie.history = [];
				jsoncookie.history.push(n);
				var b = jsoncookie.history.length;
				var d = new historyinfo(jsoncookie.history.length, j, c, k, l
						.toString(), a);
				d = _ToJSON(d);
				jsoncookie.history.push(d)
			}
		}
	}
	var p = _ToJSON(jsoncookie);
	p = p.replace('"history":', '"history":[');
	p = p.replace("}}", "}]}");
	setcookie("toolbox_urls", p)
}

function ToolBoxDeleteValue(b) {
	jsoncookie = getCookieTojson();
	delete jsoncookie.history[b];
	deleteCookie("toolbox_urls");
	var a = _ToJSON(jsoncookie);
	if (jsoncookie.history.length == 1) {
		a = "{}"
	} else {
		a = a.replace(",null", "");
		a = a.replace("null,", "");
		a = a.replace('"history":', '"history":[');
		a = a.replace("}}", "}]}")
	}
	setcookie("toolbox_urls", a)
}

function FillUrls() {
	jsoncookie = getCookieTojson();
	var e = "<li class='tool-but' onclick='ToolBoxAdd()'>临时保存输入框的单号</li>";
	if (_ToJSON(jsoncookie) != "{}") {
		var h = jsoncookie.history;
		if (h == null) {
			e += ""
		} else {
			for ( var d = h.length - 1; d > -1; d--) {
				var a = h[d].order;
				var g = h[d].code;
				var c = h[d].nu;
				var b = h[d].com;
				var f = b + ":" + c;
				e += "<li><img src='http://cdn.kuaidi100.com/images/bg_tool.gif' alt='删除' onclick=\"ToolBoxDeleteValue('"
						+ d
						+ "');\" style='cursor:pointer' /><a href=\"javascript:InputSetValue('"
						+ d + "');\">" + f + "</a></li>"
			}
		}
	} else {
		e += ""
	}
	getid("xlist").innerHTML = e
}

function hasJson(d, h) {
	jsoncookie = getCookieTojson();
	var g = -1;
	if (_ToJSON(jsoncookie) == "{}") {
		return -3
	}
	if (d == null || d == "" || h == null || h == "") {
		return g = -2
	}
	var f = jsoncookie.history;
	if (f == null) {
		return g
	}
	for ( var c = 0; c < f.length; c++) {
		var a = f[c].order;
		var e = f[c].code;
		var b = f[c].nu;
		if (d == e && h == b) {
			g = c
		}
	}
	return g
}

function historyinfo(a, b, d, c, f, e) {
	this.order = a;
	this.com = b;
	this.code = d;
	this.nu = c;
	this.time = f;
	this.ischeck = e
}

function getWenZi(a) {
	return a.replace(/<\/?.+?>/g, "")
}

var EvPNG = {
	ns : "EvPNG",
	imgSize : {},
	createVmlNameSpace : function() {
		if (document.namespaces && !document.namespaces[this.ns]) {
			document.namespaces.add(this.ns, "urn:schemas-microsoft-com:vml")
		}
		if (window.attachEvent) {
			window.attachEvent("onbeforeunload", function() {
				EvPNG = null
			})
		}
	},
	createVmlStyleSheet : function() {
		var d = document.createElement("style");
		document.documentElement.firstChild.insertBefore(d,
				document.documentElement.firstChild.firstChild);
		var c = d.styleSheet;
		c.addRule(this.ns + "\\:*", "{behavior:url(#default#VML)}");
		c.addRule(this.ns + "\\:shape", "position:absolute;");
		c
				.addRule(
						"img." + this.ns + "_0",
						"behavior:none; border:none; position:absolute; z-index:-1; top:-10000px; visibility:hidden;");
		this.styleSheet = c
	},
	readPropertyChange : function() {
		var d = event.srcElement;
		if (event.propertyName.search("background") != -1
				|| event.propertyName.search("border") != -1) {
			EvPNG.applyVML(d)
		}
		if (event.propertyName == "style.display") {
			var c = (d.currentStyle.display == "none") ? "none" : "block";
			for ( var e in d.vml) {
				d.vml[e].shape.style.display = c
			}
		}
		if (event.propertyName.search("filter") != -1) {
			EvPNG.vmlOpacity(d)
		}
	},
	vmlOpacity : function(d) {
		if (d.currentStyle.filter.search("lpha") != -1) {
			var c = d.currentStyle.filter;
			c = parseInt(c
					.substring(c.lastIndexOf("=") + 1, c.lastIndexOf(")")), 10) / 100;
			d.vml.color.shape.style.filter = d.currentStyle.filter;
			d.vml.image.fill.opacity = c
		}
	},
	handlePseudoHover : function(b) {
		setTimeout(function() {
			EvPNG.applyVML(b)
		}, 1)
	},
	fix : function(d) {
		var c = d.split(",");
		for ( var e = 0; e < c.length; e++) {
			this.styleSheet.addRule(c[e],
					"behavior:expression(EvPNG.fixPng(this))")
		}
	},
	applyVML : function(b) {
		b.runtimeStyle.cssText = "";
		this.vmlFill(b);
		this.vmlOffsets(b);
		this.vmlOpacity(b);
		if (b.isImg) {
			this.copyImageBorders(b)
		}
	},
	attachHandlers : function(f) {
		var l = this;
		var k = {
			resize : "vmlOffsets",
			move : "vmlOffsets"
		};
		if (f.nodeName == "A") {
			var j = {
				mouseleave : "handlePseudoHover",
				mouseenter : "handlePseudoHover",
				focus : "handlePseudoHover",
				blur : "handlePseudoHover"
			};
			for ( var g in j) {
				k[g] = j[g]
			}
		}
		for ( var i in k) {
			f.attachEvent("on" + i, function() {
				l[k[i]](f)
			})
		}
		f.attachEvent("onpropertychange", this.readPropertyChange)
	},
	giveLayout : function(b) {
		b.style.zoom = 1;
		if (b.currentStyle.position == "static") {
			b.style.position = "relative"
		}
	},
	copyImageBorders : function(d) {
		var c = {
			borderStyle : true,
			borderWidth : true,
			borderColor : true
		};
		for ( var e in c) {
			d.vml.color.shape.style[e] = d.currentStyle[e]
		}
	},
	vmlFill : function(h) {
		if (!h.currentStyle) {
			return

		} else {
			var g = h.currentStyle
		}
		for ( var i in h.vml) {
			h.vml[i].shape.style.zIndex = g.zIndex
		}
		h.runtimeStyle.backgroundColor = "";
		h.runtimeStyle.backgroundImage = "";
		var m = (g.backgroundColor == "transparent");
		var l = true;
		if (g.backgroundImage != "none" || h.isImg) {
			if (!h.isImg) {
				h.vmlBg = g.backgroundImage;
				h.vmlBg = h.vmlBg.substr(5, h.vmlBg.lastIndexOf('")') - 5)
			} else {
				h.vmlBg = h.src
			}
			var k = this;
			if (!k.imgSize[h.vmlBg]) {
				var j = document.createElement("img");
				k.imgSize[h.vmlBg] = j;
				j.className = k.ns + "_0";
				j.runtimeStyle.cssText = "behavior:none; position:absolute; left:-10000px; top:-10000px; border:none;";
				j.attachEvent("onload", function() {
					this.width = this.offsetWidth;
					this.height = this.offsetHeight;
					k.vmlOffsets(h)
				});
				j.src = h.vmlBg;
				j.removeAttribute("width");
				j.removeAttribute("height");
				document.body.insertBefore(j, document.body.firstChild)
			}
			h.vml.image.fill.src = h.vmlBg;
			l = false
		}
		h.vml.image.fill.on = !l;
		h.vml.image.fill.color = "none";
		h.vml.color.shape.style.backgroundColor = g.backgroundColor;
		h.runtimeStyle.backgroundImage = "none";
		h.runtimeStyle.backgroundColor = "transparent"
	},
	vmlOffsets : function(y) {
		var x = y.currentStyle;
		var w = {
			W : y.clientWidth + 1,
			H : y.clientHeight + 1,
			w : this.imgSize[y.vmlBg].width,
			h : this.imgSize[y.vmlBg].height,
			L : y.offsetLeft,
			T : y.offsetTop,
			bLW : y.clientLeft,
			bTW : y.clientTop
		};
		var u = (w.L + w.bLW == 1) ? 1 : 0;
		var s = function(e, c, f, b, g, i) {
			e.coordsize = b + "," + g;
			e.coordorigin = i + "," + i;
			e.path = "m0,0l" + b + ",0l" + b + "," + g + "l0," + g + " xe";
			e.style.width = b + "px";
			e.style.height = g + "px";
			e.style.left = c + "px";
			e.style.top = f + "px"
		};
		s(y.vml.color.shape, (w.L + (y.isImg ? 0 : w.bLW)), (w.T + (y.isImg ? 0
				: w.bTW)), (w.W - 1), (w.H - 1), 0);
		s(y.vml.image.shape, (w.L + w.bLW), (w.T + w.bTW), (w.W), (w.H), 1);
		var o = {
			X : 0,
			Y : 0
		};
		var l = function(f, e) {
			var i = true;
			switch (e) {
			case "left":
			case "top":
				o[f] = 0;
				break;
			case "center":
				o[f] = 0.5;
				break;
			case "right":
			case "bottom":
				o[f] = 1;
				break;
			default:
				if (e.search("%") != -1) {
					o[f] = parseInt(e) * 0.01
				} else {
					i = false
				}
			}
			var g = (f == "X");
			o[f] = Math
					.ceil(i ? ((w[g ? "W" : "H"] * o[f]) - (w[g ? "w" : "h"] * o[f]))
							: parseInt(e));
			if (o[f] == 0) {
				o[f]++
			}
		};
		for ( var A in o) {
			l(A, x["backgroundPosition" + A])
		}
		y.vml.image.fill.position = (o.X / w.W) + "," + (o.Y / w.H);
		var h = x.backgroundRepeat;
		var d = {
			T : 1,
			R : w.W + u,
			B : w.H,
			L : 1 + u
		};
		var a = {
			X : {
				b1 : "L",
				b2 : "R",
				d : "W"
			},
			Y : {
				b1 : "T",
				b2 : "B",
				d : "H"
			}
		};
		if (h != "repeat") {
			var z = {
				T : (o.Y),
				R : (o.X + w.w),
				B : (o.Y + w.h),
				L : (o.X)
			};
			if (h.search("repeat-") != -1) {
				var B = h.split("repeat-")[1].toUpperCase();
				z[a[B].b1] = 1;
				z[a[B].b2] = w[a[B].d]
			}
			if (z.B > w.H) {
				z.B = w.H
			}
			y.vml.image.shape.style.clip = "rect(" + z.T + "px " + (z.R + u)
					+ "px " + z.B + "px " + (z.L + u) + "px)"
		} else {
			y.vml.image.shape.style.clip = "rect(" + d.T + "px " + d.R + "px "
					+ d.B + "px " + d.L + "px)"
		}
	},
	fixPng : function(g) {
		g.style.behavior = "none";
		if (g.nodeName == "BODY" || g.nodeName == "TD" || g.nodeName == "TR") {
			return

		}
		g.isImg = false;
		if (g.nodeName == "IMG") {
			if (g.src.toLowerCase().search(/\.png$/) != -1) {
				g.isImg = true;
				g.style.visibility = "hidden"
			} else {
				return

			}
		} else {
			if (g.currentStyle.backgroundImage.toLowerCase().search(".png") == -1) {
				return

			}
		}
		var f = EvPNG;
		g.vml = {
			color : {},
			image : {}
		};
		var k = {
			shape : {},
			fill : {}
		};
		for ( var h in g.vml) {
			for ( var i in k) {
				var j = f.ns + ":" + i;
				g.vml[h][i] = document.createElement(j)
			}
			g.vml[h].shape.stroked = false;
			g.vml[h].shape.appendChild(g.vml[h].fill);
			g.parentNode.insertBefore(g.vml[h].shape, g)
		}
		g.vml.image.shape.fillcolor = "none";
		g.vml.image.fill.type = "tile";
		g.vml.color.fill.on = false;
		f.attachHandlers(g);
		f.giveLayout(g);
		f.giveLayout(g.offsetParent);
		f.applyVML(g)
	}
};
if (!!window.ActiveXObject && !window.XMLHttpRequest) {
	try {
		document.execCommand("BackgroundImageCache", false, true)
	} catch (r) {
	}
	EvPNG.createVmlNameSpace();
	EvPNG.createVmlStyleSheet()
}
(function(a) {
	a.fn.fixPNG = function() {
		var b = a(this).selector;
		if (!!window.ActiveXObject && !window.XMLHttpRequest) {
			try {
				EvPNG.fix(b)
			} catch (c) {
			}
		}
	}
})(jQuery);
var t;
var t2;
var rssFrom = "index";
var doSendShortUrl = 0;
function rssMsn() {
	$("#friendTip").hide();
	$(".calbtn").hide();
	$(".confirm-div").hide();
	var account = $("#loginAccount").val();
	var loginStatus = $("#loginStatus").val();
	var phone = getcookie("phone");
	var ischeck = getcookie("ischeck");
	//var rssSet = jsonbook.company;
	// TODO:	var canRss;
	
	var canRss = 1;
//	for ( var i = 0; i < rssSet.length; i++) {
//		if (rssSet[i].code == gCompanyCode) {
//			canRss = rssSet[i].web;
//			break
//		}
//	}
	
	if (rssFrom == "history"
			&& (gCompanyCode == "shentong" || gCompanyCode == "shunfeng" || gCompanyCode == "ems")) {
		doSendShortUrl = 1;
		canRss = 1
	} else {
		doSendShortUrl = 0
	}
	if (canRss != 1) {
		$("#notFindTip").hide();
		$("#rss-div").hide();
		$("#selectedTag").hide();
		showError("抱歉，" + gCompanyName + "暂不提供短信提醒服务。")
	} else {
//		TODO: 由于 调试 状态 原值为 gIsCheck == 1 && ischeck != 1
		if (gIsCheck == 2 && ischeck != 1) {
			$("#friendTip").hide();
			$("#rss-div").hide();
			$("#selectedTag").hide();
			showError("抱歉，此单已经签收，没必要邮件提示。")
		} else {
			$("#rss-div").show();
			$("#selectedTag").removeClass("pos2").addClass("pos1").show();
			if (loginStatus == 1 && ischeck == 1) {
				if (doSendShortUrl == 1) {
					showShortUrlBox()
				} else {
					$.ajax({
						type : "get",
						url : "/user/info",
						data : "tmp=" + Math.random(),
						success : function(responseText) {
							var resultJson = eval("(" + responseText + ")");
							if (resultJson.status == 200) {
								if (rssFrom == "history") {
									addphone(phone, resultJson.fplace)
								} else {
									addQuery(phone, resultJson.fplace)
								}
							} else {
								if (resultJson.status == 440) {
									var pwd = getcookie("password");
									loginByTel(phone, pwd)
								}
							}
						}
					})
				}
			} else {
				if (loginStatus == 1 && ischeck == 0) {
					$("#p-pwd1").hide();
					$("#p-pwd2").hide();
					$("#telephone").focus();
					gotostep1()
				} else {
					gotologin()
				}
			}
		}
	}
}

function getRandom(phone, valid) {
	$.ajax({
		type : "post",
		url : "/user/random",
		data : "code=" + valid + "&telephone=" + phone,
		success : function(responseText) {
			var resultData = eval("(" + responseText + ")");
			if (resultData.status == 200) {
				showstep2();
				$("#telephone2").html(phone);
				$("#telephone3").html(phone)
			} else {
				if (resultData.status == 402) {
					$("#step1wait").hide();
					showError("验证码错误，请重新输入。")
				} else {
					if (resultData.status == 414) {
						$("#step1wait").hide();
						showError("验证码错误，请重新输入。");
						$("#telephone").select()
					} else {
						if (resultData.status == 420) {
							$("#step1wait").hide();
							showError("您输入的手机号码已经被注册。");
							$("#telephone").select()
						} else {
							$("#step1wait").hide();
							showError("服务器错误，请刷新后重试。")
						}
					}
				}
			}
			refreshRssCode()
		}
	})
}

function loginByTel(phone, pwd) {
	$
			.ajax({
				type : "post",
				url : "/login",
				data : "account=" + phone + "&password=" + pwd,
				success : function(responseText) {
					var resultJson = eval("(" + responseText + ")");
					$("#step0wait").hide();
					if (resultJson.status == 200) {
						saveLoginCookies(resultJson.account, pwd);
						setcookie("ischeck", "1");
						setcookie("phone", phone);
						setWelcomeLogin(resultJson.account);
						addQuery(phone, resultJson.fplace)
					} else {
						if (resultJson.status == 424) {
							showError("您输入的用户名不存在。")
						} else {
							if (resultJson.status == 410) {
								showError("用户名或密码错误。<a href='#' onclick='forgetPwd();return false;'>找回密码&gt;&gt;</a>")
							} else {
								showError("请输入正确的Email或手机。")
							}
						}
					}
				}
			})
}

function regByPhone() {
	var phone = $("#telephone").val();
	var pwd = $("#pwd1").val();
	var valid = $("#valid2").val();
	$.ajax({
		type : "post",
		url : "/user/regbyphone",
		data : "telephone=" + phone + "&password=" + pwd + "&code=" + valid,
		success : function(responseText) {
			var resultJson = eval("(" + responseText + ")");
			if (resultJson.status == 200) {
				saveLoginCookies(resultJson.account, pwd);
				setcookie("ischeck", "1");
				setcookie("phone", phone);
				setWelcomeLogin(resultJson.account);
				addQuery(phone, resultJson.fplace)
			} else {
				if (resultJson.status == 404) {
					showError("短信校验码错误，重新输入。")
				} else {
					showError("服务器错误，请刷新后重试。")
				}
			}
		}
	})
}

function bindByPhone() {
	var phone = $("#telephone").val();
	var valid = $("#valid2").val();
	$.ajax({
		type : "post",
		url : "/user/regbyphonebind",
		data : "telephone=" + phone + "&code=" + valid + "&temp="
				+ Math.random(),
		success : function(responseText) {
			var resultData = eval("(" + responseText + ")");
			if (resultData.status == 200) {
				setcookie("ischeck", "1");
				setcookie("phone", phone);
				if (doSendShortUrl == 1) {
					showShortUrlBox()
				} else {
					changeProperty(resultData.fplace)
				}
			} else {
				if (resultData.status == 404) {
					showError("短信校验码错误，重新输入。")
				} else {
					showError("服务器错误，请刷新后重试。")
				}
			}
		}
	})
}

function addQuery(phone, place) {
	$
			.ajax({
				type : "post",
				url : "/userquery/add",
				data : "kuaidicom=" + gCompanyCode + "&kuaidinum="
						+ gKuaidiNumber + "&ffirststatus=" + gQueryResult,
				success : function(responseText) {
					var resultJson = eval("(" + responseText + ")");
					if (resultJson.status == 200 || resultJson.status == 412) {
						gIsRss = resultJson.isRss;
						gRssId = resultJson.rssid;
						gQueryId = resultJson.fid;
						if (rssFrom == "history") {
							for ( var i = 0; i < gQueryResultJson.length; i++) {
								if (gQueryResultJson[i].kuaidicom == gCompanyCode
										&& gQueryResultJson[i].kuaidinum == gKuaidiNumber) {
									gQueryResultJson[i].isRss = gIsRss;
									gQueryResultJson[i].rssid = gRssId;
									gQueryResultJson[i].fid = gQueryId
								}
							}
						}
						if (doSendShortUrl == 1) {
							showShortUrlBox()
						} else {
							addphone(phone, place)
						}
					} else {
						if (resultJson.status == 440) {
							showError("您的操作超时，请<a href='#' onclick='relogin();return false;'>重新登录&gt;&gt;</a>。")
						} else {
							showError("服务器错误，请刷新之后重试。")
						}
					}
				}
			})
}

function addphone(b, a) {
	if (gIsRss == 1 || gIsRss == 2) {
		smsQuery()
	} else {
		if (gIsRss == 0 || gIsRss == 3) {
			changeProperty(a)
		}
	}
}

function addRss(rss1, rss2, rss3) {
	$
			.ajax({
				type : "post",
				url : "/sms/add",
				data : "fmyqueryid=" + gQueryId + "&kuaidicom=" + gCompanyCode
						+ "&kuaidinum=" + gKuaidiNumber + "&fplace="
						+ $("#cityId_input").val() + "&ffirststatus="
						+ gQueryResult + "&rsstype1=" + rss1 + "&rsstype2="
						+ rss2 + "&rsstype3=" + rss3,
				success : function(responseText) {
					var resultJson = eval("(" + responseText + ")");
					if (resultJson.status == 200) {
						gRssId = resultJson.fid;
						gIsRss = 1;
						rssFinish()
					} else {
						if (resultJson.status == 401) {
							var rssid = (resultJson.fid != null) ? resultJson.fid
									: gRssId;
							updateRss(rssid, rss1, rss2, rss3)
						} else {
							if (resultJson.status == 440) {
								$("#step3wait").hide();
								showError("您的操作超时，请<a href='#' onclick='relogin();return false;'>重新登录&gt;&gt;</a>。")
							} else {
								$("#step3wait").hide();
								showError("订阅失败，请刷新之后重试。")
							}
						}
					}
				}
			})
}

function updateRss(rssid, rss1, rss2, rss3) {
	$
			.ajax({
				type : "post",
				url : "/sms/update",
				data : "fid=" + rssid + "&fplace=" + $("#cityId_input").val()
						+ "&rsstype1=" + rss1 + "&rsstype2=" + rss2
						+ "&rsstype3=" + rss3,
				success : function(responseText) {
					var resultJson = eval("(" + responseText + ")");
					if (resultJson.status == 200) {
						gRssId = resultJson.fid;
						gQueryId = resultJson.fmyqueryid;
						gIsRss = 1;
						rssFinish()
					} else {
						if (resultJson.status == 440) {
							$("#step3wait").hide();
							showError("您的操作超时，请<a href='#' onclick='relogin();return false;'>重新登录&gt;&gt;</a>。")
						} else {
							if (resultJson.status == 401
									&& $("#cityId_input").val() == "") {
								$("#step3wait").hide();
								showError("请设置到达城市。")
							} else {
								$("#step3wait").hide();
								showError("订阅失败，请刷新之后重试。")
							}
						}
					}
				}
			})
}

function changeProperty(a) {
	showstep3();
	if (a != "") {
		$("#cityId_input").val(a);
		var c = area.city;
		for ( var b = 0; b < c.length; b++) {
			if (c[b].code == a) {
				$("#cityName_input").html(c[b].name);
				break
			}
		}
	}
	if (gIsRss == 1) {
		$("#confirm-yes-2").replaceWith(
				'<a href="#" id="confirm-yes-2" class="btn-ok" onclick="deleteRss('
						+ gRssId + ');return false;">确定</a>');
		$(".calbtn").show()
	}
	$("#server_1").attr("checked", true);
	$("#server_2").attr("checked", true);
	$("#server_3").attr("checked", false);
	if (gQueryResult == 200) {
		$("#server_1").attr("disabled", true);
		$("#server_1").attr("checked", false)
	} else {
		$("#server_1").attr("disabled", false)
	}
}

function smsQuery() {
	$
			.ajax({
				type : "get",
				url : "/sms/query",
				data : "rssid=" + gRssId + "&temp=" + Math.random(),
				success : function(responseText2) {
					var resultJson2 = eval("(" + responseText2 + ")");
					if (resultJson2.status == 200) {
						place = resultJson2.fplace;
						gRssId = resultJson2.fid;
						gQueryId = resultJson2.fmyqueryid;
						changeProperty(place);
						if (resultJson2.rsstype1 == 0) {
							$("#server_1").attr("checked", false)
						} else {
							$("#server_1").attr("checked", true)
						}
						if (resultJson2.rsstype2 == 0) {
							$("#server_2").attr("checked", false)
						} else {
							$("#server_2").attr("checked", true)
						}
						if (resultJson2.rsstype3 == 0) {
							$("#server_3").attr("checked", false)
						} else {
							$("#server_3").attr("checked", true)
						}
					} else {
						if (resultJson2.status == 440) {
							showError("您的操作超时，请<a href='#' onclick='relogin();return false;'>重新登录&gt;&gt;</a>。")
						}
					}
				}
			})
}

function deleteRss(rssid) {
	$
			.ajax({
				type : "POST",
				url : "/sms/cancer?rssid=" + rssid,
				success : function(responseText) {
					var resultJson = eval("(" + responseText + ")");
					if (resultJson.status == 200) {
						$(".calbtn").hide();
						$(".confirm-div").hide();
						$("#rss-div").hide();
						$("#selectedTag").hide();
						showTips(gCompanyName + "单号：" + gKuaidiNumber
								+ "短信跟踪服务取消订阅成功!");
						gIsRss = 0;
						gRssId = 0;
						if (rssFrom == "history") {
							$("#tr-" + gCompanyCode + gKuaidiNumber).find(
									".a-rss").addClass("rss-1").removeClass(
									"rss-2");
							if (typeof (queryClose) == "function") {
								queryClose()
							}
							for ( var i = 0; i < gQueryResultJson.length; i++) {
								if (gQueryResultJson[i].kuaidicom == gCompanyCode
										&& gQueryResultJson[i].kuaidinum == gKuaidiNumber) {
									gQueryResultJson[i].isRss = 0;
									gQueryResultJson[i].rssid = 0
								}
							}
						} else {
							if ($("html").scrollTop() > 0) {
								$("html").animate({
									scrollTop : 0
								}, "normal")
							}
						}
					} else {
						if (resultJson.status == 440) {
							showError("您的操作超时，请<a href='#' onclick='relogin();return false;'>重新登录&gt;&gt;</a>。")
						} else {
							showError("服务器错误，请刷新之后重试。")
						}
					}
				}
			})
}

function refreshRssCode() {
	$("#valicodeImg").attr("src", "/image.jsp?tmp=" + Math.random())
}

function relogin() {
	logout();
	window.location.href = "../login.html"
}

function rsslogin() {
	account = $("#telephone0").val();
	pwd = $("#pwd0").val();
	$("#step0wait").show();
	if (!checkMobile(account)) {
		$("#step0wait").hide();
		$("#notFindTip").hide();
		showError("请输入正确的手机号码。");
		$("#telephone0").select()
	} else {
		if (pwd == "") {
			$("#step0wait").hide();
			$("#notFindTip").hide();
			showError("请输入您的密码。");
			$("#pwd0").select()
		} else {
			if (!isNumberLetterFuhao(pwd)) {
				$("#step0wait").hide();
				$("#notFindTip").hide();
				showError("您输入的密码不合法。");
				$("#pwd0").select()
			} else {
				if (pwd.length < 6) {
					$("#step0wait").hide();
					$("#notFindTip").hide();
					showError("您输入的密码长度不足6位。");
					$("#pwd0").select()
				} else {
					loginByTel(account, pwd)
				}
			}
		}
	}
}

function gotologin() {
	clearInterval(t);
	$("#error").hide();
	$("#errorTips").hide();
	$("#rss-step").removeClass("step_state_1").removeClass("step_state_2")
			.removeClass("step_state_3").addClass("step_state_0");
	var a = $("#rss-div");
	a.find(".step_waiting").hide();
	a.find(".step_1").hide();
	a.find(".step_2").hide();
	a.find(".step_3").hide();
	a.find(".step_0").show();
	a.find(".step_0 input").val("");
	$("#telephone0").select()
}

function gotostep1() {
	clearInterval(t);
	refreshRssCode();
	$("#error").hide();
	$("#errorTips").hide();
	$("#rss-step").removeClass("step_state_0").removeClass("step_state_2")
			.removeClass("step_state_3").addClass("step_state_1");
	var a = $("#rss-div");
	a.find("#valid").val("");
	a.find(".step_waiting").hide();
	a.find(".step_0").hide();
	a.find(".step_2").hide();
	a.find(".step_3").hide();
	a.find(".step_1").show();
	a.find(".step_1 input").val("");
	$("#telephone").select()
}

function gotostep2() {
	var a = $("#telephone").val();
	var b = $("#valid").val();
	var d;
	var c;
	if (!$("#p-pwd1").is(":hidden")) {
		d = $("#pwd1").val();
		c = $("#pwd2").val()
	} else {
		d = "888888";
		c = "888888"
	}
	$("#errorTips").hide();
	$("#" + gCompanyCode + gKuaidiNumber + "errorTips").hide();
	if (!checkMobile(a)) {
		$("#step1wait").hide();
		$("#notFindTip").hide();
		showError('请输入正确的手机号码，按"下一步"继续。')
	} else {
		if (!isNumberLetterFuhao(d) || !isNumberLetterFuhao(c)) {
			$("#step1wait").hide();
			$("#notFindTip").hide();
			showError("您输入的密码不合法。")
		} else {
			if (d.length < 6 || c.length < 6) {
				$("#step1wait").hide();
				$("#notFindTip").hide();
				showError("您输入的密码长度不足6位。")
			} else {
				if (d != c) {
					$("#step1wait").hide();
					$("#notFindTip").hide();
					showError("您两次输入的密码不相同。")
				} else {
					if (b == "") {
						$("#step1wait").hide();
						$("#notFindTip").hide();
						showError("请输入验证码")
					} else {
						$("#errorTips").hide();
						getRandom(a, b)
					}
				}
			}
		}
	}
}

function showstep2() {
	$("#rss-step").removeClass("step_state_1").removeClass("step_state_3")
			.addClass("step_state_2");
	var a = $("#rss-div");
	a.find(".step_waiting").hide();
	a.find(".step_1").hide();
	a.find(".step_3").hide();
	a.find(".step_2").show();
	$("#valid2").select();
	timeCountStart()
}

function gotostep3() {
	var a = $("#valid2").val();
	if (a != "" && a != null) {
		if ($("#loginStatus").val() == 1) {
			bindByPhone()
		} else {
			regByPhone()
		}
	} else {
		showError("请输入短信校验码。")
	}
}

function showstep3() {
	$("#error").hide();
	$("#errorTips").hide();
	$("#rss-step").removeClass("step_state_01").removeClass("step_state_0")
			.removeClass("step_state_1").removeClass("step_state_2")
			.removeClass("step_state_4").addClass("step_state_3");
	$("#kuaidiinfo").html(gCompanyName + "：" + gKuaidiNumber);
	$("#cityName_input").html("");
	$("#cityId_input").val("");
	var a = $("#rss-div");
	a.find(".step_waiting").hide();
	a.find(".step_0").hide();
	a.find(".step_1").hide();
	a.find(".step_2").hide();
	a.find(".step_3").show()
}

function submitRss() {
	var d = 0, c = 0, b = 0, a = 0;
	if ($("#server_1").attr("checked")) {
		if ($("#server_1").attr("disabled")) {
			d = 2
		} else {
			d = 1
		}
	}
	if ($("#server_2").attr("checked")) {
		if ($("#server_2").attr("disabled")) {
			c = 2
		} else {
			c = 1
		}
	}
	if ($("#server_3").attr("checked")) {
		if ($("#server_3").attr("disabled")) {
			b = 2
		} else {
			b = 1
		}
	}
	$("#errorTips").hide();
	$("#step3wait").show();
	if (gIsCheck == 1) {
		$("#step3wait").hide();
		$("#rss-div").hide();
		$("#selectedTag").hide();
		$("#notFindTip").hide();
		showError("抱歉，此单已经签收，不能订阅提示短信。")
	} else {
		if (d == 0 && c == 0 && b == 0) {
			$("#step3wait").hide();
			$("#" + gCompanyCode + gKuaidiNumber + "notFindTip").hide();
			showError("请至少选择一个订阅的选项。")
		} else {
			if ($("#cityId_input").val() == "") {
				$("#step3wait").hide();
				showError("请设置到达城市。")
			} else {
				if (gIsRss != 1) {
					addRss(d, c, b)
				} else {
					updateRss(gRssId, d, c, b)
				}
			}
		}
	}
}

function rssFinish() {
	$("#error").hide();
	$("#step3wait").hide();
	$("#rss-div").hide();
	$("#selectedTag").hide();
	showTips(gCompanyName + "单号：" + gKuaidiNumber + "短信跟踪服务订阅成功!");
	$("#rssTips").fadeIn();
	clearTimeout(t2);
	t2 = setTimeout("$('#rssTips').fadeOut();", 8000);
	if (rssFrom == "history") {
		$("#tr-" + gCompanyCode + gKuaidiNumber).find(".a-rss").addClass(
				"rss-2").removeClass("rss-1");
		if (typeof (queryClose) == "function") {
			queryClose()
		}
		for ( var a = 0; a < gQueryResultJson.length; a++) {
			if (gQueryResultJson[a].kuaidicom == gCompanyCode
					&& gQueryResultJson[a].kuaidinum == gKuaidiNumber) {
				gQueryResultJson[a].isRss = 1;
				gQueryResultJson[a].rssid = gRssId
			}
		}
	} else {
		if ($("html").scrollTop() > 0) {
			$("html").animate({
				scrollTop : 0
			}, "normal")
		}
	}
}

function showShortUrlBox() {
	$("#sendShortUrlBtn").attr("disabled", false);
	$("#rss-div").hide();
	$("#shortUrlTips").hide();
	$("#sendShortUrl").show();
	$(".shortUrlTips").html("很抱歉，短信订阅暂不支持" + gCompanyName);
	$("#shortUrlImg").attr("src",
			"http://cdn.kuaidi100.com/images/user/ex_sms.png")
}

function forgetPwd() {
	var a = $("#telephone0").val();
	if (checkEmail(a)) {
		window.location.href = "/user/findByEmail.shtml?email=" + a
	} else {
		if (checkMobile(a)) {
			window.location.href = "/user/findByTel.shtml?tel=" + a
		} else {
			window.location.href = "/user/findByTel.shtml"
		}
	}
}

function sendPwdToMobile(thiz) {
	$(thiz).hide();
	var phone = $("#telephone").val();
	$("#sendSms").hide();
	$("#sendAgainSpan").show();
	timeCountStart();
	$.ajax({
		type : "POST",
		url : "/user/randomagain",
		data : "telephone=" + phone,
		success : function(responseText) {
			var resultJson = eval("(" + responseText + ")");
			if (resultJson.status != 200) {
				$("#telRegBox_2 .pwdError").html("发送短信失败，请刷新后重试。");
				$("#telRegBox_2 .pwdError-p").show()
			}
		},
		error : function(xmlHttpRequest, error) {
			$(thiz).show()
		}
	})
}

var gEndTime;
var gInterval;
function timeCountdown() {
	var c = gEndTime.getTime() - new Date().getTime();
	if (c > 0) {
		var f = Math.floor(c / (1000 * 60));
		var e = c - f * 1000 * 60;
		var b = Math.floor(e / 1000);
		var d = f;
		var a = "" + b;
		if (b < 10) {
			a = "0" + b
		}
		$("#minute").text(d);
		$("#second").text(a)
	} else {
		$("#timeSpan").hide();
		$("#sendSmsAgain").show();
		clearInterval(gInterval)
	}
}

function timeCountStart() {
	$("#sendSmsAgain").hide();
	$("#timeSpan").show();
	gEndTime = new Date();
	gEndTime.setTime(new Date().getTime() + 2 * 60 * 1000);
	gInterval = setInterval("timeCountdown()", 100)
}

function showError(a) {
	$("#notFindTip").hide();
	$("#errorMessage").html(a);
	$("#errorTips").show()
}

function saveLoginCookies(a, b) {
	document.cookie = escape("loginAccount") + "=" + escape(a) + ";path=/";
	document.cookie = escape("loginStatus") + "=" + escape("1") + ";path=/";
	document.cookie = escape("loginSession") + "=" + escape("1") + ";path=/";
	document.cookie = escape("password") + "=" + escape(b) + ";path=/"
}

function isNumberLetterFuhao(c) {
	var a = "^[0-9a-zA-Z@#$-]+$";
	var b = new RegExp(a);
	if (b.test(c)) {
		return true
	} else {
		return false
	}
}

function checkMobile(a) {
	var b = /^(?:13\d|14\d|15\d|18\d)-?\d{5}(\d{3}|\*{3})$/;
	return b.test(a)
}

function checkEmail(a) {
	var b = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
	return b.test(a)
}

function isNumberLetterFuhao(c) {
	var a = "^[0-9a-zA-Z@#$-]+$";
	var b = new RegExp(a);
	if (b.test(c)) {
		return true
	} else {
		return false
	}
}

var clip = null;
copyInit();
function copyInit() {
	ZCBinder("sendUrl", "sendUrlBtn", "sendHistory", function() {
		$("#sendUrl").select();
		$("#sendMsg").html("已把转发地址复制到剪贴板!");
		$("#sendContent").css({
			height : "18px"
		})
	});
	ZCBinder("sendContent", "sendContentBtn", "sendHistory", function() {
		$("#sendContent").select().css({
			height : "200px"
		});
		$("#sendMsg").html("已把转发内容复制到剪贴板!")
	})
}

function openSenBox() {
	$("#sendMsg").html("");
	$("#sendUrl").val(
			"http://www.kuaidi100.com/chaxun?com=" + gCompanyCode + "&nu="
					+ gKuaidiNumber);
	$("#sendContent").val(
			gCompanyName + "单号" + gKuaidiNumber + "的查询结果\n"
					+ translateTotext(gResultData, 3)
					+ "查看地址为：http://www.kuaidi100.com/chaxun?com="
					+ gCompanyCode + "&nu=" + gKuaidiNumber);
	$("#sendHistoryBtn").hide();
	$("#sendHistory").show();
	$("#sendUrl").blur();
	$("#sendContent").blur();
	$("#selectedTag").removeClass("pos1").addClass("pos2").show()
}

function translateTotext(b, a) {
	try {
		if (a > b.length) {
			a = b.length
		}
		var d = "";
		for ( var c = 0; c < a; c++) {
			d += b[c].time + " " + b[c].context + "\n"
		}
		return d
	} catch (f) {
	}
}

function ZCBinder(a, d, b, c) {
	clip = new ZeroClipboard.Client();
	ZeroClipboard
			.setMoviePath("http://cdn.kuaidi100.com/images/ZeroClipboard.swf");
	clip.setHandCursor(true);
	$("#" + d).mouseover(function() {
		clip.setText($("#" + a).val());
		if (clip.div) {
			clip.reposition(d)
		} else {
			clip.glue(d)
		}
		clip.addEventListener("complete", function() {
			if (c != null) {
				c()
			}
		});
		clip.receiveEvent("mouseover", null)
	})
}

function selectCtrl() {
	if (document.selection) {
		document.selection.empty()
	} else {
		if (window.getSelection) {
			window.getSelection().removeAllRanges()
		}
	}
	$(".sendMsg").html("")
}

function closeHisCtrl() {
	selectCtrl();
	$(".send-box").hide();
	$(".send-box-on").show();
	$(".sendMsg").html("");
	$("#selectedTag").hide();
	$("#sendContent").css({
		height : "18px"
	})
}

var addrs = new Array();
var points = new Array();
var endAddr = "";
var endPoint;
var usedTime;
var arrTime;
var readyPoint = 0;
var map;
var control;
var mQueryResult;
var mIsChecked;
var mapReady = 0;
var tmpCom = "";
var tmpNu = "";
var mapInfoAjax;
function CustomOverlay(a, c, b) {
	this._point = a;
	this._text = c;
	this._marker = b
}
CustomOverlay.prototype = new BMap.Overlay();
CustomOverlay.prototype.initialize = function(g) {
	this._map = g;
	var h = this._div = document.createElement("div");
	h.style.position = "absolute";
	h.style.zIndex = "11";
	h.style.backgroundColor = "#E1F3FF";
	h.style.border = "1px solid #67baf7";
	h.style.color = "#333333";
	h.style.width = "140px";
	h.style.padding = "8px";
	h.style.lineHeight = "18px";
	h.style.MozUserSelect = "none";
	h.style.fontSize = "12px";
	var d = this._span = document.createElement("span");
	h.appendChild(d);
	d.innerHTML = this._text;
	var b = d.getElementsByTagName("strong");
	for ( var c = 0; c < b.length; c++) {
		b[c].style.color = "#FF8c00"
	}
	var e = this;
	var f = this._arrow = document.createElement("div");
	f.style.background = 'url("http://cdn.kuaidi100.com/images/ico_map.gif") -3px -95px no-repeat';
	f.style.position = "absolute";
	f.style.width = "16px";
	f.style.height = "8px";
	f.style.top = "-8px";
	f.style.left = "67px";
	f.style.overflow = "hidden";
	h.appendChild(f);
	var a = this._marker;
	a.addEventListener("mouseover", function() {
		h.style.display = "block"
	});
	a.addEventListener("mouseout", function() {
		h.style.display = "none"
	});
	h.style.display = "none";
	g.getPanes().labelPane.appendChild(h);
	return h
};
CustomOverlay.prototype.draw = function() {
	var b = this._map;
	var a = b.pointToOverlayPixel(this._point);
	this._div.style.left = a.x - 75 + "px";
	this._div.style.top = a.y + 10 + "px"
};
function FixedCustomOverlay(a, c, b) {
	this._point = a;
	this._text = c;
	this._marker = b
}
FixedCustomOverlay.prototype = new BMap.Overlay();
FixedCustomOverlay.prototype.initialize = function(b) {
	this._map = b;
	var a = this._div = document.createElement("div");
	a.style.position = "absolute";
	a.style.zIndex = "10";
	a.style.backgroundColor = "#E1F3FF";
	a.style.border = "1px solid #67baf7";
	a.style.color = "#333333";
	a.style.width = "155px";
	a.style.padding = "10px";
	a.style.lineHeight = "20px";
	a.style.MozUserSelect = "none";
	a.style.fontSize = "12px";
	var h = this._span = document.createElement("span");
	a.appendChild(h);
	h.innerHTML = this._text;
	var j = h.getElementsByTagName("strong");
	for ( var e = 0; e < j.length; e++) {
		j[e].style.color = "#FF8c00"
	}
	var f = this;
	var g = this._arrow = document.createElement("div");
	g.style.background = 'url("http://cdn.kuaidi100.com/images/ico_map.gif") -3px -95px no-repeat';
	g.style.position = "absolute";
	g.style.width = "16px";
	g.style.height = "8px";
	g.style.top = "-8px";
	g.style.left = "77px";
	g.style.overflow = "hidden";
	a.appendChild(g);
	var c = this._btn = document.createElement("a");
	c.style.background = 'url("http://cdn.kuaidi100.com/images/ico_map.png") -255px -52px no-repeat';
	c.style.display = "block";
	c.style.position = "absolute";
	c.style.width = "16px";
	c.style.height = "16px";
	c.style.top = "0px";
	c.style.right = "0px";
	c.style.overflow = "hidden";
	c.style.cursor = "pointer";
	var d = this._marker;
	if (c.addEventListener) {
		c.addEventListener("click", function() {
			a.style.display = "none";
			c.style.display = "none";
			d.addEventListener("mouseout", function() {
				a.style.display = "none"
			});
			return false
		})
	} else {
		c.attachEvent("onclick", function() {
			a.style.display = "none";
			c.style.display = "none";
			d.addEventListener("mouseout", function() {
				a.style.display = "none"
			});
			return false
		})
	}
	d.addEventListener("mouseover", function() {
		a.style.display = "block"
	});
	a.appendChild(c);
	b.getPanes().labelPane.appendChild(a);
	return a
};
FixedCustomOverlay.prototype.draw = function() {
	var b = this._map;
	var a = b.pointToOverlayPixel(this._point);
	this._div.style.left = a.x - 87 + "px";
	this._div.style.top = a.y + 10 + "px"
};
function showMap() {
	if (mapReady == 0) {
		map = new BMap.Map("map");
		map.centerAndZoom(new BMap.Point(116.404, 39.915), 11);
		control = new BMap.NavigationControl({
			type : BMAP_NAVIGATION_CONTROL_SMALL
		});
		map.addControl(control);
		map.setMaxZoom(13);
		map.setMinZoom(5);
		mapReady = 1
	}
	if (!(tmpCom == gCompanyCode && tmpNu == gKuaidiNumber)) {
		endAddr = "";
		mQueryResult = gResultJson.data;
		mIsChecked = gResultJson.ischeck;
		tmpCom = gCompanyCode;
		tmpNu = gKuaidiNumber;
		if (mIsChecked == 1) {
			control.setOffset(new BMap.Size(10, 10));
			$("#mapArrCity").hide()
		} else {
			control.setOffset(new BMap.Size(10, 50));
			$("#mapArrCity").show()
		}
		$("#cityName_input_2").html("");
		drawMap(Obj2str(gResultJson), "", "", tmpNu, tmpCom)
	}
}

function setArrCity() {
	var b = $("#cityName_input_2").html();
	var a = $("#cityId_input_2").val();
	$("#mapSetTips").hide();
	if (endAddr != b) {
		endAddr = b;
		drawMap(Obj2str(gResultJson), b, a, tmpNu, tmpCom)
	}
}

function drawMap(result, toAddr, toAddrCode, nu, com) {
	$("#mapWait")
			.html(
					'<img src="./images/app-1.gif"/><p class="mt10px">正在为您加载百度地图...</p>');
	$("#mapWait").show();
	map.clearOverlays();
	addrs = [];
	points = [];
	endPoint = "";
	usedTime = "";
	arrTime = "";
	readyPoint = 0;
	if (mapInfoAjax) {
		mapInfoAjax.abort()
	}
	mapInfoAjax = $.ajax({
		type : "post",
		url : "./MapInfoServlet",
		data : "queryResult=" + encodeURIComponent(result) + "&toAddr="
				+ encodeURIComponent(toAddr) + "&toAddrCode=" + toAddrCode
				+ "&nu=" + gKuaidiNumber + "&com=" + gCompanyCode + "&temp="
				+ Math.random(),
		contentType : "application/x-www-form-urlencoded; charset=utf-8",
		success : function(resultText) {
			if (resultText != "") {
				var json = eval("(" + resultText + ")");
				addrs = json.addrList;
				endAddr = json.arrCity;
				usedTime = json.usedTime;
				arrTime = json.arrTime;
				getPointsByAddr();
				if (endAddr != "") {
					$("#cityName_input_2").html(json.shortArrCity);
					getPointByAddr(endAddr, -1)
				} else {
					if (mIsChecked != 1) {
						$("#mapSetTips").show()
					}
				}
			} else {
				tmpNu = "";
				tmpCom = "";
				$("#mapWait").html("很抱歉，此线路没有数据。")
			}
		}
	})
}

function getPointsByAddr() {
	for ( var a = 0; a < addrs.length; a++) {
		getPointByAddr(addrs[a], a)
	}
}

function getPointByAddr(c, a) {
	var b = new BMap.Geocoder();
	b.getPoint(c, function(d) {
		if (d) {
			if (a == -1) {
				endPoint = d
			} else {
				points[a] = d
			}
		}
		readyPoint++;
		checkReady()
	})
}

function checkReady() {
	if (((readyPoint == addrs.length) && endAddr == "")
			|| ((readyPoint == addrs.length + 1) && endAddr != "")) {
		$("#mapWait").hide();
		for ( var k = 0; k < points.length; k++) {
			if (!points[k]) {
				points.splice(k, 1);
				k--
			}
		}
		var n = new BMap.Icon("http://cdn.kuaidi100.com/images/ico_map.png",
				new BMap.Size(26, 33), {
					offset : new BMap.Size(0, 0),
					imageOffset : new BMap.Size(50, 50)
				});
		var m = new BMap.Icon("http://cdn.kuaidi100.com/images/ico_map.png",
				new BMap.Size(35, 40), {
					offset : new BMap.Size(0, 0),
					imageOffset : new BMap.Size(50, 50)
				});
		var h = new BMap.Marker(points[0], {
			offset : new BMap.Size(0, -16),
			icon : n
		});
		var g;
		if (mIsChecked == 1) {
			drawCityLabel(points[points.length - 1], addrs[addrs.length - 1], 3);
			drawCityPoint(points[points.length - 1], 3);
			g = new BMap.Marker(points[points.length - 1], {
				offset : new BMap.Size(0, -16),
				icon : n
			})
		} else {
			drawCityPoint(points[points.length - 1], 2);
			g = new BMap.Marker(points[points.length - 1], {
				offset : new BMap.Size(0, -20),
				icon : m
			})
		}
		map.addOverlay(h);
		map.addOverlay(g);
		h.setZIndex(1);
		g.setZIndex(2);
		drawCityLabel(points[0], addrs[0], 1);
		drawCityPoint(points[0], 1);
		drivingLines();
		var c = new CustomOverlay(points[0],
				mQueryResult[mQueryResult.length - 1].ftime
						+ "</br>快件从<strong>" + addrs[0] + "</strong>发出", h);
		map.addOverlay(c);
		if (endAddr != "" && mIsChecked != 1) {
			var e = new BMap.Marker(endPoint, {
				offset : new BMap.Size(0, -16),
				icon : n
			});
			map.addOverlay(e);
			e.setZIndex(3);
			drawCityLabel(endPoint, endAddr, 3);
			drawCityPoint(endPoint, 3);
			var j = new BMap.DrivingRoute(map, {
				onSearchComplete : drawLine2
			});
			j.search(points[points.length - 1], endPoint);
			var b = new CustomOverlay(points[points.length - 1],
					time2str(usedTime), g);
			map.addOverlay(b);
			var a = new FixedCustomOverlay(endPoint, arrTime, e);
			map.addOverlay(a)
		} else {
			var b = new FixedCustomOverlay(points[points.length - 1],
					time2str(usedTime), g);
			map.addOverlay(b)
		}
		var l = [];
		for ( var k = 0; k < points.length; k++) {
			l.push(points[k])
		}
		if (endAddr != "" && mIsChecked != 1) {
			l.push(endPoint)
		}
		if (mIsChecked == 1) {
			map.setViewport(l, {
				margins : [ 20, 90, 85, 90 ]
			})
		} else {
			map.setViewport(l, {
				margins : [ 60, 90, 85, 90 ]
			})
		}
		var f = new BMap.InfoWindow(mQueryResult[mQueryResult.length - 1].ftime
				+ "</br>" + mQueryResult[mQueryResult.length - 1].context, {
			width : 200
		});
		var d = new BMap.InfoWindow(mQueryResult[0].ftime + "</br>"
				+ mQueryResult[0].context, {
			width : 200
		});
		h.addEventListener("click", function() {
			this.openInfoWindow(f)
		});
		g.addEventListener("click", function() {
			this.openInfoWindow(d)
		})
	}
}

function drawCityPoint(a, d) {
	var c = new BMap.Label("", {
		position : a,
		offset : new BMap.Size(-16, -38)
	});
	var b;
	switch (d) {
	case (1):
		b = {
			width : "26px",
			height : "40px",
			border : "none",
			background : 'url("http://cdn.kuaidi100.com/images/ico_map.png") 2px 6px no-repeat'
		};
		break;
	case (2):
		b = {
			width : "35px",
			height : "40px",
			border : "none",
			background : 'url("http://cdn.kuaidi100.com/images/ico_map.png") -245px -7px no-repeat'
		};
		break;
	case (3):
		b = {
			width : "26px",
			height : "40px",
			border : "none",
			background : 'url("http://cdn.kuaidi100.com/images/ico_map.png") 2px -36px no-repeat'
		};
		break
	}
	c.setStyle(b);
	c.setZIndex(d);
	map.addOverlay(c)
}

function drawCityLabel(a, c, d) {
	var b = new BMap.Label(c, {
		position : a,
		offset : new BMap.Size(12, -25)
	});
	b
			.setStyle({
				color : "#333333",
				whiteSpace : "nowrap",
				height : "24px",
				lineHeight : "16px",
				padding : "0 20px 0 4px",
				border : "none",
				background : 'url("http://cdn.kuaidi100.com/images/ico_map.png") right -86px no-repeat'
			});
	b.setZIndex(d);
	map.addOverlay(b)
}

function drivingLines() {
	for ( var a = 0; a < points.length - 1; a++) {
		var c = points[a];
		var b = points[a + 1];
		var d = new BMap.DrivingRoute(map, {
			onSearchComplete : drawLine
		});
		d.search(c, b)
	}
}

function drawLine(d) {
	if (d.getNumPlans() > 0) {
		var c = d.getPlan(0);
		for ( var b = 0; b < c.getNumRoutes(); b++) {
			var a = c.getRoute(b);
			if (a.getDistance(false) <= 0) {
				continue
			}
			map.addOverlay(new BMap.Polyline(a.getPath(), {
				strokeStyle : "solid",
				strokeColor : "#3E548E",
				strokeOpacity : 0.8,
				strokeWeight : 5
			}))
		}
	}
}

function drawLine2(d) {
	if (d.getNumPlans() > 0) {
		var c = d.getPlan(0);
		for ( var b = 0; b < c.getNumRoutes(); b++) {
			var a = c.getRoute(b);
			if (a.getDistance(false) <= 0) {
				continue
			}
			map.addOverlay(new BMap.Polyline(a.getPath(), {
				strokeStyle : "dashed",
				strokeColor : "#3E548E",
				strokeOpacity : 0.8,
				strokeWeight : 5
			}))
		}
	}
}

function time2str(c) {
	var e = "";
	e = "已到达<strong>" + addrs[addrs.length - 1] + "</strong>";
	if (c != 0) {
		e += "</br>耗时<strong>";
		c = c / 1000;
		var b = parseInt(c / 86400);
		var a = parseInt(c % 86400 / 3600);
		var d = parseInt(c % 86400 % 3600 / 60);
		if (b != 0) {
			e += b + "天"
		}
		if (a != 0 || b != 0) {
			e += a + "小时"
		}
		if (d != 0) {
			e += d + "分钟"
		}
		e += "</strong>"
	}
	return e
}

function Obj2str(c) {
	if (c == undefined) {
		return ""
	}
	var b = [];
	if (typeof c == "string") {
		return '"'
				+ c.replace(/([\"\\])/g, "\\$1").replace(/(\n)/g, "\\n")
						.replace(/(\r)/g, "\\r").replace(/(\t)/g, "\\t") + '"'
	}
	if (typeof c == "object") {
		if (!c.sort) {
			for ( var a in c) {
				b.push('"' + a + '":' + Obj2str(c[a]))
			}
			if (!!document.all
					&& !/^\n?function\s*toString\(\)\s*\{\n?\s*\[native code\]\n?\s*\}\n?\s*$/
							.test(c.toString)) {
				b.push("toString:" + c.toString.toString())
			}
			b = "{" + b.join() + "}"
		} else {
			for ( var a = 0; a < c.length; a++) {
				b.push(Obj2str(c[a]))
			}
			b = "[" + b.join() + "]"
		}
		return b
	}
	return c.toString().replace(/\"\:/g, '":""')
}

var thisHREF = document.location.href;
if (thisHREF.indexOf("api.kuaidi100.com") > 0) {
	document.location = "http://www.kuaidi100.com/api/"
}
var gQueryType = 1;
var index_ad = 0;
var t_ad;
var copyNotfindReady = 0;
$(document).ready(function() {
	$("#rss-div .step_0").delegate("input", "keydown", function(b) {
		var a = b.keyCode ? b.keyCode : b.which;
		if (a == "13") {
			rsslogin()
		}
	});
	$("#rss-div .step_1").delegate("input", "keydown", function(b) {
		var a = b.keyCode ? b.keyCode : b.which;
		if (a == "13") {
			gotostep2()
		}
	});
	$("#rss-div .step_2").delegate("input", "keydown", function(b) {
		var a = b.keyCode ? b.keyCode : b.which;
		if (a == "13") {
			gotostep3()
		}
	});
	$("#moreComStr").keydown(function(b) {
		var a = b.keyCode ? b.keyCode : b.which;
		if (a == "13") {
			findMoreCom()
		}
	}).focus(function() {
		if ($(this).val() == $(this).attr("placeHolder")) {
			$(this).val("")
		}
	}).blur(function() {
		if ($(this).val() == "") {
			$(this).val($(this).attr("placeHolder"))
		}
	}).blur();
	$(".a-mobile-animate").mouseenter(function() {
		$(this).find("span").stop().animate({
			top : "15px"
		})
	}).mouseleave(function() {
		$(this).find("span").stop().animate({
			top : "65px"
		})
	});
	$(".ad-content").click(function() {
		clearInterval(t_ad);
		adPlay();
		t_ad = setInterval("adPlay()", 3000)
	});
	t_ad = setInterval("adPlay()", 3000);
	cityinit("provinces", 0);
	cityinit("provinces2", 2, setArrCity)
});
indexInit();
function indexInit() {
	if (GetQueryString("whereFrom") == "fromRenRen") {
		var a = GetQueryString("comCode");
		var b = GetQueryString("kdNum");
		selectCompany(a, $("#a-" + a));
		$("#postid").val(b);
		getResult(a, b)
	} else {
		gCompanyCode = getcookie("indexCompanyCode");
		// selectCompany(gCompanyCode, $("#a-" + gCompanyCode))
	}
	$(".com-list").delegate("a", "click", function() {
		// selectCompany($(this).attr("data-code"), $(this));
		return false
	})
}

function adPlay() {
	switch (index_ad) {
	case (0):
		$(".ad-box .ad-content").stop().animate({
			top : "-80px"
		});
		index_ad = 1;
		break;
	case (1):
		$(".ad-box .ad-content").stop().animate({
			top : "-197px"
		});
		index_ad = 2;
		break;
	case (2):
		$(".ad-box .ad-content").stop().animate({
			top : "-314px"
		});
		index_ad = 3;
		break;
	case (3):
		$(".ad-box .ad-content").stop().animate({
			top : "0px"
		});
		index_ad = 0;
		break
	}
}

function query() {
	$("#adDiv").hide();
	$("#rss-div").hide();
	$("#rssTips").hide();
	// if (validateKuaidiNumber()) {
	// getResult(gCompanyCode, $.trim($("#postid").val()))
	// }
	gCompanyCode = 'yunda';
	getResult(gCompanyCode, $.trim($("#postid").val()));
}
/*
 * function selectCompany(e, a) { hideTips(); $("#rss-div").hide();
 * $("#rssTips").hide(); $("#friendTip").show(); $("#companyList
 * a.select-cp").removeClass("select-cp"); a.addClass("select-cp"); if
 * ($("html").scrollTop() > $("#topShow").offset().top) { $("html").animate({
 * scrollTop : $("#topShow").offset().top }, "normal") } selectCompanyByCode(e);
 * setcookie("indexCompanyCode", e); $("#postid").select(); var d =
 * jsonbook.company; var c; for (var b = 0; b < d.length; b++) { if (d[b].code ==
 * gCompanyCode) { c = d[b].web; break } } if (c == 1) {
 * $("#tips-save-btn").hide(); $("#tips-rss-btn").show() } else {
 * $("#tips-rss-btn").hide(); $("#tips-save-btn").show() } }
 * 
 */
/*
function findMoreCom() {
	var c = $.trim($("#moreComStr").val());
	if (c != null && c != "" && c != $("#moreComStr").attr("placeHolder")) {
		var a = jsoncom.company;
		var d = false;
		for ( var b = 0; b < a.length; b++) {
			if (a[b].code.indexOf(c) != -1 || a[b].companyname.indexOf(c) != -1
					|| a[b].url.indexOf(c) != -1
					|| c.indexOf(a[b].shortname) != -1) {
				window.location.href = "/all/" + a[b].url + ".shtml";
				d = true
			}
		}
		if (!d) {
			window.location.href = "/user/moreCompany.shtml?comname="
					+ encodeURIComponent(c)
		}
	} else {
		window.location.href = "/all/index.shtml"
	}
}
*/

function logged() {
	$("#friendTip").hide();
	if (gIsReAddQuery) {
		gIsReAddQuery = false;
		var a = $("#postid").val();
		if (a != "") {
			addQuery()
		}
	}
	countUncheck()
}

function unLogged() {
	countHis()
}

function countHis() {
	var a = getCookieTojson();
	if (_ToJSON(a) != "{}") {
		var b = a.history;
		$("#hisNum").html(b.length).show().unbind("mouseenter").unbind(
				"mouseleave").mouseenter(function() {
			$(this).css("width", "140px");
			$(this).html("您已有了" + $(this).html() + "个查询记录")
		}).mouseleave(function() {
			$(this).css("width", "16px");
			var c = $(this).html().indexOf("个");
			$(this).html($(this).html().substring(4, c))
		});
		$("#hisNum2").html(b.length).show().unbind("mouseenter").unbind(
				"mouseleave").mouseenter(function() {
			$(this).css("width", "140px");
			$(this).html("您已有了" + $(this).html() + "个查询记录")
		}).mouseleave(function() {
			$(this).css("width", "16px");
			var c = $(this).html().indexOf("个");
			$(this).html($(this).html().substring(4, c))
		})
	}
	setTopCookieTips()
}

function countUncheck() {
	$.ajax({
		type : "post",
		url : "/userquery/query",
		data : "method=querycount&transstatus=1",
		success : function(responseText) {
			var resultJson = eval("(" + responseText + ")");
			if (resultJson.status == 200) {
				$("#hisNum2").html(resultJson.totalsize).show().unbind(
						"mouseenter").unbind("mouseleave").mouseenter(
						function() {
							$(this).css("width", "140px");
							$(this).html("您还有" + $(this).html() + "个未签收快递")
						}).mouseleave(function() {
					$(this).css("width", "16px");
					var subStrIndex = $(this).html().indexOf("个");
					$(this).html($(this).html().substring(3, subStrIndex))
				})
			}
		}
	})
}

function useTips() {
	var a = $("#inputTips").find("a").html();
	$("#postid").focus();
	$("#postid").val(a)
}

function addFavoritesHistory(a) {
	var f = "快递查询-查快递，寄快递，上";
	var b = "http://" + document.domain;
	if (a != "" && a != null) {
		b = a
	}
	try {
		window.external.addFavorite(b, f)
	} catch (e) {
		try {
			window.external.AddToFavoritesBar(b, f)
		} catch (d) {
			try {
				window.sidebar.addPanel(f, b)
			} catch (c) {
				alert('收藏失败，此操作被浏览器拒绝！\n请使用"Ctrl+D"进行收藏！')
			}
		}
	}
}

function showCopyNotfind() {
	$("#copyNumInput").val(gKuaidiNumber);
	$("#copyNumBtn").html("（复制单号）");
	if (copyNotfindReady == 0) {
		copyNotfindReady = 1;
		ZCBinder("copyNumInput", "copyNumBtn", "copyNumBox", function() {
			$("#copyNumBtn").html("（复制成功！）")
		})
	}
}

var domainnum = window.location.pathname;
domainnum = domainnum.replace("/", "");
isAutoLogin();
function isAutoLogin() {
	var b = getcookie("loginAccount");
	var a = getcookie("loginStatus");
	var c = getcookie("loginSession");
	if (a == "1" && c == "1") {
		$("#loginAccount").val(b);
		$("#loginStatus").val("1");
		setWelcomeLogin(b);
		setUncheckTips();
		if ($.isFunction(window.logged)) {
			logged()
		}
	} else {
		login()
	}
}

function login() {
	var account = getcookie("loginAccount");
	var password = getcookie("password");
	if (account && account != "" && password && password != "") {
		$("#welcome")
				.html(
						'<img src="http://cdn.kuaidi100.com/images/ajax-loader.gif" />正在自动登陆');
		$.ajax({
			type : "post",
			url : "/login",
			data : "account=" + account + "&password=" + password,
			success : function(responseText) {
				var resultJson = eval("(" + responseText + ")");
				var account = resultJson.account;
				if (resultJson.status == "200") {
					if (resultJson.ischeck == "1") {
						setcookie("ischeck", "1");
						setcookie("phone", resultJson.telephone)
					} else {
						deleteCookie("ischeck")
					}
					setWelcomeLogin(resultJson.account);
					setUncheckTips();
					$("#loginAccount").val(account);
					$("#loginStatus").val("1");
					document.cookie = escape("loginSession") + "="
							+ escape("1") + ";path=/";
					if ($.isFunction(window.logged)) {
						logged()
					}
				} else {
					if (resultJson.status == "302") {
						window.location.href = resultJson.url
					} else {
						if (resultJson.status == "410") {
							deleteCookie("loginAccount");
							deleteCookie("loginStatus");
							deleteCookie("loginSession");
							deleteCookie("password");
							deleteCookie("ischeck");
							deleteCookie("phone");
							location.href = "../login.html"
						} else {
							deleteCookie("loginAccount");
							deleteCookie("loginStatus");
							deleteCookie("loginSession");
							deleteCookie("password");
							deleteCookie("ischeck");
							deleteCookie("phone");
							setWelcomeLogout();
							setTopCookieTips();
							$("#loginAccount").val("");
							$("#loginStatus").val("0");
							if ($.isFunction(window.unLogged)) {
								unLogged()
							}
						}
					}
				}
			}
		})
	} else {
		setWelcomeLogout();
		setTopCookieTips();
		$("#loginAccount").val("");
		$("#loginStatus").val("0");
		if ($.isFunction(window.unLogged)) {
			unLogged()
		}
	}
}

function logout() {
	var outAccount = getcookie("loginAccount");
	if (outAccount && outAccount != "") {
		var logoutUrl = "/logout";
		var sendData = "account=" + escape(outAccount);
		try {
			$.post(logoutUrl, {
				outAccount : outAccount
			}, function(responseText) {
				var resultJson = eval("(" + responseText + ")");
				if (resultJson.status == "200" || resultJson.status == "420") {
					deleteCookie("loginAccount");
					deleteCookie("loginStatus");
					deleteCookie("loginSession");
					deleteCookie("phone");
					deleteCookie("ischeck");
					$.post("/sso/api.do?action=logout", function(responseText) {
						if (/\d{10}/.test(domainnum)
								|| domainnum.indexOf("history.shtml") > -1
								|| domainnum.indexOf("orderList.shtml") > -1) {
							location.replace("../login.html")
						} else {
							location.replace(location.href)
						}
					})
				}
			})
		} catch (e) {
		}
	}
};
