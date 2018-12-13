<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script
	src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<title>주문 완료</title>
</head>
<body>
	<% // 받아온 테이블 번호 확인
	int tn;
	try {
		tn = Integer.parseInt(request.getParameter("tn"));
		if (tn >= 1 || tn <= 6) {
		} else {
			response.sendRedirect("error.jsp");
		}
	} catch (Exception e) {
		response.sendRedirect("error.jsp");
	}
	tn = Integer.parseInt(request.getParameter("tn"));
	%>
	<sql:query var="rs" dataSource="jdbc/mysql"> /* DB 불러오기 */
		select * from ordertable
	</sql:query>
	
	<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost/test";
	
	int index = 0; // index 값 초기화
	String time = request.getParameter("time");
	String check = request.getParameter("check");
	pageContext.setAttribute("time", time);
	pageContext.setAttribute("check", check);
	
	int remove_check = 0;
	%>
	
	<c:if test="${check eq 'on'}"> <!-- 주문 취소 -->
		<c:forEach var="row" items="${rs.rows }">
			<c:if test="${row.time eq time }">
				<c:if test="${row.verify eq 'y'}"> <%remove_check = -1; %></c:if>
				<c:if test="${row.verify eq 'n'}">
					<sql:update var="remove" dataSource="jdbc/mysql">
						delete from ordertable where time='<%=time %>'
					</sql:update>
					<%remove_check = 1; %>
				</c:if>
			</c:if>
		</c:forEach>
		<%
		if(remove_check == -1) {out.println("<script>alert('이미 확인된 주문입니다.\n취소를 원하시면 카운터에 문의하세요.');location.href='order_send_confirmed.jsp.';</script>");}
		if(remove_check == 1) {out.println("<script>alert('주문 삭제가 완료되었습니다.');location.href='table_' + " + tn + " + '.html';</script>");}	
		if(remove_check == 0) {out.println("<script>alert('이미 삭제된 주문입니다.');location.href='table_' + " + tn + " + '.html';</script>");}
		%>
	</c:if>
	
	<center>
		<div class="content" data-role="content" style="background-color: white">
			<h1>주문완료</h1>
			※주문 취소를 원할 경우, 창을 끄지 말아주세요.<br>※혹시 종료하셨다면, 카운터에서 직접 말해주시길 바랍니다.<br><br>
			<form name="form1" method="post" action="order_send.jsp">
				<input type="submit" name="cancel" value="주문취소" onclick="return confirm('정말 취소하시겠습니까?\n※카운터에서 주문 확인시 취소가 불가능합니다.');">
				<input type="hidden" name="check" value="on">
				<input type="hidden" name="tn" value="<%=tn %>">
				<input type="hidden" name="time" value="<%=time %>">
			</form>
		</div>
	</center>
</body>
</html>