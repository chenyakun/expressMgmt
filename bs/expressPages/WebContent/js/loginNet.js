/**
 * 网点登录页面js
 */

var gAccountSug="请输入手机号码/电子邮箱";

initFunction();

/*初始化函数*/
function initFunction(){
	/*$("#account").mailAutoComplete({
		boxClass: "out_box"
	});*/
	$("#account").keydown(function(e){
		var keycode = e.keyCode ? e.keyCode: e.which;
		if(keycode == "13"){
			$("#account").blur();
			$("#password").focus();
		}
	});
	$("#password").keydown(function(e){
		var keycode = e.keyCode ? e.keyCode: e.which;
		if(keycode == "13"){
			loginNet();
		}
	});
	
	$("#account").val(gAccountSug);
	$("#account").addClass("watermark");
	$("#account").focus(function(){
		if($("#account").val()==gAccountSug){
			$("#account").removeClass("watermark");
			$("#account").val("");
		}
	});
	$("#account").blur(function(){
		if($.trim($("#account").val())==""){
			$("#account").addClass("watermark");
			$("#account").val(gAccountSug);
		}
	});
}

function loginNet(){
	$("#account").val($.trim($("#account").val()));
	if($("#account").val()==""||$.trim($("#account").val())==gAccountSug){
		alert("请输入用户名");
		//$("#logBox .pwdError").html("请输入用户名");
		//$("#logBox .pwdError-p").show();
		$("#account").focus();
		$("#account").select();
		return;
	}
	if($("#password").val()==""){
		alert("请输入密码");
		//$("#logBox .pwdError").html("请输入密码");
		//$("#logBox .pwdError-p").show();
		$("#password").focus();
		$("#password").select();
		return;
	}
	
	$("#regWait").show();
	$.ajax({
		type : "POST",
		contentType : "application/x-www-form-urlencoded;charset=utf-8",
		url : "http://localhost:8080/expressAdmin/userController/login.action",
		data : $("#loginNetForm").serializeArray(),
		success : function(responseText) {
			$("#regWait").hide();
			var res = $.parseJSON(responseText);
			if (!res.success) {
				alert("用户名错误");
				//$("#logBox .pwdError").html("用户名错误");
				//$("#logBox .pwdError-p").show();
				$("#account").focus();
				$("#account").select();
			} else if (res.result == "errorInviteStatus") {
				alert("此用户尚未激活，请先使用激活码激活");
				//$("#logBox .pwdError").html("此用户尚未激活，请先使用激活码激活");
				//$("#logBox .pwdError-p").show();
			} else if (res.result == "errorPassword") {
				alert("密码错误");
				//$("#logBox .pwdError").html("密码错误");
				//$("#logBox .pwdError-p").show();
				$("#password").focus();
				$("#password").select();
			} else if (res.success) {
				
				
				location.href = "http://localhost:8080/expressAdmin/";
				
			 
			}
		}
	});
}

