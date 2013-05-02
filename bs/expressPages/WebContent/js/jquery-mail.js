(function($) {
	$.fn.mailAutoComplete = function(options) {
		var defaults = {
			boxClass : "mailListBox",
			//外部box样式
			listClass : "mailListDefault",
			//默认的列表样式
			focusClass : "mailListFocus",
			//列表选样式中
			markCalss : "mailListHlignt",
			//高亮样式
			zIndex : 1,
			autoClass : true,
			//是否使用插件自带class样式
			mailArr : ["qq.com", "163.com", "126.com", "gmail.com", "hotmail.com", "live.com", "sina.com", "sohu.com", "yahoo.com", "yahoo.com.cn"],
			//邮件数组
			textHint : false,
			//文字提示的自动显示与隐藏
			hintText : "",
			focusColor : "#333",
			blurColor : "#666",
			top : "",
			width : ""
		};
		var settings = $.extend({}, defaults, options || {});
		//页面装载CSS样式
		if (settings.autoClass && $("#mailListAppendCss").size() === 0) {
			$('<style id="mailListAppendCss" type="text/css">.mailListBox{border:1px solid #369;background:#FFF;font:12px/20px Arial;}.mailListDefault{padding:0 5px;cursor:pointer;white-space:nowrap;}.mailListFocus{padding:0 5px;cursor:pointer;white-space:nowrap;background:#369;color:white;}.mailListHlignt{color:#333;}.mailListFocus .mailListHlignt{color:#FFF;}</style>').appendTo($("head"));
		}
		var self = this;
		var cb = settings.boxClass, cl = settings.listClass, cf = settings.focusClass, cm = settings.markCalss;
		//插件的class变量
		var z = settings.zIndex, newArr = mailArr = settings.mailArr, hint = settings.textHint, text = settings.hintText, fc = settings.focusColor, bc = settings.blurColor;
		var gTop = settings.top;
		var gWidth = settings.width;
		//创建邮件内部列表内容
		$.createHtml = function(str, arr, cur) {
			if (index == -1) {
				var mailHtml = '<div class="mailHover ' + cf + '" id="mailList_-1"><span class="' + cm + '">' + str + '</span></div>';
			} else {
				var mailHtml = '<div class="mailHover ' + cl + '" id="mailList_-1"><span class="' + cm + '">' + str + '</span></div>';
			}
			if ($.isArray(arr)) {
				$.each(arr, function(i, n) {
					if (i === cur) {
						mailHtml += '<div class="mailHover ' + cf + '" id="mailList_' + i + '"><span class="' + cm + '">' + str + '</span>@' + arr[i] + '</div>';
					} else {
						mailHtml += '<div class="mailHover ' + cl + '" id="mailList_' + i + '"><span class="' + cm + '">' + str + '</span>@' + arr[i] + '</div>';
					}
				});
			}
			return mailHtml;
		};
		//一些全局变量
		var index = -2, s, v;
		$(this).each(function() {
			var that = $(this), i = $(".justForJs").size();
			if (i > 0) {//只绑定一个文本框
				return;
			}
			var w = that.outerWidth(), h = that.outerHeight();
			//获取当前对象（即文本框）的宽高
			//样式的初始化
			if (gTop != "") {
				h = gTop;
			}
			if (gWidth != "") {
				w = gWidth;
			}
			that.wrap('<span style="display:inline-block;position:relative;"></span>').before('<div id="mailListBox_' + i + '" class="justForJs ' + cb + '" style="min-width:' + (w - 2) + 'px;position:absolute;left:-6000px;top:' + h + 'px;z-index:' + z + ';"></div>');
			var x = $("#mailListBox_" + i);
			//列表框对象
			if (x.width() < (w - 2)) {
				x.css("width", (w - 2));
			}
			that.focus(function() {
				//父标签的层级
				$(this).css("color", fc).parent().css("z-index", z);
				//提示文字的显示与隐藏
				if (hint && text) {
					var focus_v = $.trim($(this).val());
					if (focus_v === text) {
						$(this).val("");
					}
				}
			});
			//键盘事件
			$(this).keydown(function(e) {
				s = v = $.trim($(this).val());
				if (/@/.test(v)) {
					s = v.replace(/@.*/, "");
				}
				if (v.length > 0) {
					//如果按键是上下键
					if (e.keyCode === 38 || e.keyCode === 40) {
						if (e.keyCode === 38) {
							//向上
							if (index < 0) {
								index = newArr.length;
							}
							index--;
							$(this).val($("#mailList_" + index).text());
						} else {
							//向下
							if (index >= newArr.length - 1) {
								index = -2;
							}
							index++;
							$(this).val($("#mailList_" + index).text());
						}
						changeIndex();
						if (x.css("left") == "-6000px") {
							x.html($.createHtml(s, newArr, index)).css("left", 0);
						}
					}
				} else {
					x.css("left", "-6000px");
					index = -2;
				}
			}).keyup(function(e) {
				s = v = $.trim($(this).val());
				if (/@/.test(v)) {
					s = v.replace(/@.*/, "");
				}
				if (v.length > 0) {
					if (e.keyCode === 38 || e.keyCode === 40) {
					} else {
						if (e.keyCode === 13) {
							//回车
							if (index >= -1 && index < newArr.length) {
								//如果当前有激活列表
								$(this).val($("#mailList_" + index).text());
							}
						}
						if (/@/.test(v)) {
							index = -2;
							//获得@后面的值
							//s = v.replace(/@.*/, "");
							//创建新匹配数组
							var site = v.replace(/.*@/, "");
							newArr = $.map(mailArr, function(n) {
								var reg = new RegExp(site);
								if (reg.test(n)) {
									return n;
								}
							});
						} else {
							newArr = mailArr;
						}

						x.html($.createHtml(s, newArr, index)).css("left", 0);
					}
					if (e.keyCode === 13) {
						//回车
						if (x.css("left") == "0px") {
							//如果当前有激活列表
							x.css("left", "-6000px");
							index = -2;
						}
					}
				} else {
					x.css("left", "-6000px");
					index = -2;
				}
				if ($.isFunction(window.emailAfterKeyup)) {
					emailAfterKeyup(e);
				}
			}).blur(function() {
				if (hint && text) {
					var blur_v = $.trim($(this).val());
					if (blur_v === "") {
						$(this).val(text);
					}
				}
				$(this).css("color", bc).parent().css("z-index", 0);
				x.css("left", "-6000px");
				index = -2;
			});
			//鼠标经过列表项事件
			//鼠标经过
			var liveValue;
			$(".mailHover").live("mousedown", function() {
				index = Number($(this).attr("id").split("_")[1]);
				liveValue = $("#mailList_" + index).text();
				that.val(liveValue);
				s = v = $.trim($(that).val());
				if (/@/.test(v)) {
					//获得@后面的值
					//s = v.replace(/@.*/, "");
					//创建新匹配数组
					var site = v.replace(/.*@/, "");
					newArr = $.map(mailArr, function(n) {
						var reg = new RegExp(site);
						if (reg.test(n)) {
							return n;
						}
					});
				} else {
					newArr = mailArr;
				}
				x.html($.createHtml(s, newArr, index));
				x.css("left", "-6000px");
				index = -2;
				that.focus();
				return false;
			}).live("mouseenter", function() {
				index = Number($(this).attr("id").split("_")[1]);
				changeIndex();
			});
			/*x.bind("mousedown", function(){
			 that.val(liveValue);
			 });*/

		});
		function changeIndex() {
			$("." + cf).addClass(cl);
			$("." + cf).removeClass(cf);
			$("#mailList_" + index).addClass(cf);
			$("#mailList_" + index).removeClass(cl);
		}

	};
})(jQuery);
