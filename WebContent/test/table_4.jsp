<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body><script type="text/javascript">
var oldUrl = 'http://localhost:8080/Capstone/test/table_4.jsp'; // url 변경 스크립트(현재 작동 X)
var changeUrl = 'http://localhost:8080/Capstone/test/main.jsp';
var urlString = location.href;
if(urlString.match(oldUrl)) {
	window.location.replace(urlString.replace(oldUrl, changeUrl));
} else { }
</script>

<%-- 테이블 번호별 테이블 번호 생성 및 전송 --%>
<jsp:forward page="main.jsp">
	<jsp:param name="tn" value="4" />
</jsp:forward>

</body>
</html>
</body>
</html>