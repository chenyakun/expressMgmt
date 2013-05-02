var jsoncookie;
function __getIE() {
  if (window.ActiveXObject) {
    var v = navigator.userAgent.match(/MSIE([^;]+)/)[1];
    return parseFloat(v.substring(0, v.indexOf(".")));
  }
  return false;
};
Array.prototype.foreach = function(func) {
  if (func && this.length > 0) {
    for (var i = 0; i < this.length; i++) {
      func(this[i]);
    }
  }
};
String.format = function() {
  if (arguments.length == 0) return null;
  var str = arguments[0];
  for (var i = 1; i < arguments.length; i++) {
    var regExp = new RegExp('\\{' + (i - 1) + '\\}', 'gm');
    str = str.replace(regExp, arguments[i]);
  }
  return str;
};
String.prototype.startWith = function(s) {
  return this.indexOf(s) == 0;
};
String.prototype.startWith = function(s) {
  var d = this.length - s.length;
  return (d >= 0 && this.lastIndexOf(s) === d);
};
String.prototype.trim = function() {
  return this.replace(/(^\s*)|(\s*$)/g, '');
};

function getid(id) {
  return (typeof id == 'string') ? document.getElementById(id) : id;
};

document.getElementsByClassName = function(name) {
  var tags = document.getElementsByTagName('*') || document.all;
  var els = [];
  for (var i = 0; i < tags.length; i++) {
    if (tags[i].className) {
      var cs = tags[i].className.split(' ');
      for (var j = 0; j < cs.length; j++) {
        if (name == cs[j]) {
          els.push(tags[i]);
          break;
        }
      }
    }
  }
  return els;
};

function getOffsetTop(el, p) {
  var _t = el.offsetTop;
  while (el = el.offsetParent) {
    if (el == p) break;
    _t += el.offsetTop;
  }
  return _t;
};

function getOffsetLeft(el, p) {
  var _l = el.offsetLeft;
  while (el = el.offsetParent) {
    if (el == p) break;
    _l += el.offsetLeft;
  }
  return _l;
};

function attach(o, e, f) {
  if (document.attachEvent) o.attachEvent("on" + e, f);
  else if (document.addEventListener) o.addEventListener(e, f, false);
}

//--------- ToolBox --------------
var currentInput = null;
function BoxShowUrls() {
  var input = getid("postid");
  var box = getid("ToolBox");
  currentInput = input;
  FillUrls();
  box.style.left = getOffsetLeft(input) + 'px';
  box.style.top = (getOffsetTop(input) + (input.offsetHeight - 1)) + 'px';
  box.style.width = (input.offsetWidth - 2) + 'px';
  box.style.display = 'block';
}

function InputSetValue(value) {
  var temphistory = jsoncookie["history"];
  var history = jsoncookie["history"];
  var comcode = history[value].code;
  var comnu = history[value].nu;
  setCookie("comcode", comcode);
  setCookie("inputpostid", comnu);
  //alert(getCookie("inputpostid"));
  ischoose = false;
  clear();
  var tags = document.getElementById("postid");
  tags.value = comnu;
  
}

function ToolBoxAdd(companyCode, num, ischeck) {
  jsoncookie = getCookieTojson();
  var nu = "";
  var com = "";
  var check = "";
  
  if(companyCode != null && companyCode != ""){
  	com = companyCode;
  }else{
  	com = gCompanyCode;
  }
  if(num != null && num != ""){
  	nu = num;
  }else{
  	nu = gKuaidiNumber;
  }
  if(ischeck != null && ischeck != ""){
  	check = ischeck;
  }else{
  	check = gIsCheck;
  }
  
  var companyname = "";
  var companysInfo = jsoncom.company;
  for (var i = 0; i < companysInfo.length; i++) {
    if (com == companysInfo[i].code) {
      companyname = companysInfo[i].shortname; //å…¬å¸ç®€ç§°
      break;
    }
  }
  if (nu == "") {
    return;
  }
  var returnvale = hasJson(com, nu);
  var userinfo = null;
  var today = new Date();
  if (returnvale == -3) {
    var info = new historyinfo(0, companyname, com, nu, today.toString(), check);
    info = _ToJSON(info);
    jsoncookie["name"] = "kuaidicookie";
    jsoncookie["creatdate"] = today.toDateString();
    jsoncookie["history"] = [];
    jsoncookie["history"].push(info);
  } else if (returnvale == -2) {} else if (returnvale == -1) {
    var temphistory = jsoncookie["history"];
    if (temphistory.length >= 10) {
      ToolBoxDeleteValue('0');
      jsoncookie = getCookieTojson();
      temphistory = jsoncookie["history"];
    }
    jsoncookie["history"] = [];
    jsoncookie["history"].push(temphistory);
    var length = jsoncookie["history"].length;
    var info = new historyinfo(jsoncookie["history"].length, companyname, com, nu, today.toString(), check);
    info = _ToJSON(info);
    //jsoncookie["history"]=[];
    //jsoncookie["history"][jsoncookie["history"].length]=info;
    jsoncookie["history"].push(info);
  }
  var temp_jsoncookie = _ToJSON(jsoncookie);
  temp_jsoncookie = temp_jsoncookie.replace('"history":', '"history":[');
  temp_jsoncookie = temp_jsoncookie.replace('}}', '}]}');
  //ajaxget('/ajax.aspx?at=toolbox&iswords='+iswords+'&addval='+escape(val));
  setcookie('toolbox_urls', temp_jsoncookie);
  //BoxShowUrls();
}

function ToolBoxDeleteValue(val) {
  jsoncookie = getCookieTojson();
  delete jsoncookie.history[val];
  deleteCookie('toolbox_urls');
  var temp_jsoncookie = _ToJSON(jsoncookie);
  if (jsoncookie.history.length == 1) {
    temp_jsoncookie = "{}";
  } else {
    temp_jsoncookie = temp_jsoncookie.replace(',null', '');
    temp_jsoncookie = temp_jsoncookie.replace('null,', '');
    temp_jsoncookie = temp_jsoncookie.replace('"history":', '"history":[');
    temp_jsoncookie = temp_jsoncookie.replace('}}', '}]}');
  }
  setcookie('toolbox_urls', temp_jsoncookie);
  //BoxShowUrls();
}

function FillUrls() {
  jsoncookie = getCookieTojson();
  var html = "<li class='tool-but' onclick='ToolBoxAdd()'>ä¸´æ—¶ä¿å­˜è¾“å…¥æ¡†çš„å•å·</li>";
  //alert(_ToJSON(jsoncookie) )
  if (_ToJSON(jsoncookie) != "{}") {
    var history = jsoncookie["history"];
    if (history == null) {
      html += "";
    } else {
      for (var i = history.length - 1; i > -1; i--) {
        var order = history[i].order;
        var code = history[i].code;
        var nu = history[i].nu;
        var com = history[i].com;
        var textval = com + ":" + nu;
        html += "<li><img src='http://cdn.kuaidi100.com/images/bg_tool.gif' alt='åˆ é™¤' onclick=\"ToolBoxDeleteValue('" + i + "');\" style='cursor:pointer' /><a href=\"javascript:InputSetValue('" + i + "');\">" + textval + "</a></li>";
      }
    }
  } else {
    html += "";
  }
  getid("xlist").innerHTML = html;
}

//{'name':'kuaidicookie','creatdate':'now','history':[{'order':0,'com':'ç”³é€š','code':'shentong','nu':'1111','time':''},{'order':1,'com':'ç”³é€š','code':'shentong','time':''},{'order':1,'com':'ç”³é€š','code':'shentong','time':''}]}
function hasJson(type, postid) {
  jsoncookie = getCookieTojson();
  var returnvalue = -1;
  if (_ToJSON(jsoncookie) == "{}") {
    return - 3;
  }
  if (type == null || type == "" || postid == null || postid == "") {
    return returnvalue = -2;
  }
  var history = jsoncookie["history"];
  if (history == null) return returnvalue;
  for (var i = 0; i < history.length; i++) {
    var order = history[i].order;
    var code = history[i].code;
    var nu = history[i].nu;
    if (type == code && postid == nu) {
      returnvalue = i;
    }
  }
  return returnvalue;
}

function historyinfo(order, com, code, nu, time, ischeck) {
  this.order = order;
  this.com = com;
  this.code = code;
  this.nu = nu;
  this.time = time;
  this.ischeck = ischeck;
}

function getWenZi(value) {
  return value.replace(/<\/?.+?>/g, "");
}
