<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<title>全城搜喵</title>
<style>
/* 为了不至于很丑陋，css代码拷贝自: http://johnsardine.com/  */
body { 
    font-family:Arial, Helvetica, sans-serif; font-size:0.9em; margin-left: 100px;
}
p { line-height:150%;}
#query { width: 400px; }
table { border-collapse: collapse; border-spacing: 0; padding: 0px; width: 800px;}
input[type=text] {
    border: solid 2px #e5e5e5;
    border-radius: 0;
    background: #fff;
    -webkit-transition: border-color 0.3s;
    -moz-transition: border-color 0.3s;
    -ms-transition: border-color 0.3s;
    -o-transition: border-color 0.3s;
    transition: border-color 0.3s;
    resize: none;
    outline: medium none;
    padding: 0.4em;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    -o-box-sizing: border-box;
    box-sizing: border-box;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    font-size: 1.1em;
}
.large {
    width: 100%;
}
h2 {
    font-size: 22px;
    line-height: 23px;
    color: #1B9596;
    padding: 25px 0;
    font-weight: normal;
    text-transform: uppercase;
    margin: 0;
    text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.2);
}
table a:link {
    color: #666;
    font-weight: bold;
    text-decoration:none;
}
table a:visited {
    color: #999999;
    font-weight:bold;
    text-decoration:none;
}
table a:active,
table a:hover {
    color: #bd5a35;
    text-decoration:underline;
}
table {
    font-family:Arial, Helvetica, sans-serif;
    color:#666;
    font-size:12px;
    text-shadow: 1px 1px 0px #fff;
    background:#eaebec;
    margin:1px;
    border:#ccc 1px solid;
    -moz-border-radius:3px;
    -webkit-border-radius:3px;
    border-radius:3px;

    -moz-box-shadow: 0 1px 2px #d1d1d1;
    -webkit-box-shadow: 0 1px 2px #d1d1d1;
    box-shadow: 0 1px 2px #d1d1d1;
}
table th {
    padding:21px 25px 22px 25px;
    border-top:1px solid #fafafa;
    border-bottom:1px solid #e0e0e0;

    background: #ededed;
    background: -webkit-gradient(linear, left top, left bottom, from(#ededed), to(#ebebeb));
    background: -moz-linear-gradient(top,  #ededed,  #ebebeb);
}
table th:first-child {
    text-align: left;
    padding-left:20px;
}
table tr:first-child th:first-child {
    -moz-border-radius-topleft:3px;
    -webkit-border-top-left-radius:3px;
    border-top-left-radius:3px;
}
table tr:first-child th:last-child {
    -moz-border-radius-topright:3px;
    -webkit-border-top-right-radius:3px;
    border-top-right-radius:3px;
}
table tr {
    text-align: center;
    padding-left:20px;
}
table td:first-child {
    text-align: left;
    padding-left:20px;
    border-left: 0;
}
table td {
    padding:18px;
    border-top: 1px solid #ffffff;
    border-bottom:1px solid #e0e0e0;
    border-left: 1px solid #e0e0e0;

    background: #fafafa;
    background: -webkit-gradient(linear, left top, left bottom, from(#fbfbfb), to(#fafafa));
    background: -moz-linear-gradient(top,  #fbfbfb,  #fafafa);
}
table tr.even td {
    background: #f6f6f6;
    background: -webkit-gradient(linear, left top, left bottom, from(#f8f8f8), to(#f6f6f6));
    background: -moz-linear-gradient(top,  #f8f8f8,  #f6f6f6);
}
table tr:last-child td {
    border-bottom:0;
}
table tr:last-child td:first-child {
    -moz-border-radius-bottomleft:3px;
    -webkit-border-bottom-left-radius:3px;
    border-bottom-left-radius:3px;
}
table tr:last-child td:last-child {
    -moz-border-radius-bottomright:3px;
    -webkit-border-bottom-right-radius:3px;
    border-bottom-right-radius:3px;
}
table tr:hover td {
    background: #f2f2f2;
    background: -webkit-gradient(linear, left top, left bottom, from(#f2f2f2), to(#f0f0f0));
    background: -moz-linear-gradient(top,  #f2f2f2,  #f0f0f0);  
}
</style>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript">
search = function() {
	var query = $('input#query').val();
	$.ajax({
		url: "shop",
		type: "POST",
		data: { query: query },
		dataType: "json",
		success: function (result) {
			var out = "<table border=0>"
			var weidian = new Array();
			for (var i = 0; i < result.length; i++) {
				weidian.push(result[i]);
			}
			for (var i = 0; i < weidian.length; i++){
			out += "<tr>"
			out += "<td width=150px>";
            out += "<a href=\"http://mmwd.me/item_detail/"+weidian[i].item_id+"\">"+weidian[i].title+"</a>";
			out += "<br>"
            out += "<font color=\"green\">销量: "+weidian[i].sales+"</font>";
			out += "<br>"
            out += "<font color=\"green\">价格: "+(weidian[i].price/100.0).toFixed(2)+"</font>";
			out += "<br>"
            out += "<font color=\"#3385ff\">商品创建日期: "+weidian[i].create_time+"</font>";
			out += "</td>";
			out += "<td>";
			out += "<p>" +weidian[i].item_desc+ "</p>";
			out += "</td>";
			out += "</tr>";
			}
			out += "</table>"
			$('div#output').html(out);
		},
		error: function (xhr, ajaxOptions, thrownError) {
		    alert(xhr.status);
		    alert(thrownError);
		}
	});
};
</script>
</head>
<body onload="search(0)">
<h2>全城搜喵</h2>
<p><input type="text" class="large" id="query" oninput="search()"></p>
<div id="output"></div>
</body>
</html>
	