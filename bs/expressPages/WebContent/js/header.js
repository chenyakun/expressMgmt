/**
 * header的js
 */

selectNav();
//loadAffiche();

//公告用计时器
var t;

/* 选中页面所属的导航菜单 */
function selectNav(){
	var headerMenuInput = $("#headerMenu").val();
	if(headerMenuInput != null && headerMenuInput != ""){
		var headerMenuInputArray = headerMenuInput.split(" ");
		if(headerMenuInputArray.length == 2){
			var headerMenu = headerMenuInputArray[0];
			var headerSubMenu = headerMenuInputArray[1];
			$(".nav-select").removeClass("nav-select");
			$("#" + headerMenu).addClass("nav-select");
			$("#" + headerSubMenu).addClass("nav-select");
			$("#" + headerMenu + "SubMenu").show();
			if($("#" + headerMenu + "SubMenu .nav-select").length > 0){
				$("#" + headerMenu + "SubMenu").find(".underline").css({width:$("#" + headerMenu + "SubMenu .nav-select").css("width"),left:($("#" + headerMenu + "SubMenu .nav-select").offset().left - $("#" + headerMenu + "SubMenu").offset().left)},"fast");
			}
			$(".sub-nav").show();
		}else if(headerMenuInputArray.length == 1){
			var headerMenu = headerMenuInputArray[0];
			$("#" + headerMenu).addClass("nav-select");
			$(".sub-nav").hide();
		}else{
			$(".sub-nav").hide();
		}
	}else{
		$(".sub-nav").hide();
	}
	
	$(".sub-nav-box").delegate("a","mouseenter",function(){
		$(this).siblings(".underline").stop().animate({width:$(this).css("width"),left:($(this).offset().left - $(this).parent().offset().left)},"fast");
	}).mouseleave(function(){
		if($(this).find(".nav-select").length > 0){
			$(this).find(".underline").stop().animate({width:$(this).find(".nav-select").css("width"),left:($(this).find(".nav-select").offset().left - $(this).offset().left)},"fast");
		}else{
			$(this).find(".underline").stop().css({width:"0px",left:"0px"});
		}
	});
}

/* 根据是否登录判断历史记录页面链接 */
function historyPageLink(){
	var cookieValue = $("#loginStatus").val();
	if(cookieValue != "1"){//未登录
		location.href="login.html";
	}else{//已登录
		location.href="history.html";
	}
}

/* 根据是否登录判断我的订单页面链接 */
function orderPageLink(){
	var cookieValue = $("#loginStatus").val();
	if(cookieValue != "1"){//未登录
		location.href="login.html";
	}else{//已登录
		location.href="orderList.shtml";
	}
}

function setWelcomeLogin(account){
	$("#welcome").html("[&nbsp;<span class=\"login\"><a href=\"set_info.shtml\">" + account + "</a></span>&nbsp;|&nbsp;<a href=\"/user/\" onclick=\"logout();return false;\" class=\"logout\">退出</a>&nbsp;]");
}

function setWelcomeLogout(){
	$("#welcome").html("[&nbsp;<a href=\"login.html\">登录</a>&nbsp;|&nbsp;<a href=\"regByTel.shtml\">注册</a>&nbsp;]");
}

function setTopCookieTips(){
	var jsoncookie=getCookieTojson();
	if(_ToJSON(jsoncookie)!="{}"){
	  var history= jsoncookie["history"];
	  $("#cookieTips").html("<a href=\"../user/history.shtml?from=banner\">已为您保存&nbsp;" + history.length + "&nbsp;条查询记录，点此查看&gt;&gt;</a>").show();
	  $("#cookieTips2").html("[" + history.length + "]").show();
	  $("#moreList").css({"width":"100px"});
	  $(".more-link").css({"width":"80px"});
	}
}

function setUncheckTips(){
	$.ajax({
		type:"post",
		url:"/userquery/query",
		data:"method=querycount&transstatus=1",
		success:function(responseText){
			var resultJson = eval("(" + responseText + ")");
			if(resultJson.status == 200){
				$("#uncheckTips").html("<a href=\"/user/history.shtml?from=banner\">您还有&nbsp;" + resultJson.totalsize + "&nbsp;个未签收快递</a>");
				$("#uncheckTips2").html("[" + resultJson.totalsize + "]").show();
	  			$("#cookieTips2").html("[" + resultJson.totalsize + "]").show();
				if(resultJson.totalsize < 10){
					$("#moreList").css({"width":"100px"});
					$(".more-link").css({"width":"80px"});
					$(".tabSpan-w").css({"width":"110px"});
				}else if(resultJson.totalsize < 100){
					$("#moreList").css({"width":"105px"});
					$(".more-link").css({"width":"85px"});
					$(".tabSpan-w").css({"width":"115px"});
				}else{
					$("#moreList").css({"width":"110px"});
					$(".more-link").css({"width":"90px"});
					$(".tabSpan-w").css({"width":"120px"});
				}
				$("#uncheckTips2").parent().mouseenter(function(){$("#uncheckTips").show();}).mouseleave(function(){$("#uncheckTips").hide();});
			}
		}
	});
}

/* 添加到收藏夹 */
function addFavorites(setUrl){
	var title="快递查询-查快递，寄快递，上";
    var url="http://"+document.domain;
	if(setUrl!="" && setUrl!=null){
		url = setUrl
	}
	
	try{
		window.external.addFavorite(url,title);
	}catch(e1){
		try{
			window.external.AddToFavoritesBar(url,title);
		}catch (e2){
			try{
				window.sidebar.addPanel(title,url);
			}catch (e3){
				alert("收藏失败，此操作被浏览器拒绝！\n请使用\"Ctrl+D\"进行收藏！");
			}
		}
	}
}

function feedbackInit(){
	$('.fb-finish').hide();
	$('.fb-box').hide();
	$('#fb-input2').hide();
	$('#fb-input1').show();
	$('#fb-checkbox').attr('checked',false);
	$("#fb-context").val("");
	$("#fb-error").hide();
}

function submitFeedback(){
	$("#fb-error").hide();
	var context = $("#fb-context").val();
	var fbsender = $("#fb-sender").val();
	var fbchecked = $("#fb-checkbox").attr("checked");
	var isEmail = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(fbsender);
	var isQQ = /^[0-9]+$/.test(fbsender);
	
	if(fbchecked && fbsender == ''){
		$("#fb-error").html("请输入您的邮箱或者QQ。");
		$("#fb-error").show();
		$("#fb-sender").select();
		return false;
	}else if(fbchecked && !(isEmail || isQQ)){
		$("#fb-error").html("请输入正确的邮箱或者QQ。");
		$("#fb-error").show();
		$("#fb-sender").select();
		return false;
	}else if(context == ''){
		$("#fb-error").html("请输入您的建议。");
		$("#fb-error").show();
		$("#fb-context").select();
		return false;
	}else if(context.length < 10){
		$("#fb-error").html("填写的建议请不少于10个字。");
		$("#fb-error").show();
		$("#fb-context").select();
		return false;
	}else{
		context = "#用户体验建议#" + context + "from[" + window.location.href + "]";
		$.ajax({
			type:"POST",
			url:"/Mailsend",
			data:"context=" + encodeURIComponent(encodeURIComponent(context)) + "&sender=" + ((fbchecked&&isEmail)?fbsender:"") + "&fqq=" + ((fbchecked&&isQQ)?fbsender:""),
			success:function(responseText){
				var resultData = eval('(' + responseText + ')');
				if(resultData.status == 200){
					$('.fb-box').hide();
					$('.fb-finish').show();
				}else{
					$("#fb-error").html("提交失败，请刷新后重试。");
					$("#fb-error").show();
				}
			}
		});
	}
}

function gototop(){
	acceleration = 0.3;
	time = 15;
	var x=0,y=0;

	if (document.documentElement) {
	   x = document.documentElement.scrollLeft || 0;
	   y = document.documentElement.scrollTop  || 0;
	}
	
	var speed = 1 + acceleration;
	window.scrollTo(x, Math.floor(y / speed));
	if(y > 0) {
		var invokeFunction = "gototop()";
		window.setTimeout(invokeFunction, time);
	}
}

function gotobottom(){
	window.scrollTo(document.documentElement.scrollLeft, document.documentElement.scrollHeight);
}

function loadAffiche(){
	var loadAffiche = getCookieByName("loadAffiche");
	if(loadAffiche!=1){
		$.ajax({
			type:"POST",
			url:"/loadAffiche",
			success:function(responseText){
				var resultJson = eval("("+ responseText + ")");
				switch(resultJson.status){
					case("0"):{
						var list = resultJson.list;
						if(list.length > 0){
							if(list.length == 1){
								$("#afficheTips").html("<p id='affiche' class='tips'><a onclick='$(\"#afficheTips\").hide();return false;' href='#' class='tips-close' title='关闭'></a><strong></strong>"+list[0].content+"</p>");
							}else{
								showAffiche(list,0);
							}
							$("#afficheTips").show();
						}
						break;
					}
					case("1"):{
						if($("#pageName").val()!="history"){
							var list = resultJson.list;
							if(list.length > 0){
								if(list.length == 1){
									var html = "";
									if(list[0].href!=''){
										html = "<a href='"+list[0].href+"' target='_blank'><img src='"+list[0].url+"'/></a>";
									}else{
										html = "<img src='"+list[0].url+"'/>";
									}
									$("#afficheTips").html(html);
									$("#afficheTips").show();
								}else{
									showAd(list,0);
								}
							}
							break;
						}
					}
					default:{
						
					}
				}
			}
		});
		$("#afficheTips .tips-close").click(function(){
			$('#afficheTips').show();
			clearInterval(t);
			//setcookie2("loadAffiche",1,24*3600*1000);
			setcookie2("loadAffiche",1,1000);
			return false;
		});
		
	}
}

function showAffiche(list,i){
	$("#afficheTips").html("<p id='affiche' class='tips'><a onclick='$(\"#afficheTips\").hide();return false;' href='#' class='tips-close' title='关闭'></a><strong></strong>"+list[i].content+"</p>");
	if(i==list.length-1) i=0;
	else i++;
	clearInterval(t);
	t = setInterval(function(){showAffiche(list,i)},8000);
}

function showAd(list,i){
	$("#afficheTips").fadeOut("normal",function(){
		var html = "";
		if(list[i].href!=''){
			html = "<a href='" + list[i].href + "' target='_blank'><img src='" + list[i].url + "'/></a>";
		}else{
			html = "<img src='" + list[i].url + "'/>";
		}
		$("#afficheTips").html(html);
		$("#afficheTips").fadeIn("normal");
									
		if(i==list.length-1) i=0;
		else i++;
		clearInterval(t);
		t = setInterval(function(){showAd(list,i)},8000);
	});
}

$(document).ready(function(){ 

	$("#serviceList").mouseleave(function(){     //ul li部分
		$("#serviceList").hide();
		$(".service-link").removeClass("service-link-open");   //a标签
	});
	
	$(".service-link").mouseenter(function(){    //a标签
		$('#serviceList').show();                //ul li部分
		$(".service-link").addClass("service-link-open");
	});
	
	$("#serviceList02").mouseleave(function(){    //ul li部分
		$("#serviceList02").hide();
		$(".service-link02").removeClass("service-link-open02");   //a标签
	});
	
	$(".service-link02").mouseenter(function(){  //a标签
		$('#serviceList02').show();              //ul li部分
		$(".service-link02").addClass("service-link-open02");     //a标签
	});
	
	
	
	$("#moreList").mouseleave(function(){
		$("#moreList").hide();
		$(".more-link").removeClass("more-link-open");
	});
	$(".more-link").mouseenter(function(){
		$('#moreList').show();
		$(".more-link").addClass("more-link-open");
	});
});


/* 获取cookie值(严格) */
function getCookieByName(cookieName){
  var cookieValue="";if (document.cookie && document.cookie != '') {var cookies = document.cookie.split(';');
  for (var i = 0; i < cookies.length; i++) {var cookie = cookies[i].replace(/(^\s*)|(\s*$)/g, "");
  if(cookie.substring(0, cookieName.length + 1) == (cookieName + '=')){cookieValue = unescape(cookie.substring(cookieName.length + 1));break;}}}return cookieValue;
}
/*获取cookies*/
function getcookie(cookieName) {
  var cookieValue="";if (document.cookie && document.cookie != '') {var cookies = document.cookie.split(';');
  for (var i = 0; i < cookies.length; i++) {var cookie = cookies[i].replace(/(^\s*)|(\s*$)/g, "");
  if(cookie.substring(0, cookieName.length + 1) == (cookieName + '=')){cookieValue = unescape(cookie.substring(cookieName.length + 1));break;}}}return cookieValue;
}

//设置永久cookies
function setcookie(cookieName, cookieValue) {
  var expires = new Date();
  var now = parseInt(expires.getTime());
  var et = (86400 - expires.getHours() * 3600 - expires.getMinutes() * 60 - expires.getSeconds());
  expires.setTime(now + 1000000 * (et - expires.getTimezoneOffset() * 60));
  document.cookie = escape(cookieName) + "=" + escape(cookieValue) + ";expires=" + expires.toGMTString() + "; path=/";
}

//设置定时cookies
function setcookie2(cookieName, cookieValue, expireTime) {
  var expires = new Date();
  var now = parseInt(expires.getTime());
  expires.setTime(now + expireTime);
  document.cookie = escape(cookieName) + "=" + escape(cookieValue) + ";expires=" + expires.toGMTString() + "; path=/";
}

function deleteCookie(name) {
  var exp = new Date();
  exp.setTime(exp.getTime() - 1);
  var cval = getcookie(name);
  document.cookie = escape(name) + "=" + escape(cval) + "; expires=" + exp.toGMTString() + "; path=/";
}

function getCookieTojson() {
  var tempstr = getcookie('toolbox_urls');
  if (tempstr == null || tempstr == "") {
    return {};
  }
  //alert(_ToJSON(tempstr));
  var jsoncookietemp = eval("(" + _ToJSON(tempstr) + ")");
  return jsoncookietemp;

}

function _ToJSON(o) {
  if (o == null) return "null";
  switch (o.constructor) {
  case String:
    var s = o; // .encodeURI();
    if (s.indexOf("}") < 0) s = '"' + s.replace(/(["\\])/g, '\\$1') + '"';
    s = s.replace(/\n/g, "\\n");
    s = s.replace(/\r/g, "\\r");
    return s;
  case Array:
    var v = [];
    for (var i = 0; i < o.length; i++) v.push(_ToJSON(o[i]));
    if (v.length <= 0) return "\"\"";
    return "" + v.join(",") + "";
  case Number:
    return isFinite(o) ? o.toString() : _ToJSON(null);
  case Boolean:
    return o.toString();
  case Date:
    var d = new Object();
    d.__type = "System.DateTime";
    d.Year = o.getUTCFullYear();
    d.Month = o.getUTCMonth() + 1;
    d.Day = o.getUTCDate();
    d.Hour = o.getUTCHours();
    d.Minute = o.getUTCMinutes();
    d.Second = o.getUTCSeconds();
    d.Millisecond = o.getUTCMilliseconds();
    d.TimezoneOffset = o.getTimezoneOffset();
    return _ToJSON(d);
  default:
    if (o["toJSON"] != null && typeof o["toJSON"] == "function") return o.toJSON();
    if (typeof o == "object") {
      var v = [];
      for (attr in o) {
        if (typeof o[attr] != "function") v.push('"' + attr + '": ' + _ToJSON(o[attr]));
      }
      if (v.length > 0) return "{" + v.join(",") + "}";
      else return "{}";
    }
    //alert(o.toString());
    return o.toString();
  }
};

/*获取参数*/
function GetQueryString(name){
  var reg=new RegExp("(^|&)"+name+"=([^&]*)(&|$)","i");
  var r=window.location.search.substr(1).match(reg);
  if(r!=null) return unescape(r[2]);return null;
}
