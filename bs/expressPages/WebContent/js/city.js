/*选择城市*/
function cityinit(id, inputId, callback) {

	var html = "";
	html += "<ul class=\"tab-list\">";
	html += "<li id=\"select-tab\"></li>";
	html += "<li class=\"select tab\" id=\"common\" index=\"0\"><a href=\"#\">常用</a></li>";
	html += "<li class=\"tab\" id=\"province\" index=\"1\"><a href=\"#\">省份</a></li>";
	html += "<li class=\"tab\" id=\"city\" index=\"2\"><a href=\"#\">城市</a></li>";
	html += "</ul>";
	html += "<div class=\"tab-box\"> <a class=\"place city\" href=\"#\" code=\"310000\">上海市</a> <a class=\"place city\" href=\"#\" code=\"440300\">深圳市</a> <a class=\"place city\" href=\"#\" code=\"110000\">北京市</a> <a class=\"place city\" href=\"#\" code=\"440100\">广州市</a> <a class=\"place city\" href=\"#\" code=\"320500\">苏州市</a> <a class=\"place city\" href=\"#\" code=\"510100\">成都市</a> <a class=\"place city\" href=\"#\" code=\"441900\">东莞市</a> <a class=\"place city\" href=\"#\" code=\"330200\">宁波市</a> <a class=\"place city\" href=\"#\" code=\"120000\">天津市</a> <a class=\"place city\" href=\"#\" code=\"330100\">杭州市</a> <a class=\"place city\" href=\"#\" code=\"370200\">青岛市</a> <a class=\"place city\" href=\"#\" code=\"500000\">重庆市</a> <a class=\"place city\" href=\"#\" code=\"420100\">武汉市</a> <a class=\"place city\" href=\"#\" code=\"440600\">佛山市</a> <a class=\"place city\" href=\"#\" code=\"410100\">郑州市</a> </div>";
	html += "<div class=\"hidden tab-box province-box\">";
	html += "<dl>";
	html += "<dt>A-G</dt>";
	html += "<dd> <a class=\"place province\" href=\"#\" code=\"34\">安徽</a> <a class=\"place province\" href=\"#\" code=\"11\">北京</a> <a class=\"place province\" href=\"#\" code=\"50\">重庆</a> <a class=\"place province\" href=\"#\" code=\"35\">福建</a> <a class=\"place province\" href=\"#\" code=\"62\">甘肃</a> <a class=\"place province\" href=\"#\" code=\"44\">广东</a> <a class=\"place province\" href=\"#\" code=\"45\">广西</a> <a class=\"place province\" href=\"#\" code=\"52\">贵州</a> </dd>";
	html += "<dt>H-K</dt>";
	html += "<dd> <a class=\"place province\" href=\"#\" code=\"46\">海南</a> <a class=\"place province\" href=\"#\" code=\"13\">河北</a> <a class=\"place province\" href=\"#\" code=\"41\">河南</a> <a class=\"place province\" href=\"#\" code=\"23\">黑龙江</a> <a class=\"place province\" href=\"#\" code=\"42\">湖北</a> <a class=\"place province\" href=\"#\" code=\"43\">湖南</a> <a class=\"place province\" href=\"#\" code=\"22\">吉林</a> <a class=\"place province\" href=\"#\" code=\"32\">江苏</a> <a class=\"place province\" href=\"#\" code=\"36\">江西</a> </dd>";
	html += "<dt>L-S</dt>";
	html += "<dd> <a class=\"place province\" href=\"#\" code=\"21\">辽宁</a> <a class=\"place province\" href=\"#\" code=\"15\">内蒙古</a> <a class=\"place province\" href=\"#\" code=\"64\">宁夏</a> <a class=\"place province\" href=\"#\" code=\"63\">青海</a> <a class=\"place province\" href=\"#\" code=\"37\">山东</a> <a class=\"place province\" href=\"#\" code=\"14\">山西</a> <a class=\"place province\" href=\"#\" code=\"61\">陕西</a> <a class=\"place province\" href=\"#\" code=\"31\">上海</a> <a class=\"place province\" href=\"#\" code=\"51\">四川</a> </dd>";
	html += "<dt>T-Z</dt>";
	html += "<dd> <a class=\"place province\" href=\"#\" code=\"12\">天津</a> <a class=\"place province\" href=\"#\" code=\"54\">西藏</a> <a class=\"place province\" href=\"#\" code=\"65\">新疆</a> <a class=\"place province\" href=\"#\" code=\"53\">云南</a> <a class=\"place province\" href=\"#\" code=\"33\">浙江</a> </dd>";
	html += "</dl>";
	html += "</div>";
	html += "<div class=\"hidden tab-box\"></div>";

	$("#" + id).html(html);

	$(document).click(function() {
		if (!$("#" + id).is(":hidden")) {
			$("#" + id).hide();
		}
	});

	$("body").delegate("a.selectCity", "click", function(e) {
		e.stopPropagation();
	});

	if (inputId == 0)
		inputId = '';
	else
		inputId = "_" + inputId;

	$("#" + id).delegate("li.tab", "click", function() {
		var n = $(this).attr("index");
		$("#" + id).find(".tab-box").hide();
		$("#" + id).find(".tab-box:eq(" + n + ")").show();
		$("#" + id).find(".tab").removeClass("select");
		$("#" + id).find("#select-tab").animate({
			left : n * 70 - 1 + "px"
		}, 200, function() {
			$("#" + id).find(".tab:eq(" + n + ")").addClass("select");
		});
		return false;
	}).delegate("a.province", "click", function() {
		$("#" + id).find("a.select").removeClass("select");
		$(this).addClass("select");
		$("#" + id).find("#city").click();
		var provinceId = $(this).attr("code");
		var cityJson = area.city;
		$("#" + id).find(".tab-box:eq(2)").html('');
		for (var i = 0; i < cityJson.length; i++) {
			if (cityJson[i].code.substring(0, 2) == provinceId) {
				$("#" + id).find(".tab-box:eq(2)").append("<a class='place city' href='#' code='" + cityJson[i].code + "'>" + cityJson[i].name + "</a>");
			}
		}
		return false;
	}).delegate("a.city", "click", function() {
		$("#" + id).find("a.select").removeClass("select");
		$(this).addClass("select");
		var cityname = $("#cityName_input" + inputId);
		var cityid = $("#cityId_input" + inputId);
		var provinceJson = area.province;
		for (var i = 0; i < provinceJson.length; i++) {
			if (provinceJson[i].code.substring(0, 2) == $(this).attr("code").substring(0, 2)) {
				cityname.val(provinceJson[i].name + "-" + $(this).html());
				try {
					cityname.html(provinceJson[i].name + "-" + $(this).html());
				} catch(e) {
				}
			}
		}

		cityid.val($(this).attr('code'));
		cityname.css("color", "#333333");
		$("#" + id).hide();

		if (callback != null) {
			callback();
		}
		return false;
	}).click(function(e) {
		e.stopPropagation();
	});
}

