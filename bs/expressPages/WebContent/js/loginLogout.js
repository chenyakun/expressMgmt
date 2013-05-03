/**
 * 登录注销js
 * cookie中loginAccount为当前登录帐号，loginStatus为登录状态
 */
var domainnum = window.location.pathname; 
domainnum = domainnum.replace("/", "");

isAutoLogin();

function isAutoLogin(){//自动登录
	var loginAccount = getcookie("loginAccount");
	var loginStatus = getcookie("loginStatus");
	var loginSession = getcookie("loginSession");

	if(loginStatus == "1" && loginSession == "1"){ //已登录
		$("#loginAccount").val(loginAccount);
		$("#loginStatus").val("1");
		setWelcomeLogin(loginAccount);
		setUncheckTips();
		if($.isFunction(window.logged)){
		  logged();
		}
	}else{
		login();
	}
}



function login(){//登录操作
	var account = getcookie("loginAccount");
	var password = getcookie("password");
	
	if(account && account != "" && password && password != ""){ //有帐号有密码
		$("#welcome").html("<img src=\"http://cdn.kuaidi100.com/images/ajax-loader.gif\" />正在自动登陆");
		$.ajax({
			type:"post",
			url:"/login",
			data:"account=" + account + "&password=" + password,
			success:function(responseText){
				var resultJson = eval("(" + responseText + ")");
				var account = resultJson.account;
				if(resultJson.status == "200"){ //登录成功
					if(resultJson.ischeck=="1"){//手机验证状态
					  setcookie("ischeck","1");
					  setcookie("phone",resultJson.telephone);
					}else{
					  deleteCookie("ischeck");
					}
					setWelcomeLogin(resultJson.account);
					setUncheckTips();
					$("#loginAccount").val(account);
					$("#loginStatus").val("1");
					document.cookie = escape("loginSession") + "=" + escape("1") + ";path=/";
					
					if($.isFunction(window.logged)){
						logged();
					}
				}else if(resultJson.status == "302"){
					window.location.href = resultJson.url;
				}else if(resultJson.status == "410"){//个性域名不存在，跳转到登录状态。
					deleteCookie("loginAccount");
					deleteCookie("loginStatus");
					deleteCookie("loginSession");
					deleteCookie("password");
					deleteCookie("ischeck");
					deleteCookie("phone");
					location.href="/login.html";
				}else{ //登录失败
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
					if($.isFunction(window.unLogged)){
						unLogged();
					}
				}
			}
		});
	}else{ //无帐号显示登录
		setWelcomeLogout();
		setTopCookieTips();
		$("#loginAccount").val("");
		$("#loginStatus").val("0");
		if($.isFunction(window.unLogged)){
			unLogged();
		}
	}
}

function logout(){//注销 
  var outAccount = getcookie("loginAccount");
  if(outAccount && outAccount != ""){ //有登录
	var logoutUrl = "/logout";
	var sendData = "account=" + escape(outAccount);
	try{
		$.post(logoutUrl,{outAccount: outAccount},
		function(responseText){
		  var resultJson = eval("(" + responseText + ")");
		  if(resultJson.status == "200" || resultJson.status == "420"){ //注销成功(或未登录)，注销时把记住我账号销毁
			//$("#frame_logout").attr("src","http://service.youshang.com/logout.do?t="+Math.round(Math.random()*10000));
			deleteCookie("loginAccount");
			deleteCookie("loginStatus");
			deleteCookie("loginSession");
			deleteCookie("phone");
			deleteCookie("ischeck");
			$.post("/sso/api.do?action=logout",function(responseText){
				if(/\d{10}/.test(domainnum)||domainnum.indexOf("history.shtml")>-1||domainnum.indexOf("orderList.shtml")>-1){
				  location.replace("/login.html");
				}else{
				  location.replace(location.href);
				}
			});
		  }
		});
	}catch(e){
	}
  }
}
