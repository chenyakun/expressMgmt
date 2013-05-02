/* 下单js */
/*公司水印*/
var gCompanySug = "如需发票必须填写";
var gMobileSug = "手机和电话号码至少填写一项";
var gAddrSug1 = "请输入街道名/路名";
var gAddrSug2 = "请输入厂区名/大楼名/小区名及门牌号";
$("#sender_company").val(gCompanySug);
$("#sender_company").addClass("watermark");
$("#sender_company").focus(function() {
	if ($("#sender_company").val() == gCompanySug) {
		$("#sender_company").removeClass("watermark");
		$("#sender_company").val("");
	}
});
$("#sender_company").blur(function() {
	if ($.trim($("#sender_company").val()) == "") {
		$("#sender_company").addClass("watermark");
		$("#sender_company").val(gCompanySug);
	}
});

$("#receive_company").val(gCompanySug);
$("#receive_company").addClass("watermark");
$("#receive_company").focus(function() {
	if ($("#receive_company").val() == gCompanySug) {
		$("#receive_company").removeClass("watermark");
		$("#receive_company").val("");
	}
});
$("#receive_company").blur(function() {
	if ($.trim($("#receive_company").val()) == "") {
		$("#receive_company").addClass("watermark");
		$("#receive_company").val(gCompanySug);
	}
});

$("#receive_address1").val(gAddrSug1);
$("#receive_address1").addClass("watermark");
$("#receive_address1").focus(function() {
	if ($("#receive_address1").val() == gAddrSug1) {
		$("#receive_address1").removeClass("watermark");
		$("#receive_address1").val("");
	}
});
$("#receive_address1").blur(function() {
	if ($.trim($("#receive_address1").val()) == "") {
		$("#receive_address1").addClass("watermark");
		$("#receive_address1").val(gAddrSug1);
	}
});

$("#receive_address2").val(gAddrSug2);
$("#receive_address2").addClass("watermark");
$("#receive_address2").focus(function() {
	if ($("#receive_address2").val() == gAddrSug2) {
		$("#receive_address2").removeClass("watermark");
		$("#receive_address2").val("");
	}
});
$("#receive_address2").blur(function() {
	if ($.trim($("#receive_address2").val()) == "") {
		$("#receive_address2").addClass("watermark");
		$("#receive_address2").val(gAddrSug2);
	}
});

$("#sender_address1").val(gAddrSug1);
$("#sender_address1").addClass("watermark");
$("#sender_address1").focus(function() {
	if ($("#sender_address1").val() == gAddrSug1) {
		$("#sender_address1").removeClass("watermark");
		$("#sender_address1").val("");
	}
});
$("#sender_address1").blur(function() {
	if ($.trim($("#sender_address1").val()) == "") {
		$("#sender_address1").addClass("watermark");
		$("#sender_address1").val(gAddrSug1);
	}
});

$("#sender_address2").val(gAddrSug2);
$("#sender_address2").addClass("watermark");
$("#sender_address2").focus(function() {
	if ($("#sender_address2").val() == gAddrSug2) {
		$("#sender_address2").removeClass("watermark");
		$("#sender_address2").val("");
	}
});
$("#sender_address2").blur(function() {
	if ($.trim($("#sender_address2").val()) == "") {
		$("#sender_address2").addClass("watermark");
		$("#sender_address2").val(gAddrSug2);
	}
});

/*
 * $("#sender_mobile").val(gMobileSug);
 * $("#sender_mobile").addClass("watermark");
 * $("#sender_mobile").focus(function(){
 * if($("#sender_mobile").val()==gMobileSug){
 * $("#sender_mobile").removeClass("watermark"); $("#sender_mobile").val(""); }
 * }); $("#sender_mobile").blur(function(){
 * if($.trim($("#sender_mobile").val())==""){
 * $("#sender_mobile").addClass("watermark");
 * $("#sender_mobile").val(gMobileSug); } });
 */

$("#receive_mobile").val(gMobileSug);
$("#receive_mobile").addClass("watermark");
$("#receive_mobile").focus(function() {
	if ($("#receive_mobile").val() == gMobileSug) {
		$("#receive_mobile").removeClass("watermark");
		$("#receive_mobile").val("");
	}
});
$("#receive_mobile").blur(function() {
	if ($.trim($("#receive_mobile").val()) == "") {
		$("#receive_mobile").addClass("watermark");
		$("#receive_mobile").val(gMobileSug);
	}
});

/* 查询验证 */
function orderValidate() {
	if ($.trim($("#sender_name").val()) == "") {
		alert("请输入发货联系人");
		$("#sender_name").focus();
		return false;
	}
	if ($.trim($("#sender_address1").val()) == ""
			|| $.trim($("#sender_address1").val()) == gAddrSug1) {
		alert("请输入详细发货地址");
		$("#sender_address1").focus();
		return false;
	}
	if ($.trim($("#sender_address2").val()) == ""
			|| $.trim($("#sender_address2").val()) == gAddrSug2) {
		alert("请输入详细发货地址");
		$("#sender_address2").focus();
		return false;
	}
	if ($.trim($("#sender_mobile").val()) == "") {
		alert("请输入发货人手机号码");
		$("#sender_mobile").focus();
		return false;
	} else if (!isNumber($("#sender_mobile").val())) {
		alert("发货人手机号码需要输入数字");
		$("#sender_mobile").select();
		return false;
	} else if ($.trim($("#sender_mobile").val()).length != 11) {
		alert("发货人手机号码需要输入11位");
		$("#sender_mobile").select();
		return false;
	}

	if ($.trim($("#receive_name").val()) == "") {
		alert("请输入收货联系人");
		$("#receive_name").focus();
		return false;
	}
	if ($.trim($("#receive_address1").val()) == ""
			|| $.trim($("#receive_address1").val()) == gAddrSug1) {
		alert("请输入详细收货地址");
		$("#receive_address1").focus();
		return false;
	}
	if ($.trim($("#receive_address2").val()) == ""
			|| $.trim($("#receive_address2").val()) == gAddrSug2) {
		alert("请输入详细收货地址");
		$("#receive_address2").focus();
		return false;
	}
	if (($.trim($("#receive_mobile").val()) == "" || $
			.trim($("#receive_mobile").val()) == gMobileSug)
			&& $.trim($("#receive_tel2").val()) == "") {
		alert("请输入收货人手机或电话号码");
		$("#receive_mobile").focus();
		return false;
	} else if ($.trim($("#receive_mobile").val()) != ""
			&& $.trim($("#receive_mobile").val()) != gMobileSug
			&& !isNumber($("#receive_mobile").val())) {
		alert("收货人手机号码需要输入数字");
		$("#receive_mobile").select();
		return false;
	} else if ($.trim($("#receive_mobile").val()) != ""
			&& $.trim($("#receive_mobile").val()) != gMobileSug
			&& $.trim($("#receive_mobile").val()).length != 11) {
		alert("收货人手机号码需要输入11位");
		$("#receive_mobile").select();
		return false;
	} else if ($.trim($("#receive_tel1").val()) != ""
			&& !isNumber($("#receive_tel1").val())) {
		alert("收货人电话号码需要输入数字");
		$("#receive_tel1").select();
		return false;
	} else if ($.trim($("#receive_tel2").val()) != ""
			&& !isNumber($("#receive_tel2").val())) {
		alert("收货人电话号码需要输入数字");
		$("#receive_tel2").select();
		return false;
	} else if ($.trim($("#receive_tel3").val()) != ""
			&& !isNumber($("#receive_tel3").val())) {
		alert("收货人电话号码需要输入数字");
		$("#receive_tel3").select();
		return false;
	} else if ($.trim($("#receive_tel1").val()) != ""
			&& $.trim($("#receive_tel2").val()) == "") {
		alert("收货人电话号码需要输入座机号");
		$("#receive_tel2").select();
		return false;
	} else if ($.trim($("#receive_tel2").val()) != ""
			&& $.trim($("#receive_tel1").val()) == "") {
		alert("收货人电话号码需要输入区号");
		$("#receive_tel1").select();
		return false;
	} else if ($.trim($("#receive_tel3").val()) != ""
			&& $.trim($("#receive_tel2").val()) == "") {
		alert("收货人电话号码需要输入座机号");
		$("#receive_tel2").select();
		return false;
	}

	if ($.trim($("#cargo_name").val()) == "") {
		alert("请输入货物名称");
		$("#cargo_name").focus();
		return false;
	}
	if ($.trim($("#cargo_total_number").val()) == "") {
		alert("请输入包装总件数");
		$("#cargo_total_number").focus();
		return false;
	} else if (!isNumber($("#cargo_total_number").val())) {
		alert("包装总件数需要输入正整数");
		$("#cargo_total_number").select();
		return false;
	}
	if ($("#cargo_desc").val().length > 64) {
		alert("注意事项/备注最大为64个字符");
		$("#cargo_desc").focus();
		return false;
	}

	return true;
}

// 返回上一步
function backToFirstBaidu() {
	parent.backBaidu();
}
function backToFirst() {
	parent.back();
}
function backToFirstKuaidi100() {
	parent.backKuaidi100();
}

// 判断是否是数字
function isNumber(s) {
	var regu = "^[0-9]+$";
	var re = new RegExp(regu);
	if (re.test(s)) {
		return true;
	} else {
		return false;
	}
}

/* 判断是否登录 */
function isLogined() {
	var valiResult = orderValidate();
	if (!valiResult) {
		return false;
	}
	$("#queryForm").attr("target", "_self");
	$("#queryForm").attr("action",
			"order.do?action=addNewOrder&t=" + new Date().getTime());
	if ($("#sender_company").val() == gCompanySug) {
		$("#sender_company").val("");
	}
	if ($("#receive_company").val() == gCompanySug) {
		$("#receive_company").val("");
	}
	if ($("#receive_mobile").val() == gMobileSug) {
		$("#receive_mobile").val("");
	}

	$("#submitOrder").hide();
	$("#submiting").show();
	$("#queryForm").submit();
	/*
	 * $.ajax({ type:"POST", url:"order.do?action=isLogined",
	 * data:{isPost:"true"},
	 * contentType:"application/x-www-form-urlencoded;charset=utf-8",
	 * success:function(responseText){ if(responseText=="Y"){
	 * $("#queryForm").attr("target","_self");
	 * $("#queryForm").attr("action","order.do?action=addNewOrder");
	 * if($("#sender_company").val()==gCompanySug){
	 * $("#sender_company").val(""); }
	 * if($("#receive_company").val()==gCompanySug){
	 * $("#receive_company").val(""); }
	 * if($("#sender_mobile").val()==gMobileSug){ $("#sender_mobile").val(""); }
	 * if($("#receive_mobile").val()==gMobileSug){ $("#receive_mobile").val(""); }
	 * $("#queryForm").submit(); }else{ showEleCenter("loginIframe"); } } });
	 */
}

/* 查看网点详情 */
function networkDetail(thiz) {
	var senderNetwork = $("#sender_network").val();
	var networkInfo = senderNetwork.split("@and@");
	if (networkInfo.length >= 3) {
		$(thiz).attr("href",
				"http://www.kuaidi100.com/networkDt" + networkInfo[2] + ".htm");
		return true;
	} else {
		alert("请先选择网点");
		return false;
	}
}

/* 页面预览 */
function viewOrder() {
	var valiResult = orderValidate();
	if (!valiResult) {
		return false;
	}
	$("#queryForm").attr("target", "_blank");
	$("#queryForm").attr("action", "order.do?action=addNewOrder&isView=true");
	if ($("#sender_company").val() == gCompanySug) {
		$("#sender_company").val("");
	}
	if ($("#receive_company").val() == gCompanySug) {
		$("#receive_company").val("");
	}
	if ($("#sender_mobile").val() == gMobileSug) {
		$("#sender_mobile").val("");
	}
	if ($("#receive_mobile").val() == gMobileSug) {
		$("#receive_mobile").val("");
	}
	if ($("#sender_address1").val() == gAddrSug1) {
		$("#sender_address1").val("");
	}
	if ($("#sender_address2").val() == gAddrSug2) {
		$("#sender_address2").val("");
	}
	if ($("#receive_address1").val() == gAddrSug1) {
		$("#receive_address1").val("");
	}
	if ($("#receive_address2").val() == gAddrSug2) {
		$("#receive_address2").val("");
	}
	$("#queryForm").submit();
	if ($("#sender_company").val() == "") {
		$("#sender_company").val(gCompanySug);
	}
	if ($("#receive_company").val() == "") {
		$("#receive_company").val(gCompanySug);
	}
	if ($("#sender_mobile").val() == "") {
		$("#sender_mobile").val(gMobileSug);
	}
	if ($("#receive_mobile").val() == "") {
		$("#receive_mobile").val(gMobileSug);
	}
	if ($("#sender_address1").val() == "") {
		$("#sender_address1").val(gAddrSug1);
	}
	if ($("#sender_address2").val() == "") {
		$("#sender_address2").val(gAddrSug2);
	}
	if ($("#receive_address1").val() == "") {
		$("#receive_address1").val(gAddrSug1);
	}
	if ($("#receive_address2").val() == "") {
		$("#receive_address2").val(gAddrSug2);
	}
}
