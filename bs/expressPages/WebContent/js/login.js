/**
 * reg页面js
 */
var isRegister=false;//是否刚注册
var gEmailFZ=22;
//var isfirstregster=false;//是否第一次注册

//登录注册全局变量
var account = '';
var pwd = '';

//reg.js放到文件末端执行比$(document).ready反映速度快很多
var loginAccount = getcookie("loginAccount");
var loginStatus = getcookie("loginStatus");
var loginSession = getcookie("loginSession");
if(loginSession == null){
	loginSession = "";
}
if(loginSession == "1"){ //已登录
	var source=GetQueryString("source");
	if(source=="order"){//如果来自下单
		$.ajax({
			type:"POST",
			url:"/userOrderReg?action=isLogin",
			data:{isPost:"true"},
			contentType:"application/x-www-form-urlencoded;charset=utf-8", 
			success:function(responseText){
				var resultJson = eval("(" + responseText + ")");
				if(resultJson.status=="Y"){//确定session存在
					location.href="/userOrderReg?action=regAndLogin";
				}else{//session不存在
					$.post("/login",{account:loginAccount},
						function(responseText){
							var resultJson = eval("("+ responseText + ")");
							if(resultJson.status=="200"){//登录成功
								location.href="/userOrderReg?action=regAndLogin";
							}
						}
					);
				}
			}
		});
	}else{	
		addQuerysFromCookie();
	}
}else{//未登录
	var account = getcookie("loginAccount");
	var pwd = getcookie("password");
	
	if(account != null && account != "" && pwd != null && pwd != ""){
		$.ajax({
			type:"post",
			url:"/login",
			data:"account=" + account + "&password=" + pwd,
			success:function(responseText){
				var resultJson = eval("("+ responseText + ")");
				if(resultJson.status == 200){//存在帐号
					addQuerysFromCookie();
				}else{
					deleteCookie("loginAccount");
					deleteCookie("loginStatus");
					deleteCookie("loginSession");
					deleteCookie("password");
					deleteCookie("ischeck");
					deleteCookie("phone");
				}
			}
		});	
	}else{
		deleteCookie("loginAccount");
		deleteCookie("loginStatus");
		deleteCookie("loginSession");
		deleteCookie("password");
		deleteCookie("ischeck");
		deleteCookie("phone");
	}
}
$(function() {
	setWelcomeLogout();
	
	$("#email").blur(function(){
		var account=$.trim($("#email").val());
		$("#email").val(account);
		if($("#email").val()!=""){
			logValidateAccount(account,"888888");
		}
	}).keydown(function(e){
		var keycode = e.keyCode ? e.keyCode: e.which;
		if(keycode == "13"){
			logConfirm();
		}
	});
	$("#logBox").delegate("input#logpwd","keydown",function(e){
		var keycode = e.keyCode ? e.keyCode: e.which;
		if(keycode == "13"){
			logConfirm();
		}
	});

	$("#logBox input").focus(function(){
		$(this).addClass("focus");
	}).blur(function(){
		$(this).removeClass("focus");
	});
	
	var loginCookies = getcookie("loginCookies");
	if(loginCookies != null && loginCookies != ""){
		var loginNameArray = loginCookies.split(",");
		var loginNames = [];
		for(var i in loginNameArray){
			loginNames.push(loginNameArray[i]);
		}
		$("#email").autocomplete({
			source: loginNames
		});
	}
});

/* 邮箱改变时判断字体 */
function emailChange(){
	$("#emailSpan").text($("#email").val());
	var emailWidth=$("#emailSpan").width();
	if(emailWidth>260){
		if(gEmailFZ>12){
			gEmailFZ=gEmailFZ-2;
			$("#email").css("font-size",gEmailFZ+"px");
			$("#emailSpan").css("font-size",gEmailFZ+"px");
			emailChange();
		}
	}else{
		if(gEmailFZ<22){
			var emailFZ=gEmailFZ+2;
			$("#emailSpan").css("font-size",emailFZ+"px");
			var emailSpanWidth=$("#emailSpan").width();
			if(emailSpanWidth<=260){
				gEmailFZ=gEmailFZ+2;
				$("#email").css("font-size",gEmailFZ+"px");
				$("#emailSpan").css("font-size",gEmailFZ+"px");
				emailChange();
			}else{
				$("#emailSpan").css("font-size",gEmailFZ+"px");
			}
			
		}
	}
}

function pwdInputInit(){
	$("#logBox").find("input").val("");
	$("#error").hide();
}

/* 确定按钮事件->登录 */
function logConfirm(){
	var account = $.trim($('#email').val());
	var pwd = $('#logpwd').val();
	var remember = $('#remember').attr('checked');
	
	account = account.toLowerCase();
	
    if(logValidateAccount(account,pwd)){		
		$("#logBox").find("#regWait").show();
		$.ajax({
			type:"post",
			url:"/login",
			data:"account=" + account + "&password=" + pwd,
			dataType:"json",
			success:function(resultJson){
				$("#logBox").find("#regWait").hide();
				if(resultJson.status == 200){//存在帐号
					saveLoginCookies(resultJson.account,pwd,remember);
					if(resultJson.ischeck=="1"){//手机验证状态
					  setcookie("ischeck","1");
					  setcookie("phone",resultJson.telephone);
					}else{
					  deleteCookie("ischeck");
					}
					addQuerysFromCookie();
				}else if(resultJson.status == 302){
					window.location.href = resultJson.url;
				}else if(resultJson.status == 424){
					$("#logBox").find("#errorTips").html("您输入的账号不存在");
					$("#logBox").find("#error").show();
				}else if(resultJson.status == 410){
					$("#logBox").find("#errorTips").html("用户名或密码错误");
					$("#logBox").find("#error").show();
				}else{
					$("#logBox").find("#errorTips").html("请输入正确的Email或手机");
					$("#logBox").find("#error").show();
				}
			}
		});
		
		var loginCookies = getcookie("loginCookies");
		if(loginCookies != null && loginCookies != ""){
			if(loginCookies.indexOf(account) == -1){
				loginCookies += "," + account;
			}
		}else{
			loginCookies = account;
		}
		setcookie("loginCookies",loginCookies);
	}
}

/* 注册后把cookies单号存入数据库 */
function addQuerysFromCookie(){
  var userQuerys="{\"userquerys\":[";
  jsoncookie=getCookieTojson();
  if(_ToJSON(jsoncookie)!="{}"){
	var history= jsoncookie["history"];
	if(history!=null){
	  for(var i = history.length-1; i >-1; i--){
		userQuerys += "{\"kuaidicom\":\""+history[i].code+"\",\"kuaidinum\":\""+history[i].nu+"\"},";
	  }
	  if(history.length>0){
		userQuerys.substring(0, userQuerys.length-1);
	  }
	}
  }
  userQuerys += "]}";
  var addQuerysUrl="/userquery/adds";
  $.post(addQuerysUrl,{userquerys:userQuerys},
  function(responseText){
	//无论是否添加成功，返回结果即跳转
	//var account=$("#email").val();
	//document.cookie = escape("loginAccount") + "=" + escape(account) + ";path=/";
	
	if(window.location.href.indexOf("redirect=") != -1){
		var index = window.location.href.indexOf("redirect=");
		var redirect = window.location.href.substring(index+9);
		location.href = redirect;
	}else{
		location.href = "/user/history.shtml";
		 
	}
  });
}

/* 登录 - 验证账号 */
function logValidateAccount(account,pwd){

	//	if(ityValidaccount){
//		$("#logBox").find("#errorTips").html("用户名有非法字符，请重新输入")
//		$("#logBox").find("#error").show();
//		$('#email').select();
//		return false;		
//	}else
	if(checkEmail(account)){
		if(account.length >= 64){
			$("#logBox").find("#errorTips").html("这个Email的长度大于64个字符...")
			$("#logBox").find("#error").show();
			$('#email').select();
			return false;
		}else{
			$("#logBox").find("#error").hide();
		}
	}else if(checkMobile(account)){
		$("#logBox").find("#error").hide();
	}else{
		$("#logBox").find("#errorTips").html("请输入正确的Email或手机");
		$("#logBox").find("#error").show();
		$("#email").select();
		return false;
	}
	
	if(pwd == '' || pwd == null){
		$("#logBox").find("#errorTips").html("请输入密码");
		$("#logBox").find("#error").show();
		$("#logpwd").select();
		return false;
	}else{
		$("#logBox").find("#error").hide();
	}
	return true;
}

function forgetPwd(){
	var account = $("#email").val();
	if(checkEmail(account)){
		window.location.href = "/user/findByEmail.shtml?email=" + account;
	}else if(checkMobile(account)){
		window.location.href = "/user/findByTel.shtml?tel=" + account;
	}else{
		window.location.href = "/user/findByTel.shtml";
	}
}

function isNumberLetterFuhao(str) {
	var regStr = "^[0-9a-zA-Z\@\#\$\-\]+$";
	var reg = new RegExp(regStr);
	if (reg.test(str)) {
		return true;
	} else {
		return false;
	}
}

/* 邮箱验证 */
function checkEmail(email) {
  var regular = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
  return regular.test(email);   
}  

/* 验证手机 */
function checkMobile(mobile){ 
  var regular = /^(?:13\d|14\d|15\d|18\d)-?\d{5}(\d{3}|\*{3})$/;
  return regular.test(mobile); 
}

/* 存帐号cookies（没点记住帐号cookies只存到没有关闭浏览器前） */
function saveLoginCookies(account,pwd,remember){
  if(remember){
	  setcookie("loginAccount",account);
	  setcookie("loginStatus","1");
	  setcookie("password",pwd);
  }else{
	  document.cookie = escape("loginAccount") + "=" + escape(account) + ";path=/";
 	  document.cookie = escape("loginStatus") + "=" + escape("1") + ";path=/";
	  document.cookie = escape("password") + "=" + escape(pwd) + ";path=/";
  }
  document.cookie = escape("loginSession") + "=" + escape("1") + ";path=/";
}