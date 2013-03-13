<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<meta http-equiv="content-type" content="text/html;"/>
<title>阿里巴巴地图演示</title>
<script language="javascript" src="map.js" ></script>
</head>
<body>
<div id="mapDiv" style="width:800px;height:600px"></div>
 
<script language="javascript">
 
          map=new AliMap("mapDiv"); //使用id为mapDiv的层创建一个地图对象
 
          map.centerAndZoom(new AliLatLng(30.238747,120.14532),15);//显示地图
           
</script>
</body>
</html>