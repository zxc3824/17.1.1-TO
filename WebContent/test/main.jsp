<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"%>
<!DOCTYPE html>

<html> <!-- html + jquery(javascript + css) -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"	href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script	src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript" src="http://dev.jtsage.com/cdn/spinbox/latest/jqm-spinbox.min.js"></script>
<style type="text/css">
	#popupDialog-popup {
		width: 90%;
	}
</style>
<title>REAL COFFEE</title>
</head>
<body>
	<% // 받아온 테이블 번호 확인
	int tn;
	try{
		tn = Integer.parseInt(request.getParameter("tn"));
		if(tn >= 1 || tn <= 6){
		} else {
			response.sendRedirect("error.jsp");
		}
	} catch (Exception e){
		response.sendRedirect("error.jsp");
	}
	tn = Integer.parseInt(request.getParameter("tn"));
	%>
	<section id="page1" data-role="page" data-add-back-btn="true">
		<header data-role="header" data-position="fixed">
			<img src="KakaoTalk_20170516_221434655a.jpg" width=100%>
			<a href="menuboard.jsp" style="opacity:0;display:block;width:9%;height:65%;text-decoration:none;left:2%;top:10%;position:absolute"></a>
		</header>
		<img src="KakaoTalk_20170516_221434655b.jpg" width=100%>
		<a href="order.jsp?tn=<%=tn %>" style="display:block;width:37%;height:6%;text-decoration:none;left:31%;top:74%;position:absolute"></a>
		<script>
		</script>
	</section>
</body>
</html>