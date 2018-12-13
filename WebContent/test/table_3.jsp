<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%-- 테이블 번호별 테이블 번호 생성 및 전송 --%>
<jsp:forward page="main.jsp">
	<jsp:param name="tn" value="3" />
</jsp:forward>

</body>
</html>